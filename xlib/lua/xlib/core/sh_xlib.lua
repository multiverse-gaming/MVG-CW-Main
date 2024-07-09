function xLib.GetLanguageString(s)
	if not xLib.Config.Languages[xLib.Config.LANG] then return "LANGUAGE ERROR" end
	if not xLib.Config.Languages[xLib.Config.LANG][s] then end
	return (xLib.Config.Languages[xLib.Config.LANG][s]) or "LANGUAGE ERROR"
end

xLib.LOG_INFO = "[INFO]"
xLib.LOG_ERROR = "[ERROR]"

function xLib.log(addontb, msg, typ)
	if not msg then return end
	if not typ then typ = xLib.LOG_INFO end
  
	MsgC(addontb.Config.PrefixCol or xLib.Config.PrefixCol, string.format("[%s]", addontb.Config.Name or xLib.Config.Name), " ", Color(200, 200, 200), typ, " ", msg, "\n")
end

function xLib.logerr(addontb, msg)
	xLib.log(addontb, msg, xLib.LOG_ERROR)
end

function xLib.logAddonLoaded(addontb)
	local msg = string.format("Loaded %s v%s.%s.%s by %s", addontb.Config.Name or "N/A", addontb.Config.MajorVersion or 1, addontb.Config.MinorVersion or 0, addontb.Config.Patch or 0, addontb.Config.Author or xLib.Config.Author)
	xLib.log(addontb, msg)
end

xLib.CachedAddonVersions = xLib.CachedAddonVersions or {}
function xLib.FetchAddonVersions(addontb, callback)
	local addonid = addontb.Config.AddonID

	if (xLib.CachedAddonVersions[addonid] and (CurTime() < xLib.CachedAddonVersions[addonid].NextCache)) then
		callback(xLib.CachedAddonVersions[addonid].Data.data)
		return
	end

	local url = "https://thexnator.dev/gms/checkaddonversion.php?addon_id=%s&access_key=4Y5Zap2XmFk4MYprs6V"
	http.Fetch(string.format(url, addonid), function(body, l, head, code)
		local dat = util.JSONToTable(body)

		xLib.CachedAddonVersions[addonid] = {
			NextCache = CurTime() + (60 * 60),
			Data = dat,
		}

		callback(xLib.CachedAddonVersions[addonid].Data.data)
	end)
end

function xLib.IsLatestVersion(addontb, dat)
	local latestdat = dat[1]
	if not latestdat then return true end
	local installedversion = string.format("%i.%i.%i", addontb.Config.MajorVersion, addontb.Config.MinorVersion, addontb.Config.Patch)
	
	return (installedversion >= latestdat.name)
end

xLib.ConfigTypes = xLib.ConfigTypes or {}
xLib.ConfigOptions = xLib.ConfigOptions or {}
xLib.ConfigTables = xLib.ConfigTables or {}

function xLib.RegisterConfigOption(addontb, name, configID, parseFunc, parseToSQLFunc, inputType)
	if not (name and isstring(name)) then xLib.logerr("Attempting to create invalid config option. Aborting.") return end
	if not (configID and isstring(configID) and (addontb.Config[configID] ~= nil)) then xLib.logerr(string.format("Attempting to create config option '%s' with invalid configID. Aborting.", name)) return end
	if not (parseFunc and isfunction(parseFunc)) then parseFunc = function(val) return val end end
	if not (parseToSQLFunc and isfunction(parseToSQLFunc)) then parseToSQLFunc = function(val) return val end end
	if not (inputType and isstring(inputType)) then inputType = "String" end
	
	xLib.ConfigOptions[addontb.Config.Name] = xLib.ConfigOptions[addontb.Config.Name] or {}
	xLib.ConfigOptions[addontb.Config.Name][name] = {
		Name = name,
		ConfigID = configID,
		ParseFunc = parseFunc,
		ParseToSQLFunc = parseToSQLFunc,
		InputType = inputType,
	}

	xLib.ConfigTables[addontb.Config.Name] = xLib.ConfigTables[addontb.Config.Name] or addontb.Config
end

function xLib.RegisterConfigType(id, checkFunc, parseFromString, parseToString, inputFunc, extraFuncs, onSave)
	xLib.ConfigTypes[id] = {CheckFunc = checkFunc, ParseFromStringFunc = parseFromString, ParseToStringFunc = parseToString, InputType = id, InputFunc = inputFunc, ExtraFuncs = extraFuncs, OnSave = onSave}
end

xLib.RegisterConfigType("String", isstring, function(val) return val end, function(val) return val end, function(parent, x, y, w, h, addonname, configid, val)
	return xLib.Utils.DoStrInput(parent, val, x, y, w, h)
end, function(pnl, addonname, configid)
	function pnl:OnEnter()
		xLib.SendUpdatedConfigSetting(addonname, configid, self:GetValue())
	end

	function pnl:OnFocusChanged(gained)
		if not gained then
			xLib.SendUpdatedConfigSetting(addonname, configid, self:GetValue())
		end
	end
end, function(pnl, addonname, configid)
	xLib.SendUpdatedConfigSetting(addonname, configid, pnl:GetValue())
end)

xLib.RegisterConfigType("Int", isnumber, function(val) return tonumber(val) or 0 end, function(val) return val end, function(parent, x, y, w, h, addonname, configid, val)
	return xLib.Utils.DoIntInput(parent, val, x, y, w, h)
end, function(pnl, addonname, configid)
	function pnl:OnEnter()
		xLib.SendUpdatedConfigSetting(addonname, configid, self:GetValue())
	end

	function pnl:OnFocusChanged(gained)
		if not gained then
			xLib.SendUpdatedConfigSetting(addonname, configid, self:GetValue())
		end
	end
end, function(pnl, addonname, configid)
	xLib.SendUpdatedConfigSetting(addonname, configid, pnl:GetValue())
end)

xLib.RegisterConfigType("Boolean", isbool, function(val) return (val == "true") end, function(val) return tostring(val) end, function(parent, x, y, w, h, addonname, configid, val)
	return xLib.Utils.DoOptionInput(parent, x, y, w, h, {{Val = "True", Dat = "true"}, {Val = "False", Dat = "false"}}, (val == true) and "True" or "False")
end, function(pnl, addonname, configid)
	function pnl:OnSelect(index, val, dat)
		xLib.SendUpdatedConfigSetting(addonname, configid, dat)
	end
end, function(pnl, addonname, configid)
	local val, data = pnl:GetSelected()
	xLib.SendUpdatedConfigSetting(addonname, configid, data)
end)

function xLib.GetConfigType(addontb, key)
	for k, v in pairs(xLib.ConfigTypes) do
		if v.CheckFunc(addontb.Config[key]) then return k end
	end

	return false
end

xLib.IgnoreConfig = xLib.IgnoreConfig or {}
xLib.IgnoreConfig["Name"] = true
xLib.IgnoreConfig["MajorVersion"] = true
xLib.IgnoreConfig["MinorVersion"] = true
xLib.IgnoreConfig["Patch"] = true
xLib.IgnoreConfig["Author"] = true
xLib.IgnoreConfig["AddonID"] = true

-- We don't want to load any serverside config options
xLib.IgnoreConfig["UseMySQL"] = true
xLib.IgnoreConfig["DBInfo"] = true
xLib.IgnoreConfig["EnableDebug"] = true
xLib.IgnoreConfig["TableNamePrefix"] = true
xLib.IgnoreConfig["SteamAPIKey"] = true
xLib.IgnoreConfig["DoDiscordRelay"] = true
xLib.IgnoreConfig["RelayURL"] = true
xLib.IgnoreConfig["RelayKey"] = true
xLib.IgnoreConfig["DiscordWebhook"] = true
xLib.IgnoreConfig["LogsTableNamePrefix"] = true
xLib.IgnoreConfig["DBLoadLimit"] = true
xLib.IgnoreConfig["SettingsTableName"] = true
xLib.IgnoreConfig["WarnsTableName"] = true

function xLib.RegisterAddonConfig(addontb)
	if not addontb then return end

	for k, v in pairs(addontb.Config) do
		if xLib.IgnoreConfig[k] then continue end

		local configType = xLib.GetConfigType(addontb, k)
		if (not (configType and xLib.ConfigTypes[configType])) then continue end

		xLib.RegisterConfigOption(addontb, k, k, xLib.ConfigTypes[configType].ParseFromStringFunc, xLib.ConfigTypes[configType].ParseToStringFunc, xLib.ConfigTypes[configType].InputType)
	end
end

hook.Add("OnGamemodeLoaded", "xLibRegisterAddonConfigs", function()
	xLib.RegisterAddonConfig(xLib)
	xLib.RegisterAddonConfig(xAdmin)
	xLib.RegisterAddonConfig(xStore)
	xLib.RegisterAddonConfig(xWhitelist)
	xLib.RegisterAddonConfig(xWarn)
	xLib.RegisterAddonConfig(xLogs)
end)

xLib.AdminSystems = xLib.AdminSystems or {}
xLib.AdminSystem = xLib.AdminSystem or "CAMI"

-- Register a new admin system to support xLib
function xLib.RegisterAdminSystem(name, check, permissionCheck, getGroup, permissionRegister)
	xLib.AdminSystems[name] = {
		CheckPermission = permissionCheck,
		GetGroup = getGroup,
		RegisterPermission = permissionRegister,
		CheckRun = check,
	}
end

-- FAdmin Support
xLib.RegisterAdminSystem("FAdmin", function() return FAdmin end, function(ply, node)
	return FAdmin.Access.PlayerHasPrivilege(ply, node)
end, function(ply)
	if isstring(ply) then ply = player.GetBySteamID(ply) end
	return ply and IsValid(ply) and ply:GetUserGroup() or "disconnected"
end, function(addoname, name, node)
	FAdmin.Access.AddPrivilege(node, 2)
end)

-- xAdmin Support
xLib.RegisterAdminSystem("xAdmin", function() return xAdmin end, function(ply, node)
	return ply:xAdminHasPermission(node)
end, function(ply)
	if isstring(ply) then return xAdmin.UserGroups[ply] or "disconnected" end
	return ply and IsValid(ply) and ply:GetUserGroup() or "disconnected"
end, function(addonname, name, node)
	local isnew = (xAdmin.Config.MajorVersion == 2)
	xAdmin.RegisterPermission(isnew and node or name, isnew and name or node, isnew and addonname or "admin")
end)

-- ULX Support
xLib.RegisterAdminSystem("ULX", function() return ulx end, function(ply, node)
	return ULib.ucl.query(ply, node)
end, function(ply)
	if isstring(ply) then ply = player.GetBySteamID(ply) end
	return ply and IsValid(ply) and ply:GetUserGroup() or "disconnected"
end, function(addoname, name, node)
	if SERVER then ULib.ucl.registerAccess(node, ULib.ACCESS_ADMIN, name, addoname) end
end)

-- Load xLib admin system
function xLib.SetupAdminSystem()
	local adminSystemFound = false

	for k, v in pairs(xLib.AdminSystems) do
		if v.CheckRun() then
			if adminSystemFound then xLib.logerr(xLib, "Found multiple supported admin systems - it is recommended not to run multiple admin systems!") end

			xLib.AdminSystem = k
			adminSystemFound = true
		end
	end

	if (xLib.AdminSystem == "CAMI") then xLib.logerr(xLib, "No supported admin system found - attempting to use CAMI!") else xLib.log(xLib, string.format("Using %s admin system!", xLib.AdminSystem)) end

	xLib.RegisterPermission("xLib", xLib.GetLanguageString("editconfigs"), "xlib_editconfigs")

	xLib.LoadedAdminSystem = true
	hook.Run("xLibLoadedAdminSystem")
end
hook.Add("OnGamemodeLoaded", "xLibSetupAdminSystem", xLib.SetupAdminSystem)

-- Check if a user has permissions for a permission node
function xLib.HasPermission(ply, node)
	if (xLib.AdminSystem == "CAMI") then
		return CAMI and CAMI.PlayerHasAccess(ply, node) or ply:IsSuperAdmin()
	end

	local func = xLib.AdminSystems[xLib.AdminSystem].CheckPermission
	return func(ply, node)
end

-- Get a user's group
function xLib.GetUserGroup(ply)
	if (xLib.AdminSystem == "CAMI") then return player.GetBySteamID(ply) and player.GetBySteamID(ply):GetUserGroup() or "UNKNOWN" end

	local func = xLib.AdminSystems[xLib.AdminSystem].GetGroup
	return func(ply)
end

-- Register a permission node for xLib
function xLib.RegisterPermission(addonname, name, node)
	if (xLib.AdminSystem == "CAMI") then if CAMI then CAMI.RegisterPrivilege({Name = node, MinAccess = "admin", Description = name}) end return end

	local func = xLib.AdminSystems[xLib.AdminSystem].RegisterPermission
	func(addonname, name, node)
end