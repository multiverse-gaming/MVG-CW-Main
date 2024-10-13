function xLogs.GetLanguageString(s)
	if not xLogs.Config.Languages[xLogs.Config.LANG] then return "LANGUAGE ERROR" end
	return (xLogs.Config.Languages[xLogs.Config.LANG][s]) or "LANGUAGE ERROR"
end

--Logging prefixes
xLogs.LOG_INFO = "[INFO]"
xLogs.LOG_ERROR = "[ERROR]"
function xLogs.log(msg, logtype)
	if not msg then return end
	if not logtype then logtype = "[INFO]" end
  
	MsgN(string.format("[xLogs] %s %s", logtype, msg))
end

--Log errors without having to actually use LOG_ERROR every time
function xLogs.logerr(msg)
	if not msg then return end
	xLogs.log(msg, xLogs.LOG_ERROR)
end

xLogs.NotificationSUCCESS = 1
xLogs.NotificationERROR = 2

xLogs.AdminSystems = xLogs.AdminSystems or {}
xLogs.AdminSystem = xLogs.AdminSystem or "CAMI"

-- Register a new admin system to support xLogs
function xLogs.RegisterAdminSystem(name, check, permissionCheck, getGroup, permissionRegister)
	xLogs.AdminSystems[name] = {
		CheckPermission = permissionCheck,
		GetGroup = getGroup,
		RegisterPermission = permissionRegister,
		CheckRun = check,
	}
end

-- FAdmin Support
xLogs.RegisterAdminSystem("FAdmin", function() return FAdmin end, function(ply, node)
	return FAdmin.Access.PlayerHasPrivilege(ply, node)
end, function(ply)
	if isstring(ply) then ply = player.GetBySteamID(ply) end
	return ply and IsValid(ply) and ply:GetUserGroup() or "disconnected"
end, function(name, node)
	FAdmin.Access.AddPrivilege(node, 2)
end)

-- xAdmin Support
xLogs.RegisterAdminSystem("xAdmin", function() return xAdmin end, function(ply, node)
	return ply:xAdminHasPermission(node)
end, function(ply)
	if isstring(ply) then return xAdmin.UserGroups[ply] or "disconnected" end
	return ply and IsValid(ply) and ply:GetUserGroup() or "disconnected"
end, function(name, node)
	local isnew = (xAdmin.Config.MajorVersion == 2)
	xAdmin.RegisterPermission(isnew and node or name, isnew and name or node, isnew and "xLogs" or "admin")
end)

-- ULX Support
xLogs.RegisterAdminSystem("ULX", function() return ulx end, function(ply, node)
	return ULib.ucl.query(ply, node)
end, function(ply)
	if isstring(ply) then ply = player.GetBySteamID(ply) end
	return ply and IsValid(ply) and ply:GetUserGroup() or "disconnected"
end, function(name, node)
	if SERVER then ULib.ucl.registerAccess(node, ULib.ACCESS_ADMIN, name, "xLogs") end
end)

-- Load xLogs admin system
function xLogs.SetupAdminSystem()
	for k, v in pairs(xLogs.AdminSystems) do
		if v.CheckRun() then
			xLogs.AdminSystem = k
		end
	end

	if (xLogs.AdminSystem == "CAMI") then xLogs.logerr("No supported admin system found - attempting to use CAMI!") end
end
hook.Add("OnGamemodeLoaded", "xLogsSetupAdminSystem", xLogs.SetupAdminSystem)

-- Check if a user has permissions for a permission node
function xLogs.HasPermission(ply, node)
	if (xLogs.AdminSystem == "CAMI") then
		if node == "xlogs_enablecategories" then 
			return CAMI and CAMI.PlayerHasAccess(ply, node) or ply:IsSuperAdmin()
		else 
			return CAMI and CAMI.PlayerHasAccess(ply, "xlogs_viewlogs")
		end
	end

	local func = xLogs.AdminSystems[xLogs.AdminSystem].CheckPermission
	return func(ply, node)
end

-- Get a user's group
function xLogs.GetUserGroup(ply)
	if (xLogs.AdminSystem == "CAMI") then return player.GetBySteamID(ply) and player.GetBySteamID(ply):GetUserGroup() or "UNKNOWN" end

	local func = xLogs.AdminSystems[xLogs.AdminSystem].GetGroup
	return func(ply)
end

-- Register a permission node for xLogs
function xLogs.RegisterPermission(name, node)
	if (xLogs.AdminSystem == "CAMI") then if CAMI then CAMI.RegisterPrivilege({Name = node, MinAccess = "admin", Description = name}) end return end

	local func = xLogs.AdminSystems[xLogs.AdminSystem].RegisterPermission
	func(name, node)
end

-- Display, save and send logs
function xLogs.RunLog(typ, str, ...)
	local varargs = ...
	local success, result = pcall(function()
		if not (typ and isstring(typ) and xLogs.LoggingTypes[typ]) then return end
		local tim = os.time()
		local content = string.format(str, unpack({varargs}))
	
		local cat = xLogs.LoggingTypes[typ].Cat
		if not xLogs.LoggingCats[cat].Enabled then return end
	
		xLogs.Logs[cat] = xLogs.Logs[cat] or {}
	
		table.insert(xLogs.Logs[cat], {Type = typ, Content = content, Time = tim})
		
		-- We don't want to do anything else if, for some reason, this is running clientside
		if not SERVER then return end
	
		xLogs.DB:insertQuery(string.format("%s%s", xLogs.Config.LogsTableNamePrefix, string.lower(cat)), {"Type", "Content", "Time"}, {typ, content, tim})
	
		//MsgN(string.format("[%s : %s] <%s> %s", cat, typ, os.date("%H:%M:%S - %d/%m/%Y", tim), content))
	
		xLogs.NetworkLog(typ, content, tim)
	
		if xLogs.Config.DoDiscordRelay then
			xLogs.RunDiscordRelay({Type = typ, Content = content, Time = tim})
		end
	end)
	
	if not success then
		print("[XLogs] Caught error:", result)
		print(debug.traceback("Stack trace:"))
	end
end

-- Register a new category for storing logs
	-- Name: The name to display for the logging category in menu sidebar
	-- Col: Colour to use for log category
	-- GeneratePermission: Whether or not the log category needs permission to view
	-- CheckFunc: Function to check whether or not the category should run
function xLogs.RegisterLoggingCategory(name, col, generatePermission, checkFunc)
	-- Don't load the logging category if the conditions are not met for it to load
	if (checkFunc and isfunction(checkFunc) and (not checkFunc())) then return end

	xLogs.LoggingCats[name] = xLogs.LoggingCats[name] or {}
	
	xLogs.Logs[name] = {}

	-- This makes reading settings from the database slightly better and prevents needing to assign the Enabled flag to another table
	xLogs.LoggingCats[name].Name = name
	xLogs.LoggingCats[name].Col = col
	xLogs.LoggingCats[name].NeedsPermissions = generatePermission

	if generatePermission then
		hook.Add("PostGamemodeLoaded", string.format("xLogs%sLoadPermissions", name), function()
			xLogs.RegisterPermission(string.format("xLogs: %s", name), string.format("xlogs_%s", string.lower(name)))
		end)
	end

	-- Create database table and read information if logs exists
	if SERVER then
		hook.Add("xLogsDatabaseConnected", string.format("xLogsDatabaseInit%s", name), function()
			local tbName = string.format("%s%s", xLogs.Config.LogsTableNamePrefix, string.lower(name))

			local valueCols = {
				{ColName = "ID", DatType = "INTEGER", Extra = string.format("PRIMARY KEY %s NOT NULL", xLogs.DB.UsingMySQL and "AUTO_INCREMENT" or "AUTOINCREMENT")},
				{ColName = "Type", DatType = "TEXT"},
				{ColName = "Content", DatType = "TEXT"},
				{ColName = "Time", DatType = "INTEGER"},
			}

			xLogs.DB:createTableQuery(tbName, valueCols, function(dat1)
				xLogs.DB:selectQuery(tbName, function(dat)
					if dat and (table.Count(dat) > 0) then
						for k, v in ipairs(dat) do
							table.insert(xLogs.Logs[name], {Type = v.Type, Content = v.Content, Time = v.Time})
							xLogs.NetworkLog(v.Type, v.Content, v.Time)
						end
					end
				end, string.format("ORDER BY Time DESC LIMIT %s", xLogs.Config.DBLoadLimit))
			end)
		end)
	end
end

-- Register a new log type
	-- Name: The name to display for the log
	-- Cat: Category to store the log under
	-- Col: Colour to use for log
	-- GeneratePermission: Whether or not the log type needs permission to view
	-- Hooks: Table of hooks to use for the log type
function xLogs.RegisterLoggingType(name, cat, col, generatePermission, hooks)
	-- Make sure we don't load the type if the category is not active
	if not xLogs.LoggingCats[cat] then return end

	xLogs.LoggingTypes[name] = {Name = name, Cat = cat, Col = col, NeedsPermissions = generatePermission, Hooks = hooks}

	if generatePermission then
		hook.Add("PostGamemodeLoaded", string.format("xLogs%sLoadTypePermissions", name), function()
			xLogs.RegisterPermission(string.format("xLogs: %s", name), string.format("xlogs_%s", string.lower(name)))
		end)
	end
	
	if not SERVER then return end

	for k, v in ipairs(hooks) do
		hook.Add(v[1], string.format("%s_%s%s", v[1], name, cat), v[2])
	end
end

-- Register a new setting
	-- Name: Name to display in menu
	-- ID: Unique identifier
	-- Serverside: Whether or not the setting is serverside
	-- Default: Default value
	-- Permission: Required permission node (for serverside settings)
	-- Function: Function to run when the setting is changed
		-- This is not needed for clientside settings
function xLogs.RegisterSetting(name, id, serverside, default, permission, func)
	xLogs.Settings[id] = {ID = id, Name = name, ServerSide = serverside, Permission = permission, Value = default, Func = func}

	if not serverside then
		CreateClientConVar(id, "0")

		xLogs.Settings[id].Func = function(val)
			GetConVar(id):SetBool(val)
			xLogs.Settings[id].Value = val
		end
	end
end

-- Format a player entity or SteamID into name and SteamID (ie. TheXnator (STEAM_0:0:52189662))
function xLogs.DoPlayerFormatting(ply)
	if not ply then return "N/A (N/A)" end

	local sid = (not isstring(ply) and IsValid(ply)) and ply:SteamID64() or ""
	local nick = (not isstring(ply) and IsValid(ply)) and ply:Nick() or ""
	if sid == "" then sid = (isstring(ply) and util.SteamIDFrom64(ply)) and ply or util.SteamIDTo64(ply) end

	if nick == "" then
		return string.format("%s (%s)", util.SteamIDFrom64(sid), util.SteamIDFrom64(sid))
	else
		return string.format("%s (%s)", nick, util.SteamIDFrom64(sid))
	end
end

-- Format an entity into name and entity ID (ie. prop_physics (34))
function xLogs.DoEntityFormatting(ent)
	if (not (ent and IsValid(ent))) then return "N/A (N/A)" end

	local class = ent:GetClass()
	local id = ent:EntIndex()

	return string.format("%s (%s)", class, id)
end

hook.Add("InitPostEntity", "xLogsRegisterSettings", function()
	xLogs.RegisterSetting(xLogs.GetLanguageString("onscreenrelay"), "onscreenrelay", false, false)

	xLogs.RegisterPermission("Enable xLogs Categories", "xlogs_enablecategories")
	for k, v in pairs(xLogs.LoggingCats) do
		xLogs.RegisterSetting(string.format(xLogs.GetLanguageString("enablecat"), v.Name), "enable" .. v.Name, true, true, "xlogs_enablecategories", function(val)
			v.Enabled = val

			if SERVER then
				local tbName = string.format("%s%s", xLogs.Config.LogsTableNamePrefix, "settings")
				local qs = string.format("UPDATE %s SET Enabled=%s WHERE Category=%s;", tbName, xLogs.DB:escape(v.Enabled and 1 or 0), xLogs.DB:escape(v.Name))
				xLogs.DB:query(qs)
			end
		end)
	end
end)