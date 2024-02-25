local REQUEST_GRANTEE_FRAME
local REQUEST_GRANTEE_SCROLL

--[[----------------------------------------------------------------]]--
--  Send the request to all players who can grant it.
--[[----------------------------------------------------------------]]--
local SKINS = {}

local function SelectHangar(FRAMED, V_CLASS)
    if not V_CLASS then
        return
    end

    local V_TAB = RDV.VEHICLE_REQ.VEHICLES[V_CLASS]

    if not V_TAB then
        return
    end

    local COUNT = 0

    local FRAME_HANGARS = vgui.Create("RDV_LIBRARY_FRAME")
    FRAME_HANGARS:SetSize(ScrW() * 0.3, ScrH() * 0.4)
    FRAME_HANGARS:Center()
    FRAME_HANGARS:MakePopup(true)
    FRAME_HANGARS:SetMouseInputEnabled(true)
    FRAME_HANGARS:SetTitle(RDV.LIBRARY.GetLang(nil, "VR_npcOverhead"))
    FRAME_HANGARS.OnRemove = function()
        if IsValid(FRAMED) then
            FRAMED:SetVisible(true)
        end
    end

    local w, h = FRAME_HANGARS:GetSize()

    local LUnavailableSpawns = RDV.LIBRARY.GetLang(nil, "VR_unavailableSpawns")

    local SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", FRAME_HANGARS)
    SCROLL:Dock(FILL)
    SCROLL:SetMouseInputEnabled(true)
    SCROLL.PaintOver = function(self, w, h)
        if COUNT <= 0 then
            draw.SimpleText(LUnavailableSpawns, "RDV_REQ_LabelFont", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    if IsValid(FRAMED) then
        FRAMED:SetVisible(false)
    end

    if COUNT > 0 then
        local nameLabel = RDV.LIBRARY.GetLang(nil, "VR_nameLabel")
        local statusLabel = RDV.LIBRARY.GetLang(nil, "VR_statusLabel")
        local distanceLabel = RDV.LIBRARY.GetLang(nil, "VR_distanceLabel")

        local label = SCROLL:Add("DButton")
        label:SetSize(0, h * 0.1)
        label:DockMargin(w * 0.01, 0, w * 0.01, 0)
        label:Dock(TOP)
        label:SetText("")
        label.Paint = function(self, w, h)
            draw.SimpleText(nameLabel, "RDV_REQ_LabelFont", w * 0.05, h * 0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            draw.SimpleText(statusLabel, "RDV_REQ_LabelFont", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            draw.SimpleText(distanceLabel, "RDV_REQ_LabelFont", w * 0.95, h * 0.5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end
    end

    for k, v in ipairs(RDV.VEHICLE_REQ.SPAWNS) do
        if !V_TAB.BL_EMPTY and V_TAB.BLACKLIST[v.NAME] then continue end
        if !V_TAB.WL_EMPTY and !V_TAB.SPAWNS[v.NAME] then continue end

        if ( v.MAP ~= game.GetMap() ) then continue end

        if not table.IsEmpty(v.TEAMS) and not v.TEAMS[team.GetName(LocalPlayer():Team())] then
            continue
        end
        
        if v.CanRequest and ( v:CanRequest(LocalPlayer()) == false ) then
            continue
        end
        
        local DISTANCE = (string.Explode(".", v.Position:Distance(LocalPlayer():GetPos()) / 52.49))[1]

        if RDV.VEHICLE_REQ.CFG.Distance then
            if tonumber(DISTANCE) >= (RDV.VEHICLE_REQ.CFG.Distance or 500) then
                continue
            end
        end

        COUNT = COUNT + 1

        local should_2 = true

        local HANGAR_IN_USE = RDV.VEHICLE_REQ.IsHangarInUse(k)

        local claimedLabel = RDV.LIBRARY.GetLang(nil, "VR_claimedLabel")
        local unclaimedLabel = RDV.LIBRARY.GetLang(nil, "VR_unclaimedLabel")

        local label = SCROLL:Add("DLabel")
        label:SetSize(0, h * 0.1)
        label:DockMargin(w * 0.01, h * 0.01, w * 0.01, 0)
        label:Dock(TOP)
        label:SetText("")
        label:SetMouseInputEnabled(true)
        label.Paint = function(self, w, h)
            local HOV = self:IsHovered()
            local COL = RDV.VEHICLE_REQ.THEME.BF2_GREY

            if HOV then
                COL = RDV.VEHICLE_REQ.THEME.BF2_YELLOW 
            end

            surface.SetDrawColor( COL )
            surface.DrawOutlinedRect( 0, 0, w, h )

            draw.SimpleText(v.NAME, "RDV_REQ_LabelFont", w * 0.05, h * 0.5, ( (HOV and COL) or color_white ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            draw.SimpleText("("..(HANGAR_IN_USE and claimedLabel or unclaimedLabel)..")", "RDV_REQ_LabelFont", w * 0.5, h * 0.5, ( (HOV and COL) or color_white ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            draw.SimpleText(DISTANCE.."m", "RDV_REQ_LabelFont", w * 0.95, h * 0.5, ( (HOV and COL) or color_white ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        label.OnCursorEntered = function(self)
            surface.PlaySound("rdv/new/slider.mp3")
        end

        label.DoClick = function() 
            surface.PlaySound("rdv/new/activate.mp3")

            if IsValid(FRAMED) then FRAMED:Remove() end
            if IsValid(FRAME_HANGARS) then FRAME_HANGARS:Remove() end

            net.Start("RDV.VEHICLE_REQ.START")
                net.WriteUInt(V_CLASS, 8)
                net.WriteUInt(k, 8)

                if SKINS[V_CLASS] then
                    net.WriteUInt(SKINS[V_CLASS], 8)
                end
            net.SendToServer()
        end
    end
end

local TAB = {}
local NTAB = {}

local DELAY = CurTime()

hook.Add("Tick", "RDV.ASDSDS", function()
    if DELAY > CurTime() then
        return
    end

    local COUNT = #TAB

    for i = 1, COUNT do
        if !TAB[i] or !TAB[i].TIME then
            continue
        end

        TAB[i].TIME = TAB[i].TIME - 1

        if TAB[i].TIME <= 0 then
            table.remove(TAB, i)
        end
    end

    DELAY = CurTime() + 1
end)

local function AddLabel(SHIP, HANGAR, UID, TIME)
    if not RDV.VEHICLE_REQ.VEHICLES[SHIP] then
        return
    end
    
    local PLAYER = Entity(UID)

    if !IsValid(PLAYER) then
        return
    end

    local INS

    if !TIME then
        TIME = ( RDV.VEHICLE_REQ.CFG.Waiting or 60 )

        INS = table.insert(TAB, {
            TIME = TIME,
            UID = UID,
        })

        NTAB[UID] = INS
    end

    local PCOLOR = team.GetColor(PLAYER:Team())
    local PNAME = PLAYER:Name()

    local SNAME = ( RDV.VEHICLE_REQ.VEHICLES[SHIP].NAME or "INVALID" )
    local HNAME = ( RDV.VEHICLE_REQ.SPAWNS[HANGAR].NAME or "INVALID" )

    if not IsValid(REQUEST_GRANTEE_FRAME) then
        local LTitle = RDV.LIBRARY.GetLang(nil, "VR_requestsTitle")

        REQUEST_GRANTEE_FRAME = vgui.Create("RDV_LIBRARY_FRAME")
        REQUEST_GRANTEE_FRAME:SetSize(ScrW() * 0.2, ScrH() * 0.35)
        REQUEST_GRANTEE_FRAME:SetPos(ScrW() * 0.01, ScrH() * 0.35)
        REQUEST_GRANTEE_FRAME:SetMouseInputEnabled(true)
        REQUEST_GRANTEE_FRAME:SetTitle(LTitle)

        REQUEST_GRANTEE_SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", REQUEST_GRANTEE_FRAME)
        REQUEST_GRANTEE_SCROLL:Dock(FILL)
    end

    local w, h = REQUEST_GRANTEE_FRAME:GetSize()

    local label = REQUEST_GRANTEE_SCROLL:Add("RDV_LIBRARY_TextButton")
    label:SetSize(0, h * 0.2)
    label:DockMargin(w * 0.03, h * 0.015, w * 0.03, 0)
    label:Dock(TOP)
    label:SetText("")
    label.PaintOver = function(self, w, h)
        draw.SimpleText(SNAME, "RDV_REQ_LabelFont", w * 0.5, h * 0.2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        draw.SimpleText(HNAME, "RDV_REQ_LabelFont", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if not IsValid(PLAYER) then
            self:Remove()
            return
        end

        if !TAB[INS] then
            self:Remove()
            return
        end

        draw.SimpleText(PNAME.." ("..TAB[INS].TIME..")", "RDV_REQ_LabelFont", w * 0.5, h * 0.8, PCOLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end 
    label.DoClick = function()
        if not IsValid(PLAYER) then
            return
        end

        surface.PlaySound("rdv/new/activate.mp3")

        local LGrant = RDV.LIBRARY.GetLang(nil, "VR_grantLabel")
        local LDeny = RDV.LIBRARY.GetLang(nil, "VR_denyLabel")

        local MenuButtonOptions = DermaMenu()

        MenuButtonOptions:AddOption(LGrant, function()
            net.Start("RDV.VEHICLE_REQ.GRANT")
                net.WriteUInt(UID, 8)
            net.SendToServer()
        end)

        MenuButtonOptions:AddOption(LDeny, function()
            net.Start("RDV.VEHICLE_REQ.DENY")
                net.WriteUInt(UID, 8)
            net.SendToServer()
        end)

        MenuButtonOptions:Open()
    end

    RDV.VEHICLE_REQ.ACTIVE[UID] = {
        Ship = SHIP,
        Hangar = HANGAR,
        Label = label,
    }
end

--[[----------------------------------------------------------------]]--
--  Purge the player because they've been denied / accepted/
--[[----------------------------------------------------------------]]--

net.Receive("RDV.VEHICLE_REQ.CLEAR", function()
    local UID = net.ReadUInt(8)

    if !RDV.VEHICLE_REQ.ACTIVE or !RDV.VEHICLE_REQ.ACTIVE[UID] then
        return
    end

    local label = RDV.VEHICLE_REQ.ACTIVE[UID].Label

    if IsValid(label) then
        label:Remove()
    end

    RDV.VEHICLE_REQ.ACTIVE[UID] = nil

    if RDV.VEHICLE_REQ.ACTIVE and table.Count(RDV.VEHICLE_REQ.ACTIVE) <= 0 then
        if IsValid(REQUEST_GRANTEE_FRAME) then
            REQUEST_GRANTEE_FRAME:Remove()
        end
    end

    local INS = NTAB[UID]

    table.remove(TAB, INS)
    
    NTAB[UID] = nil
end)


net.Receive("RDV.VEHICLE_REQ.INITIAL", function()
    local COUNT = net.ReadUInt(8)

    for i = 1, COUNT do
        local SHIP = net.ReadUInt(8)
        local HANGAR = net.ReadUInt(8)
        local UID = net.ReadUInt(8)
        local TIME = net.ReadUInt(8)

        AddLabel(SHIP, HANGAR, UID, TIME)
    end
end)

net.Receive("RDV.VEHICLE_REQ.ASK", function()
    local SHIP = net.ReadUInt(8)
    local HANGAR = net.ReadUInt(8)
    local UID = net.ReadUInt(8)

    AddLabel(SHIP, HANGAR, UID)

    surface.PlaySound("buttons/blip1.wav")
end)

--[[----------------------------------------------------------------]]--
--  Main Request Menu
--[[----------------------------------------------------------------]]--

local function ChangeIcon(ICON, model)
    if !model then return end

    if !string.find(model, ".mdl") then
        local TAB = scripted_ents.GetStored(model)

        if !TAB or !TAB.t or !TAB.t.MDL then
            return
        end
            
        model = scripted_ents.GetStored(model).t.MDL
    end

    if model and model ~= "" then
        ICON:SetModel(model)

        local mn, mx = ICON.Entity:GetRenderBounds()
        mn = mn * 0.7
        mx = mx * 0.7
    
        local size = 0
    
        size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
        size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
        size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
    
        ICON:SetCamPos(Vector(size, size, size))
        ICON:SetLookAt((mn + mx) * 0.55)
        ICON:SetAmbientLight( color_white )
    else
        return
    end
end

net.Receive("RDV.VEHICLE_REQ.MENU", function()
    local MODEL = RDV.VEHICLE_REQ.CFG.Menu.Model
    local ICON
    local B_SKIN

    local SELECTED
    local V_CLASS
    
    local FRAMED = vgui.Create("RDV_LIBRARY_FRAME")
    FRAMED:SetSize(ScrW() * 0.6, ScrH() * 0.7)
    FRAMED:Center()
    FRAMED:MakePopup(true)
    FRAMED:SetMouseInputEnabled(true)
    FRAMED:SetTitle(RDV.LIBRARY.GetLang(nil, "VR_npcOverhead"))

    local w,h = FRAMED:GetSize()

    local SIDE = vgui.Create("RDV_LIBRARY_SIDEBAR", FRAMED)


    local PANEL = vgui.Create("DPanel", FRAMED)
    PANEL:Dock(FILL)
    PANEL.Paint = function() end
    PANEL.Think = function(self) SIDE:SelectPage(RDV.LIBRARY.GetLang(nil, "VR_requestLabel")) self.Think = function() end end

    --[[--------------------------------------------------------]]--
    --  Left side of the panel (scrollbar)
    --[[--------------------------------------------------------]]--

    SIDE:AddPage(RDV.LIBRARY.GetLang(nil, "VR_requestLabel"), "sx1yoq4", function()
        PANEL:Clear()

        local PANEL_LEFT = vgui.Create("DPanel", PANEL)
        PANEL_LEFT:SetSize(w * 0.35, h)
        PANEL_LEFT:Dock(LEFT)
        PANEL_LEFT.Paint = function() end
        PANEL_LEFT:SetMouseInputEnabled(true)

        local COUNT = 0

        local LVehiclesUnavailable = RDV.LIBRARY.GetLang(nil, "VR_vehiclesUnavailable")

        local SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", PANEL_LEFT)
        SCROLL:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)
        SCROLL:Dock(FILL)
        SCROLL:SetMouseInputEnabled(true)
        SCROLL.PaintOver = function(self, w, h)
            if COUNT <= 0 then
                draw.SimpleText(LVehiclesUnavailable, "RDV_REQ_LabelFont", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end

        local DELAY = 0.5 + SysTime()

        SCROLL.Think = function(self, w, h)
            if DELAY > SysTime() then
                return
            end

            DELAY = 0.5 + SysTime()

            if not self:IsChildHovered() then
                if !V_CLASS then
                    return
                end

                local VEH = RDV.VEHICLE_REQ.VEHICLES[V_CLASS]

                if !VEH then
                    return
                end

                if ICON:GetModel() ~= VEH.MODEL then
                    ChangeIcon(ICON, VEH.MODEL)
                end

                if SKINS[V_CLASS] then
                    ICON.Entity:SetSkin(SKINS[V_CLASS])
                elseif VEH.SKIN then
                    ICON.Entity:SetSkin(VEH.SKIN)
                end
            end
        end

        local CATEGORIES = {}

        for k, v in ipairs(RDV.VEHICLE_REQ.VEHICLES) do
            if not table.IsEmpty(v.TEAMS) and not v.TEAMS[team.GetName(LocalPlayer():Team())] then
                continue
            end

            if v.CanRequest and ( v:CanRequest(LocalPlayer()) == false ) then
                continue
            end

            COUNT = COUNT + 1

            if not CATEGORIES[v.Category] then
                local D_CATEGORY = SCROLL:Add("DCollapsibleCategory")

                local CAT_LABEL = D_CATEGORY:GetChildren()[1]
        
                D_CATEGORY:Dock(TOP)
                D_CATEGORY:SetLabel( v.Category )
                D_CATEGORY:DockMargin(0, 0, 0, h * 0.035)
                D_CATEGORY:SetTall(D_CATEGORY:GetTall() * 1.25)
                D_CATEGORY:DockPadding(0, 0, 0, h * 0.025)
                D_CATEGORY.Paint = function(s, w, h) 
                    surface.SetDrawColor( RDV.VEHICLE_REQ.THEME.BF2_GREY )
                    surface.DrawOutlinedRect( 0, 0, w, h )
                end
                D_CATEGORY.OnToggle = function(s, B)
                    if B then
                        CAT_LABEL:SetTextColor(RDV.VEHICLE_REQ.THEME.BF2_YELLOW)
                    else
                        CAT_LABEL:SetTextColor(color_white)
                    end
                end
        
                CAT_LABEL:SetTextColor(RDV.VEHICLE_REQ.THEME.BF2_YELLOW)
                CAT_LABEL:SetContentAlignment(5)
                CAT_LABEL:SetFont("RDV_REQ_LabelFont")
                CAT_LABEL:SetTall(CAT_LABEL:GetTall() * 1.5) 
                CAT_LABEL.Paint = function(s, w, h) 
                    surface.SetDrawColor( RDV.VEHICLE_REQ.THEME.BF2_GREY )
                    surface.DrawOutlinedRect( 0, 0, w, h )
                end

                CATEGORIES[v.Category] = D_CATEGORY
            end

            local CATEGORY = CATEGORIES[v.Category]
            
            local FORMAT

            if v.PRICE then
                FORMAT = RDV.LIBRARY.FormatMoney(nil, v.PRICE)
            end

            local label = CATEGORY:Add("RDV_LIBRARY_TextButton")
            label:SetSize(0, h * 0.1)
            label:DockMargin(w * 0.015, h * 0.015, w * 0.015, h * 0.015)
            label:Dock(TOP)
            label:SetText("")

            local LAccept = RDV.LIBRARY.GetLang(nil, "VR_acceptLabel")

            local BUTTON = vgui.Create("RDV_LIBRARY_TextButton", label)
            BUTTON:Dock(RIGHT)
            BUTTON:SetText(LAccept)
            BUTTON.DoClick = function(s)                
                if (SELECTED ~= BUTTON ) then
                    if IsValid(SELECTED) then
                        SELECTED:SetText(LAccept)
                    end

                    BUTTON:SetText(RDV.LIBRARY.GetLang(nil, "VR_confirmLabel"))

                    SELECTED = BUTTON
                    V_CLASS = k

                    surface.PlaySound("rdv/new/activate.mp3")

                    if v.MODEL then
                        ChangeIcon(ICON, v.MODEL)
    
                        local BGS = v.BODYGROUPS
    
                        if istable(BGS) then
                            for k, v in pairs(BGS) do
                                ICON.Entity:SetBodygroup(k, v)
                            end
                        end
    
                        if SKINS[k] then
                            ICON.Entity:SetSkin(SKINS[k])
                        elseif v.SKIN then
                            ICON.Entity:SetSkin(v.SKIN)
                        end
                    end
                else
                    SelectHangar(FRAMED, k)
                end
            end

            local LChangeSkin = RDV.LIBRARY.GetLang(nil, "VR_changeSkin")

            label.Paint = function(self, w, h)
                local COL = RDV.VEHICLE_REQ.THEME.BF2_GREY
            
                surface.SetDrawColor(COL)
                surface.DrawOutlinedRect( 0, 0, w, h )

                if FORMAT then
                    draw.SimpleText(FORMAT, "RDV_REQ_LabelFont", w * 0.95, h * 0.5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(v.NAME, "RDV_REQ_LabelFont", w * 0.05, h * 0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText(v.NAME, "RDV_REQ_LabelFont", w * 0.05, h * 0.5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end
            end
            label.DoClick = function()
                surface.PlaySound("rdv/new/activate.mp3")

                if IsValid(B_SKIN) and v.CUSTOMIZABLE then
                    B_SKIN:SetText(LChangeSkin.." ("..ICON.Entity:GetSkin()..")")
                end
            end
        end

        local DOCKER = vgui.Create("DPanel", PANEL_LEFT)
        DOCKER:SetSize(0, h * 0.1)
        DOCKER:DockMargin(0, h * 0.02, w * 0.02, h * 0.02)

        DOCKER:Dock(BOTTOM)
        DOCKER:SetMouseInputEnabled(true)
        DOCKER.Paint = function() end

        local returnLabel = RDV.LIBRARY.GetLang(nil, "VR_returnLabel")

        local RETURN = vgui.Create("RDV_LIBRARY_TextButton", DOCKER)
        RETURN:Dock(FILL)
        RETURN:SetText(returnLabel)

        RETURN.DoClick = function()
            surface.PlaySound("rdv/new/activate.mp3")

            net.Start("RDV.VEHICLE_REQ.RETURN")
            net.SendToServer()
        end

        --[[--------------------------------------------------------]]--
        --  Left side of the panel (ModelPanel)
        --[[--------------------------------------------------------]]--

        local PANEL_RIGHT = vgui.Create("DPanel", PANEL)
        PANEL_RIGHT:Dock(FILL)
        PANEL_RIGHT.Paint = function() end
        PANEL_RIGHT:SetMouseInputEnabled(true)

        B_SKIN = vgui.Create("RDV_LIBRARY_TextButton", PANEL_RIGHT)
        B_SKIN:SetText("N/A")
        B_SKIN:SetSize(w, h * 0.1)
        B_SKIN:DockMargin(w * 0.05, h * 0.05, w * 0.05, h * 0.05)
        B_SKIN:Dock(BOTTOM)
        B_SKIN.DoClick = function()
            if !V_CLASS then
                return
            end


            if RDV.VEHICLE_REQ.VEHICLES[V_CLASS].CUSTOMIZABLE then
                surface.PlaySound("rdv/new/activate.mp3")

                local skinLabel = RDV.LIBRARY.GetLang(nil, "VR_skinLabel")
                local changeSkinLabel = RDV.LIBRARY.GetLang(nil, "VR_changeSkin")

                local MenuButtonOptions = DermaMenu() -- Creates the menu

                for i = 1, ICON.Entity:SkinCount() do
                    MenuButtonOptions:AddOption(skinLabel.." "..i, function() 
                        ICON.Entity:SetSkin(i)

                        if IsValid(B_SKIN) then
                            B_SKIN:SetText(changeSkinLabel.." ("..i..")")
                        end

                        SKINS[V_CLASS] = i
                    end )
                end

                MenuButtonOptions:Open() -- Open the menu AFTER adding your options
            end
        end

        
        ICON = vgui.Create("DModelPanel", PANEL_RIGHT)
        ICON:Dock(FILL)
        ICON:SetSize(w * 0.25, h)
        
        ChangeIcon(ICON, MODEL)
    end)

    if RDV.VEHICLE_REQ.CFG.Tabs["active"] then
        SIDE:AddPage(RDV.LIBRARY.GetLang(nil, "VR_activeLabel"), "t96pum1", function()
            PANEL:Clear()

            local COUNT = 0
            
            local SCROLL = vgui.Create("RDV_LIBRARY_SCROLL", PANEL)
            SCROLL:DockMargin(w * 0.01, h * 0.01, 0, 0)
            SCROLL:Dock(FILL)
            SCROLL:SetMouseInputEnabled(true)
            SCROLL.PaintOver = function(self, w, h)
                if COUNT <= 0 then
                    draw.SimpleText(RDV.LIBRARY.GetLang(nil, "VR_noVehiclesActive"), "RDV_REQ_LabelFont", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end

            SCROLL.Think = function(self)
                local w, h = self:GetSize()

                for k, v in ipairs(player.GetAll()) do
                    if v:InVehicle() and IsValid(v:GetVehicle()) and RDV.VEHICLE_REQ.NSVehicles[v:GetVehicle():GetClass()] then
                        local PCOLOR = team.GetColor(v:Team())

                        local CLASS = v:GetVehicle():GetClass()
                        local TAB = scripted_ents.Get(CLASS)
                        local NAME = ( TAB and TAB.PrintName or CLASS )

                        local label = SCROLL:Add("RDV_LIBRARY_TextButton")
                        label:SetSize(0, h * 0.1)
                        label:DockMargin(0, h * 0.01, 0, 0)
                        label:Dock(TOP)
                        label:SetText("")

                        label.PaintOver = function(self, w, h)
                            if !IsValid(v) or !IsValid(v:GetVehicle()) then
                                self:Remove()
                                return
                            end

                            local HP = RDV.LIBRARY.GetLang(nil, "VR_hpLabel", {v:GetVehicle():Health()})

                            draw.SimpleText(v:Name(), "RDV_REQ_LabelFont", w * 0.05, h * 0.5, PCOLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                            draw.SimpleText(NAME, "RDV_REQ_LabelFont", w * 0.5, h * 0.5, COL_USE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                            draw.SimpleText(HP, "RDV_REQ_LabelFont", w * 0.95, h * 0.5, COL_USE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

                        end

                        COUNT = COUNT + 1
                    end
                end

                self.Think = function() end
            end
        end)
    end
end)


hook.Add( "PostDrawTranslucentRenderables", "test", function( bDepth, bSkybox )
    if !RDV.VEHICLE_REQ.CFG.HDisplay then return end
    
    for k, v in ipairs(RDV.VEHICLE_REQ.SPAWNS) do
        if v.MAP and v.MAP ~= game.GetMap() then continue end
        
        local POS = v.Position

        if ( POS:DistToSqr(LocalPlayer():GetPos()) > 1000000 ) then
            continue
        end

        local POS2 = Vector(POS.x, POS.y, POS.z + 1)

        cam.Start3D2D(POS2, Angle(0, CurTime(), 0), 1)
            surface.DrawCircle( 0, 0, RDV.VEHICLE_REQ.CFG.Size, color_white )
        cam.End3D2D()

        cam.Start3D2D(POS2, Angle(0, 0, 0), 0.75)
            draw.SimpleText(v.NAME, "RD_FONTS_CORE_OVERHEAD", 0, 0, color_white, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end)