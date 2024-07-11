xLogs.WOS = xLogs.WOS or {}

xLogs.RegisterLoggingCategory("WOS", Color(240, 128, 18, 255), true)

function xLogs.WOS.LogItemUse(playerUser, itemUsed, itemGot)
	xLogs.RunLog("Item Used", string.format(xLogs.GetLanguageString("woslog"), xLogs.DoPlayerFormatting(playerUser),itemUsed, itemGot))
end

xLogs.RegisterLoggingType("Item Used", "WOS", Color(125, 100, 15, 255), false, {
	{"WILTOS.ItemUsed", xLogs.WOS.LogItemUse},
})
