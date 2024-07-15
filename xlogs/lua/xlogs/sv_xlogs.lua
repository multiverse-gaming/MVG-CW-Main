-- Automatic version checking
function xLogs.CheckVersion()
	if not xLogs.CheckedAddonVersion then
		http.Fetch(string.format("https://api.gmodstore.com/v2/addons/%i/versions", xLogs.Config.AddonID), function(body, l, head, code)
			if (code == 401) then xLogs.logerr(string.format("%s gmodstore API key invalid!", xLogs.Config.Name)) return end
			if (not (code == 200)) then xLogs.logerr(string.format("Something went wrong checking %s version! Error code: %i", xLogs.Config.Name, code)) return end
			
			-- Get the latest version
			local latestdat = util.JSONToTable(body).data[1]
			-- Get the current installed version
			local installedversion = string.format("%i.%i.%i", xLogs.Config.MajorVersion, xLogs.Config.MinorVersion, xLogs.Config.Patch)
			
			local vernumlatest = string.Replace(latestdat.name, ".", "")
			local vernumcur = string.Replace(installedversion, ".", "")
			if vernumcur > vernumlatest then xLogs.log(string.format("Running a newer version of %s than the latest! This looks fun! Latest: %s Current: %s", xLogs.Config.Name, latestdat.name, installedversion)) return end
			
			if (installedversion == latestdat.name) then
				xLogs.log(string.format("%s is up to date! Version: %s", xLogs.Config.Name, installedversion))
			else
				xLogs.logerr(string.format("You are running an outdated version of %s! Latest: %s Current: %s", xLogs.Config.Name, latestdat.name, installedversion))
			end
		end, function(err)
			xLogs.logerr(string.format("Failed to check %s version. Error: %s", xLogs.Config.Name, err))
		end, {Authorization = "Bearer d00d1c82e316b756ba59edb0b26006858e99bcf5"})

		xLogs.CheckedAddonVersion = true
	end
end

hook.Add("PlayerInitialSpawn", "xLogsCheckAddonVersion", function()
	xLogs.CheckVersion()
end)

-- Network strings
util.AddNetworkString("xLogsNetworkLog")
util.AddNetworkString("xLogsNetworkLogs")
util.AddNetworkString("xLogsRequestLogUpdate")
util.AddNetworkString("xLogsUpdateSetting")
util.AddNetworkString("xLogsUpdateSettingCl")

-- Setup xLogs Settings SQL tables
function xLogs.CreateTables()
	local tbName = string.format("%s%s", xLogs.Config.LogsTableNamePrefix, "settings")

	local valueCols = {
		{ColName = "Category", DatType = "VARCHAR(255)", Extra = "PRIMARY KEY NOT NULL"},
		{ColName = "Enabled", DatType = "INTEGER"},
	}

	-- Create settings table
	xLogs.DB:createTableQuery(tbName, valueCols, function(dat1)
		xLogs.DB:selectQuery(tbName, function(dat)
			if dat and (table.Count(dat) > 0) then
				for k, v in pairs(dat) do
					-- Set up enabled and disabled logging categories
					xLogs.LoggingCats[v.Category] = xLogs.LoggingCats[v.Category] or {}
					xLogs.LoggingCats[v.Category].Enabled = (tonumber(v.Enabled) == 1) and true or false
				end
			end

			for k, v in pairs(xLogs.LoggingCats) do
				if (v.Enabled == nil) then
					xLogs.DB:insertQuery(tbName, {"Category", "Enabled"}, {v.Name, 1})
				end
			end
		end)
	end)
end
hook.Add("xLogsDatabaseConnected", "xLogsCreateTables", xLogs.CreateTables)

local function RGBToHex(col)
	local rtn = "#"

	col = {col.r, col.g, col.b}

	for k, v in ipairs(col) do
		local hex = ""

		while v > 0 do
			local val = math.fmod(v, 16) + 1
			v = math.floor(v / 16)
			hex = string.sub("0123456789ABCDEF", val, val) .. hex			
		end

		rtn = rtn .. hex
	end

	return rtn
end

-- Send a log to the configured Discord webhook
function xLogs.RunDiscordRelay(log)
	if xLogs.Config.DoDiscordRelay and xLogs.Config.RelayURL and (xLogs.Config.RelayURL ~= "") then
		http.Post(xLogs.Config.RelayURL, {title = string.format("%s - %s", xLogs.LoggingTypes[log.Type].Cat, log.Type), color = RGBToHex(xLogs.LoggingCats[xLogs.LoggingTypes[log.Type].Cat].Col), url = xLogs.Config.DiscordWebhook, content = log.Content})
	end
end

function xLogs.SplitLogTables(ply, tb)
	local max = 50

	local rtn = {}
	local i = 0
	local tbpos = 1

	for k, log in ipairs(tb or {}) do
		if i > max then tbpos = tbpos + 1 end

		table.insert(rtn, tbpos, log)
		table.remove(tb, k)

		i = i + 1
	end

	return rtn
end

-- Network all available logs to a client
function xLogs.NetworkLogs(len, ply)
	local alllogs = {}

	for cat, logs in pairs(xLogs.Logs) do
		if xLogs.LoggingCats[cat].Enabled == false then continue end

		if (not xLogs.LoggingCats[cat].NeedsPermissions) or xLogs.HasPermission(ply, string.format("xlogs_%s", string.lower(cat))) then
			for k, v in ipairs(logs) do
				table.insert(alllogs, {Cat = cat, Type = v.Type, Content = v.Content, Time = v.Time})
			end
		end
	end

	local send = xLogs.SplitLogTables(ply, alllogs)

	for k1, v1 in ipairs(send) do
		et.Start("xLogsNetworkLogs", true)
			net.WriteUInt(table.Count(v1), 32)
			for k, v in ipairs(v1) do
				net.WriteString(v.Cat)
				net.WriteString(v.Type)
				net.WriteString(v.Content)
				net.WriteUInt(v.Time, 32)
			end
		net.Send(ply)
	end

	for k, v in pairs(xLogs.LoggingCats) do
		et.Start("xLogsUpdateSettingCl", true) -- Use unreliable network buffers, doesn't guarantee delivery, but should fix activedev+ from being kicked due to buffer overflows
			net.WriteString("enable" .. k)
			net.WriteBool(v.Enabled)
		net.Send(ply)
	end
end
net.Receive("xLogsRequestLogUpdate", xLogs.NetworkLogs)

-- Network a log to all clients with permission to view it
function xLogs.NetworkLog(typ, content, tim)
	local send = {}
	if not xLogs.LoggingTypes[typ] then return end
	local cat = xLogs.LoggingCats[xLogs.LoggingTypes[typ].Cat]
	if cat.Enabled == false then return end

	-- If the category needs permissions to be assigned, only get players with perms
	-- Otherwise, we can just send it to everyone
	if cat.NeedsPermissions then
		for k, v in ipairs(player.GetAll()) do
			if xLogs.HasPermission(v, string.format("xlogs_%s", string.lower(cat.Name))) then
				table.insert(send, v)
			end
		end
	else
		send = player.GetAll()
	end

	et.Start("xLogsNetworkLog", true)
		net.WriteString(typ)
		net.WriteString(content)
		net.WriteInt(tim, 32)
	net.Send(send)
end

net.Receive("xLogsUpdateSetting", function(len, ply)
	local setting = net.ReadString()
	local val = net.ReadBool()

	if not xLogs.Settings[setting] then return end

	local settingTb = xLogs.Settings[setting]
	if not xLogs.HasPermission(ply, settingTb.Permission) then return end

	settingTb.Func(val)
	settingTb.Value = val

	et.Start("xLogsUpdateSettingCl", true)
		net.WriteString(setting)
		net.WriteBool(val)
	net.Broadcast()
end)

-- Get a player's location from their IP address
function xLogs.GetLocationFromIP(ip, callback)
	local qs = string.format("https://thexnator.dev/gms/userinfo.php?ip=%s", ip or "")
	http.Fetch(qs, function(body, len, headers, code)		
		local json = body
		local data = util.JSONToTable(json)

		callback(data)
	end, function(err)
		callback({country_name="N/A"})
	end)
end

-- Chat commands
hook.Add("PlayerSay", "xLogsChatCommands", function(ply, text, team)
	--Menu
	if (string.sub(text, 1, string.len(xLogs.Config.ChatCommand)) == xLogs.Config.ChatCommand) then
		ply:ConCommand("xLogsToggleMenu")
		return ""
	end
end)
