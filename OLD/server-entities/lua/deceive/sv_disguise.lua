
util.AddNetworkString("deceive.disguise")

deceive.DisguisedPlayers = {}
function deceive.Disguise(ply, target)
	if not IsValid(target) or not target:IsPlayer() then
		target = nil
	end

	ply.Disguised = target
	ply.Disguised_Team = target and target:Team(true) or nil
	deceive.DisguisedPlayers[ply] = target

	if deceive.Config and deceive.Config.FakeModel then
		if target and not ply.Deceive_OldModel then
			ply.Deceive_OldModel = ply:GetModel()
		end
		if not target and ply.Deceive_OldModel then
			ply:SetModel(ply.Deceive_OldModel)
			ply.Deceive_OldModel = nil
		elseif target then
			ply:SetModel(ply.Disguised.Deceive_OldModel and ply.Disguised.Deceive_OldModel or ply.Disguised:GetModel())
		end
	end

	net.Start("deceive.disguise")
		net.WriteUInt(ply:UserID(), 32)
		net.WriteUInt(IsValid(target) and target:UserID() or 0, 32)
	net.Broadcast()
end

local PLAYER = FindMetaTable("Player")

function PLAYER:Disguise(target)
	deceive.Disguise(self, target)
end

hook.Add("OnPlayerChangedTeam", "deceive", function(ply)
	for spy, target in next, deceive.DisguisedPlayers do
		if ply == target then
			deceive.Notify(spy, "target_jobchange", NOTIFY_HINT)
		end
	end

	if IsValid(ply.Disguised) then
		ply:Disguise(nil)
		hook.Run("DisguiseRemoved", ply)

		deceive.Notify(ply, "disguise_removed_jobchange", NOTIFY_HINT)
		-- ply:ChatPrint("Your disguise was removed because you changed jobs.")
	end
end)

local function removeDisguise(ply)
	if IsValid(ply.Disguised) then
		ply:Disguise(nil)
		hook.Run("DisguiseRemoved", ply)
	end
end
hook.Add("PlayerDeath", "deceive", removeDisguise)
hook.Add("playerArrested", "deceive", removeDisguise)

hook.Add("PlayerSay", "deceive", function(ply, txt)
	local cmd = (deceive.Config and deceive.Config.UndisguiseCommand) and deceive.Config.UndisguiseCommand:lower() or "undisguised"
	if txt:lower():Trim():match("^[/!%.]" .. cmd) then
		if not IsValid(ply.Disguised) then
			deceive.Notify(ply, "disguise_none", NOTIFY_ERROR)
			-- ply:ChatPrint("You have no disguise!")
			return ""
		end

		ply:Disguise(nil)
		hook.Run("DisguiseRemoved", ply)

		ply:EmitSound("npc/metropolice/gear" .. math.random(1, 6) .. ".wav")
		deceive.Notify(ply, "disguise_removed", NOTIFY_HINT)
		-- ply:ChatPrint("You removed your disguise.")
		return ""
	end
end)

hook.Add("PlayerDisconnected", "deceive", function(ply)
	for criminal, victim in next, deceive.DisguisedPlayers do
		if victim == ply then
			deceive.Notify(criminal, "disguise_warn_disconnect", NOTIFY_ERROR, 10)
			-- criminal:ChatPrint("WARNING: The player you were disguised as just disconnected from the server! It would be wise to undisguise before someone notices you should be gone.")
		end
	end
end)

hook.Add("PlayerInitialSpawn", "deceive", function(ply)
	-- if this is inefficient I'll find another way, I'm lazy right now
	for k, v in next, deceive.DisguisedPlayers do
		if IsValid(k) and IsValid(v) then
			net.Start("deceive.disguise")
				net.WriteUInt(k:UserID(), 32)
				net.WriteUInt(IsValid(v) and v:UserID() or 0, 32)
			net.Send(ply)
		end
	end
end)

hook.Add("EntityFireBullets", "deceive", function(ent)
	if deceive.Config and deceive.Config.RemoveOnAttack and IsValid(ent) and ent:IsPlayer() and ent.Disguised then
		local ok = hook.Run("DisguiseBlowing", ent)
		if ok == false then return end

		ent:Disguise(nil)
		hook.Run("DisguiseRemoved", ent)

		deceive.Notify(ent, "disguise_blown")
		-- ent:ChatPrint("Your disguise was blown because you fired a bullet!")
	end
end)

-- God I hate this
if deceive.Config and deceive.Config.FakeJob then
	deceive.team_GetColor = deceive.team_GetColor or team.GetColor
	deceive.team_GetName = deceive.team_GetName or team.GetName
	function team.GetColor(id, disguisedId)
		return deceive.team_GetColor(disguisedId or id)
	end
	function team.GetName(id, disguisedId)
		return deceive.team_GetName(disguisedId or id)
	end

	--[[
	deceive.GAMEMODE = deceive.GAMEMODE or {}
	deceive.GAMEMODE.PlayerSay = deceive.GAMEMODE.PlayerSay or GAMEMODE.PlayerSay
	deceive.hook_Call = deceive.hook_Call or hook.Call

	function GAMEMODE:PlayerSay(ply, ...)
		ply.Deceive_ShowFakeTeam = true
		local ret = deceive.GAMEMODE.PlayerSay(self, ply, ...)
		if ply.Deceive_ShowFakeTeam then ply.Deceive_ShowFakeTeam = false end
		return ret
	end
	local postCall = {
		PlayerSay = function(ply)
			ply.Deceive_ShowFakeTeam = false
		end
	}
	hook.Call = function(event, tbl, ...)
	    local returns = { deceive.hook_Call(event, tbl, ...) }
	    if postCall[event] then postCall[event](...) end
	    return unpack(returns)
	end
	]]
end
