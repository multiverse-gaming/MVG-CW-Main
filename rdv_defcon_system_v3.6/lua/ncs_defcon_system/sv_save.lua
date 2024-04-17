util.AddNetworkString("NCS_DEFCON_ConfigCommand")
util.AddNetworkString("NCS_DEFCON_AddDefcon")
util.AddNetworkString("NCS_DEFCON_ChangeSettings")

local function SendNotification(ply, msg)
    local CFG = NCS_DEFCON.CONFIG
	local PC = CFG.prefixcolor
	local PT = CFG.prefixtext

    NCS_DEFCON.AddText(ply, PC, "["..PT.."] ", color_white, msg)
end


local function SaveData()
    if !file.Exists("ncs/defcon/data.json", "DATA") then
        file.CreateDir("ncs/defcon/")
    end

    local jsonTable = util.TableToJSON(NCS_DEFCON.CONFIG)
    
    if !jsonTable then return end

    file.Write("ncs/defcon/data.json", jsonTable)
end

local function ReadData()
    if !file.Exists("ncs/defcon/data.json", "DATA") then
        file.CreateDir("ncs/defcon/")
    else
        local DATA = file.Read("ncs/defcon/data.json", "DATA")

        if DATA and DATA ~= "" then
            local newData = util.JSONToTable(DATA)

            local updatedList = false

            local COOKIE = cookie.GetNumber("defconLevel", table.maxn(NCS_DEFCON.CONFIG.defconList))
            local defDefcon = newData.defaultdefcon

            local foundCookie = false
            local foundDefault = false
            
            
            if newData.defconList then

                for k, v in pairs(newData.defconList) do
                    if defDefcon and ( defDefcon == v.uid ) then
                        foundDefault = true
                    end
                    
                    if ( v.uid == COOKIE ) then
                        foundCookie = true
                    end

                    if !v.uid or tonumber(v.uid) > 4294967295 then
                        newData.defconList[k] = nil

                        updatedList = true
                    end
                end

                if foundDefault and defDefcon then
                    NCS_DEFCON.CURRENT = defDefcon
                elseif foundCookie and COOKIE then
                    NCS_DEFCON.CURRENT = COOKIE
                end
            end

            for k, v in pairs(newData) do
                if NCS_DEFCON.CONFIG[k] ~= nil then
                    NCS_DEFCON.CONFIG[k] = v
                end
            end
            
            if updatedList then SaveData() end
        end
    end

    if !file.Exists("ncs/defcon/consoles_"..game.GetMap()..".json", "DATA") then
        file.CreateDir("ncs/defcon/")
    else
        local DATA = file.Read("ncs/defcon/consoles_"..game.GetMap()..".json", "DATA")

        if DATA and DATA ~= "" then
            DATA = util.JSONToTable(DATA)

            for k, v in ipairs(DATA) do
                local E = ents.Create("ncs_defcon_console")
                E:SetPos(v.POS)
                E:SetAngles(v.ANG)
                E:Spawn()
            end
        end
    end
end
ReadData()

hook.Add("PlayerSay", "NCS_DEFCON_ConfigCommand", function(P, TEXT)
    if string.lower(TEXT) == NCS_DEFCON.CONFIG.command then
        NCS_DEFCON.IsAdmin(P, function(checkPassed)
            if !checkPassed then return end

            net.Start("NCS_DEFCON_ConfigCommand")
            net.Send(P)
        end )

        return ""
    elseif string.lower(TEXT) == NCS_DEFCON.CONFIG.m_command then
        NCS_DEFCON.IsAdmin(P, function(checkPassed)
            if !checkPassed then
                local FOUND = false

                for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
                    if v.teams and v.teams[team.GetName(P:Team())] or v.allteams then
                        FOUND = true
                        break
                    end
                end

                if !checkPassed and !FOUND then return end
            end
            
            net.Start("RD_DEFCON_MENU")
            net.Send(P)
        end )

        return ""
    elseif string.lower(TEXT) == NCS_DEFCON.CONFIG.savecommand then
        NCS_DEFCON.IsAdmin(P, function(checkPassed)
            if !checkPassed then return "" end

            if !file.Exists("ncs/defcon/consoles_"..game.GetMap()..".json", "DATA") then
                file.CreateDir("ncs/defcon/")
            end

            local DATA = {}
            local d_Count = 0

            for k, v in ipairs(ents.GetAll()) do
                if v:GetClass() ~= "ncs_defcon_console" then continue end

                d_Count = d_Count + 1

                table.insert(DATA, {
                    POS = v:GetPos(),
                    ANG = v:GetAngles(),
                })
            end

            DATA = util.TableToJSON(DATA)

            file.Write("ncs/defcon/consoles_"..game.GetMap()..".json", DATA)

            SendNotification(P, NCS_DEFCON.GetLang(nil, "DEF_savedConsoles", {tostring(d_Count), game.GetMap()}))

        end )
            
        return ""
    end
end )

util.AddNetworkString("NCS_DEFCON_LoadPlayer")
hook.Add("NCS_DEFCON_PlayerReadyForNetworking", "NCS_DEFCON_LoadPlayer", function(P)
    local D = NCS_DEFCON.CONFIG
    
    local json = util.TableToJSON(D)
    local compressed = util.Compress(json)
    local length = compressed:len()

    net.Start("NCS_DEFCON_LoadPlayer")
        net.WriteUInt(length, 32)
        net.WriteData(compressed, length)
    net.Send(P)

    if !NCS_DEFCON.CURRENT or !isnumber(NCS_DEFCON.CURRENT) then return end

    net.Start("NCS_DEFCON_CHANGE")
        net.WriteUInt(NCS_DEFCON.CURRENT, 16)
    net.Send(P)
end )

net.Receive("NCS_DEFCON_ChangeSettings", function(_, P)
    NCS_DEFCON.IsAdmin(P, function(checkPassed)
        if !checkPassed then return end

        local length = net.ReadUInt(32)
        local data = net.ReadData(length)
        local uncompressed = util.Decompress(data)

        if (!uncompressed) then
            return
        end

        local D = util.JSONToTable(uncompressed)

        if !D.admins["superadmin"] then
            D.admins["superadmin"] = "World"
        end

        for k, v in pairs(D) do
            NCS_DEFCON.CONFIG[k] = v
        end

        net.Start("NCS_DEFCON_ChangeSettings")
            net.WriteUInt(length, 32)
            net.WriteData(data, length)
        net.Broadcast()

        SaveData()
    end )
end )

net.Receive("NCS_DEFCON_AddDefcon", function(_, P)
    NCS_DEFCON.IsAdmin(P, function(checkPassed)
        if !checkPassed then return end

        local length = net.ReadUInt(32)
        local data = net.ReadData(length)
        local uncompressed = util.Decompress(data)

        if (!uncompressed) then
            return
        end

        local D = util.JSONToTable(uncompressed)
        local CFG = NCS_DEFCON.CONFIG

        if !D.name or !D.desc then return end
        
        D.name = string.Trim(D.name)
        D.desc = string.Trim(D.desc)
        D.sound = string.Trim(D.sound)

        if ( !D.name or D.name == "" ) then return end
        if ( !D.desc or D.desc == "" ) then return end
        if !D.col then D.col = Color(255,0,0) end
        if !D.teams then D.teams = {} end
        if !D.sound or D.sound == "" then D.sound = false end

        if D.uid then
            for k, v in ipairs(NCS_DEFCON.CONFIG.defconList) do
                if v.uid ~= D.uid then continue end

                NCS_DEFCON.CONFIG.defconList[k] = D

                MsgC(CFG.prefixcolor, CFG.prefixtext, color_white, " "..NCS_DEFCON.GetLang(nil, "DEF_editedSuccessfully", {D.name}).."\n")

                SendNotification(P, NCS_DEFCON.GetLang(nil, "DEF_editedSuccessfully", {D.name}))
                break 
            end
        else
            local UID = table.maxn(NCS_DEFCON.CONFIG.defconList) + 1

            D.uid = UID

            table.insert(NCS_DEFCON.CONFIG.defconList, D)

            MsgC(CFG.prefixcolor, CFG.prefixtext, color_white, " "..NCS_DEFCON.GetLang(nil, "DEF_addedSuccessfully", {D.name}).."\n")

            SendNotification(P, NCS_DEFCON.GetLang(nil, "DEF_addedSuccessfully", {D.name}))
        end

        local json = util.TableToJSON(D)
        local compressed = util.Compress(json)
        local length = compressed:len()

        net.Start("NCS_DEFCON_AddDefcon")
            net.WriteUInt(P:EntIndex(), 8)
            net.WriteUInt(length, 32)
            net.WriteData(compressed, length)
        net.Broadcast()

        SaveData()
    end )
end )

util.AddNetworkString("NCS_DEF_RemoveDefcon")

net.Receive("NCS_DEF_RemoveDefcon", function(_, P)
    NCS_DEFCON.IsAdmin(P, function(checkPassed)
        if !checkPassed then return end

        local UID = net.ReadUInt(16)
        local FOUND = false

        local CFG = NCS_DEFCON.CONFIG
        
        for k, v in pairs(CFG.defconList) do
            if ( tonumber(v.uid) == tonumber(UID) ) then
                CFG.defconList[k] = nil

                FOUND = v.name
            end
        end

        if FOUND then
            MsgC(CFG.prefixcolor, CFG.prefixtext, color_white, " "..NCS_DEFCON.GetLang(nil, "DEF_removedSuccessfully", {FOUND}).."\n")

            SendNotification(P, NCS_DEFCON.GetLang(nil, "DEF_removedSuccessfully", {FOUND}))

            net.Start("NCS_DEF_RemoveDefcon")
                net.WriteUInt(UID, 16)
            net.Broadcast()

            SaveData()
        else
            ErrorNoHalt(NCS_DEFCON.GetLang(nil, "DEF_noLevelFound"))
        end
    end )
end )