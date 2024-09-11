util.AddNetworkString("RDV.LEVELS.RetrieveScoreboard")
util.AddNetworkString("RDV.LEVELS.UpgradeSkill")
util.AddNetworkString("RDV.LEVELS.PurchaseSkillpoint")
util.AddNetworkString("RDV.LEVELS.UpdateClient")
util.AddNetworkString("RDV.LEVELS.ResetSkills")
util.AddNetworkString("RDV.LEVELS.GetSkills")

util.AddNetworkString("RDV.LEVELS.GetPlayer")
util.AddNetworkString("RDV.LEVELS.SetPlayer")

local COL_1 = Color(255,255,255)

local function SendNotification(ply, msg)
    RDV.LIBRARY.AddText(ply, RDV.LIBRARY.GetConfigOption("SAL_prefixColor"), "["..RDV.LIBRARY.GetConfigOption("SAL_prefix").."] ", Color(255,255,255), msg)
end

net.Receive("RDV.LEVELS.SetPlayer", function(len, ply)
    if !RDV.SAL.HasPermission(ply) then return end

    local E = net.ReadPlayer()

    if !IsValid(E) then return end

    local LVL = net.ReadUInt(16)
    local POI = net.ReadUInt(16)
    local EXP = tonumber(net.ReadString())

    RDV.SAL.SetLevel(E, LVL)

    local C_EXP = RDV.SAL.GetExperience(E)
    EXP = ( EXP - C_EXP )

    RDV.SAL.AddExperience(E, EXP)

    local C_POI = RDV.SAL.GetPoints(E)
    POI = ( POI - C_POI )

    RDV.SAL.GivePoints(E, POI)
end )

net.Receive("RDV.LEVELS.GetPlayer", function(len, ply)
    if !RDV.SAL.HasPermission(ply) then return end

    local E = net.ReadPlayer()

    local LVL = RDV.SAL.GetLevel(E)
    local POI = RDV.SAL.GetPoints(E)
    local EXP = RDV.SAL.GetExperience(E)

    net.Start("RDV.LEVELS.GetPlayer")
        net.WritePlayer(E)
        net.WriteUInt(LVL, 16)
        net.WriteUInt(POI, 16)
        net.WriteString(EXP)
    net.Send(ply)
end )

net.Receive("RDV.LEVELS.UpgradeSkill", function(len, ply)
    local SKILL = net.ReadString()
    local POINTS = RDV.SAL.GetPoints(ply)

    local CFG = RDV.SAL.SKILLS.LIST[SKILL]

    if not CFG or tonumber(POINTS) <= 0 then
        return
    else
        local CurTier = RDV.SAL.GetSkillTier(ply, SKILL)
        local LVL = RDV.SAL.GetLevel(ply)

        if CurTier >= CFG.MAX then
            local LANG = RDV.LIBRARY.GetLang(nil, "SAL_noUpgradeAvailable")

            SendNotification(ply, LANG)

            return
        end

        local REQ = CFG.LevelReq[CurTier + 1]

        if REQ and REQ > tonumber(LVL) then
            return
        end

        RDV.SAL.GivePoints(ply, -1)

        RDV.SAL.GiveSkill(ply, SKILL, CurTier + 1)
    end
end)

net.Receive("RDV.LEVELS.PurchaseSkillpoint", function(len, ply)
    local canBuy = RDV.LIBRARY.GetConfigOption("SAL_purchaseEnabled")

    if !canBuy then return end

    local PRICE = RDV.LIBRARY.GetConfigOption("SAL_skillPrice")

    if isnumber(PRICE) and PRICE > 0 then
        local AFFORD = RDV.LIBRARY.CanAfford(ply, nil, PRICE)

        if AFFORD then
            RDV.SAL.GivePoints(ply, 1)

            local AFFORD = RDV.LIBRARY.AddMoney(ply, nil, -PRICE)

            local LANG = RDV.LIBRARY.GetLang(nil, "SAL_skillpointPurchased")

            SendNotification(ply, LANG)
        else
            local LANG = RDV.LIBRARY.GetLang(nil, "SAL_cannotAffordSkillpoint")

            SendNotification(ply, LANG)
        end
    end
end)

local LD_REQ = {}

net.Receive("RDV.LEVELS.RetrieveScoreboard", function(len, ply)
    if RDV.LIBRARY.GetConfigOption("SAL_leaderboardEnabled") == false then
        return
    end

    if LD_REQ[ply] and LD_REQ[ply] > 20 then ply:Kick() return end

    local LIMIT = RDV.LIBRARY.GetConfigOption("SAL_ldbLimit")

    local q = RDV_Mysql:Select("RDV_LEVELS_DB_V1")
        q:Select("CLIENT")
        q:Select("PCHARACTER")
        q:Select("LEVEL")
        q:OrderByDesc("LEVEL")
        q:Limit(LIMIT)
        q:Callback(function(data)
            if not data or data[1] == nil then
                return
            end

            net.Start("RDV.LEVELS.RetrieveScoreboard")
                net.WriteTable(data)
            net.Send(ply)
        end)
    q:Execute()

    if !LD_REQ[ply] then LD_REQ[ply] = 0 end
    LD_REQ[ply] = (LD_REQ[ply] + 1)

    local TID = "RDV_SAL_GetLeaderboardDelay_"..ply:SteamID64()

    if timer.Exists(TID) then return end

    timer.Create(TID, 60, 1, function()
        if IsValid(ply) and LD_REQ[ply] then
            LD_REQ[ply] = 0
        end
    end )
end)

net.Receive("RDV.LEVELS.ResetSkills", function(len, ply)
    local CAN = RDV.LIBRARY.GetConfigOption("SAL_resetEnabled")

    if !CAN then return end
    
    if not RDV.LIBRARY.GetConfigOption("SAL_resetPrice") then
        return
    end

    local PRICE = RDV.LIBRARY.GetConfigOption("SAL_resetPrice")
    local AFFORD = RDV.LIBRARY.CanAfford(ply, nil, PRICE)

    if AFFORD then
        RDV.LIBRARY.AddMoney(ply, nil, -PRICE)

        local RESET, POINTS = RDV.SAL.ResetSkills(ply)

        if not RESET then
            local LANG = RDV.LIBRARY.GetLang(nil, "SAL_noPointsInvested")

            SendNotification(ply, LANG)
        else
            local LANG = RDV.LIBRARY.GetLang(nil, "SAL_successfullyReset", {
                POINTS,
            })

            SendNotification(ply, LANG)
        end
    end
end)

local PVS = {}

util.AddNetworkString("RDV.LEVELS.PVS_Experience")

net.Receive("RDV.LEVELS.PVS_Experience", function(len, ply)
    if !RDV.LIBRARY.GetConfigOption("SAL_expPVS") then return end

    local INDEX = net.ReadUInt(8)
    local PLAYER = Entity(INDEX)

    if !IsValid(PLAYER) or !PLAYER:IsPlayer() then
        return
    end

    PVS[ply] = PVS[ply] or {}

    if PVS[ply][PLAYER] and PVS[ply][PLAYER] > CurTime() then return end

    local EXP = RDV.SAL.GetExperience(PLAYER)

    if !EXP or EXP == 0 then
        return 
    end

    net.Start("RDV.LEVELS.PVS_Experience")
        net.WriteUInt(INDEX, 8)
        net.WriteString(EXP)
    net.Send(ply)

    PVS[ply][PLAYER] = CurTime() + 10
end)

local GS_REQ = {}

net.Receive("RDV.LEVELS.GetSkills", function(len, ply)
    if GS_REQ[ply] and GS_REQ[ply] > 20 then ply:Kick() return end

    local SID64 = ply:SteamID64()
    local TAB = RDV.SAL.PLAYERS[SID64]

    net.Start("RDV.LEVELS.GetSkills")
        net.WritePlayer(ply)
        net.WriteTable(TAB.SKILLS or {})
    net.Send(ply)

    if !GS_REQ[ply] then GS_REQ[ply] = 0 end
    GS_REQ[ply] = (GS_REQ[ply] + 1)

    local TID = "RDV_SAL_GetSkillsDelay_"..ply:SteamID64()

    if timer.Exists(TID) then return end

    timer.Create(TID, 60, 1, function()
        if IsValid(ply) and GS_REQ[ply] then
            GS_REQ[ply] = 0
        end
    end )
end )