local PANEL = {}

AccessorFunc(PANEL, "m_bgWidth", "BackgroundWidth")
AccessorFunc(PANEL, "m_bgHeight", "BackgroundHeight")

function PANEL:Init()
  self.background = vgui.Create("XeninUI.Frame", self)
  self.background.Paint = function(pnl, w, h)
    local x, y = pnl:LocalToScreen(0, 0)

    BSHADOWS.BeginShadow()
    draw.RoundedBox(6, x, y, w, h, XeninUI.Theme.Background)
    BSHADOWS.EndShadow(1, 2, 2, 150, 0, 0)
  end
  self.background.closeBtn.DoClick = function(pnl)
    self:Remove()
  end
end

function PANEL:Paint(w, h)
  surface.SetDrawColor(20, 20, 20, 160)
  surface.DrawRect(0, 0, w, h)
end

function PANEL:PerformLayout(w, h)
  self.background:SetSize(self:GetBackgroundWidth(), self:GetBackgroundHeight())
  self.background:Center()
end

function PANEL:SetTitle(str)
  self.background:SetTitle(str)
end

vgui.Register("XeninUI.Popup", PANEL, "EditablePanel")
