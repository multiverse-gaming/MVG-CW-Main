local PANEL = {}

local this
local plusIcon = Material("ldt_polls/plus.png", "noclamp smooth")

-- Setup default properties of this panel
function PANEL:Init()
    LDT_Polls.NumOfOptionsCreated = 0
    this = self

    self:Dock(FILL)
    self:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    
    self:CreateBody()
    self:CreateTitle()
    self:CreateDescription()
    self:CreatePollOptions()
    self:CreatePollSettings()
    self:CreateBottomBtn(false)
end

-- Creates the body that will hold all of the individual options and settings for the poll
function PANEL:CreateBody()
    self.scroll = self:Add("DScrollPanel")
    self.scroll:Dock(FILL)

    local sbar = self.scroll:GetVBar()
    function sbar:Paint(w, h)
    end
    function sbar.btnUp:Paint(w, h)
    end
    function sbar.btnDown:Paint(w, h)
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(5, 0, 0, w*.6, h, LDT_Polls.Config.Blue)
    end
end

-- Creates the poll title input box
function PANEL:CreateTitle()
    self.titleHolder = self.scroll:Add("DPanel")
    self.titleHolder:Dock(TOP)
    self.titleHolder:SetTall(LDT_Polls.GetHeight(75))
    self.titleHolder:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), 0)
    self.titleHolder:DockPadding(LDT_Polls.GetWidth(5), LDT_Polls.GetHeight(30), 0, 0)
    self.titleHolder.Paint = function(me, w, h)
        local textEntryText = self.textEntryTitle:GetValue()

        if #textEntryText > LDT_Polls.Config.MaxNumOfCharsTitle then
            draw.SimpleText(#textEntryText.."/"..LDT_Polls.Config.MaxNumOfCharsTitle, "WorkSans30-Bold", w, h*.15, LDT_Polls.Config.RedSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(#textEntryText.."/"..LDT_Polls.Config.MaxNumOfCharsTitle, "WorkSans30-Bold", w, h*.15, LDT_Polls.Config.WhiteSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        draw.SimpleText(LDT_Polls.GetLanguange("PollTitle"), "WorkSans40-Bold", 0, h*.13, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.RoundedBox(5, 0, LDT_Polls.GetHeight(30), w, h-LDT_Polls.GetHeight(30), LDT_Polls.Config.Grey)
    end
        
    self.textEntryTitle = self.titleHolder:Add( "DTextEntry" )
	self.textEntryTitle:Dock( FILL )
    self.textEntryTitle:SetMultiline( false )
    self.textEntryTitle:SetFont( "WorkSans26" )
    self.textEntryTitle:SetTextColor(LDT_Polls.Config.White)
    self.textEntryTitle:SetPaintBackground( false )
	self.textEntryTitle:SetPlaceholderText( LDT_Polls.GetLanguange("PlaceHolderText") )
end

-- Creates the poll description input box
function PANEL:CreateDescription()
    self.descHolder = self.scroll:Add("DPanel")
    self.descHolder:Dock(TOP)
    self.descHolder:SetTall(LDT_Polls.GetHeight(200))
    self.descHolder:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), 0)
    self.descHolder:DockPadding(LDT_Polls.GetWidth(5), LDT_Polls.GetHeight(30), 0, 0)
    self.descHolder.Paint = function(me, w, h)
        local textEntryText = self.textEntryDesc:GetValue()

        if #textEntryText > LDT_Polls.Config.MaxNumOfCharsDesc then
            draw.SimpleText(#textEntryText.."/"..LDT_Polls.Config.MaxNumOfCharsDesc, "WorkSans30-Bold", w, h*.065, LDT_Polls.Config.RedSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(#textEntryText.."/"..LDT_Polls.Config.MaxNumOfCharsDesc, "WorkSans30-Bold", w, h*.065, LDT_Polls.Config.WhiteSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        draw.SimpleText(LDT_Polls.GetLanguange("PollDescriptionTitle"), "WorkSans40-Bold", 0, h*.05, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.RoundedBox(5, 0, LDT_Polls.GetHeight(30), w, h-LDT_Polls.GetHeight(30), LDT_Polls.Config.Grey)
    end
        
    self.textEntryDesc = self.descHolder:Add( "DTextEntry" )
	self.textEntryDesc:Dock( FILL )
    self.textEntryDesc:SetMultiline( true )
    self.textEntryDesc:SetFont( "WorkSans26" )
    self.textEntryDesc:SetTextColor(LDT_Polls.Config.White)
    self.textEntryDesc:SetPaintBackground( false )
	self.textEntryDesc:SetPlaceholderText( LDT_Polls.GetLanguange("PlaceHolderText") )
end

-- Creates the poll options
function PANEL:CreatePollOptions()
    self.optionsHolder = self.scroll:Add("DPanel")
    self.optionsHolder:Dock(TOP)
    self.optionsHolder:SetTall(LDT_Polls.GetHeight(260))
    self.optionsHolder:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(5), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    self.optionsHolder:DockPadding(0, 0, 0, LDT_Polls.GetHeight(10))
    self.optionsHolder.Paint = function(me, w, h)
        if LDT_Polls.NumOfOptionsCreated > LDT_Polls.Config.MaxNumOfPollOptions then
            draw.SimpleText(LDT_Polls.NumOfOptionsCreated.."/"..LDT_Polls.Config.MaxNumOfPollOptions, "WorkSans30-Bold", w*0.92, h*.065, LDT_Polls.Config.RedSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(LDT_Polls.NumOfOptionsCreated.."/"..LDT_Polls.Config.MaxNumOfPollOptions, "WorkSans30-Bold", w*0.92, h*.065, LDT_Polls.Config.WhiteSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        draw.RoundedBox(5, 0, LDT_Polls.GetHeight(40), w, h-LDT_Polls.GetHeight(40), LDT_Polls.Config.Grey)
        draw.SimpleText(LDT_Polls.GetLanguange("PollOptionsTitle"), "WorkSans40-Bold", 0, h*.06, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.topBar = self.optionsHolder:Add("DPanel")
    self.topBar:Dock(TOP)
    self.topBar:SetTall(LDT_Polls.GetHeight(40))
    self.topBar:DockPadding(0, 0, 0, LDT_Polls.GetHeight(10))
    self.topBar.Paint = function(me,w,h)
    end

    local scroll2 = self.optionsHolder:Add("DScrollPanel")
    scroll2:Dock(FILL)

    local sbar = scroll2:GetVBar()
    function sbar:Paint(w, h)
    end
    function sbar.btnUp:Paint(w, h)
    end
    function sbar.btnDown:Paint(w, h)
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(5, 0, 0, w*.6, h, LDT_Polls.Config.Blue)
    end

    self.optionsPanels = {}
    for i = 1, 2 do
        self.optionsPanels[i] = scroll2:Add("PollsOptionPanelInput")
        self.optionsPanels[i]:SetData(false)
    end

    self.plusBtn = self.topBar:Add("DImageButton")
    self.plusBtn:Dock(RIGHT)
    self.plusBtn:SetWide(LDT_Polls.GetWidth(24))
    self.plusBtn:DockMargin(0, 0, LDT_Polls.GetWidth(5), 0)
    self.plusBtn.DoClick = function()
        local i = #self.optionsPanels+1
        self.optionsPanels[i] = scroll2:Add("PollsOptionPanelInput")
        self.optionsPanels[i]:SetData(true)
    end
    self.plusBtn.Paint = function(me, w, h)
        surface.SetMaterial( plusIcon )
        surface.SetDrawColor( LDT_Polls.Config.Green )
        surface.DrawTexturedRect( 0, h*0.2, LDT_Polls.GetWidth(24), LDT_Polls.GetHeight(24) )
    end
end

-- Creates the poll settings
function PANEL:CreatePollSettings()
    self.settingsHolder = self.scroll:Add("DPanel")
    self.settingsHolder:Dock(TOP)
    self.settingsHolder:SetTall(LDT_Polls.GetHeight(200))
    self.settingsHolder:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), 0)
    self.settingsHolder:DockPadding(0, LDT_Polls.GetHeight(30), 0, 0)
    self.settingsHolder.Paint = function(me, w, h)
        if LDT_Polls.Config.Language == "es" or LDT_Polls.Config.Language == "fr"or LDT_Polls.Config.Language == "tr" then
            draw.SimpleText(LDT_Polls.GetLanguange("PollSettingsTitle"), "WorkSans30-Bold", 0, h*.05, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(LDT_Polls.GetLanguange("PollSettingsTitle"), "WorkSans40-Bold", 0, h*.05, LDT_Polls.Config.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        if LDT_Polls.Config.Language == "fr" or LDT_Polls.Config.Language == "tr" then
            draw.SimpleText(LDT_Polls.GetLanguange("LeaveEmptyText"), "WorkSans24-Bold", w, h*.065, LDT_Polls.Config.WhiteSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(LDT_Polls.GetLanguange("LeaveEmptyText"), "WorkSans30-Bold", w, h*.065, LDT_Polls.Config.WhiteSecond, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end
        draw.RoundedBox(5, 0, LDT_Polls.GetHeight(30), w, h-LDT_Polls.GetHeight(30), LDT_Polls.Config.Grey)
    end
        
    local scroll2 = self.settingsHolder:Add("DScrollPanel")
    scroll2:Dock(FILL)
    
    local sbar = scroll2:GetVBar()
    function sbar:Paint(w, h)
    end
    function sbar.btnUp:Paint(w, h)
    end
    function sbar.btnDown:Paint(w, h)
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(5, 0, 0, w*.6, h, LDT_Polls.Config.Blue)
    end

    -- This adds all of the settings to the settings portion of the poll creator.
    self.settingsComponents = {}
    self.settingsComponents[1] = scroll2:Add("PollsSettingsInput")
    self.settingsComponents[1]:SetData(LDT_Polls.GetLanguange("WhoCanSeeThePollTitle"), 3)

    self.settingsComponents[2] = scroll2:Add("PollsSettingsInput")
    self.settingsComponents[2]:SetData(LDT_Polls.GetLanguange("WhoVoteInThePollTitle"), 3)

    if LDT_Polls.Config.EnableVoteRewards then
        self.settingsComponents[4] = scroll2:Add("PollsSettingsInput")
        self.settingsComponents[4]:SetData(LDT_Polls.GetLanguange("RewardForVotingTitle"), 2)
    end

    self.settingsComponents[3] = scroll2:Add("PollsSettingsInput")
    self.settingsComponents[3]:SetData(LDT_Polls.GetLanguange("WhenShouldThePollEndTitle"), 1)
end

-- Create the bottom btn
function PANEL:CreateBottomBtn(error)
    self.createPoll = self:Add("DButton")
    self.createPoll:SetText("")
    self.createPoll:SetTall(LDT_Polls.GetHeight(40))
    self.createPoll:Dock(BOTTOM)
    self.createPoll:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    self.createPoll.Paint = function(me, w, h)
        if self.createPoll:IsHovered() then
            draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.BlueSecond )
        else
            draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.Blue )
        end

        draw.SimpleText(LDT_Polls.GetLanguange("CreatePoll"), "WorkSans30-Bold", w*.5, h*.5, LDT_Polls.Config.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    self.createPoll.DoClick = function()
        -- Get the title text and verify it.
        local textEntryTitleText = self.textEntryTitle:GetValue()
        if #textEntryTitleText > LDT_Polls.Config.MaxNumOfCharsTitle then self.msg = LDT_Polls.GetLanguange("TitleTooLong") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        if #textEntryTitleText == 0 then self.msg = LDT_Polls.GetLanguange("TitleEmpty") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end

        -- Get the description text and verify it.
        local textEntryDescText = self.textEntryDesc:GetValue()
        if #textEntryDescText > LDT_Polls.Config.MaxNumOfCharsDesc then self.msg = LDT_Polls.GetLanguange("DescriptionTooLong") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        if #textEntryDescText == 0 then self.msg = LDT_Polls.GetLanguange("DescriptionEmpty") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        
        -- Verify that option panels have their title filled.
        local isOneEmpty = false;
        for k, v in pairs(self.optionsPanels) do
            if IsValid(v) then
                if v:ReturnData() == "" then
                    isOneEmpty = true
                    break
                end
            end
        end

        -- If there is one option title with missing title. Return error.
        if isOneEmpty then self.msg = LDT_Polls.GetLanguange("PollOptionsTitleEmpty") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        if self.settingsComponents[3]:ReturnData() == "" then self.msg = LDT_Polls.GetLanguange("PollEndDateEmpty") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        
        -- Get the date string and verify it.
        local fulldatestring = self.settingsComponents[3]:ReturnData()
        local spaceSplit = string.Split(fulldatestring," ")
        if #spaceSplit != 2  then self.msg = LDT_Polls.GetLanguange("PollEndDateSyntaxIssue") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        
        -- Convert the date string into unix epoch. And also verify individual parts of the date.
        local date = string.Split(spaceSplit[1], "-")
        local time = string.Split(spaceSplit[2], ":")
        if #date != 3 or #time != 3 then self.msg = LDT_Polls.GetLanguange("PollEndDateSyntaxIssue") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        if date[1] == "" or date[2] == "" or date[3] == "" or time[1] == "" or time[2] == "" or time[3] == "" then self.msg = LDT_Polls.GetLanguange("PollEndDateSyntaxIssue") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        
        -- Verify that the date is greater then today.
        local timestamp = os.time{year=date[1], month=date[2], day=date[3], hour=time[1], min=time[2], sec=time[3]}
        if timestamp < os.time() then self.msg = LDT_Polls.GetLanguange("PollEndDatePast") if not IsValid(self.errorMsg) then self.createPoll:Remove() self:CreateBottomBtn(true) end return end
        


        -- Now send the data from client to the server.
        net.Start("LDT_Polls_CreatePoll")
            net.WriteString(textEntryTitleText)
            net.WriteString(textEntryDescText)

            local totalNumOfOptions = 0
            for k, v in pairs(self.optionsPanels) do
                if IsValid(v) then
                    totalNumOfOptions = totalNumOfOptions+1
                end
            end
            net.WriteUInt(totalNumOfOptions, 8)

            for k, v in pairs(self.optionsPanels) do
                if IsValid(v) then
                    net.WriteString(v:ReturnData())
                end
            end

            local rewardAmount = ""
            if LDT_Polls.Config.EnableVoteRewards then
                rewardAmount = self.settingsComponents[4]:ReturnData()
            end

            net.WriteUInt(timestamp,32)
            net.WriteString(self.settingsComponents[1]:ReturnData())
            net.WriteString(self.settingsComponents[2]:ReturnData())
            net.WriteString(rewardAmount)
        net.SendToServer()

        LDT_Polls.mainPanelThis.centerPanel:Remove()
        LDT_Polls.mainPanelThis:CreateSubButtons()
        LDT_Polls.mainPanelThis.closeBtn.DoClick = function()
            LDT_Polls.mainPanelThis:Remove()
        end
    end
    
    -- If there is an error create the error msg.
    if error then
        self.errorMsg = self:Add("DPanel")
        self.errorMsg:Dock(BOTTOM)
        self.errorMsg:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), 0)
        self.errorMsg:SetTall(LDT_Polls.GetHeight(20))
        self.errorMsg.Paint = function(me, w, h)
            if LDT_Polls.Config.Language == "es" or LDT_Polls.Config.Language == "fr" then
                draw.SimpleText(self.msg, "WorkSans24", w*.5, h*.35, LDT_Polls.Config.RedSecond, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(self.msg, "WorkSans30", w*.5, h*.35, LDT_Polls.Config.RedSecond, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end
end

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
    draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.GreySecond )
end

vgui.Register("PollCreatePanel", PANEL, "DPanel")