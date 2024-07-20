xLogs.ULX = xLogs.ULX or {}

function xLogs.ULX.LogCommandUse(ply, cmd, args)
	local argsStr = ""
	for k, v in ipairs(args) do
		if (k == 1) then argsStr = v else argsStr = string.format("%s, %s", argsStr, v) end
	end

	xLogs.RunLog("ULX", string.format(xLogs.GetLanguageString("rancommand"), xLogs.DoPlayerFormatting(ply), cmd, argsStr))
end

function xLogs.ULX.LogUserGroupChange(ply, allows, denies, new, old)
	xLogs.RunLog("ULX", string.format(xLogs.GetLanguageString("groupchanged"), xLogs.DoPlayerFormatting(ply), old, new))
end

hook.Add("PostGamemodeLoaded", "xLogsxAdminRegisterCat", function()
	xLogs.RegisterLoggingCategory("ULX", Color(219, 15, 255, 255), true, function()
		return ULX or false
	end)

	xLogs.RegisterLoggingType("ULX", "ULX", Color(240, 30, 17, 255), false, {
		{"ULibCommandCalled", xLogs.ULX.LogCommandUse},
		{"ULibUserGroupChange", xLogs.ULX.LogUserGroupChange},
	})
end)