xLogs.RealisticKidnap = xLogs.RealisticKidnap or {}

function xLogs.RealisticKidnap.Knockout(victim, attacker)
	xLogs.RunLog("Realistic Kidnap", string.format(xLogs.GetLanguageString("knockedout"), xLogs.DoPlayerFormatting(attacker), xLogs.DoPlayerFormatting(victim)))
end

function xLogs.RealisticKidnap.Restrain(victim, attacker)
	xLogs.RunLog("Realistic Kidnap", string.format(vic.RKRestrained and xLogs.GetLanguageString("unrestrained") or xLogs.GetLanguageString("restrained"), xLogs.DoPlayerFormatting(attacker), xLogs.DoPlayerFormatting(victim)))
end

function xLogs.RealisticKidnap.Blindfold(victim, attacker)
	xLogs.RunLog("Realistic Kidnap", string.format(vic.Blindfolded and xLogs.GetLanguageString("unblindfolded") or xLogs.GetLanguageString("blindfolded"), xLogs.DoPlayerFormatting(attacker), xLogs.DoPlayerFormatting(victim)))
end

function xLogs.RealisticKidnap.Gag(victim, attacker)
	xLogs.RunLog("Realistic Kidnap", string.format(vic.Gagged and xLogs.GetLanguageString("ungagged") or xLogs.GetLanguageString("gagged"), xLogs.DoPlayerFormatting(attacker), xLogs.DoPlayerFormatting(victim)))
end

hook.Add("PostGamemodeLoaded", "xLogsExecutionerHitmanRegisterCat", function()
	xLogs.RegisterLoggingCategory("Realistic Kidnap", Color(78, 13, 13, 255), true, function()
		return RKidnapConfig or false
	end)

	xLogs.RegisterLoggingType("Realistic Kidnap", "Knockout", Color(233, 150, 32, 255), false, {
		{"RKS_Knckout", xLogs.RealisticKidnap.Knockout},
	})

	xLogs.RegisterLoggingType("Realistic Kidnap", "Restrained", Color(184, 40, 60, 255), false, {
		{"RKS_Restrain", xLogs.RealisticKidnap.Restrain},
	})

	xLogs.RegisterLoggingType("Realistic Kidnap", "Blindfolded", Color(36, 42, 82, 255), false, {
		{"RKS_Blindfold", xLogs.RealisticKidnap.Blindfold},
	})

	xLogs.RegisterLoggingType("Realistic Kidnap", "Gagged", Color(89, 161, 148, 255), false, {
		{"RKS_Gag", xLogs.RealisticKidnap.Gag},
	})
end)