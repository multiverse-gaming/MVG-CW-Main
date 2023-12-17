local IsSelecting = false

hook.Add("PlayerButtonDown", "RDV_REQ_PlayerButtonDown", function(ply, button)
    if button == IN_USE and isfunction(IsSelecting) then
        IsSelecting(ply:GetPos(), ply:GetAngles())

        IsSelecting = false
    end
end )

local function CreateDivider(SCROLL, TEXT)
    local w, h = SCROLL:GetSize()

    local TLABEL = vgui.Create("DLabel", SCROLL)
    TLABEL:Dock(TOP)
    TLABEL:DockMargin(0, h * 0.01, 0, h * 0.01)
    TLABEL:SetText(TEXT)
    TLABEL:SetContentAlignment(5)
    TLABEL:SetFont("RDV_REQ_LabelFont")
    TLABEL:SetTextColor(col_white)
end

local function AddSpawn(OLD, OKEY)
    local ODATA = RDV.VEHICLE_REQ.SPAWNS[OKEY]

    if IsValid(OLD) then
        OLD:SetVisible(false)
    end

    local FRAME = vgui.Create("RDV_LIBRARY_FRAME")
    FRAME:SetSize(ScrW() * 0.25, ScrH() * 0.5)
    FRAME:Center()
    FRAME:SetVisible(true)
    FRAME:MakePopup()
    FRAME:SetTitle(RDV.LIBRARY.GetLang(nil, "VR_npcOverhead"))
    FRAME.OnRemove = function(s)
        OLD:SetVisible(true)
    end

    local w, h = FRAME:GetSize()

    local SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", FRAME)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
    SCROLL.Think = function(s)
        local DATA = {}

        if ODATA then
            DATA = {
                NAME = ODATA.NAME,
                POS = ODATA.Position,
                ANG = ODATA.Angles,
                RT = ODATA.TEAMS,
                GT = ODATA.GTEAMS,
                UID = (ODATA.UID or false),
            }
        else
            DATA = {
                NAME = nil,
                POS = nil,
                ANG = nil,
                RT = {},
                GT = {},
                UID = false,
            }
        end

        -- NAME OF THE SPAWN
        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_nameLabel"))

        local TEXT = vgui.Create("RDV_LIBRARY_TextEntry", SCROLL)
        TEXT:Dock(TOP)
        TEXT:SetHeight(h * 0.075)
        TEXT:SetPlaceholderText(RDV.LIBRARY.GetLang(nil, "VR_nameLabel"))
        TEXT:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        if ODATA then
            TEXT:SetValue(ODATA.NAME)
        end
        TEXT.OnChange = function(self, text)
            DATA.NAME = self:GetValue()
        end

        -- VECTOR POSITION AND ANGLE

        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_posAngle"))

        local VECTOR = vgui.Create("RDV_LIBRARY_TextButton", SCROLL)
        VECTOR:Dock(TOP)
        VECTOR:SetText(RDV.LIBRARY.GetLang(nil, "VR_startSelect"))
        VECTOR:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)

        if ODATA then
            VECTOR:SetText(tostring(ODATA.Position).." / "..tostring(ODATA.Angles))
        end
        VECTOR.DoClick = function(s)
            FRAME:SetVisible(false)

            RDV.VEHICLE_REQ.SendNotification(LocalPlayer(), RDV.LIBRARY.GetLang(nil, "VR_choosePos", {input.GetKeyName(IN_USE)}))
            
            IsSelecting = function(position, angle)
                DATA.POS = position
                DATA.ANG = angle

                if IsValid(FRAME) then
                    FRAME:SetVisible(true)
                end

                VECTOR:SetText(tostring(position).." / "..tostring(angle))
            end
        end

        -- REQUEST TEAMS
        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_requestTeams"))

        local RVALS = {}

        local RTEAMS = vgui.Create( "DListView", SCROLL )
        RTEAMS:Dock( TOP )
        RTEAMS:SetMultiSelect( true )
        RTEAMS:AddColumn( RDV.LIBRARY.GetLang(nil, "VR_teamLabel") )
        RTEAMS:SetHeight(h * 0.3)
        RTEAMS:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        RTEAMS.OnRowRightClick = function(s, id, line)
            line:SetSelected(false)
        end
        
        for k, v in ipairs(team.GetAllTeams()) do
            local LINE = RTEAMS:AddLine(v.Name) -- Add lines
    
            if DATA.RT[v.Name] then
                RTEAMS:SelectItem(LINE)
            end
    
            RVALS[LINE:GetID()] = k
        end

        -- GRANT TEAMS
        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_grantTeams"))

        local GVALS = {}

        local GTEAMS = vgui.Create( "DListView", SCROLL )
        GTEAMS:Dock( TOP )
        GTEAMS:SetMultiSelect( true )
        GTEAMS:AddColumn( RDV.LIBRARY.GetLang(nil, "VR_teamLabel") )
        GTEAMS:SetHeight(h * 0.3)
        GTEAMS:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        GTEAMS.OnRowRightClick = function(s, id, line)
            line:SetSelected(false)
        end

        for k, v in ipairs(team.GetAllTeams()) do
            local LINE = GTEAMS:AddLine(v.Name) -- Add lines
    
            if DATA.GT[v.Name] then
                GTEAMS:SelectItem(LINE)
            end
    
            GVALS[LINE:GetID()] = k
        end

        local SAVE = vgui.Create("RDV_LIBRARY_TextButton", FRAME)
        SAVE:Dock(BOTTOM)
        SAVE:SetText(RDV.LIBRARY.GetLang(nil, "VR_saveLabel"))
        SAVE:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        SAVE.DoClick = function(s)
            if !OKEY then
                for k, v in ipairs(RDV.VEHICLE_REQ.SPAWNS) do
                    if (DATA.NAME == v.NAME) then    
                        RDV.VEHICLE_REQ.SendNotification(LocalPlayer(), RDV.LIBRARY.GetLang(nil, "VR_nameTaken"))
            
                        return
                    end
                end
            end

            -- Grant Teams

            if !table.IsSequential(DATA.GT) then DATA.GT = {} end

            for k, v in ipairs(GTEAMS:GetSelected()) do
                local LINE = v:GetID()
            
                if !GVALS[LINE] then continue end
    
                table.insert(DATA.GT, GVALS[LINE])
            end

            -- Request Teams

            if !table.IsSequential(DATA.RT) then DATA.RT = {} end

            for k, v in ipairs(RTEAMS:GetSelected()) do
                local LINE = v:GetID()
            
                if !RVALS[LINE] then continue end
    
                table.insert(DATA.RT, RVALS[LINE])
            end

            if !DATA.NAME or !DATA.POS or !DATA.ANG then
                return
            end

            local json = util.TableToJSON((DATA or {}))
            local compressed = util.Compress(json)
            local length = compressed:len()
        
            net.Start("RDV_VR_SendHangar")
                net.WriteUInt(length, 32)
                net.WriteData(compressed, length)
            net.SendToServer()

            if IsValid(FRAME) then FRAME:Remove() end

            surface.PlaySound("reality_development/ui/ui_accept.ogg")
        end

        s.Think = function() end
    end
end

local function AddVehicle(OLD, OKEY, CB)
    if IsValid(OLD) then OLD:SetVisible(false) end

    local ODATA = RDV.VEHICLE_REQ.VEHICLES[OKEY]

    local FRAME = vgui.Create("RDV_LIBRARY_FRAME")
    FRAME:SetSize(ScrW() * 0.25, ScrH() * 0.5)
    FRAME:Center()
    FRAME:SetVisible(true)
    FRAME:MakePopup()
    FRAME:SetTitle(RDV.LIBRARY.GetLang(nil, "VR_npcOverhead"))
    FRAME.OnRemove = function(s)
        if IsValid(OLD) then
            OLD:SetVisible(true)
        end
    end

    local w, h = FRAME:GetSize()

    local SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", FRAME)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
    SCROLL.Think = function(s)
        local DATA = {}

        if ODATA then
            DATA = {
                NAME = ODATA.NAME,
                MODEL = (ODATA.MODEL or ""),
                CLASS = ODATA.CLASS,
                RT = ODATA.TEAMS,
                GT = ODATA.GTEAMS,
                SPAWNS = ODATA.SPAWNS,
                CATEGORY = (ODATA.CATEGORY or ""),
                UID = (ODATA.UID or false),
            }
        else
            DATA = {
                NAME = nil,
                CATEGORY = nil,
                MODEL = nil,
                CLASS = nil,
                RT = {},
                GT = {},
                SPAWNS = {},
                UID = false,
            }
        end

        -- NAME OF THE SPAWN
        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_nameLabel"))

        local TEXT = vgui.Create("RDV_LIBRARY_TextEntry", SCROLL)
        TEXT:Dock(TOP)
        TEXT:SetHeight(h * 0.075)
        TEXT:SetPlaceholderText(RDV.LIBRARY.GetLang(nil, "VR_nameLabel"))
        TEXT:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        if ODATA then
            TEXT:SetValue(ODATA.NAME)
        end
        TEXT.OnChange = function(self, text)
            DATA.NAME = self:GetValue()
        end

        -- CATEGORY of VEHICLE

        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_catLabel"))

        local CAT = vgui.Create("RDV_LIBRARY_TextEntry", SCROLL)
        CAT:Dock(TOP)
        CAT:SetHeight(h * 0.075)
        CAT:SetPlaceholderText(RDV.LIBRARY.GetLang(nil, "VR_catLabel"))
        CAT:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        if ODATA and ODATA.Category then
            CAT:SetValue(ODATA.Category)
        end
        CAT.OnChange = function(self, text)
            DATA.CATEGORY = self:GetValue()
        end

        -- CLASS of VEHICLE

        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_classLabel"))

        local TEXT = vgui.Create("RDV_LIBRARY_TextEntry", SCROLL)
        TEXT:Dock(TOP)
        TEXT:SetHeight(h * 0.075)

        TEXT:SetPlaceholderText(RDV.LIBRARY.GetLang(nil, "VR_classLabel"))
        TEXT:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        if ODATA then
            TEXT:SetValue(ODATA.CLASS)
        end
        TEXT.OnChange = function(self, text)
            DATA.CLASS = self:GetValue()
        end

        -- MODEL of VEHICLE

        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_modelLabel"))

        local TEXT = vgui.Create("RDV_LIBRARY_TextEntry", SCROLL)
        TEXT:Dock(TOP)
        TEXT:SetHeight(h * 0.075)
        
        TEXT:SetPlaceholderText(RDV.LIBRARY.GetLang(nil, "VR_modelLabel"))
        TEXT:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        if ODATA then
            TEXT:SetValue(ODATA.MODEL)
        end
        TEXT.OnChange = function(self, text)
            DATA.MODEL = self:GetValue()
        end

        -- SPAWNS
        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_spawnsLabel"))

        local SVALS = {}

        local SPAWNS = vgui.Create( "DListView", SCROLL )
        SPAWNS:Dock( TOP )
        SPAWNS:SetMultiSelect( true )
        SPAWNS:AddColumn( RDV.LIBRARY.GetLang(nil, "VR_spawnsLabel") )
        SPAWNS:SetHeight(h * 0.3)
        SPAWNS:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        SPAWNS.OnRowRightClick = function(s, id, line)
            line:SetSelected(false)
        end   
        for k, v in ipairs(RDV.VEHICLE_REQ.SPAWNS) do
            local LINE = SPAWNS:AddLine(v.NAME) -- Add lines
            
            if DATA.SPAWNS[v.NAME] then
                SPAWNS:SelectItem(LINE)
            end
            
            SVALS[LINE:GetID()] = v.NAME
        end

        -- GRANT TEAMS
        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_grantTeams"))

        local GVALS = {}

        local GTEAMS = vgui.Create( "DListView", SCROLL )
        GTEAMS:Dock( TOP )
        GTEAMS:SetMultiSelect( true )
        GTEAMS:AddColumn( RDV.LIBRARY.GetLang(nil, "VR_teamLabel") )
        GTEAMS:SetHeight(h * 0.3)
        GTEAMS:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        GTEAMS.OnRowRightClick = function(s, id, line)
            line:SetSelected(false)
        end
        
        for k, v in ipairs(team.GetAllTeams()) do
            local LINE = GTEAMS:AddLine(v.Name) -- Add lines
            
            if DATA.GT[v.Name] then
                GTEAMS:SelectItem(LINE)
            end
            
            GVALS[LINE:GetID()] = k
        end

                
        -- REQUEST TEAMS
        CreateDivider(SCROLL, RDV.LIBRARY.GetLang(nil, "VR_requestTeams"))

        local RVALS = {}

        local RTEAMS = vgui.Create( "DListView", SCROLL )
        RTEAMS:Dock( TOP )
        RTEAMS:SetMultiSelect( true )
        RTEAMS:AddColumn( RDV.LIBRARY.GetLang(nil, "VR_teamLabel") )
        RTEAMS:SetHeight(h * 0.3)
        RTEAMS:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        RTEAMS.OnRowRightClick = function(s, id, line)
            line:SetSelected(false)
        end   
        for k, v in ipairs(team.GetAllTeams()) do
            local LINE = RTEAMS:AddLine(v.Name) -- Add lines
    
            if DATA.RT[v.Name] then
                RTEAMS:SelectItem(LINE)
            end
    
            RVALS[LINE:GetID()] = k
        end

        local SAVE = vgui.Create("RDV_LIBRARY_TextButton", FRAME)
        SAVE:Dock(BOTTOM)
        SAVE:SetText(RDV.LIBRARY.GetLang(nil, "VR_saveLabel"))
        SAVE:DockMargin(w * 0.025, h * 0.025, w * 0.025, h * 0.025)
        SAVE.DoClick = function(s)
            if !OKEY then
                for k, v in ipairs(RDV.VEHICLE_REQ.VEHICLES) do
                    if (DATA.NAME == v.NAME) then    
                        RDV.VEHICLE_REQ.SendNotification(LocalPlayer(), RDV.LIBRARY.GetLang(nil, "VR_nameTaken"))
            
                        return
                    end
                end
            end

            -- Spawns

            if !table.IsSequential(DATA.SPAWNS) then DATA.SPAWNS = {} end

            for k, v in ipairs(SPAWNS:GetSelected()) do
                local LINE = v:GetID()
            
                if !SVALS[LINE] then continue end
    
                table.insert(DATA.SPAWNS, SVALS[LINE])
            end


            -- Grant Teams
            if !table.IsSequential(DATA.GT) then DATA.GT = {} end

            for k, v in ipairs(GTEAMS:GetSelected()) do
                local LINE = v:GetID()
            
                if !GVALS[LINE] then continue end
    
                table.insert(DATA.GT, GVALS[LINE])
            end

            -- Request Teams

            if !table.IsSequential(DATA.RT) then DATA.RT = {} end

            for k, v in ipairs(RTEAMS:GetSelected()) do
                local LINE = v:GetID()
            
                if !RVALS[LINE] then continue end
    
                table.insert(DATA.RT, RVALS[LINE])
            end

            if !DATA.NAME or !DATA.CLASS then
                return
            end

            local json = util.TableToJSON((DATA or {}))
            local compressed = util.Compress(json)
            local length = compressed:len()
        
            net.Start("RDV_VR_SendVehicle")
                net.WriteUInt(length, 32)
                net.WriteData(compressed, length)
            net.SendToServer()

            CB()

            if IsValid(FRAME) then FRAME:Remove() end

            surface.PlaySound("reality_development/ui/ui_accept.ogg")
        end

        s.Think = function() end
    end
end

concommand.Add("rdv_vr_config", function()
    if !LocalPlayer():IsAdmin() then return end

    local FRAME = vgui.Create("RDV_LIBRARY_FRAME")
    FRAME:SetSize(ScrW() * 0.4, ScrH() * 0.5)
    FRAME:Center()
    FRAME:SetVisible(true)
    FRAME:MakePopup()
    FRAME:SetTitle(RDV.LIBRARY.GetLang(nil, "VR_npcOverhead"))

    local w, h = FRAME:GetSize()

    local SIDE = vgui.Create("RDV_LIBRARY_SIDEBAR", FRAME)

    local PANEL = vgui.Create("DPanel", FRAME)
    PANEL:Dock(FILL)
    PANEL.Paint = function() end
    PANEL.Think = function(self)
        SIDE:SelectPage(RDV.LIBRARY.GetLang(nil, "VR_spawnsLabel"))

        self.Think = function() end 
    end

    SIDE:AddPage(RDV.LIBRARY.GetLang(nil, "VR_spawnsLabel"), "HIF1mjs", function()
        local function REFRESH()
            local w, h = PANEL:GetSize()

            PANEL:Clear()

            local SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", PANEL)
            SCROLL:Dock(FILL)
            SCROLL:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
            SCROLL.Think = function(s)
                local C = 0
        
                SCROLL.PaintOver = function(self, w, h )
                    if C > 0 then return end
        
                    draw.SimpleText("No Data Available", "RDV_REQ_LabelFont", w * 0.5, h * 0.4, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
        
                SCROLL:Clear()
                
                for k, v in ipairs(RDV.VEHICLE_REQ.SPAWNS) do
                    if !v.PERM then continue end
        
                    C = C + 1
        
                    local LABEL = SCROLL:Add("DLabel")
                    LABEL:SetText("")
                    LABEL:SetHeight(h * 0.1)
                    LABEL:Dock(TOP)
                    LABEL:DockMargin(0, 0, 0, h * 0.015)
                    LABEL:SetMouseInputEnabled(true)
        
                    LABEL.PaintOver = function(self, w, h)
                        surface.SetDrawColor( RDV.LIBRARY.THEME.GREY )
                        surface.DrawOutlinedRect( 0, 0, w, h )
                        
                        draw.SimpleText(v.NAME, "RDV_REQ_LabelFont", w * 0.05, h * 0.5, COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    end
        
                    local BUY = vgui.Create("RDV_LIBRARY_TextButton", LABEL)
                    BUY:Dock(RIGHT)
                    BUY:SetText(RDV.LIBRARY.GetLang(nil, "VR_deleteLabel"))
                    BUY.DoClick = function(s)
                        LABEL:Remove()
                        
                        C = C - 1
        
                        net.Start("RDV_VR_DelSpawn")
                            net.WriteString(v.UID)
                        net.SendToServer()
        
                        surface.PlaySound("reality_development/ui/ui_accept.ogg")
                    end
        
                    local BUY = vgui.Create("RDV_LIBRARY_TextButton", LABEL)
                    BUY:Dock(RIGHT)
                    BUY:SetText(RDV.LIBRARY.GetLang(nil, "VR_editLabel"))
                    BUY.DoClick = function(s)
                        AddSpawn(FRAME, k)
                    end
                end
        
                local BUY = vgui.Create("RDV_LIBRARY_TextButton", PANEL)
                BUY:SetHeight(h * 0.15)
                BUY:Dock(BOTTOM)
                BUY:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
                BUY:SetText(RDV.LIBRARY.GetLang(nil, "VR_createLabel"))
                BUY.DoClick = function(self)
                    AddSpawn(FRAME)
                end

                s.Think = function() end
            end
        end

        REFRESH()
    end)

    SIDE:AddPage("Vehicles", "49WlRXK", function()
        local function REFRESH()
            local w, h = PANEL:GetSize()

            PANEL:Clear()

            local SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", PANEL)
            SCROLL:Dock(FILL)
            SCROLL:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
            SCROLL.Think = function(s)
                local C = 0

                SCROLL.PaintOver = function(self, w, h )
                    if C > 0 then return end

                    draw.SimpleText(RDV.LIBRARY.GetLang(nil, "VR_noData"), "RDV_REQ_LabelFont", w * 0.5, h * 0.4, COL_1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end

                for k, v in ipairs(RDV.VEHICLE_REQ.VEHICLES) do
                    if !v.PERM then continue end

                    C = C + 1

                    local LABEL = SCROLL:Add("DLabel")
                    LABEL:SetText("")
                    LABEL:SetHeight(h * 0.1)
                    LABEL:Dock(TOP)
                    LABEL:DockMargin(0, 0, 0, h * 0.015)
                    LABEL:SetMouseInputEnabled(true)

                    LABEL.PaintOver = function(self, w, h)
                        surface.SetDrawColor( RDV.LIBRARY.THEME.GREY )
                        surface.DrawOutlinedRect( 0, 0, w, h )

                        draw.SimpleText(v.NAME, "RDV_REQ_LabelFont", w * 0.05, h * 0.5, COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    end

                    local BUY = vgui.Create("RDV_LIBRARY_TextButton", LABEL)
                    BUY:Dock(RIGHT)
                    BUY:SetText(RDV.LIBRARY.GetLang(nil, "VR_deleteLabel"))
                    BUY.DoClick = function(s)
                        LABEL:Remove()
                        
                        C = C - 1

                        net.Start("RDV_VR_DelVehicle")
                            net.WriteString(v.UID)
                        net.SendToServer()
                    end

                    local BUY = vgui.Create("RDV_LIBRARY_TextButton", LABEL)
                    BUY:Dock(RIGHT)
                    BUY:SetText(RDV.LIBRARY.GetLang(nil, "VR_editLabel"))
                    BUY.DoClick = function(s)
                        AddVehicle(FRAME, k, function()
                            timer.Simple(0, REFRESH)
                        end )
                    end
                end

                local BUY = vgui.Create("RDV_LIBRARY_TextButton", PANEL)
                BUY:SetHeight(h * 0.15)
                BUY:Dock(BOTTOM)
                BUY:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
                BUY:SetText(RDV.LIBRARY.GetLang(nil, "VR_createLabel"))
                BUY.DoClick = function(self)
                    AddVehicle(FRAME, nil, function()
                        timer.Simple(0, REFRESH)
                    end )
                end

                s.Think = function() end
            end
        end

        REFRESH()
    end)
end)

net.Receive("RDV_VR_SendVehicle", function()
    local length = net.ReadUInt(32)
	local data = net.ReadData(length)
	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		return
	end

	local FINAL = util.JSONToTable(uncompressed)

    for k, v in ipairs(FINAL) do
        local OBJ = RDV.VEHICLE_REQ.AddVehicle(v.NAME)
        OBJ:SetCategory( (v.CATEGORY or "Uncategorized") )
        OBJ:SetClass(v.CLASS)
        OBJ:AddRequestTeams(v.RT)
        OBJ:AddGrantTeams(v.GT)
            
        if v.MODEL and v.MODEL ~= "" then
            OBJ:SetModel(v.MODEL)
        end

        if v.SPAWNS then
            for k, v in ipairs(v.SPAWNS) do
                OBJ:AddHangar(v)
            end
        end

        OBJ.UID = v.UID
        OBJ.PERM = true
    end
end )

net.Receive("RDV_VR_SendHangar", function()
    local length = net.ReadUInt(32)
	local data = net.ReadData(length)
	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		return
	end

	local FINAL = util.JSONToTable(uncompressed)
    
    for k, v in ipairs(FINAL) do
        local OBJ = RDV.VEHICLE_REQ.AddSpawn(v.NAME)
        OBJ:SetPosition(v.POS)
        OBJ:SetAngles(v.ANG)
        OBJ:AddRequestTeams(v.RT)
        OBJ:AddGrantTeams(v.GT)
        OBJ:SetMap(game.GetMap())

        OBJ.UID = v.UID
        OBJ.PERM = true
    end
end )

net.Receive("RDV_VR_DelSpawn", function()
    local UID = net.ReadString()

    for k, v in ipairs(RDV.VEHICLE_REQ.SPAWNS) do
        if v.UID == UID then
            table.remove(RDV.VEHICLE_REQ.SPAWNS, k)
        end
    end
end )

net.Receive("RDV_VR_DelVehicle", function()
    local UID = net.ReadString()

    for k, v in ipairs(RDV.VEHICLE_REQ.VEHICLES) do
        if v.UID == UID then
            table.remove(RDV.VEHICLE_REQ.VEHICLES, k)
        end
    end
end )