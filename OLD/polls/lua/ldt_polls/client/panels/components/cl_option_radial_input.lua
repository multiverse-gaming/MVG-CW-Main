local PANEL = {}

local icons = {
    {
        Icon = Material("ldt_polls/radial.png", "noclamp smooth"),
        IconPressed = Material("ldt_polls/radial_pressed.png", "noclamp smooth"),
        Sizex = 32
    }
}

-- Setup default properties of this panel
function PANEL:Init()
    LDT_Polls.NumOfOptionsCreated = LDT_Polls.NumOfOptionsCreated+1

    self:Dock(TOP)
    self:SetTall(LDT_Polls.GetHeight(32))
    self:DockMargin(LDT_Polls.GetWidth(5), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
end

-- Sets the data for this radial input
function PANEL:SetData(createMinus)
    self.createMinus = createMinus
    self:CreatePanel()
end

-- Returns the data from the radial input
function PANEL:ReturnData()
    return self.textEntry:GetValue()
end

-- Creates the radial input panel
function PANEL:CreatePanel()
    if self.createMinus then
        self.minusBtn = self:Add("DImageButton")
        self.minusBtn:Dock(LEFT)
        self.minusBtn:SetWide(LDT_Polls.GetWidth(16))
        self.minusBtn:DockMargin(0, 0, LDT_Polls.GetWidth(5), 0)
        self.minusBtn.DoClick = function()
            LDT_Polls.NumOfOptionsCreated = LDT_Polls.NumOfOptionsCreated-1
            self:Remove()
        end
        self.minusBtn.Paint = function(me, w, h)
            surface.SetMaterial( LDT_Polls.minusIcon )
            surface.SetDrawColor( LDT_Polls.Config.Red )
            surface.DrawTexturedRect( 0, h*0.5-(LDT_Polls.GetHeight(16)/2), LDT_Polls.GetWidth(16), LDT_Polls.GetHeight(16) )
        end
    end

    self.textEntry = self:Add( "DTextEntry" )
	self.textEntry:Dock( LEFT )
    self.textEntry:SetMultiline( false )
    self.textEntry:SetWide(LDT_Polls.GetWidth(300))
    self.textEntry:SetFont( "WorkSans30" )
    self.textEntry:SetTextColor(LDT_Polls.Config.White)
    self.textEntry:SetPaintBackground( false )
	self.textEntry:SetPlaceholderText( LDT_Polls.GetLanguange("PlaceHolderText") )

    self.radialImg = self:Add("DImage")
    self.radialImg:Dock(RIGHT)
    self.radialImg:SetWide(LDT_Polls.GetWidth(32))
    self.radialImg:DockMargin(LDT_Polls.GetWidth(10), 0, 0, 0)
    self.radialImg.Paint = function(me, w, h)
        surface.SetMaterial( icons[1]["Icon"] )
        surface.SetDrawColor( LDT_Polls.Config.Blue )
        surface.DrawTexturedRect( 0, h*0.5-(LDT_Polls.GetHeight(32)/2), LDT_Polls.GetWidth(32), LDT_Polls.GetHeight(32) )
    end
end

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
end

vgui.Register("PollsOptionPanelInput", PANEL, "DPanel")