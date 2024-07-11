xLogs.SAM = xLogs.SAM or {}

function xLogs.SAM.LogCommandUse(ply, cmd_name, args, cmd)
	local argsStr = ""
	for k, v in ipairs(args) do
		if (k == 1) then argsStr = v else argsStr = string.format("%s, %s", argsStr, v) end
	end

	if !IsValid(ply) then 
		xLogs.RunLog("SAM", string.format(xLogs.GetLanguageString("rancommand"), "Console", cmd_name, argsStr))
		return
	end

	xLogs.RunLog("SAM", string.format(xLogs.GetLanguageString("rancommand"), xLogs.DoPlayerFormatting(ply), cmd_name, argsStr))
end

function xLogs.SAM.LogUserGroupChange(ply, rank, old_rank, expiry_date)
	xLogs.RunLog("SAM", string.format(xLogs.GetLanguageString("groupchanged"), xLogs.DoPlayerFormatting(ply), old_rank, rank))
end

function xLogs.SAM.LogUserGroupChangeID(steamid, rank, old_rank, expiry_date, exists)
	if (exists) then
		xLogs.RunLog("SAM", string.format(xLogs.GetLanguageString("groupchanged"), xLogs.DoPlayerFormatting(steamid), old_rank, rank))
	end
end

hook.Add("PostGamemodeLoaded", "xLogsSAMRegisterCat", function()
	xLogs.RegisterLoggingCategory("SAM", Color(219, 15, 255, 255), true, function()
		return sam or false
	end)

	xLogs.RegisterLoggingType("SAM", "SAM", Color(240, 30, 17, 255), false, {
		{"SAM.RanCommand", xLogs.SAM.LogCommandUse},
		{"SAM.ChangedPlayerRank", xLogs.SAM.LogUserGroupChange},
		{"SAM.ChangedSteamIDRank", xLogs.SAM.LogUserGroupChangeID},
	})
end)