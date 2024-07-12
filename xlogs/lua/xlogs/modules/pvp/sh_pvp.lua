xLogs.PvP = xLogs.PvP or {}

xLogs.RegisterLoggingCategory("PvP", Color(240, 128, 18, 255), true)

function xLogs.Base.LogDamage(ply, dmgInfo)
	if ply:IsPlayer() then
		local attacker = dmgInfo:GetAttacker()
		local inflictor = dmgInfo:GetInflictor()

		xLogs.RunLog("Damage", xLogs.GetLanguageString("damaged"), xLogs.DoPlayerFormatting(ply), attacker:IsPlayer() and xLogs.DoPlayerFormatting(attacker) or "world", math.Round(dmgInfo:GetDamage()), (attacker:IsPlayer() and attacker:GetActiveWeapon()) and xLogs.DoEntityFormatting(attacker:GetActiveWeapon()) or "N/A")
	end
end

function xLogs.Base.LogKill(victim, attacker, dmgInfo)
	if victim:IsPlayer() then
		xLogs.RunLog("Kill", xLogs.GetLanguageString("killed"), xLogs.DoPlayerFormatting(victim), attacker:IsPlayer() and xLogs.DoPlayerFormatting(attacker) or "world", (attacker:IsPlayer() and attacker:GetActiveWeapon()) and xLogs.DoEntityFormatting(attacker:GetActiveWeapon()) or "N/A")
	end
end

xLogs.RegisterLoggingType("Damage", "PvP", Color(125, 100, 15, 255), false, {
	{"EntityTakeDamage", xLogs.Base.LogDamage},
})

xLogs.RegisterLoggingType("Kill", "PvP", Color(255, 20, 20, 255), false, {
	{"DoPlayerDeath", xLogs.Base.LogKill},
})