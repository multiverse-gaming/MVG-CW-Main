net.Receive("xLibUpdateConfigSettingCl", function()
	local addonname = net.ReadString()
	local configid = net.ReadString()
	local val = net.ReadString()

	local optionDat = xLib.ConfigOptions[addonname][configid]

	if not optionDat then return end

	xLib.ConfigTables[addonname][configid] = optionDat.ParseFunc(val)
end)

function xLib.SendUpdatedConfigSetting(addonname, configid, val)
	net.Start("xLibUpdateConfigSetting")
		net.WriteString(addonname)
		net.WriteString(configid)
		net.WriteString(tostring(val))
	net.SendToServer()
end

net.Receive("xLibNotifyPlayer", function()
	local col = net.ReadColor()
	local addonname = net.ReadString()
	local msg = net.ReadString()

	chat.AddText(col, "[", addonname, "] ", Color(200, 200, 200), msg)
end)

function xLib.SendNotification(addonname, prefixcol, msg)
	chat.AddText(prefixcol, "[", addonname, "] ", Color(200, 200, 200), msg)
end