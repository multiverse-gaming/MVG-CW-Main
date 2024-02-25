local PANEL = {}

local this
local StatsDataTable = {}

-- Setup default properties of this panel
function PANEL:Init()
    this = self
    self.starttime = SysTime()
    self:Dock(FILL)
    self:DockMargin(LDT_Polls.GetWidth(10), 0, LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(10))

    net.Start("LDT_Polls_GetStats")
    net.SendToServer()

    this:CreateBody()
    this:PopulateStats()
end

-- Create the scroll body that will hold the stats.
function PANEL:CreateBody()
    self.scroll = self:Add("DScrollPanel")
    self.scroll:Dock(FILL)
    self.scroll:DockMargin(0, LDT_Polls.GetHeight(10), 0, LDT_Polls.GetHeight(10))

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

-- Populate the body with all of the Stats
function PANEL:PopulateStats()
    if #StatsDataTable == 0 then
        this.scroll:Remove()
        this.noServerData = this:Add("DPanel")
        this.noServerData:Dock(FILL)
        this.noServerData:DockMargin(0, 0, 0, 0)
        this.noServerData.Paint = function(me, w, h)
            draw.SimpleText(LDT_Polls.GetLanguange("NoStats"),"WorkSans40-Bold", w*.5, h*.5, LDT_Polls.Config.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        return
    end
    
    self.i = 1
    timer.Create( "FadeTimer", 0.15, #StatsDataTable, function()
        if StatsDataTable[self.i] == nil or not IsValid(self.topPlayers[self.i]) then return end

        self.topPlayers[self.i].StartFade = true self.i = self.i +1 
    end )
    
    self.topPlayers = {}
    for k, v in ipairs(StatsDataTable) do
        self.topPlayers[k] = this.scroll:Add("DPanel")
        self.topPlayers[k]:Dock(TOP)
        self.topPlayers[k]:SetTall(LDT_Polls.GetHeight(70))
        self.topPlayers[k]:DockMargin(LDT_Polls.GetWidth(10), 0, LDT_Polls.GetWidth(10), LDT_Polls.GetHeight(15))

        self.topPlayers[k].Colors = {}
        self.topPlayers[k].Colors.whiteCopy = table.Copy(LDT_Polls.Config.White)
        self.topPlayers[k].Colors.whiteSecondCopy = table.Copy(LDT_Polls.Config.WhiteSecond)
        self.topPlayers[k].Colors.bronzeCopy = table.Copy(LDT_Polls.Config.Bronze)
        self.topPlayers[k].Colors.goldCopy = table.Copy(LDT_Polls.Config.Gold)
        self.topPlayers[k].Colors.silverCopy = table.Copy(LDT_Polls.Config.Silver)
        self.topPlayers[k].Colors.greyCopy = table.Copy(LDT_Polls.Config.Grey)
        for key, value in pairs(self.topPlayers[k].Colors) do
            value.a = 0
        end

        self.topPlayers[k].Paint = function(me, w, h)
            if me.StartFade then
                me.Colors.greyCopy.a = Lerp((SysTime()-self.starttime)/20, me.Colors.greyCopy.a, 255)
                for key, value in pairs(self.topPlayers[k].Colors) do
                    value.a = me.Colors.greyCopy.a
                end
            end

            draw.RoundedBox( 5, 0, 0, w, h, me.Colors.greyCopy )
            
            local height = .5
            if k < 4 then 
                height = .46
            end
            draw.SimpleText(LDT_Polls.GetLanguange("NumVotesText")..v["Count"], "WorkSans30", w*.96, h*height, me.Colors.whiteCopy, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            draw.SimpleText(k, "WorkSans30-Bold", w*.01, h*height, me.Colors.whiteSecondCopy, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            steamworks.RequestPlayerInfo( v["SteamID"], function( steamName )
                draw.SimpleText(steamName, "WorkSans30-Bold", w*.04, h*height, me.Colors.whiteCopy, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end )

            if k == 1 then
                draw.RoundedBox( 5, 0, h*.92, w, h*.08, me.Colors.goldCopy )
            elseif k==2 then
                draw.RoundedBox( 5, 0, h*.92, w, h*.08, me.Colors.silverCopy )
            elseif k==3 then
                draw.RoundedBox( 5, 0, h*.92, w, h*.08, me.Colors.bronzeCopy )
            end
        end 
    end
end

-- Receive poll stats from the server
net.Receive("LDT_Polls_SendStats",function()
    table.Empty(StatsDataTable)

    -- Insert all of the stats into a table.
    local datalength = net.ReadUInt(16)
    for i = 1, datalength do
        local tempTable = {}
        tempTable["SteamID"] = net.ReadString()
        tempTable["Count"] = net.ReadUInt(12)
        table.insert(StatsDataTable, i, tempTable)
    end
    
    if not IsValid(LDT_Polls.mainPanel) then return end
    if IsValid(this.scroll) then this.scroll:Remove() end
    if IsValid(this.noServerData) then this.noServerData:Remove() end
    this:CreateBody()
    this:PopulateStats()
end)

function PANEL:OnSizeChanged(w, h)
end

-- Change the defualt paint.
function PANEL:Paint(w, h)
    draw.RoundedBox( 5, 0, 0, w, h, LDT_Polls.Config.GreySecond )
end

vgui.Register("PollsStatsPanel", PANEL, "DPanel")