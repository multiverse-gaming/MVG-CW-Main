if LDT_Polls.Config.DatabaseMode != "mysqloo" then return end
local MySQLOO = require("mysqloo")

-- Creates the DB connection
LDT_Polls.DB_POLLS = mysqloo.connect(LDT_Polls.Config.DatabaseConfig.host,LDT_Polls.Config.DatabaseConfig.user,LDT_Polls.Config.DatabaseConfig.password,LDT_Polls.Config.DatabaseConfig.database,LDT_Polls.Config.DatabaseConfig.port)

-- Connects to the DB
function LDT_Polls.ConnectToDatabase()
	LDT_Polls.DB_POLLS:setAutoReconnect(true)
	
	print("[POLLS] Connecting to Database!")
	LDT_Polls.DB_POLLS.onConnected = function()
		print("[POLLS] Database Connection Successful!")
	end
	LDT_Polls.DB_POLLS.onConnectionFailed = function(db,msg)
		print("[POLLS] Database Connection failed!")
		print(msg)
	end
	LDT_Polls.DB_POLLS:connect()
end

-- Creates all the necessary tables
local function CreateDBTable()
    local query = LDT_Polls.DB_POLLS:query([[
		CREATE TABLE IF NOT EXISTS polls (
			PollID INT PRIMARY KEY AUTO_INCREMENT,
			SteamID VARCHAR(20) NOT NULL,
			PollTitle VARCHAR(20) NOT NULL,
			PollDescription VARCHAR(200) NOT NULL,
			PollOptions JSON NOT NULL,
			PollSettings JSON NOT NULL,
			PollEndDate INT UNSIGNED NOT NULL
		);
			
		CREATE TABLE IF NOT EXISTS polls_submits (
			ID INT PRIMARY KEY AUTO_INCREMENT,
			PollID INT NOT NULL,
			SteamID VARCHAR(20) NOT NULL,
			OptionID INT NOT NULL,
			DateSubmited INT UNSIGNED NOT NULL,
			SubmitWeight INT NOT NULL
		);]])
		
	query.onSuccess = function()
		print("[POLLS] Successfully created MySQL tables.")
	end
	query:start()
end

-- Gets the Running, Ended or Your polls from the mysql DB
function LDT_Polls.GetPollsMysql(ply,type)
	-- First we get the type of data we want to get from the db
	local querystring = ""
	if type == "Running" then
		querystring= "SELECT * FROM polls WHERE PollEndDate > UNIX_TIMESTAMP();"
	elseif type == "Finished" then
		querystring = "SELECT * FROM polls WHERE PollEndDate < UNIX_TIMESTAMP();"
	elseif type == "Your" then
		querystring = "SELECT * FROM polls WHERE SteamID = '"..LDT_Polls.DB_POLLS:escape(ply:SteamID64()).."'"
	end

	local query = LDT_Polls.DB_POLLS:query(querystring)
	query.onSuccess = function()
		local data = query:getData()
		local query2string = ""
		for k, v in ipairs(data) do
			query2string = query2string..","..v["PollID"]
		end
		
		-- Now we select all of the poll submits for the type of polls we selected.
		query2string = query2string:sub(2)
		local query2 = LDT_Polls.DB_POLLS:query("SELECT PollID,OptionID FROM polls_submits WHERE PollID IN("..query2string..") AND SteamID = '"..LDT_Polls.DB_POLLS:escape(ply:SteamID64()).."'")

		query2.onSuccess = function()
			local data2 = query2:getData()
			local viewablePolls = {}

			-- And now we prepare it and send it to the client.
			net.Start("LDT_Polls_SendPolls")

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
						voteGroupsTotal = voteGroupsTotal+1
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
		query2:start()	
	end
	query:start()
end

-- Submits new poll vote to the mysql DB
function LDT_Polls.SubmitPollMysql(ply, pollID, optionID)
	local query = LDT_Polls.DB_POLLS:query("SELECT PollSettings,PollEndDate FROM polls WHERE PollID = "..tonumber(pollID)..";")
	query.onSuccess = function()
		local pollSettings = util.JSONToTable( query:getData()[1]["PollSettings"] )
		if not pollSettings["voteGroups"][LDT_Polls.GetPlayerGroup(ply)] and not LDT_Polls.Config.AdminRanks[LDT_Polls.GetPlayerGroup(ply)] and not table.IsEmpty(pollSettings["voteGroups"]) then return end
		if tonumber(query:getData()[1]["PollEndDate"]) < os.time() then return end

		local query2
		if LDT_Polls.Config.UsegroupWeightsEnabled and LDT_Polls.Config.UsergroupWeights[LDT_Polls.GetPlayerGroup(ply)] != nil then
			query2 = LDT_Polls.DB_POLLS:query("INSERT INTO `polls_submits`(`PollID`, `SteamID`, `OptionID`, `DateSubmited`, `SubmitWeight`) VALUES ("..tonumber(pollID)..",'"..LDT_Polls.DB_POLLS:escape(ply:SteamID64()).."',"..tonumber(optionID)..","..sql.SQLStr( os.time() )..","..sql.SQLStr( LDT_Polls.Config.UsergroupWeights[LDT_Polls.GetPlayerGroup(ply)] )..")")
		else
			query2 = LDT_Polls.DB_POLLS:query("INSERT INTO `polls_submits`(`PollID`, `SteamID`, `OptionID`, `DateSubmited`, `SubmitWeight`) VALUES ("..tonumber(pollID)..",'"..LDT_Polls.DB_POLLS:escape(ply:SteamID64()).."',"..tonumber(optionID)..","..sql.SQLStr( os.time() )..",1)")
		end

		query2.onSuccess = function()
			if pollSettings["voteRewardAmount"] == "" then return end
			if not LDT_Polls.Config.EnableVoteRewards or tonumber(pollSettings["voteRewardAmount"]) < 1 then return end

			LDT_Polls.RewardPlayer(ply,tonumber(pollSettings["voteRewardAmount"]))
		end
		query2:start()
	end
	query:start()
end

-- Gets all sumbits for a certain poll from the mysql db
function LDT_Polls.GetAllSubmitsMysql(ply, pollID)
	local query = LDT_Polls.DB_POLLS:query("SELECT OptionID,COUNT(OptionID) FROM polls_submits WHERE PollID = "..tonumber(pollID).." GROUP BY OptionID")
	query.onSuccess = function()
		net.Start("LDT_Polls_SendAllSubmits")
			net.WriteUInt(#query:getData(), 8)
			for k, v in ipairs(query:getData()) do
				net.WriteUInt(v["OptionID"], 8)
				net.WriteUInt(v["COUNT(OptionID)"], 8)
			end
		net.Send(ply)
	end
	query:start()
end

-- Inserts new poll into the mysql DB
function LDT_Polls.CreateNewPollMysql(ply, title, description, pollOptions, timestamp,pollSettings)
	local jsonPollOptions = util.TableToJSON(pollOptions)
	local jsonPollSettings = util.TableToJSON(pollSettings)
	local query = LDT_Polls.DB_POLLS:query("INSERT INTO `polls`(`SteamID`, `PollTitle`, `PollDescription`, `PollOptions`, `PollEndDate`,`PollSettings`) VALUES ('"..LDT_Polls.DB_POLLS:escape(ply:SteamID64()).."','"..LDT_Polls.DB_POLLS:escape(title).."','"..LDT_Polls.DB_POLLS:escape(description).."','"..LDT_Polls.DB_POLLS:escape(jsonPollOptions).."',"..tonumber(timestamp)..",'"..LDT_Polls.DB_POLLS:escape(jsonPollSettings).."')")
	query:start()
end

-- Removes a poll from the mysql DB
function LDT_Polls.RemovePollMysql(ply, pollID)
	local query = LDT_Polls.DB_POLLS:query("SELECT SteamID FROM polls WHERE PollID = "..tonumber(pollID)..";")
	query.onSuccess = function()
		local data = query:getData()
		if not LDT_Polls.Config.CanDeleteOwnPolls and not LDT_Polls.Config.WhoCanDeletePolls[LDT_Polls.GetPlayerGroup(ply)] then return end
		if data[1]["SteamID"] != ply:SteamID64() and not LDT_Polls.Config.WhoCanDeletePolls[LDT_Polls.GetPlayerGroup(ply)] then return end

		local query2 = LDT_Polls.DB_POLLS:query("DELETE FROM `polls` WHERE PollID = "..tonumber(pollID).."; DELETE FROM `polls_submits` WHERE PollID = "..tonumber(pollID).."")
		query2:start()
	end
	query:start()
end

-- Gets all of the stats from the mysql DB
function LDT_Polls.GetStatsMysql(ply)
	local querytext = "SELECT SteamID,SUM(SubmitWeight) FROM polls_submits WHERE DateSubmited BETWEEN UNIX_TIMESTAMP(NOW()- INTERVAL "..LDT_Polls.GetInterval()..") AND UNIX_TIMESTAMP() GROUP BY SteamID ORDER BY SUM(SubmitWeight) DESC;"
	if LDT_Polls.GetInterval() == "all" then
		querytext = "SELECT SteamID,SUM(SubmitWeight) FROM polls_submits GROUP BY SteamID ORDER BY SUM(SubmitWeight) DESC;"
	end

	local query = LDT_Polls.DB_POLLS:query(querytext)
    query.onSuccess = function()
		local data = query:getData()

		net.Start("LDT_Polls_SendStats")
			net.WriteUInt(#data, 16)
			for k, v in ipairs(data) do
				net.WriteString(v["SteamID"])
				net.WriteUInt(v["SUM(SubmitWeight)"], 12)
			end
		net.Send(ply)
	end
	query:start()
end

hook.Add( "Initialize", "LDT_Polls.createMysqlTable", function()
    if LDT_Polls.Config.DatabaseMode != "mysqloo" then return end
	
	LDT_Polls.ConnectToDatabase()
	CreateDBTable()
end )