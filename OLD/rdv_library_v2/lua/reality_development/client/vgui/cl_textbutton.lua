local PANEL = {}

function PANEL:Init()
    self.HOVERED = false
    self:SetFont("RDV_LIB_FRAME_TITLE")
    self:SetTextColor(color_white)
end

function PANEL:Paint(w, h)
    local COL

    if !self.HOVERED then
        COL = RDV.LIBRARY.GetConfigOption("LIBRARY_outlineTheme")
    else
        COL = RDV.LIBRARY.GetConfigOption("LIBRARY_hoverTheme")
    end

    surface.SetDrawColor(COL)
    surface.DrawOutlinedRect( 0, 0, w, h )
end
function PANEL:OnCursorEntered()
    surface.PlaySound(RDV.LIBRARY.GetConfigOption("LIBRARY_hoverSound"))

    self:SetTextColor(RDV.LIBRARY.GetConfigOption("LIBRARY_hoverTheme"))
    self.HOVERED = true
end

function PANEL:OnCursorExited()
    self:SetTextColor(color_white)
    self.HOVERED = false
end


vgui.Register("RDV_LIBRARY_TextButton", PANEL, "DButton")