-- Modified from Garry's Mod DColorMixer

local PANEL = {}

AccessorFunc(PANEL, "m_ConVarR", "ConVarR")
AccessorFunc(PANEL, "m_ConVarG", "ConVarG")
AccessorFunc(PANEL, "m_ConVarB", "ConVarB")
AccessorFunc(PANEL, "m_ConVarA", "ConVarA")

AccessorFunc(PANEL, "m_bWangsPanel", "Wangs", FORCE_BOOL)

AccessorFunc(PANEL, "m_Color", "Color")

local BarWide = 26

local function CreateWangFunction(self, colindex)
	local function OnValueChanged(ptxt, strvar)
		if (ptxt.notuserchange) then return end

		local targetValue = tonumber(strvar) or 0
		self:GetColor()[colindex] = targetValue
		if (colindex ~= "a") then
			self.HSV:SetColor( self:GetColor() )

			local h, s, v = ColorToHSV(self.HSV:GetBaseRGB())
			self.RGB.LastY = (1 - h / 360) * self.RGB:GetTall()
		end

		self:UpdateColor(self:GetColor())
	end

	return OnValueChanged
end

local function paintPanel(col, w, h)
	surface.SetDrawColor(col)
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:Init()
	--The number stuff
	self.WangsPanel = vgui.Create( "Panel", self )
	self.WangsPanel:SetWide(50)
	self.WangsPanel:Dock(RIGHT)
	self.WangsPanel:DockMargin(4, 0, 0, 0)
	self:SetWangs( true )

	self.txtR = self.WangsPanel:Add("DNumberWang")
	self.txtR:Dock(TOP)
	self.txtR:DockMargin(0, 0, 0, 5)
	self.txtR:SetFont("xLibSubTitleFont")
	self.txtR:SetMinMax(0, 255)
	local rcol = Color(255, 0, 0)
	function self.txtR:Paint(w, h)
		paintPanel(rcol, w, h)
		self:DrawTextEntryText(Color(255, 255, 255, 255), Color(0, 0, 255), Color(0, 0, 0, 255))
	end

	self.txtG = self.WangsPanel:Add("DNumberWang")
	self.txtG:Dock(TOP)
	self.txtG:DockMargin(0, 0, 0, 5)
	self.txtG:SetFont("xLibSubTitleFont")
	self.txtG:SetMinMax(0, 255)
	local gcol = Color(0, 255, 0)
	function self.txtG:Paint(w, h)
		paintPanel(gcol, w, h)
		self:DrawTextEntryText(Color(255, 255, 255, 255), Color(0, 0, 255), Color(0, 0, 0, 255))
	end

	self.txtB = self.WangsPanel:Add("DNumberWang")
	self.txtB:Dock(TOP)
	self.txtB:DockMargin(0, 0, 0, 5)
	self.txtB:SetFont("xLibSubTitleFont")
	self.txtB:SetMinMax(0, 255)
	local bcol = Color(0, 0, 255)
	function self.txtB:Paint(w, h)
		paintPanel(bcol, w, h)
		self:DrawTextEntryText(Color(255, 255, 255, 255), Color(0, 0, 255), Color(0, 0, 0, 255))
	end

	self.txtR.OnValueChanged = CreateWangFunction( self, "r" )
	self.txtG.OnValueChanged = CreateWangFunction( self, "g" )
	self.txtB.OnValueChanged = CreateWangFunction( self, "b" )

	-- The colouring stuff
	self.HSV = vgui.Create( "xLibColorCube", self )
	self.HSV:Dock(FILL)

	self.BottomPnl = vgui.Create("DPanel", self)
	self.BottomPnl:Dock(BOTTOM)
	self.BottomPnl:SetWidth( self:GetWide() )
	self.BottomPnl:DockMargin(0, 5, 0, 0)
	function self.BottomPnl:Paint(w, h) end

	self.ColorSquare = vgui.Create( "DPanel", self.BottomPnl )
	self.ColorSquare:SetWidth(self.ColorSquare:GetTall())
	self.ColorSquare.Paint = function(s, w, h)
		surface.SetDrawColor(self:GetColor())
		surface.DrawRect(0, 0, w, h)
	end

	self.RGB = vgui.Create( "xLibRGBPicker", self.BottomPnl )
	self.RGB:SetWidth( self:GetWide() - self.ColorSquare:GetWide() - xLib.Utils.ScreenScale(5))
	self.RGB:SetPos(self.ColorSquare:GetWide() + xLib.Utils.ScreenScale(5), 0)
	self.RGB.OnChange = function(ctrl, color)
		self:SetBaseColor(color)
	end

	function self.HSV.OnUserChanged(ctrl, color)
		color.a = self:GetColor().a
		self:UpdateColor( color )

		if timer.Exists("xLibRGBSliderUpdated") then timer.Remove("xLibRGBSliderUpdated") end
		timer.Create("xLibRGBSliderUpdated", 1, 1, function()
			if (not (self and IsValid(self) and self.RGB and IsValid(self.RGB))) then return end
			if not self.RGB:IsDragging() then self.RGB:OnValueUpdated() end
		end)
	end

	-- Layout
	self:SetColor( Color( 255, 0, 0, 255 ) )
	self:SetSize( 256, 230 )
	self:InvalidateLayout()
end

function PANEL:SetLabel( text )
	if ((not text) or text == "") then
		self.label:SetVisible( false )
		return
	end

	self.label:SetText( text )
	self.label:SetVisible( true )

	self:InvalidateLayout()
end

function PANEL:SetWangs( bEnabled )
	self.m_bWangsPanel = bEnabled

	self.WangsPanel:SetVisible( bEnabled )

	self:InvalidateLayout()
end

function PANEL:PerformLayout( w, h )
	local h, s, v = ColorToHSV( self.HSV:GetBaseRGB() )
	self.RGB.LastY = ( 1 - h / 360 ) * self.RGB:GetTall()

	self.RGB:SetWidth( self.HSV:GetWide() - self.ColorSquare:GetWide() - xLib.Utils.ScreenScale(5))
end

function PANEL:Paint() end

function PANEL:TranslateValues( x, y ) end

function PANEL:SetColor( color )
	local h, s, v = ColorToHSV( color )
	self.RGB.LastY = ( 1 - h / 360 ) * self.RGB:GetTall()

	self.HSV:SetColor( color )

	self:UpdateColor( color )
end

function PANEL:SetVector( vec )
	self:SetColor( Color( vec.x * 255, vec.y * 255, vec.z * 255, 255 ) )
end

function PANEL:SetBaseColor( color )
	self.HSV:SetBaseRGB( color )
	self.HSV:TranslateValues()
end

function PANEL:UpdateColor( color )
	if ( color.r != self.txtR:GetValue() ) then
		self.txtR.notuserchange = true
		self.txtR:SetValue( color.r )
		self.txtR.notuserchange = nil
	end

	if ( color.g != self.txtG:GetValue() ) then
		self.txtG.notuserchange = true
		self.txtG:SetValue( color.g )
		self.txtG.notuserchange = nil
	end

	if ( color.b != self.txtB:GetValue() ) then
		self.txtB.notuserchange = true
		self.txtB:SetValue( color.b )
		self.txtB.notuserchange = nil
	end

	self:ValueChanged( color )

	self.m_Color = color
end

function PANEL:ValueChanged(color) end

function PANEL:GetColor()
	self.m_Color.a = 255
	return self.m_Color
end

function PANEL:GetVector()
	local col = self:GetColor()
	return Vector( col.r / 255, col.g / 255, col.b / 255 )
end

derma.DefineControl("xLibColorMixer", "", PANEL, "DPanel")
