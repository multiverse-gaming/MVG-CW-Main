local PANEL = {}

local this
local pollType = nil

-- Setup default properties of this panel
function PANEL:Init()
    this = self
    self.starttime = SysTime()
    table.Empty(LDT_Polls.Polls)
    table.Empty(LDT_Polls.SubmitedPolls)

    self:Dock(FILL)
    self:DockMargin(LDT_Polls.GetWidth(10), 0, LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))

    if LDT_Polls.Config.AdminRanks[LDT_Polls.GetPlayerGroup(LDT_Polls.ply)] then
        self:CreateBottomBtn()
    end
end

-- Sets the type of this poll panel
function PANEL:SetType(type)
    pollType = LDT_Polls.PollTypes[type]
    net.Start("LDT_Polls_GetPolls")
        net.WriteUInt( type,2 )
    net.SendToServer()
end

-- Create the scroll body that will hold the polls.
function PANEL:CreateBody()
    self.scroll = self:Add("DScrollPanel")
    self.scroll:Dock(FILL)
    if not LDT_Polls.Config.AdminRanks[LDT_Polls.GetPlayerGroup(LDT_Polls.ply)] then
        self.scroll:DockMargin(0, 0, 0, LDT_Polls.GetHeight(10))
    end

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

-- Populate the body with all of the polls
function PANEL:PopulatePolls()
    if #LDT_Polls.Polls < 1 then
        self.scroll:Remove()

        self.noServerData = self:Add("DPanel")
        self.noServerData:Dock(FILL)
        self.noServerData:DockMargin(0, 0, 0, 0)
        self.noServerData.Paint = function(me, w, h)
            draw.SimpleText(LDT_Polls.GetLanguange("NoPolls"), "WorkSans40-Bold", w*.5, h*.5, LDT_Polls.Config.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        return
    end

    self.i = 1
    self.websiteItems = {}
    timer.Create( "FadeTimer", 0.15, #LDT_Polls.Polls, function()
        if LDT_Polls.Polls[self.i] == nil or not IsValid(self.websiteItems[LDT_Polls.Polls[self.i]["PollID"]]) then return end

        self.websiteItems[LDT_Polls.Polls[self.i]["PollID"]].StartFade = true self.i = self.i +1 
    end )
    
    for k, v in pairs(LDT_Polls.Polls) do
        if v["PollID"] == nil then return end
        -- This creates the main panel of the poll.
        self.websiteItems[v["PollID"]] = self.scroll:Add("DPanel")
        self.websiteItems[v["PollID"]]:Dock(TOP)
        self.websiteItems[v["PollID"]]:SetTall(LDT_Polls.GetHeight(70))
        self.websiteItems[v["PollID"]].StartFade = false
        self.websiteItems[v["PollID"]]:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(15), LDT_Polls.GetWidth(10), 0)

        self.websiteItems[v["PollID"]].Colors = {}
        self.websiteItems[v["PollID"]].Colors.whiteCopy = table.Copy(LDT_Polls.Config.White)
        self.websiteItems[v["PollID"]].Colors.blueCopy = table.Copy(LDT_Polls.Config.Blue)
        self.websiteItems[v["PollID"]].Colors.blueSecondCopy = table.Copy(LDT_Polls.Config.BlueSecond)
        self.websiteItems[v["PollID"]].Colors.greyCopy = table.Copy(LDT_Polls.Config.Grey)
        self.websiteItems[v["PollID"]].Colors.redCopy = table.Copy(LDT_Polls.Config.Red)
        for key, value in pairs(self.websiteItems[v["PollID"]].Colors) do
            value.a = 0
        end

        self.websiteItems[v["PollID"]].Paint = function(me, w, h)
            if me.StartFade then
                me.Colors.whiteCopy.a = Lerp((SysTime()-self.starttime)/20,me.Colors.whiteCopy.a,255)
                for key, value in pairs(self.websiteItems[v["PollID"]].Colors) do
                    value.a = me.Colors.whiteCopy.a
                end
            end

            local xPos = w*.02
            if v["SteamID"] == LDT_Polls.ply:SteamID64() or LDT_Polls.Config.WhoCanDeletePolls[LDT_Polls.GetPlayerGroup(LDT_Polls.ply)] then
                xPos = w*.07
            end

            draw.RoundedBox( 5, 0, 0, w, h, me.Colors.greyCopy )
            draw.SimpleText(v["PollTitle"], "WorkSans46-Bold", xPos, h*.3, me.Colors.whiteCopy, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            steamworks.RequestPlayerInfo( v["SteamID"], function( steamName )
                draw.SimpleText("By "..steamName, "WorkSans30", xPos, h*.7, me.Colors.whiteCopy, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)    
            end )
        end

        -- This adds the open poll btn to the main poll panel.
        self.websiteItems[v["PollID"]].openPollBtn = self.websiteItems[v["PollID"]]:Add("DButton")
        self.websiteItems[v["PollID"]].openPollBtn:SetText("")
        self.websiteItems[v["PollID"]].openPollBtn:Dock(RIGHT)
        self.websiteItems[v["PollID"]].openPollBtn:SetWide(LDT_Polls.GetWidth(75))
        self.websiteItems[v["PollID"]].openPollBtn:SetDrawBackground(false)
        self.websiteItems[v["PollID"]].openPollBtn.DoClick = function()
            LDT_Polls.mainPanelThis:OpenPollDetail(v["PollID"], v["SteamID"], v["PollTitle"], v["PollDescription"], v["PollOptions"], v["PollEndDate"], v["PollVoteGroups"])
        end
        self.websiteItems[v["PollID"]].openPollBtn.Paint = function(me, w, h)
            if self.websiteItems[v["PollID"]].openPollBtn:IsHovered() then
                draw.RoundedBox( 5, 0, 0, w, h, self.websiteItems[v["PollID"]].Colors.blueSecondCopy )
            else
                draw.RoundedBox( 5, 0, 0, w, h, self.websiteItems[v["PollID"]].Colors.blueCopy )
            end

            local length = draw.SimpleText(LDT_Polls.GetLanguange("OpenPoll"), "WorkSans30-Bold", w*.5, h*.5, self.websiteItems[v["PollID"]].Colors.whiteCopy, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            if(length > 75) then
                self.websiteItems[v["PollID"]].openPollBtn:SetWide(LDT_Polls.GetWidth(length) + w*0.08)
            end
        end

        -- If the player can delete polls. This adds the minus btn next to the poll title.
        if LDT_Polls.Config.CanDeleteOwnPolls and v["SteamID"] == LDT_Polls.ply:SteamID64() or LDT_Polls.Config.WhoCanDeletePolls[LDT_Polls.GetPlayerGroup(LDT_Polls.ply)] then
            self.websiteItems[v["PollID"]].minusBtn = self.websiteItems[v["PollID"]]:Add("DImageButton")
            self.websiteItems[v["PollID"]].minusBtn:Dock(LEFT)
            self.websiteItems[v["PollID"]].minusBtn:SetWide(LDT_Polls.GetWidth(16))
            self.websiteItems[v["PollID"]].minusBtn:DockMargin(LDT_Polls.GetWidth(10), 0, 0, 0)
            self.websiteItems[v["PollID"]].minusBtn.DoClick = function()
                net.Start("LDT_Polls_RemovePoll")
                    net.WriteUInt(v["PollID"], 8)
                net.SendToServer()
                self.websiteItems[v["PollID"]]:Remove()
            end
            self.websiteItems[v["PollID"]].minusBtn.Paint = function(me, w, h)
                surface.SetMaterial( LDT_Polls.minusIcon )
                surface.SetDrawColor( self.websiteItems[v["PollID"]].Colors.redCopy )
                surface.DrawTexturedRect( 0, h*0.5-(LDT_Polls.GetHeight(16)/2), LDT_Polls.GetWidth(16), LDT_Polls.GetHeight(16) )
            end
        end
    end

    for k, v in ipairs(LDT_Polls.SubmitedPolls) do
        if not IsValid(self.websiteItems[v["PollID"]].submitedIcon) then
            self.websiteItems[v["PollID"]].submitedIcon = self.websiteItems[v["PollID"]]:Add("DImage")
            self.websiteItems[v["PollID"]].submitedIcon:Dock(RIGHT)
            self.websiteItems[v["PollID"]].submitedIcon:SetWide(LDT_Polls.GetWidth(32))
            self.websiteItems[v["PollID"]].submitedIcon:DockMargin(LDT_Polls.GetWidth(10), 0, LDT_Polls.GetWidth(10), 0)
            self.websiteItems[v["PollID"]].submitedIcon.Paint = function(me, w, h)
                surface.SetMaterial( LDT_Polls.submitedIcon )
                surface.SetDrawColor( self.websiteItems[v["PollID"]].Colors.blueCopy )
                surface.DrawTexturedRect( 0, h*0.5-(LDT_Polls.GetHeight(32)/2), LDT_Polls.GetWidth(32), LDT_Polls.GetHeight(32) )
            end
        end
    end
end

-- Create the bottom button
function PANEL:CreateBottomBtn()
    self.createPoll = self:Add("DButton")
    self.createPoll:SetText("")
    self.createPoll:SetTall(LDT_Polls.GetHeight(40))
    self.createPoll:Dock(BOTTOM)
    self.createPoll:DockMargin(LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10), LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))
    self.createPoll.DoClick = function()
        LDT_Polls.mainPanelThis:OpenCreatePoll()
    end
    self.createPoll.Paint = function(me, w, h)
        if me:IsHovered() then
            draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.BlueSecond )
        else
            draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.Blue )
        end

        draw.SimpleText(LDT_Polls.GetLanguange("CreatePoll"), "WorkSans30-Bold", w*.5, h*.5, LDT_Polls.Config.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

-- Receive polls from the server
net.Receive("LDT_Polls_SendPolls",function()
    local tableCount = net.ReadUInt(8)

    -- Create a dataTable for all of the incoming polls
    local dataTable = {}
    for var = 1, tableCount do
        local tempTable = {}
        tempTable["PollID"] = net.ReadUInt(8)
        tempTable["SteamID"] = net.ReadString()
        tempTable["PollTitle"] = net.ReadString()
        tempTable["PollDescription"] = net.ReadString()
        tempTable["PollOptions"] = {}

        local PollsOptionsLength = net.ReadUInt(8)
        for i = 1, PollsOptionsLength do
            local tempTable2 = {}
            tempTable2["OptionID"] = net.ReadUInt(8)
            tempTable2["OptionText"] = net.ReadString()
            table.insert(tempTable["PollOptions"], i, tempTable2)
        end

        tempTable["PollEndDate"] = net.ReadUInt(32)

        local voteGroupsLength = net.ReadUInt(8)
        tempTable["PollVoteGroups"] = {}
        for i = 1, voteGroupsLength do
            tempTable["PollVoteGroups"][net.ReadString()] = true
        end

        table.insert(dataTable, var, tempTable)
    end

    -- Create another dataTable for all of the clients submited polls.
    local tableCount2 = net.ReadUInt(8)
    local dataTable2 = {}
    for var = 1, tableCount2 do
        local tempTable = {}
        tempTable["PollID"] = net.ReadUInt(8)
        tempTable["OptionID"] = net.ReadUInt(8)
        table.insert(dataTable2, var, tempTable)
    end

    if not IsValid(LDT_Polls.mainPanel) then return end
    if IsValid(this.scroll) then this.scroll:Remove() end
    if IsValid(this.noServerData) then this.noServerData:Remove() end

    LDT_Polls.Polls = dataTable
    LDT_Polls.SubmitedPolls = dataTable2

    this:CreateBody()
    this:PopulatePolls()
end)

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
    draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.GreySecond )
end

vgui.Register("PollsPanel", PANEL, "DPanel")