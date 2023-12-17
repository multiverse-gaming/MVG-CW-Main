local PANEL = {}

function PANEL:Init()
    local CAT_LABEL = self:GetChildren()[1]

    CAT_LABEL:SetTextColor(RDV.LIBRARY.GetConfigOption("LIBRARY_hoverTheme"))
    CAT_LABEL:SetContentAlignment(5)
    CAT_LABEL:SetFont("RDV_LIB_FRAME_TITLE")
    CAT_LABEL:SetTall(CAT_LABEL:GetTall() * 1.5) 
    CAT_LABEL.Paint = function(s, w, h) 
        surface.SetDrawColor( RDV.LIBRARY.GetConfigOption("LIBRARY_outlineTheme") )
        surface.DrawOutlinedRect( 0, 0, w, h )
    end
end

function PANEL:OnToggle(B)
    local CAT_LABEL = self:GetChildren()[1]

    if B then
        CAT_LABEL:SetTextColor(RDV.LIBRARY.GetConfigOption("LIBRARY_hoverTheme"))
    else
        CAT_LABEL:SetTextColor(color_white)
    end
end

function PANEL:Paint(w, h)
    surface.SetDrawColor( RDV.LIBRARY.GetConfigOption("LIBRARY_outlineTheme") )
    surface.DrawOutlinedRect( 0, 0, w, h )
end



vgui.Register("RDV_LIBRARY_CollapsibleCategory", PANEL, "DCollapsibleCategory")