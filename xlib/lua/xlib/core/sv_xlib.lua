function xLib.CheckAddonVersion(addontb)
	if not addontb.CheckedAddonVersion then
		local url = "https://thexnator.dev/gms/checkaddonversion.php?addon_id=%s&access_key=4Y5Zap2XmFk4MYprs6V"
		http.Fetch(string.format(url, addontb.Config.AddonID), function(body, l, head, code)
			if (not (body and util.JSONToTable(body))) then return end

			local dat = util.JSONToTable(body).data
			if not dat then xLib.logerr(addontb, string.format("Failed to check %s version. Error: Invalid addon ID or no data found!", addontb.Config.Name)) return end

			-- Get the latest version
			local latestdat = dat[1]
			-- Get the current installed version
			local installedversion = string.format("%i.%i.%i", addontb.Config.MajorVersion, addontb.Config.MinorVersion, addontb.Config.Patch)
			
			local vernumlatest = string.Replace(latestdat.name, ".", "")
			local vernumcur = string.Replace(installedversion, ".", "")
			if vernumcur > vernumlatest then xLib.log(addontb, string.format("Running a newer version of %s than the latest! This looks fun! Latest: %s Current: %s", addontb.Config.Name, latestdat.name, installedversion)) return end
			
			if (installedversion == latestdat.name) then
				xLib.log(addontb, string.format("%s is up to date! Version: %s", addontb.Config.Name, installedversion))
			else
				xLib.logerr(addontb, string.format("You are running an outdated version of %s! Latest: %s Current: %s", addontb.Config.Name, latestdat.name, installedversion))
			end
		end, function(err)
			xLib.logerr(addontb, string.format("Failed to check %s version. Error: %s", addontb.Config.Name, err))
		end)

		addontb.CheckedAddonVersion = true
	end
end

local configTableName = string.format("%s%s", xLib.Config.TableNamePrefix, "configdata")

function xLib.CreateTables()
	local configValueCols = {
		{ColName = "ID", DatType = "VARCHAR(255)", Extra = ""},
		{ColName = "AddonName", DatType = "VARCHAR(255)", Extra = ""},
		{ColName = "Data", DatType = "TEXT(10000)", Extra = ""},
	}

	xLib.DB:createTableQuery(configTableName, configValueCols, function(dat1)
		xLib.DB:selectQuery(configTableName, function(dat)
			if dat and (table.Count(dat) > 0) then
				for k, v in pairs(dat) do
					if (not (xLib.ConfigOptions[v.AddonName] and xLib.ConfigOptions[v.AddonName][v.ID])) then continue end

					local optionDat = xLib.ConfigOptions[v.AddonName][v.ID]
					optionDat.Initialised = true

					xLib.ConfigTables[v.AddonName][v.ID] = optionDat.ParseFunc(v.Data)

					net.Start("xLibUpdateConfigSettingCl")
						net.WriteString(v.AddonName)
						net.WriteString(v.ID)
						net.WriteString(v.Data)
					net.Broadcast()
				end
			end

			-- Add any config options to the DB which don't exist yet
			for k, v in pairs(xLib.ConfigOptions) do
				for k1, v1 in pairs(v) do
					if not v1.Initialised then
						v1.Initialised = true

						local qs = string.format("INSERT INTO %s VALUES(%s, %s, %s);", configTableName, xLib.DB:escape(k1), xLib.DB:escape(k), xLib.DB:escape(v1.ParseToSQLFunc(xLib.ConfigTables[k][k1])))
						xLib.DB:query(qs)
					end
				end
			end
		end)
	end, "PRIMARY KEY(ID, AddonName)")
end
hook.Add("xLibDatabaseConnected", "xLibCreateDatabaseTables", xLib.CreateTables)

function xLib.NetReceive(id, callback)
	net.Receive(id, function(len, ply)
		if (ply.xLibLastNM and ply.xLibLastNM[id] and (ply.xLibLastNM[id] >= math.floor(CurTime()))) then return end
		ply.xLibLastNM = ply.xLibLastNM or {}
		ply.xLibLastNM[id] = math.floor(CurTime())

		callback(len, ply)
	end)
end

util.AddNetworkString("xLibUpdateConfigSetting")
util.AddNetworkString("xLibUpdateConfigSettingCl")
util.AddNetworkString("xLibNotifyPlayer")

function xLib.NotifyPlayer(ply, addontb, msg)
	local col = addontb.Config.PrefixCol

	net.Start("xLibNotifyPlayer")
		net.WriteColor(col)
		net.WriteString(addontb.Config.Name)
		net.WriteString(msg)
	net.Send(ply)
end

function xLib.UpdateConfigSetting(ply, addonname, configid, val)
	if not isstring(val) then return end

	local optionDat = xLib.ConfigOptions[addonname][configid]

	xLib.ConfigTables[addonname][configid] = optionDat.ParseFunc(val)

	local newval = optionDat.ParseToSQLFunc(xLib.ConfigTables[addonname][configid])

	local qs = string.format("UPDATE %s SET Data=%s WHERE AddonName=%s AND ID=%s;", configTableName, xLib.DB:escape(newval), xLib.DB:escape(addonname), xLib.DB:escape(configid))
	xLib.DB:query(qs)

	net.Start("xLibUpdateConfigSettingCl")
		net.WriteString(addonname)
		net.WriteString(configid)
		net.WriteString(newval)
	net.Broadcast()
end

function xLib.UpdateAllConfigSettings(ply)
	for k, v in pairs(xLib.ConfigOptions) do
		for k1, v1 in pairs(v) do
			local optionDat = xLib.ConfigOptions[k][k1]
			local val = v1.ParseToSQLFunc(xLib.ConfigTables[k][k1])

			net.Start("xLibUpdateConfigSettingCl")
				net.WriteString(k)
				net.WriteString(k1)
				net.WriteString(val)
			net.Broadcast()
		end
	end
end

hook.Add("PlayerInitialSpawn", "xLibSendAllConfigSettings", xLib.UpdateAllConfigSettings)

xLib.NetReceive("xLibUpdateConfigSetting", function(len, ply)
	if not xLib.HasPermission(ply, "xlib_editconfigs") then return end
	xLib.UpdateConfigSetting(ply, net.ReadString(), net.ReadString(), net.ReadString())
end)

-- Menu chat command
hook.Add("PlayerSay", "xLibChatCommand", function(ply, tx, team)
	if (string.sub(string.lower(tx), 1, string.len(xLib.Config.ChatCommand)) == xLib.Config.ChatCommand) then
		ply:ConCommand("xLibToggleMenu")
		return ""
	end
end)