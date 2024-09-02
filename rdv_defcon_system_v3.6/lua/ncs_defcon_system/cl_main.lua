local DEFCON_NAME
local DEFCON_DESC
local DEFCON_COLOR

local MAX_LEN

local function SendNotification(msg)
    local CFG = NCS_DEFCON.CONFIG
	local PC = CFG.prefixcolor
	local PT = CFG.prefixtext

    NCS_DEFCON.AddText(LocalPlayer(), PC, "["..PT.."] ", color_white, msg)
end

local blur = Material( "pp/blurscreen" )

local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

--[[---------------------------------]]--
-- Defcon Changes
--[[---------------------------------]]--

local function CacheDefcon(num)
	local CFG = NCS_DEFCON.CONFIG.defconList

	if !CFG[num] then
		return false
	end

	NCS_DEFCON.CURRENT = num

	DEFCON_NAME = CFG[num].name

	DEFCON_DESC = CFG[num].desc

    DEFCON_DESC = DEFCON_DESC:gsub("//", "\n"):gsub("\\n", "\n")

    DEFCON_DESC = NCS_DEFCON.textWrap(DEFCON_DESC, "NCS_DEFCON_DescText", ScrW() * 0.175)

    DEFCON_COLOR = CFG[num].col
end

net.Receive("NCS_DEFCON_CHANGE", function()
	local UID = net.ReadUInt(8)
    local P = Entity(net.ReadUInt(8))
    local LOAD = net.ReadBool()

    local VAL = CacheDefcon(UID)

    if VAL == false then
        return
    end

    local CFG = NCS_DEFCON.CONFIG
    
    if !LOAD then
        if not CFG.displaychanger or not IsValid(P) then
            SendNotification(NCS_DEFCON.GetLang(nil, "DEF_levelChanged", {DEFCON_NAME}))
        else
            if not P.Name then
                return
            end

            SendNotification(NCS_DEFCON.GetLang(nil, "DEF_levelChangedP", {DEFCON_NAME, P:Name()}))
        end
    end

    surface.PlaySound("common/talk.wav")

    if CFG.defconList[UID] and CFG.defconList[UID].sound then
        surface.PlaySound( CFG.defconList[UID].sound )
    else
        if CFG.changesounden then
            surface.PlaySound( CFG.changesound )
        end
    end
    
    hook.Run("NCS_DEF_PlayerChangedDefcon", UID, P)
end)

--[[---------------------------------]]--
-- HUD
--[[---------------------------------]]--

local w, h = 0, 0
local boxColor = Color(0, 0, 0, 100)
local outlineColor = Color(122,132,137, 180)

hook.Add("HUDPaint", "NCS_DEFCON.HUDPaint", function()
	if not NCS_DEFCON.CONFIG.defconList[NCS_DEFCON.CURRENT] then return end

    if not DEFCON_DESC or DEFCON_DESC == "" then return end

    local W, H = ScrW(), ScrH()

    local CFG = NCS_DEFCON.CONFIG

    if CFG.disablehuddead and !LocalPlayer():Alive() then return end
    
    local AD = {
        H = CFG.adjusth,
        W = CFG.adjustw,
    }

    if !CFG.nobox then
        local boxPos = ( ( W * 0.9025 + (W * AD.W) ) - ( ( w / 2 ) ) )

        local White_Outline = Color(255,255,255,100)
        local White_Corners = Color(255,255,255,180)
        local Black_Transparent = Color(50,50,50,180)
        
        --drawBlur( boxPos, (H * AD.H) + (H * 0.01), w, h, 4, 5, 255 )

        --surface.SetDrawColor(boxColor)
        surface.SetDrawColor(Black_Transparent)
        surface.DrawRect(boxPos, (H * AD.H) + (H * 0.01), w, h)

        --surface.SetDrawColor(outlineColor)
        surface.SetDrawColor(White_Outline)
        surface.DrawOutlinedRect(boxPos, (H * AD.H) + (H * 0.01), w, h)

        surface.SetDrawColor(White_Corners)
        NCS_DEFCON.DrawDefconEdges(boxPos, (H * AD.H) + (H * 0.01), w, h, 8)
    end

    w, h = draw.SimpleText(DEFCON_NAME, "NCS_DEFCON_TitleText", W * 0.9025 + (W * AD.W), H * 0.01 + (H * AD.H), DEFCON_COLOR, TEXT_ALIGN_CENTER)

    draw.DrawText(DEFCON_DESC, "NCS_DEFCON_DescText", W * 0.9025 + (W * AD.W), H * 0.0375 + (H * AD.H), COL_WHITE, TEXT_ALIGN_CENTER)

    local nw, nh = surface.GetTextSize( DEFCON_DESC )

    w = ScrW() * 0.175 + W * 0.01
    h = h + nh
end)


net.Receive("RD_DEFCON_MENU", function()
    local FRAME = vgui.Create("NCS_DEF_FRAME")
    FRAME:SetSize(ScrW() * 0.2, ScrH() * 0.3)
    FRAME:Center()
    FRAME:SetVisible(true)
    FRAME:MakePopup()
    FRAME:SetTitle(NCS_DEFCON.GetLang(nil, "DEF_consoleLabel"))

    local w, h = FRAME:GetSize()
    local d_Count = 0

    local SCROLL = vgui.Create("NCS_DEF_SCROLL", FRAME)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(0, h * 0.01, 0, h * 0.01)
    SCROLL.Paint = function(s, w, h)
        if d_Count > 0 then return end

        draw.SimpleText(NCS_DEFCON.GetLang(nil, "DEF_noDefcons"), "NCS_DEF_FRAME_TITLE", w * 0.5, h * 0.4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    NCS_DEFCON.IsStaff(LocalPlayer(), function(checkPassed)
        for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
            if checkPassed or ( v.teams and v.teams[team.GetName(LocalPlayer():Team())] ) or v.allteams then
                d_Count = d_Count + 1

                local box_color = v.col

                local LABEL = SCROLL:Add("DLabel")
                LABEL:SetText("")
                LABEL:SetHeight(h * 0.15)
                LABEL:Dock(TOP)
                LABEL:SetMouseInputEnabled(true)
                LABEL:SetCursor("hand")
                LABEL:DockMargin(w * 0.02, h * 0.015, w * 0.02, h * 0.015)

                LABEL.Paint = function(self, w, h)
                    surface.SetDrawColor(box_color)
                    surface.DrawRect(0, 0, w, h)

                    surface.SetDrawColor(color_white)
                    surface.DrawOutlinedRect(0, 0, w, h)

                    if v.name then
                        draw.SimpleText(v.name, "NCS_DEFCON_TextLabel", w * 0.5, h * 0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                end
                LABEL.DoClick = function()
                    net.Start("NCS_DEFCON_CHANGE")
                        net.WriteUInt(k, 8)
                    net.SendToServer()
                end
            end
        end 
    end )
end)