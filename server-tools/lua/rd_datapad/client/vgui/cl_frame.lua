surface.CreateFont( "RDV_DAP_FRAME_TITLE", {
	font = "Bebas Neue", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = ScrW() * 0.0135,
} )

local blur = Material("pp/blurscreen")

local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)

    local scrW, scrH = ScrW(), ScrH()

    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

local PANEL = {}

PANEL.Paint = function(s, w, h)
    DrawBlur(s, 6)
    
    surface.SetDrawColor( Color(0,0,0, 250) )
    surface.DrawRect( 0, 0, w, h )

    surface.SetDrawColor( Color(122,132,137, 180) )
    surface.DrawOutlinedRect( 0, 0, w, h )
end

PANEL.Init = function(s)
    local FRAME = s

    s.Header = vgui.Create("Panel", s)
    s.Header:Dock(TOP)
    s.Header:PaintManual(true)
    s.Header.Paint = function(_, w, h)
        surface.SetDrawColor( Color(122,132,137, 180) )
        surface.DrawOutlinedRect( 0, 0, w, h )

        draw.SimpleText((FRAME:GetTitle() or ""), "RDV_DAP_FRAME_TITLE", w * 0.01, h * 0.5, COL_2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local w, h = s.Header:GetSize()

    s.CloseButton = vgui.Create("DButton", s.Header)
    s.CloseButton:SetWide(w * 0.4)
    s.CloseButton:Dock(RIGHT)
    s.CloseButton:SetText("X")
    s.CloseButton:SetFont("RDV_DAP_FRAME_TITLE")
    s.CloseButton:SetTextColor(Color(255,0,0))
    
    s.CloseButton.DoClick = function(pnl)
        s:Remove()
    end

    s.CloseButton.Paint = function(pnl, w ,h)
        if pnl:IsHovered() then
            pnl:SetTextColor(Color(255,0,0))
        else
            pnl:SetTextColor(Color(255,255,255))
        end
    end
end

AccessorFunc(PANEL, "m_rd_titletext", "Title", FORCE_STRING)

vgui.Register("RDV_DAP_FRAME", PANEL, "EditablePanel")