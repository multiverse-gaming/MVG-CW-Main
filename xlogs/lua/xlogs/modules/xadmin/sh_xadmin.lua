xLogs.xAdmin = xLogs.xAdmin or {}

function xLogs.xAdmin.LogCommandUse(ply, target, cmd, args)
	local argsStr = ""
	for k, v in ipairs(args) do
		if (k == 1) then argsStr = v else argsStr = string.format("%s, %s", argsStr, v) end
	end

	if target then
		xLogs.RunLog("Command", string.format((argsStr ~= "") and xLogs.GetLanguageString("rancommandtarget") or xLogs.GetLanguageString("rancommandtargetnoargs"), xLogs.DoPlayerFormatting(ply), cmd, xLogs.DoPlayerFormatting(target), argsStr))
	else
		xLogs.RunLog("Command", string.format((argsStr ~= "") and xLogs.GetLanguageString("rancommand") or xLogs.GetLanguageString("rancommandnoargs"), xLogs.DoPlayerFormatting(ply), cmd, argsStr))
	end
end

function xLogs.xAdmin.LogGroupUpdated(ply, group, old)
	xLogs.RunLog("Group Updated", string.format(xLogs.GetLanguageString("groupchanged"), xLogs.DoPlayerFormatting(ply), old, group))
end

function xLogs.xAdmin.LogIDGroupUpdated(ply, group, old)
	xLogs.RunLog("Group Updated", string.format(xLogs.GetLanguageString("groupchanged"), xLogs.DoPlayerFormatting(ply), old, group))
end

hook.Add("PostGamemodeLoaded", "xLogsxAdminRegisterCat", function()
	xLogs.RegisterLoggingCategory("xAdmin", Color(219, 15, 255, 255), true, function()
		return xAdmin or false
	end)

	xLogs.RegisterLoggingType("Command", "xAdmin", Color(240, 30, 17, 255), false, {
		{"xAdminCommandRun", xLogs.xAdmin.LogCommandUse},
	})
	
	xLogs.RegisterLoggingType("Group Updated", "xAdmin", Color(110, 120, 200, 255), false, {
		{"xAdminUserGroupUpdated", xLogs.xAdmin.LogGroupUpdated},
		{"xAdminSteamIDGroupUpdated", xLogs.xAdmin.LogIDGroupUpdated},
	})
end)