local PANEL = {}

LDT_Polls.TopTextMsg = ""
LDT_Polls.TopSecTextMsg = ""

LDT_Polls.CurrentType = "Running"

-- Create list of icons for the left bar
local xicon = Material("ldt_polls/x.png", "noclamp smooth")
local squarepoll = Material("ldt_polls/square-poll.png", "noclamp smooth")


-- Setup default properties of this panel
function PANEL:Init()
    LDT_Polls.TopSecTextMsg = ""
    LDT_Polls.mainPanelThis = self
    LDT_Polls.CurrentType = "Running"
    self.selected = 1

    self:SetDraggable(false)
    self:SetTitle("")
    self:DockPadding(0, 0, 0, 0)
    self:ShowCloseButton(false)

    self:CreateTopBar()
    self:CloseButton()
    self:CreateSubButtons()
end

-- Create the top bar
function PANEL:CreateTopBar()
    if IsValid(self.topBar) then
        self.topBar:Remove()
    end

    self.topBar = self:Add("DPanel")
    self.topBar:Dock(TOP)
    self.topBar:SetTall( LDT_Polls.GetHeight(48.6) )
    self.topBar:DockPadding(0, 0, 0, 0)
    self.topBar:DockMargin(0, 0, 0, 0)
    self.topBar.Paint = function(me, w, h)
        draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.Blue )
        local length = draw.SimpleText(LDT_Polls.TopTextMsg,"WorkSans50", w*0.08, h*0.45, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(LDT_Polls.TopSecTextMsg, "WorkSans30", length+w*0.09, h*0.55, LDT_Polls.Config.WhiteHighlight, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.chartIcon = self.topBar:Add("DImage")
    self.chartIcon:Dock(LEFT)
    self.chartIcon:SetWide(LDT_Polls.GetWidth(32))
    self.chartIcon:DockMargin(LDT_Polls.GetWidth(10), 0, 0, 0)
    self.chartIcon.Paint = function(me, w, h)
        surface.SetMaterial( squarepoll )
        surface.SetDrawColor( LDT_Polls.Config.White )
        surface.DrawTexturedRect( 0, h*0.5-(LDT_Polls.GetHeight(32)/2), LDT_Polls.GetWidth(32), LDT_Polls.GetHeight(32) )
    end
end

-- Create sub buttons
function PANEL:CreateSubButtons()
    self.subBtns = self:Add("PollsSubBtns")
    if IsValid(self.topText) then
        self.topText:Remove()
    end
end

-- Opens the poll detail window
function PANEL:OpenPollDetail(ID, SteamID, Title, Desc, Options, EndDate, VoteGroups)
    if IsValid(self.centerPanel) then
        self.centerPanel:Remove()
    end

    self.subBtns:Remove()
    LDT_Polls.TopTextMsg = Title
    self.centerPanel = self:Add( "PollDetailPanel" )
    self.centerPanel:SetData(ID, SteamID, Title, Desc, Options, EndDate, VoteGroups)

    self.closeBtn.DoClick = function()
        self.centerPanel:Remove()
        self:CreateSubButtons()
        self.closeBtn.DoClick = function()
            self:Remove()
        end
    end
end

-- Opens the create poll window
function PANEL:OpenCreatePoll()
    if IsValid(self.centerPanel) then
        self.centerPanel:Remove()
    end

    self.subBtns:Remove()
    LDT_Polls.TopTextMsg = LDT_Polls.GetLanguange("CreateNewPollTitle")
    self.centerPanel = self:Add( "PollCreatePanel" )

    self.closeBtn.DoClick = function()
        self.centerPanel:Remove()
        self:CreateSubButtons()
        self.closeBtn.DoClick = function()
            self:Remove()
        end
    end
end

-- Create the close button
function PANEL:CloseButton()
    self.closeBtn = self.topBar:Add("DImageButton")
    self.closeBtn:SetPos(0,0)
    self.closeBtn:Dock(RIGHT)
    self.closeBtn:SetWide(LDT_Polls.GetWidth(32)/1.5)
    self.closeBtn:DockMargin(0, 0, LDT_Polls.GetWidth(10), 0)
    self.closeBtn.DoClick = function()
        self:Remove()
    end
    self.closeBtn.Paint = function(me, w, h)
        surface.SetMaterial( xicon )
        surface.SetDrawColor( LDT_Polls.Config.Red )
        surface.DrawTexturedRect( 0, h*0.5-((LDT_Polls.GetHeight(32)/1.5)/2), LDT_Polls.GetWidth(32)/1.5, LDT_Polls.GetHeight(32)/1.5 )
    end
end

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
    draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.Grey )
end

vgui.Register("PollsFrame", PANEL, "DFrame")