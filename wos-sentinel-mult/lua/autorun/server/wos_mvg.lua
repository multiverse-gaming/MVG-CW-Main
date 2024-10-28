-- Hook for wos reflecting, both half and full.
hook.Add("EntityTakeDamage", "wos_mvg_block_half_damage_reflect", function(target, dmginfo)

    if (target:IsPlayer()) then
        if target:GetNWFloat("ReflectTimeHalf", 0) >= CurTime() then
            if (!target._IsCurrentlyReflecting) then
                target._IsCurrentlyReflecting = true
                local damage = dmginfo:GetDamage()
                dmginfo:SetDamage(damage / 2)
                local AttackerDamageInfo = DamageInfo()
                local Attacker = dmginfo:GetAttacker()
                AttackerDamageInfo:SetAttacker(Attacker)
                AttackerDamageInfo:SetDamage(damage)
                AttackerDamageInfo:SetDamageType( DMG_GENERIC ) 
                Attacker:TakeDamageInfo(AttackerDamageInfo)
                target._IsCurrentlyReflecting = false
            end
        elseif target:GetNWFloat("ReflectTime", 0) >= CurTime() then
            if (!target._IsCurrentlyReflecting) then
                target._IsCurrentlyReflecting = true
                local AttackerDamageInfo = DamageInfo()
                local Attacker = dmginfo:GetAttacker()
                AttackerDamageInfo:SetAttacker(Attacker)
                AttackerDamageInfo:SetDamage(dmginfo:GetDamage())
                AttackerDamageInfo:SetDamageType( DMG_GENERIC ) 
                Attacker:TakeDamageInfo(AttackerDamageInfo)
                dmginfo:SetDamage(0)
                target._IsCurrentlyReflecting = false
            end
        end
    end
end)

local jedi = {}
timer.Simple(120, function()
	jedi = {
		[TEAM_JEDIPADAWAN] = true,
		[TEAM_WPJEDI] = true,
		[TEAM_GMJEDI] = true,
		[TEAM_327THJEDI] = true,
		[TEAM_501STJEDI] = true,
		[TEAM_212THJEDI] = true,
		[TEAM_JEDIKNIGHT] = true,
		[TEAM_JEDISENTINEL] = true,
		[TEAM_JEDIGUARDIAN] = true,
		[TEAM_JEDICONSULAR] = true,
		[TEAM_JEDICOUNCIL] = true,
		[TEAM_JEDIGENERALADI] = true,
		[TEAM_GMGENERALADI] = true,
		[TEAM_JEDIGENERALSHAAK] = true,
		[TEAM_CGGENERALSHAAK] = true,
		[TEAM_JEDIGENERALKIT] = true,
		[TEAM_RCGENERALKIT] = true,
		[TEAM_JEDIGENERALPLO] = true,
		[TEAM_WPGENERALPLO] = true,
		[TEAM_JEDIGENERALTANO] = true,
		[TEAM_501STGENERALTANO] = true,
		[TEAM_JEDIGENERALWINDU] = true,
		[TEAM_JEDIGENERALOBI] = true,
		[TEAM_212THGENERALOBI] = true,
		[TEAM_JEDIGENERALSKYWALKER] = true,
		[TEAM_501STGENERALSKYWALKER] = true,
		[TEAM_JEDIGRANDMASTER] = true,
		[TEAM_GCGRANDMASTER] = true,
		[TEAM_JEDIGENERALAAYLA] = true,
		[TEAM_327THGENERALAAYLA] = true,
		[TEAM_JEDIGENERALLUMINARA] = true,
		[TEAM_CGJEDI] = true,
		[TEAM_CGJEDICHIEF] = true,
		[TEAM_JEDIGENCINDRALLIG] = true,
		[TEAM_JEDITGCHIEF] = true,
		[TEAM_TGJEDI] = true,
		[TEAM_GCGENERALLUMINARA] = true,
		[TEAM_JEDIGENERALVOS] = true,
		[TEAM_SHADOWGENERALVOS] = true,
		[TEAM_JEDITOURNAMENT] = true,
	}
end)

-- CONFIG --
local NPCKillXP = 40
local PlayerKillXP = 200

hook.Add("PlayerDeath", "WOS.Custom.XP.PlayerKilled", function(ply, inflictor, attacker) 
    if not IsValid(attacker) or not attacker:IsPlayer() or ply == attacker then return end
    if jedi[ply:Team()] then
		ply:AddSkillXP(PlayerKillXP)
	end
end)

hook.Add("OnNPCKilled", "WOS.Custom.XP.NPCKilled", function(npc, attacker, inflictor)
    if not IsValid(attacker) or not attacker:IsPlayer() or ply == attacker then return end
	if jedi[ply:Team()] then
		ply:AddSkillXP(NPCKillXP)
	end
end)

-- Replace TimeBetweenXP, do a more generalised version
timer.Create("GrantJediSkillXPTimer", 420, 0, function()
    for _, ply in ipairs(player.GetAll()) do
        if (!IsValid(ply)) then continue end
        if jedi[ply:Team()] then
            ply:AddSkillXP(6)
        end
    end
end)