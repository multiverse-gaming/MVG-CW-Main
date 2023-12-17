local PANEL = {}

function PANEL:Init()
    self:SetFont("RD_FONTS_CORE_LABEL_LOWER")
end

function PANEL:Paint(w, h)
    surface.SetDrawColor( Color(122,132,137, 180) )
    surface.DrawOutlinedRect( 0, 0, w, h )

    self:DrawTextEntryText(color_white, color_white, color_white)
end

vgui.Register( "RDV_LIBRARY_TextEntry", PANEL, "DTextEntry" )