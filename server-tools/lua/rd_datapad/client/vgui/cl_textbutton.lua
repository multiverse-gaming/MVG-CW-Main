local PANEL = {}

function PANEL:Init()
    self.HOVERED = false
    self:SetFont("RDV_DAP_FRAME_TITLE")
    self:SetTextColor(color_white)
end

function PANEL:Paint(w, h)
    local COL

    if !self.HOVERED then
        COL = Color(122,132,137, 180)
    else
        COL = Color(252,180,9,255)
    end

    surface.SetDrawColor(COL)
    surface.DrawOutlinedRect( 0, 0, w, h )
end
function PANEL:OnCursorEntered()
    surface.PlaySound("rdv/new/slider.mp3")

    self:SetTextColor(Color(252,180,9,255))
    self.HOVERED = true
end

function PANEL:OnCursorExited()
    self:SetTextColor(color_white)
    self.HOVERED = false
end


vgui.Register("RDV_DAP_TextButton", PANEL, "DButton")