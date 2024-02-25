-- Prepare network strings  
util.AddNetworkString("LDT_Polls_OpenPollsUI")

util.AddNetworkString("LDT_Polls_GetPolls")
util.AddNetworkString("LDT_Polls_SendPolls")

util.AddNetworkString("LDT_Polls_SubmitPoll")
util.AddNetworkString("LDT_Polls_GetAllSubmits")
util.AddNetworkString("LDT_Polls_SendAllSubmits")
util.AddNetworkString("LDT_Polls_CreatePoll")
util.AddNetworkString("LDT_Polls_RemovePoll")
util.AddNetworkString("LDT_Polls_GetStats")
util.AddNetworkString("LDT_Polls_SendStats")


local function NotifyPlayer( ply, text )
    if DarkRP then
        DarkRP.notify( ply, 0, 5, text )
    elseif nut or ix then
        ply:notify(text)
    else 
        ply:ChatPrint( text )
    end
end

-- Chooses the correct reward framework to use.
function LDT_Polls.RewardPlayer(ply, amount)
    if LDT_Polls.Config.RewardFramework == "DarkRP" then
        ply:addMoney(amount) 
    elseif LDT_Polls.Config.RewardFramework == "NS" then
        ply:getChar():giveMoney(amount)
    elseif LDT_Polls.Config.RewardFramework == "PS1" then
        ply:PS_GivePoints(amount)
    elseif LDT_Polls.Config.RewardFramework == "PS2" then
        ply:PS2_AddStandardPoints(amount)
    end

    NotifyPlayer(ply,string.gsub(LDT_Polls.GetLanguange("RewardMsg"), "AMOUNT", LDT_Polls.PollsRewardFormater(amount)))
end

-- Receives the request to get all polls from a certain type
net.Receive("LDT_Polls_GetPolls", function(len, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply.GetPollsCooldown != nil then
        if ply.GetPollsCooldown > CurTime() then return end
    end
    ply.GetPollsCooldown = CurTime()+0.5

    local type = LDT_Polls.PollTypes[net.ReadUInt(2)]
    if LDT_Polls.Config.DatabaseMode == "mysqloo" then
        LDT_Polls.GetPollsMysql(ply, type)
    else 
        LDT_Polls.GetPollsSqlite(ply, type)
    end
end)

-- Receives the request to submit new poll vote
net.Receive("LDT_Polls_SubmitPoll", function(len, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply.PollsSubmitPollCooldown != nil then
        if ply.PollsSubmitPollCooldown > CurTime() then return end
    end
    ply.PollsSubmitPollCooldown = CurTime()+1

    local pollID = net.ReadUInt(8)
    local optionID = net.ReadUInt(4)

    if LDT_Polls.Config.DatabaseMode == "mysqloo" then
        LDT_Polls.SubmitPollMysql(ply, pollID, optionID)
    else 
        LDT_Polls.SubmitPollSqlite(ply, pollID, optionID)
    end
end)

-- Receives the request to get all submits
net.Receive("LDT_Polls_GetAllSubmits", function(len, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply.PollsGetAllSubmitsCooldown != nil then
        if ply.PollsGetAllSubmitsCooldown > CurTime() then return end
    end
    ply.PollsGetAllSubmitsCooldown = CurTime()+0.5

    local pollID = net.ReadUInt(8)

    if LDT_Polls.Config.DatabaseMode == "mysqloo" then
        LDT_Polls.GetAllSubmitsMysql(ply, pollID)
    else 
        LDT_Polls.GetAllSubmitsSqlite(ply, pollID)
    end
end)

-- Receives the request to remove a certain poll
net.Receive("LDT_Polls_RemovePoll", function(len, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply.PollsRemovePollsCooldown != nil then
        if ply.PollsRemovePollsCooldown > CurTime() then return end
    end

    ply.PollsRemovePollsCooldown = CurTime() + 0.5
    if LDT_Polls.Config.DatabaseMode == "mysqloo" then
        LDT_Polls.RemovePollMysql(ply, net.ReadUInt(8))
    else 
        LDT_Polls.RemovePollSqlite(ply, net.ReadUInt(8))
    end
end)

-- Receives the request to create new poll
net.Receive("LDT_Polls_CreatePoll",function(len, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if LDT_Polls.Config.AdminRanks[LDT_Polls.GetPlayerGroup(ply)] == false then return end

    -- This part of the code verifies the data received from the client.
    local title = net.ReadString()
    if title == "" or #title > LDT_Polls.Config.MaxNumOfCharsTitle then return end

    local description = net.ReadString()
    if description == "" or #description > LDT_Polls.Config.MaxNumOfCharsDesc then return end
    
    local pollOptionsLength = net.ReadUInt(8)
    if pollOptionsLength < 2 or pollOptionsLength > LDT_Polls.Config.MaxNumOfPollOptions then return end
    
    -- This verifies the poll options and adds them into pollOptions dataTable.
    local pollOptions = {}
    for i = 1, pollOptionsLength do
        local tempTable = {}
        tempTable["OptionText"] = net.ReadString()
        if tempTable["OptionText"] == "" then return end
        tempTable["OptionID"] = i
        table.insert(pollOptions, i, tempTable)
    end
    
    local timestamp = net.ReadUInt(32)
    if timestamp < os.time() then return end


    local pollSettings = {}
    local viewGroups = net.ReadString()
    local voteGroups = net.ReadString()
    local voteRewardAmount = net.ReadString()

    pollSettings["viewGroups"] = {}
    pollSettings["voteGroups"] = {}
    pollSettings["voteRewardAmount"] = voteRewardAmount
    
    for k, v in ipairs(string.Split(viewGroups,",")) do
        if v != "" then
            pollSettings["viewGroups"][v] = true
        end
    end

    for k, v in ipairs(string.Split(voteGroups,",")) do
        if v != "" then
            pollSettings["voteGroups"][v] = true
        end
    end
    

    -- If everything is good to go. The Mysql or sqlite db function is called.
    if LDT_Polls.Config.DatabaseMode == "mysqloo" then
        LDT_Polls.CreateNewPollMysql(ply, title, description, pollOptions, timestamp, pollSettings)
    else 
        LDT_Polls.CreateNewPollSqlite(ply, title, description, pollOptions, timestamp, pollSettings)
    end
end)

-- Receives the request to get all of the stats from the db
net.Receive("LDT_Polls_GetStats", function(len, ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply.PollsStatsPollsCooldown != nil then
        if ply.PollsStatsPollsCooldown > CurTime() then return end
    end

    ply.PollsStatsPollsCooldown = CurTime()+0.5

    if LDT_Polls.Config.DatabaseMode == "mysqloo" then
        LDT_Polls.GetStatsMysql(ply)
    else 
        LDT_Polls.GetStatsSqlite(ply)
    end
end)

-- This sends the open command to the player
hook.Add("PlayerSay", "LDT_Polls.OpenPollsUI", function( ply, text )
    if string.lower(text) == string.lower("!"..LDT_Polls.Config.MenuCommand) or string.lower(text) == string.lower("/"..LDT_Polls.Config.MenuCommand) then
        net.Start("LDT_Polls_OpenPollsUI")
        net.Send(ply)
    end
end)