local PANEL = {}

local this
local greySecondCopy = table.Copy(LDT_Polls.Config.GreySecond)
local greyCopy = table.Copy(LDT_Polls.Config.Grey)
local whiteCopy = table.Copy(LDT_Polls.Config.White)
local whiteSecondCopy = table.Copy(LDT_Polls.Config.WhiteSecond)
local blueCopy = table.Copy(LDT_Polls.Config.Blue)
local blueSecondCopy = table.Copy(LDT_Polls.Config.BlueSecond)
local blueThirdCopy = table.Copy(LDT_Polls.Config.BlueThird)

-- Setup default properties of this panel
function PANEL:Init()
    greySecondCopy.a = 0
    greyCopy.a = 0
    whiteCopy.a = 0
    whiteSecondCopy.a = 0
    blueCopy.a = 0
    blueSecondCopy.a = 0
    blueThirdCopy.a = 0

    self.starttime = SysTime()

    this = self
    LDT_Polls.SelectedOption = 1
    LDT_Polls.OptionStatsData = {}
    LDT_Polls.OptionStatsTotal = 0

    self:Dock(FILL)
    self:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
end

-- This sets the data about the current poll open
function PANEL:SetData(ID, SteamID, Title, Desc, Options, EndDate, VoteGroups)
    self.PollID = ID

    LDT_Polls.SubmitDataLength = 0
    for k, v in ipairs(LDT_Polls.SubmitedPolls) do
        if v["PollID"] == self.PollID then
            LDT_Polls.SubmitDataLength = 1
            LDT_Polls.SelectedOption = v["OptionID"]
            break
        end
    end
    
    local playerGroup = LDT_Polls.GetPlayerGroup(LDT_Polls.ply)
    LDT_Polls.CanVoteInGroup = false
    self.PollVoteGroups = VoteGroups
    
    if self.PollVoteGroups[playerGroup] or LDT_Polls.Config.AdminRanks[playerGroup] or table.IsEmpty(self.PollVoteGroups) then
        LDT_Polls.CanVoteInGroup = true
    end
    
    -- This checks if the player already voted in the polls or if he can't vote in the poll.
    local sentNetMsg = false
    if LDT_Polls.SubmitDataLength == 1 or not LDT_Polls.CanVoteInGroup then 
        net.Start("LDT_Polls_GetAllSubmits")
            net.WriteUInt(self.PollID,8)
        net.SendToServer()
        sentNetMsg = true
    end
    
    self.PollSteamID = SteamID
    self.PollTitle = Title
    self.PollDesc = Desc
    self.PollOptions = Options
    self.PollsEndDate = EndDate
    
    if LDT_Polls.GetDiff(self.PollsEndDate) < 0 or not LDT_Polls.CanVoteInGroup then
        LDT_Polls.SelectedOption = 0
    end


    self:CreateDescription()
    
    -- If the player did not vote in the poll this adds the possiblity to vote.
    if not sentNetMsg then 
        self:CreatePollOptions()
        self:CreateBottomBtn()
    end
end

-- Creates the poll description
function PANEL:CreateDescription()
    self.descHolder = self:Add("DPanel")
    self.descHolder:Dock(TOP)
    self.descHolder:SetTall(LDT_Polls.GetHeight(200))
    self.descHolder:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), 0)
    self.descHolder:DockPadding(0, LDT_Polls.GetHeight(30), 0, 0)
    self.descHolder.Paint = function(me, w, h)
        if LDT_Polls.GetDiff(self.PollsEndDate) < 0 then
            draw.SimpleText(LDT_Polls.GetLanguange("PollEndedTitle"), "WorkSans30-Bold", w, h*.065, whiteSecondCopy, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        else
            if LDT_Polls.Config.Language == "fr" or LDT_Polls.Config.Language == "tr" then
                draw.SimpleText(LDT_Polls.GetLanguange("PollEndsTitle")..LDT_Polls.DispTime( LDT_Polls.GetDiff(self.PollsEndDate)), "WorkSans26", w, h*.065, whiteSecondCopy, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(LDT_Polls.GetLanguange("PollEndsTitle")..LDT_Polls.DispTime( LDT_Polls.GetDiff(self.PollsEndDate)), "WorkSans30", w, h*.065, whiteSecondCopy, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end
        end
        
        draw.SimpleText(LDT_Polls.GetLanguange("PollDescriptionTitle"), "WorkSans40-Bold", 0, h*.05, whiteCopy, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
        
    local scroll = self.descHolder:Add("DScrollPanel")
    scroll:Dock(FILL)
    scroll.Paint = function(me, w, h)
        draw.RoundedBox(5, 0, 0, w, h, greyCopy)
    end

    local sbar = scroll:GetVBar()
    function sbar:Paint(w, h)
    end
    function sbar.btnUp:Paint(w, h)
    end
    function sbar.btnDown:Paint(w, h)
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(5, 0, 0, w*.6, h, blueCopy)
    end
    
        self.descLable = scroll:Add("RichText")
        self.descLable:SetPos(LDT_Polls.GetWidth(5),0)
        self.descLable:SetVerticalScrollbarEnabled( false )
        self.descLable:SetText( self.PollDesc )
        self.descLable.Paint = function(me, w, h)
        end
        function self.descLable:PerformLayout()
            self:SetToFullHeight()
            self:SetFontInternal( "WorkSans26" )
            self:SetFGColor( whiteCopy )
            self:SetWide(scroll:GetWide()-LDT_Polls.GetWidth(5))
        end
end

-- Creates the poll Options
function PANEL:CreatePollOptions()
    self.optionsHolder = self:Add("DPanel")
    self.optionsHolder:Dock(TOP)
    self.optionsHolder:SetTall(LDT_Polls.GetHeight(300))
    self.optionsHolder:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(5), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    self.optionsHolder:DockPadding(0, LDT_Polls.GetHeight(40), 0, LDT_Polls.GetHeight(10))
    self.optionsHolder.Paint = function(me, w, h)
        draw.SimpleText(LDT_Polls.GetLanguange("PollOptionsTitle"), "WorkSans40-Bold", 0, h*.05, whiteCopy, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.RoundedBox(5, 0, LDT_Polls.GetHeight(40), w, h-LDT_Polls.GetHeight(40), greyCopy)
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
        draw.RoundedBox(5, 0, 0, w*.6, h, blueCopy)
    end

    -- This adds poll options to the scroll view.
    self.optionsPanels = {}
    for k, v in ipairs(self.PollOptions) do
        self.optionsPanels[k] = scroll2:Add("PollsOptionPanel")
        self.optionsPanels[k]:SetData(v["OptionID"],v["OptionText"])

        if LDT_Polls.SubmitDataLength == 1 or not LDT_Polls.CanVoteInGroup then 
            for key, value in ipairs(LDT_Polls.OptionStatsData) do
                if value["OptionID"] == v["OptionID"] then
                    self.optionsPanels[k]:SetStats(value["Count"]/LDT_Polls.OptionStatsTotal)
                end
            end
        elseif LDT_Polls.GetDiff(self.PollsEndDate) < 0 then 
            self.optionsPanels[k]:SetDisabled()
        end
    end
end

-- Create the bottom btn
function PANEL:CreateBottomBtn()
    if LDT_Polls.SubmitDataLength == 1 or not LDT_Polls.CanVoteInGroup then
        self.submitPoll = self:Add("DPanel")
    else
        self.submitPoll = self:Add("DButton")
        self.submitPoll.DoClick = function()
            net.Start("LDT_Polls_SubmitPoll")
                net.WriteUInt(self.PollID,8)
                net.WriteUInt(LDT_Polls.SelectedOption,4)
            net.SendToServer()

            LDT_Polls.mainPanelThis.centerPanel:Remove()
            LDT_Polls.mainPanelThis:CreateSubButtons()
            LDT_Polls.mainPanelThis.closeBtn.DoClick = function()
                LDT_Polls.mainPanelThis:Remove()
            end
        end
    end

    self.submitPoll:SetText("")
    self.submitPoll:SetTall(LDT_Polls.GetHeight(40))
    self.submitPoll:Dock(BOTTOM)
    self.submitPoll:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    self.submitPoll.Paint = function(me, w, h)
        if me:IsHovered() and LDT_Polls.SubmitDataLength == 0 and LDT_Polls.CanVoteInGroup and LDT_Polls.GetDiff(self.PollsEndDate) > 0 then
            draw.RoundedBox( 5, 0, 0, w, h, blueSecondCopy )
        elseif LDT_Polls.SubmitDataLength == 0 and LDT_Polls.CanVoteInGroup and LDT_Polls.GetDiff(self.PollsEndDate) > 0 then
            draw.RoundedBox( 5, 0, 0, w, h, blueCopy )
        else 
            draw.RoundedBox( 5, 0, 0, w, h, blueThirdCopy )
        end
        
        local text = LDT_Polls.GetLanguange("SubmitPollBtn")
        if LDT_Polls.GetDiff(self.PollsEndDate) < 0 then 
            text = LDT_Polls.GetLanguange("PollEndedTitle")
        elseif LDT_Polls.SubmitDataLength == 1 then
            text = LDT_Polls.GetLanguange("SubmitedPollBtn")
        elseif not LDT_Polls.CanVoteInGroup then
            text = LDT_Polls.GetLanguange("PollCantVote")
        end

        draw.SimpleText(text, "WorkSans30-Bold", w*.5, h*.5, whiteCopy, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

-- Receives all of the submits for this poll
net.Receive("LDT_Polls_SendAllSubmits",function()
    local dataLength = net.ReadUInt(8)

    LDT_Polls.OptionStatsData = {}
    for i = 1, dataLength do
        local tempTable = {}
        tempTable["OptionID"] = net.ReadUInt(8)
        tempTable["Count"] = net.ReadUInt(8)
        LDT_Polls.OptionStatsTotal = LDT_Polls.OptionStatsTotal + tempTable["Count"]
        table.insert(LDT_Polls.OptionStatsData, i, tempTable)
    end

    if not IsValid(LDT_Polls.mainPanel) then return end
    this:CreatePollOptions()
    this:CreateBottomBtn()
end)

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
    greySecondCopy.a = Lerp((SysTime()-self.starttime)/10, greySecondCopy.a, 255)
    greyCopy.a = greySecondCopy.a
    whiteCopy.a = greySecondCopy.a
    whiteSecondCopy.a = greySecondCopy.a/8.5
    blueCopy.a = greySecondCopy.a
    blueSecondCopy.a = greySecondCopy.a
    blueThirdCopy.a = greySecondCopy.a

    draw.RoundedBox( 5, 0, 0, w, h, greySecondCopy )
end

vgui.Register("PollDetailPanel", PANEL, "DPanel")