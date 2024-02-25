local PANEL = {}

local icons = {
    {
        Icon = Material("ldt_polls/radial.png", "noclamp smooth"),
        IconPressed = Material("ldt_polls/radial_pressed.png", "noclamp smooth"),
        Sizex = 48
    }
}

-- Setup default properties of this panel
function PANEL:Init()
    self.Precentage = 0
    self.CurrentPrecentage = 0
    self.Disabled = false
    self.starttime = SysTime()

    self:Dock(TOP)
    self:SetTall(LDT_Polls.GetHeight(32))
    self:DockMargin(LDT_Polls.GetWidth(5), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    self:CreatePanel()
end

-- Sets the data for this radial btn
function PANEL:SetData(ID, Text)
    self.ID = ID
    self.OptionText = Text
end

-- Disables this radial btn
function PANEL:SetDisabled()
    self.Disabled = true
    if IsValid(self.radialBtn) then self.radialBtn:Remove() end
    self:CreatePanel()
end

-- Sets the precentage for this radial btn
function PANEL:SetStats(precentage)
    self.Precentage = precentage
end

-- Creates the radial btn
function PANEL:CreatePanel()
    if LDT_Polls.SubmitDataLength == 1 or not LDT_Polls.CanVoteInGroup or self.Disabled then
        self.radialBtn = self:Add("DImage")
    else
        self.radialBtn = self:Add("DImageButton")
        self.radialBtn.DoClick = function()
            LDT_Polls.SelectedOption = self.ID
        end
    end

    self.radialBtn:Dock(RIGHT)
    self.radialBtn:SetWide(LDT_Polls.GetWidth(32))
    self.radialBtn:DockMargin(LDT_Polls.GetWidth(10), 0, 0, 0)
    self.radialBtn.Paint = function(me, w, h)
        if LDT_Polls.SelectedOption == self.ID then
            surface.SetMaterial( icons[1]["IconPressed"] )
            surface.SetDrawColor( LDT_Polls.Config.Blue )
        else
            surface.SetMaterial( icons[1]["Icon"] )

            if LDT_Polls.SubmitDataLength == 1 or not LDT_Polls.CanVoteInGroup or self.Disabled then
                surface.SetDrawColor( LDT_Polls.Config.BlueThird )
            else
                surface.SetDrawColor( LDT_Polls.Config.Blue )
            end
        end

        surface.DrawTexturedRect( 0, h*0.5-(LDT_Polls.GetHeight(32)/2), LDT_Polls.GetWidth(32), LDT_Polls.GetHeight(32) )
    end
end

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
    self.CurrentPrecentage = Lerp((SysTime()-self.starttime)/20, self.CurrentPrecentage, self.Precentage)

    draw.RoundedBox( 5, 0, 0, w*  self.CurrentPrecentage-w*0.1, h, LDT_Polls.Config.BlueThird )
    draw.SimpleText(math.Round(self.Precentage*100, 0).."%", "WorkSans30", w* 0.89, h*0.45, LDT_Polls.Config.White, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    draw.SimpleText(self.OptionText, "WorkSans36", w*0.01, h*0.45, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

vgui.Register("PollsOptionPanel", PANEL, "DPanel")