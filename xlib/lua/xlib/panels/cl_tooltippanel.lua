local PANEL = {}

function PANEL:Init()
    self.HeaderText = xLib.Utils.DoText(self, "Header Text", "xLibSubHeaderFont", Color(109, 167, 255))
    self.HeaderText:SetPos(xLib.Utils.ScreenScale(5), xLib.Utils.ScreenScale(5, true))

    self.SubText = xLib.Utils.DoText(self, "Sub Text", "xLibSubHeaderFont", Color(255, 255, 255, 255))
    self.SubText:SetPos(xLib.Utils.ScreenScale(5), self.HeaderText:GetTall() + xLib.Utils.ScreenScale(10, true))

    self:SetSize(xLib.Utils.ScreenScale(150), xLib.Utils.ScreenScale(57, true))
end

function PANEL:PerformLayout() end

function PANEL:PositionTooltip()
	if ( !IsValid( self.TargetPanel ) ) then
		self:Close()
		return
	end

	self:InvalidateLayout( true )

	local x, y = input.GetCursorPos()
	local w, h = self:GetSize()

	local lx, ly = self.TargetPanel:LocalToScreen( 0, 0 )

	self:SetPos(math.Clamp(x + xLib.Utils.ScreenScale(10), 0, ScrW() - self:GetWide()), math.Clamp(y + xLib.Utils.ScreenScale(10, true), 0, ScrH() - self:GetTall()))
end

function PANEL:Paint(w, h)
    self:PositionTooltip()
    xLib.Utils.RoundedRect(xLib.Utils.ScreenScale(5), 0, 0, w, h, Color(55, 55, 55, 255))
end

function PANEL:SetText(tx)
    local txsplit = string.Split(tx or "", "\\")
    local toth = #txsplit * xLib.Utils.ScreenScale(29, true)

    self:SetSize(xLib.Utils.ScreenScale(150), toth + xLib.Utils.ScreenScale(5, true))

    self.HeaderText:SetText(txsplit[1] or "")
    self.HeaderText:SizeToContents()

    self.SubText:SetText(txsplit[2] or "")
    self.SubText:SizeToContents()

    if self.SubText:GetWide() > self:GetWide() then self:SetSize(self.SubText:GetWide() + xLib.Utils.ScreenScale(10), self:GetTall()) end

    local ypos = xLib.Utils.ScreenScale(5, true)
    for k, v in ipairs(txsplit) do
        local tx = xLib.Utils.DoText(self, v, "xLibSubHeaderFont", k == 1 and Color(109, 167, 255) or Color(255, 255, 255))
        tx:SetPos(xLib.Utils.ScreenScale(5), ypos)

        if tx:GetWide() > self:GetWide() then self:SetSize(tx:GetWide() + xLib.Utils.ScreenScale(10), self:GetTall()) end

        ypos = ypos + tx:GetTall() + xLib.Utils.ScreenScale(5, true)
    end
end

function PANEL:SetContents(pnl, bdelete)
    --
end

function PANEL:OpenForPanel(panel)
    self.TargetPanel = panel
	self:PositionTooltip()
end

function PANEL:Close()
    self:Remove()
end

derma.DefineControl("xLibTooltipPanel", "", PANEL, "DTooltip")