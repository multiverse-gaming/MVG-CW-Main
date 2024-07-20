xLogs.Base = xLogs.Base or {}

xLogs.RegisterLoggingCategory("Base", Color(18, 148, 240, 255), true)

function xLogs.Base.LogConnection(ply)
	local ip = ply:IPAddress()
	xLogs.GetLocationFromIP(ip, function(data)
		xLogs.RunLog("Connection", xLogs.GetLanguageString("connected"), xLogs.DoPlayerFormatting(ply), data.country_name or "N/A")
	end)
end

function xLogs.Base.LogDisconnect(ply)
	xLogs.RunLog("Connection", xLogs.GetLanguageString("disconnected"), xLogs.DoPlayerFormatting(ply))
end

function xLogs.Base.LogChat(ply, msg, team)
	xLogs.RunLog("Chat", "%s: %s", xLogs.DoPlayerFormatting(ply), msg)
end

function xLogs.Base.LogToolgun(ply, tr, tool)
	-- Due to the way that toolgun hooks are called, we need to make sure this doesn't spam logs
	ply.xLogsLastToolGunLog = ply.xLogsLastToolGunLog or 0
	if ((ply.xLogsLastToolGunLog == 0) or ((CurTime() - ply.xLogsLastToolGunLog) > 1)) then
		ply.xLogsLastToolGunLog = CurTime()
		xLogs.RunLog("Tools", xLogs.GetLanguageString("tooluse"), xLogs.DoPlayerFormatting(ply), tool)
	end
end

function xLogs.Base.LogPlayerSpawnedEffect(ply, model, ent)
	xLogs.RunLog("Spawned", xLogs.GetLanguageString("spawned"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), model)
end

function xLogs.Base.LogPlayerSpawnedNPC(ply, ent)
	xLogs.RunLog("Spawned", xLogs.GetLanguageString("spawned"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), "")
end

function xLogs.Base.LogPlayerSpawnedProp(ply, model, ent)
	xLogs.RunLog("Spawned", xLogs.GetLanguageString("spawned"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), model)
end

function xLogs.Base.LogPlayerSpawnedRagdoll(ply, model, ent)
	xLogs.RunLog("Spawned", xLogs.GetLanguageString("spawned"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), model)
end

function xLogs.Base.LogPlayerSpawnedSENT(ply, ent)
	xLogs.RunLog("Spawned", xLogs.GetLanguageString("spawned"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), "")
end

function xLogs.Base.LogPlayerSpawnedSWEP(ply, ent)
	xLogs.RunLog("Spawned", xLogs.GetLanguageString("spawned"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), "")
end

function xLogs.Base.LogPlayerSpawnedVehicle(ply, ent)
	xLogs.RunLog("Spawned", xLogs.GetLanguageString("spawned"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), "")
end

function xLogs.Base.LogWeaponEquip(ent, ply)
	xLogs.RunLog("Pickup", xLogs.GetLanguageString("pickup"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), "")
end

xLogs.RegisterLoggingType("Connection", "Base", Color(60, 60, 125, 255), true, {
	{"PlayerInitialSpawn", xLogs.Base.LogConnection},
	{"PlayerDisconnected", xLogs.Base.LogDisconnect},
})

xLogs.RegisterLoggingType("Chat", "Base", Color(240, 110, 17, 255), true, {
	{"PlayerSay", xLogs.Base.LogChat},
})

xLogs.RegisterLoggingType("Tools", "Base", Color(4, 105, 157, 255), true, {
	{"CanTool", xLogs.Base.LogToolgun},
})

xLogs.RegisterLoggingType("Spawned", "Base", Color(60, 125, 60, 255), true, {
	{"PlayerSpawnedEffect", xLogs.Base.LogPlayerSpawnedEffect},
	{"PlayerSpawnedNPC", xLogs.Base.LogPlayerSpawnedNPC},
	{"PlayerSpawnedProp", xLogs.Base.LogPlayerSpawnedProp},
	{"PlayerSpawnedRagdoll", xLogs.Base.LogPlayerSpawnedRagdoll},
	{"PlayerSpawnedSENT", xLogs.Base.LogPlayerSpawnedSENT},
	{"PlayerSpawnedSWEP", xLogs.Base.LogPlayerSpawnedSWEP},
	{"PlayerSpawnedVehicle", xLogs.Base.LogPlayerSpawnedVehicle},
})

xLogs.RegisterLoggingType("Pickup", "Base", Color(20, 125, 50), true, {
	{"WeaponEquip", xLogs.Base.LogWeaponEquip}
})