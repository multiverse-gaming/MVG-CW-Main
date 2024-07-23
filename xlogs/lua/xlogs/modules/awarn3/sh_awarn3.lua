xLogs.AWarn = xLogs.AWarn or {}

function xLogs.AWarn.LogWarn(ply, adminid, reason)
	local admin = player.GetBySteamID64(adminid)
	xLogs.RunLog("AWarn", string.format(xLogs.GetLanguageString("warned"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(admin), reason))
end

function xLogs.AWarn.LogWarnID(sid64, adminid, reason)
	local admin = player.GetBySteamID64(adminid)
	xLogs.RunLog("AWarn", string.format(xLogs.GetLanguageString("warned"), xLogs.DoPlayerFormatting(util.SteamIDFrom64(sid64)), xLogs.DoPlayerFormatting(admin), reason))
end

hook.Add("PostGamemodeLoaded", "xLogsAWarnRegisterCat", function()
	xLogs.RegisterLoggingCategory("AWarn", Color(18, 148, 240, 255), true, function()
		return AWarn or false
	end)

	xLogs.RegisterLoggingType("AWarn", "AWarn", Color(240, 30, 17, 255), false, {
		{"AWarnPlayerWarned", xLogs.AWarn.LogWarn},
		{"AWarnPlayerIDWarned", xLogs.AWarn.LogWarnID},
	})
end)