xLogs.FAdmin = xLogs.FAdmin or {}

function xLogs.FAdmin.LogCommandUse(ply, cmd, args, res)
	local argsStr = ""
	for k, v in ipairs(args) do
		if (k == 1) then argsStr = v else argsStr = string.format("%s, %s", argsStr, v) end
	end

	xLogs.RunLog("FAdmin", string.format(xLogs.GetLanguageString("rancommand"), xLogs.DoPlayerFormatting(ply), cmd, argsStr))
end

function xLogs.FAdmin.LogUserGroupChange(ply, old, new, src)
	if src == "FAdmin" then
		xLogs.RunLog("FAdmin", string.format(xLogs.GetLanguageString("groupchanged"), xLogs.DoPlayerFormatting(ply), old, new))
	end
end

function xLogs.FAdmin.LogSIDUserGroupChange(ply, old, new, src)
	if src == "FAdmin" then
		xLogs.RunLog("FAdmin", string.format(xLogs.GetLanguageString("groupchanged"), xLogs.DoPlayerFormatting(ply), old, new))
	end
end

hook.Add("PostGamemodeLoaded", "xLogsxAdminRegisterCat", function()
	xLogs.RegisterLoggingCategory("FAdmin", Color(219, 15, 255, 255), true, function()
		return FAdmin or false
	end)

	xLogs.RegisterLoggingType("FAdmin", "FAdmin", Color(240, 30, 17, 255), false, {
		{"FAdmin_OnCommandExecuted", xLogs.FAdmin.LogCommandUse},
		{"CAMI.PlayerUsergroupChanged", xLogs.FAdmin.LogUserGroupChange},
		{"CAMI.SteamIDUsergroupChanged", xLogs.FAdmin.LogSIDUserGroupChange},
	})
end)