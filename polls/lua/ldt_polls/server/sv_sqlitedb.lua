if LDT_Polls.Config.DatabaseMode == "mysqloo" then return end

-- Creates all the necessary tables
local function CreateDBTable()
    sql.Query([[CREATE TABLE IF NOT EXISTS polls (
        PollID INTEGER PRIMARY KEY AUTOINCREMENT,
        SteamID TEXT NOT NULL,PollTitle TEXT NOT NULL,
        PollDescription TEXT NOT NULL,
        PollOptions TEXT NOT NULL,
        PollSettings TEXT NOT NULL,
        PollEndDate INTEGER NOT NULL
    );]])
    sql.Query([[CREATE TABLE IF NOT EXISTS polls_submits (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        PollID INTEGER NOT NULL,
        SteamID TEXT NOT NULL,
        OptionID INTEGER NOT NULL,
        DateSubmited INTEGER NOT NULL,
        SubmitWeight INTEGER NOT NULL
    );]])
end

-- Gets the Running, Ended or Your polls from the sqlite DB
function LDT_Polls.GetPollsSqlite(ply,type)
    -- First we get the type of data we want to get from the db
	local querystring = ""
	if type == "Running" then
		querystring= "SELECT * FROM polls WHERE PollEndDate > strftime('%s', 'now');"
	elseif type == "Finished" then
		querystring = "SELECT * FROM polls WHERE PollEndDate < strftime('%s', 'now');"
	elseif type == "Your" then
		querystring = "SELECT * FROM polls WHERE SteamID = "..sql.SQLStr( ply:SteamID64() )..""
	end

	local data = sql.Query(querystring)
    if data == nil then
        data = {}
    end

    local query2string = ""
    for k, v in ipairs(data) do
        query2string = query2string..","..v["PollID"]
    end
    query2string = query2string:sub(2)

    -- Now we select all of the poll submits for the type of polls we selected.
    local data2 = sql.Query("SELECT PollID,OptionID FROM polls_submits WHERE PollID IN("..query2string..") AND SteamID = "..sql.SQLStr( ply:SteamID64() ).."")
    if data2 == nil then
        data2 = {}
    end

    
    -- And now we prepare it and send it to the client.
    net.Start("LDT_Polls_SendPolls")
        local viewablePolls = {}

        for k, v in ipairs(data) do
            local pollSettings = util.JSONToTable( v["PollSettings"] )
            if pollSettings["viewGroups"][LDT_Polls.GetPlayerGroup(ply)] or table.IsEmpty(pollSettings["viewGroups"]) or LDT_Polls.Config.AdminRanks[LDT_Polls.GetPlayerGroup(ply)] then
                table.insert(viewablePolls,v)
            end
        end

        net.WriteUInt(#viewablePolls,8)
        for k, v in ipairs(viewablePolls) do
            local pollSettings = util.JSONToTable( v["PollSettings"] )
            net.WriteUInt(tonumber(v["PollID"]), 8)
            net.WriteString(v["SteamID"])
            net.WriteString(v["PollTitle"])
            net.WriteString(v["PollDescription"])

            local PollsOptions = util.JSONToTable(v["PollOptions"])
            net.WriteUInt(#PollsOptions, 8)

            for key, value in ipairs(PollsOptions) do
                net.WriteUInt(value["OptionID"], 8)
                net.WriteString(value["OptionText"])
            end
            net.WriteUInt(v["PollEndDate"],32)

            local voteGroupsTotal = 0
            for key, value in pairs(pollSettings["voteGroups"]) do
                voteGroupsTotal = voteGroupsTotal + 1
            end

            net.WriteUInt(voteGroupsTotal, 8)
            for key, value in pairs(pollSettings["voteGroups"]) do
                net.WriteString(key)
            end
        end

        net.WriteUInt(#data2, 8)
            for k, v in ipairs(data2) do
                net.WriteUInt(tonumber(v["PollID"]), 8)
                net.WriteUInt(tonumber(v["OptionID"]), 8)
            end
    net.Send(ply)	
end

-- Submits new poll vote to the sqlite DB
function LDT_Polls.SubmitPollSqlite(ply, pollID, optionID)
	local data = sql.Query("SELECT PollSettings,PollEndDate FROM polls WHERE PollID = "..sql.SQLStr( pollID, true )..";")
    local pollSettings = util.JSONToTable( data[1]["PollSettings"] )
    if not pollSettings["voteGroups"][LDT_Polls.GetPlayerGroup(ply)] and not LDT_Polls.Config.AdminRanks[LDT_Polls.GetPlayerGroup(ply)] and not table.IsEmpty(pollSettings["voteGroups"]) then return end
    if tonumber(data[1]["PollEndDate"]) < os.time() then return end

    local data
    if LDT_Polls.Config.UsegroupWeightsEnabled and LDT_Polls.Config.UsergroupWeights[LDT_Polls.GetPlayerGroup(ply)] != nil then
        data = sql.Query("INSERT INTO `polls_submits`(`PollID`, `SteamID`, `OptionID`,`DateSubmited`,`SubmitWeight`) VALUES ("..sql.SQLStr( pollID, true )..","..sql.SQLStr( ply:SteamID64() )..","..sql.SQLStr( optionID, true )..","..sql.SQLStr( os.time() )..","..sql.SQLStr( LDT_Polls.Config.UsergroupWeights[LDT_Polls.GetPlayerGroup(ply)] )..")")
    else
        data = sql.Query("INSERT INTO `polls_submits`(`PollID`, `SteamID`, `OptionID`,`DateSubmited`,`SubmitWeight`) VALUES ("..sql.SQLStr( pollID, true )..","..sql.SQLStr( ply:SteamID64() )..","..sql.SQLStr( optionID, true )..","..sql.SQLStr( os.time() )..",1)")
    end


    if pollSettings["voteRewardAmount"] == "" then return end
    if data != nil or not LDT_Polls.Config.EnableVoteRewards or tonumber(pollSettings["voteRewardAmount"]) < 1 then return end

    LDT_Polls.RewardPlayer(ply,tonumber(pollSettings["voteRewardAmount"]))
end

-- Gets all sumbits for a certain poll from the sqlite db
function LDT_Polls.GetAllSubmitsSqlite(ply, pollID)
	local data = sql.Query("SELECT OptionID,COUNT(OptionID) FROM polls_submits WHERE PollID = "..sql.SQLStr( pollID, true ).." GROUP BY OptionID")

    net.Start("LDT_Polls_SendAllSubmits")
		net.WriteUInt(#data, 8)
		for k, v in ipairs(data) do
            net.WriteUInt(v["OptionID"], 8)
            net.WriteUInt(v["COUNT(OptionID)"], 8)
        end
    net.Send(ply)
end

-- Inserts new poll into the sqlite DB
function LDT_Polls.CreateNewPollSqlite(ply, title, description, pollOptions, timestamp,pollSettings)
	local jsonPollOptions = util.TableToJSON(pollOptions)
	local jsonPollSettings = util.TableToJSON(pollSettings)
	local query = sql.Query("INSERT INTO `polls`(`SteamID`, `PollTitle`, `PollDescription`, `PollOptions`, `PollEndDate`,`PollSettings`) VALUES ("..sql.SQLStr( ply:SteamID64() )..","..sql.SQLStr( title )..","..sql.SQLStr( description )..","..sql.SQLStr( jsonPollOptions )..","..sql.SQLStr( timestamp )..","..sql.SQLStr( jsonPollSettings )..")")
end

-- Removes a poll from the sqlite DB
function LDT_Polls.RemovePollSqlite(ply, pollID)
	local data = sql.Query("SELECT SteamID FROM polls WHERE PollID = "..pollID..";")
    if data == nil or not data then return end
    if not LDT_Polls.Config.CanDeleteOwnPolls and not LDT_Polls.Config.WhoCanDeletePolls[LDT_Polls.GetPlayerGroup(ply)] then return end
    if data[1]["SteamID"] != ply:SteamID64() and not LDT_Polls.Config.WhoCanDeletePolls[LDT_Polls.GetPlayerGroup(ply)] then return end
    
    sql.Query("DELETE FROM `polls` WHERE PollID = "..sql.SQLStr( pollID, true ).."; DELETE FROM `polls_submits` WHERE PollID = "..sql.SQLStr( pollID, true ).."")
end

-- Gets all of the stats from the sqlite DB
function LDT_Polls.GetStatsSqlite(ply)
    local querytext = "SELECT SteamID,SUM(SubmitWeight) FROM polls_submits WHERE DateSubmited BETWEEN strftime('%s', 'now','localtime','-"..LDT_Polls.GetInterval().."') AND strftime('%s', 'now','localtime') GROUP BY SteamID ORDER BY SUM(SubmitWeight) DESC;"
	if LDT_Polls.GetInterval() == "all" then
		querytext = "SELECT SteamID,SUM(SubmitWeight) FROM polls_submits GROUP BY SteamID ORDER BY SUM(SubmitWeight) DESC;"
	end

	local data = sql.Query(querytext)
    if data == false then return end
    if data == nil then data = {} end
    

    net.Start("LDT_Polls_SendStats")
        net.WriteUInt(#data, 16)
        for k, v in ipairs(data) do
            net.WriteString(v["SteamID"])
            net.WriteUInt(v["SUM(SubmitWeight)"], 12)
        end
    net.Send(ply)
end


hook.Add( "Initialize", "LDT_Polls.createSqliteTable", function()
    if LDT_Polls.Config.DatabaseMode != "sqlite" then return end
    CreateDBTable()
end )
