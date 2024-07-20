-- Modified from Garry's Mod DRGBPicker

local PANEL = {}

AccessorFunc(PANEL, "m_RGB", "RGB")

function PANEL:Init()
	self:SetRGB(color_white)

	self.Material = Material("xlib/colors.png")

	self.LastX = -100
	self.LastY = -100
end

function PANEL:GetPosColor( x, y )
	local con_x = (x / self:GetWide()) * self.Material:Width()
	local con_y = (y / self:GetTall()) * self.Material:Height()

	con_x = math.Clamp(con_x, 0, self.Material:Width() - 1)
	con_y = math.Clamp(con_y, 0, self.Material:Height() - 1)

	local col = self.Material:GetColor(con_x, con_y)

	return col, con_x, con_y
end

function PANEL:OnCursorMoved(x, y)
	if (not input.IsMouseDown(MOUSE_LEFT)) then return end

	local col = self:GetPosColor(x, y)

	if (col) then
		self.m_RGB = col
		self.m_RGB.a = 255
		self:OnChange(self.m_RGB)
	end

	self.LastX = x
	self.LastY = y
end

function PANEL:OnChange(col) end

function PANEL:OnValueUpdated() end

function PANEL:OnMousePressed(mcode)
	self:MouseCapture(true)
	self:OnCursorMoved(self:CursorPos())

	if timer.Exists("xLibRGBPickerUpdated") then timer.Remove("xLibRGBPickerUpdated") end
end

function PANEL:OnMouseReleased(mcode)
	self:MouseCapture(false)
	self:OnCursorMoved(self:CursorPos())

	if timer.Exists("xLibRGBPickerUpdated") then timer.Remove("xLibRGBPickerUpdated") end
	timer.Create("xLibRGBPickerUpdated", 1, 1, function()
		if (not (self and IsValid(self))) then return end
		self:OnValueUpdated()
	end)
end

function PANEL:Paint( w, h )
	surface.SetMaterial(self.Material)
	surface.SetDrawColor(Color(255, 255, 255, 255))
	surface.DrawTexturedRect(0, 0, w, h)

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(math.Clamp(self.LastX, 0, w) - 2, 0, 4, h)
end

derma.DefineControl("xLibRGBPicker", "", PANEL, "DPanel")