xLogs.ExecutionerHitman = xLogs.ExecutionerHitman or {}

function xLogs.ExecutionerHitman.HitAccepted(data)
	local hitman = data.hitman
	local target = data.target
	local amount = data.price

	xLogs.RunLog("Executioner", string.format(xLogs.GetLanguageString("hitaccepted"), xLogs.DoPlayerFormatting(hitman), xLogs.DoPlayerFormatting(target), DarkRP.formatMoney(amount)))
end

function xLogs.ExecutionerHitman.HitDeclined(data)
	local hitman = data.hitman
	local target = data.target
	local amount = data.price

	xLogs.RunLog("Executioner", string.format(xLogs.GetLanguageString("hitdeclined"), xLogs.DoPlayerFormatting(hitman), xLogs.DoPlayerFormatting(target), DarkRP.formatMoney(amount)))
end

function xLogs.ExecutionerHitman.HitCompleted(data)
	local hitman = data.hitman
	local target = data.target
	local amount = data.price

	xLogs.RunLog("Executioner", string.format(xLogs.GetLanguageString("hitcompleted"), xLogs.DoPlayerFormatting(hitman), xLogs.DoPlayerFormatting(target), DarkRP.formatMoney(amount)))
end

function xLogs.ExecutionerHitman.HitFailed(data, target, attacker)
	local hitman = data.hitman

	xLogs.RunLog("Executioner", string.format(xLogs.GetLanguageString("hitfailed"), xLogs.DoPlayerFormatting(target), xLogs.DoPlayerFormatting(attacker), DarkRP.DoPlayerFormatting(hitman)))
end

function xLogs.ExecutionerHitman.HitDisconnected(data)
	local hitman = data.hitman

	if hitman and IsValid(hitman) then
		xLogs.RunLog("Executioner", string.format(xLogs.GetLanguageString("hitdisconnected"), xLogs.DoPlayerFormatting(hitman)))
	end
end

function xLogs.ExecutionerHitman.HitArrested(data, target, time, arrestor)
	local hitman = data.hitman

	xLogs.RunLog("Executioner", string.format(xLogs.GetLanguageString("hitarrested"), xLogs.DoPlayerFormatting(arrestor), xLogs.DoPlayerFormatting(target), DarkRP.DoPlayerFormatting(hitman)))
end

function xLogs.ExecutionerHitman.HitExpired(data)
	local hitman = data.hitman
	local target = data.target

	xLogs.RunLog("Executioner", string.format(xLogs.GetLanguageString("hitexpired"), xLogs.DoPlayerFormatting(hitman), xLogs.DoPlayerFormatting(target)))
end

hook.Add("PostGamemodeLoaded", "xLogsExecutionerHitmanRegisterCat", function()
	xLogs.RegisterLoggingCategory("Executioner", Color(18, 148, 240, 255), true, function()
		return Executioner or false
	end)

	xLogs.RegisterLoggingType("Executioner", "Accepted Hit", Color(45, 104, 45, 255), false, {
		{"Executioner.OnHitAccepted", xLogs.ExecutionerHitman.HitAccepted},
	})

	xLogs.RegisterLoggingType("Executioner", "Declined Hit", Color(18, 148, 240, 255), false, {
		{"Executioner.OnHitDeclined", xLogs.ExecutionerHitman.HitDeclined},
	})

	xLogs.RegisterLoggingType("Executioner", "Completed Hit", Color(45, 104, 45, 255), false, {
		{"Executioner.OnHitCompleted", xLogs.ExecutionerHitman.HitCompleted},
	})

	xLogs.RegisterLoggingType("Executioner", "Failed Hit", Color(18, 148, 240, 255), false, {
		{"Executioner.OnHitFailed", xLogs.ExecutionerHitman.HitFailed},
		{"Executioner.OnHitDisconnected", xLogs.ExecutionerHitman.HitDisconnected},
		{"Executioner.OnHitArrested", xLogs.ExecutionerHitman.HitArrested},
		{"Executioner.OnHitExpired", xLogs.ExecutionerHitman.HitExpired},
	})
end)