local PANEL = {}

-- Setup default properties of this panel
function PANEL:Init()
    self:Dock(TOP)
    self:SetTall(LDT_Polls.GetHeight(32))
    self:DockMargin(LDT_Polls.GetWidth(5), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
end

-- Sets the data for this settings input
function PANEL:SetData(text,type)
    self.msg = text
    self.type = type
    self:CreatePanel()
end

-- Returns the data from this settings input
function PANEL:ReturnData()
    return self.textEntry:GetValue()
end

-- These are the only allowed chars for PollEndDate setting
local AllowedChars = LDT_Polls.Set {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", ":", " "}

-- Creates this settings input
function PANEL:CreatePanel()
    self.textEntry = self:Add( "DTextEntry" )
	self.textEntry:Dock( RIGHT )
    self.textEntry:SetMultiline( false )
    if LDT_Polls.Config.Language == "de" or LDT_Polls.Config.Language == "es" then
        self.textEntry:SetWide(LDT_Polls.GetWidth(150))
    else
        self.textEntry:SetWide(LDT_Polls.GetWidth(200))
    end
    self.textEntry:SetFont( "WorkSans30" )
    self.textEntry:SetTextColor(LDT_Polls.Config.White)
    self.textEntry:SetPaintBackground( false )

    if self.type == 1 then
        self.textEntry:SetPlaceholderText( "2022-12-31 12:11:11" )
        self.textEntry.AllowInput = function(me,char)
            if AllowedChars[char] == nil then
                return true
            else 
                return false
            end
        end
    elseif self.type == 2 then
        self.textEntry:SetPlaceholderText( "500" )
        self.textEntry:SetNumeric(true)
    elseif self.type == 3 then
        self.textEntry:SetPlaceholderText( "superadmin,admin" )
    end
end

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
    if LDT_Polls.Config.Language == "de" or LDT_Polls.Config.Language == "es" then
        draw.SimpleText(self.msg, "WorkSans26", w*0.01, h*0.45, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    else
        draw.SimpleText(self.msg, "WorkSans30", w*0.01, h*0.45, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end

vgui.Register("PollsSettingsInput", PANEL, "DPanel")