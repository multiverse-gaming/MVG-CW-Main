xLogs.Economy = xLogs.Economy or {}
xLogs.Economy.Info = xLogs.Economy.Info or {}
xLogs.Economy.PlayerInfo = xLogs.Economy.PlayerInfo or {}
xLogs.Economy.LastLogged = xLogs.Economy.LastLogged or 0

local tbName = string.format("%s%s", xLogs.Config.LogsTableNamePrefix, "economydata")

util.AddNetworkString("xLogsSendEconomyInfo")
util.AddNetworkString("xLogsSendEconomyPlayerInfo")

-- Setup xLogs Economy SQL tables
function xLogs.Economy.CreateTables()
	if DarkRP then
		local valueCols = {
			{ColName = "Time", DatType = "INTEGER", Extra = "PRIMARY KEY NOT NULL"},
			{ColName = "Money", DatType = "INTEGER"},
		}

		-- Create economy data table
		xLogs.DB:createTableQuery(tbName, valueCols, function(dat1)
			xLogs.DB:selectQuery(tbName, function(dat)
				if dat and (table.Count(dat) > 0) then
					for k, v in pairs(dat) do
						table.insert(xLogs.Economy.Info, {Time = v.Time, Money = v.Money})
					end

					xLogs.Economy.SendEconomyData()
				end
			end)
		end)
	end
end
hook.Add("xLogsDatabaseConnected", "xLogsEconomyCreateTables", xLogs.Economy.CreateTables)

function xLogs.Economy.SendEconomyData(ply)
	if not ply then ply = player.GetAll() end

	local sendtb = util.Compress(util.TableToJSON(xLogs.Economy.Info or {}))
    net.Start("xLogsSendEconomyInfo", true)
        net.WriteUInt(#sendtb, 32)
        net.WriteData(sendtb, #sendtb)
    net.Send(ply)
end

function xLogs.Economy.SendEconomyPlayerData(ply)
	if not ply then ply = player.GetAll() end

	local sendtb = util.Compress(util.TableToJSON(xLogs.Economy.PlayerInfo or {}))
    net.Start("xLogsSendEconomyPlayerInfo", true)
        net.WriteUInt(#sendtb, 32)
        net.WriteData(sendtb, #sendtb)
    net.Send(ply)
end

hook.Add("PlayerInitialSpawn", "xLogsEconomySendData", function(ply)
	xLogs.Economy.SendEconomyData(ply)
	xLogs.Economy.GetPlayerData(ply)
end)

-- Record daily economy information
function xLogs.Economy.LogEconomyInfo()
	if not DarkRP then return end
	if ((os.time() - xLogs.Economy.LastLogged) < 86400) then return end

	local totalMoney = 0
	local qs = "SELECT SUM(wallet) AS totalMoney FROM darkrp_player WHERE uid >= 4294967296;"
	MySQLite.query(qs, function(dat)
		if dat and dat[1] then
			local logTime = os.time()
			table.insert(xLogs.Economy.Info, {Time = logTime, Money = dat[1].totalMoney})

			xLogs.DB:insertQuery(tbName, {"Time", "Money"}, {logTime, dat[1].totalMoney})

			xLogs.Economy.LastLogged = logTime

			xLogs.Economy.SendEconomyData()
		end
	end)
end

-- Check once an hour whether or not we need to log economy status and update client data
timer.Create("xLogsRunEconomyLogging", 60 * 60, 0, function()
	xLogs.Economy.LogEconomyInfo()
	xLogs.Economy.GetPlayerData()
end)

function xLogs.Economy.GetPlayerData(ply)
	local qs = "SELECT * FROM darkrp_player ORDER BY wallet DESC LIMIT 20;"

	MySQLite.query(qs, function(dat)
		if dat and (table.Count(dat) > 0) then
			xLogs.Economy.PlayerInfo = {}

			for k, v in pairs(dat) do
				table.insert(xLogs.Economy.PlayerInfo, {Name = v.rpname, SteamID = util.SteamIDFrom64(v.uid), Money = v.wallet})
			end
		end

		xLogs.Economy.SendEconomyPlayerData(ply)
	end)
end