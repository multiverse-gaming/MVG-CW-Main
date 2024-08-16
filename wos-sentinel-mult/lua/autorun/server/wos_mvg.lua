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

//local TeamsAllowed_wiltOS = {}

TeamsAllowed_wiltOS = {}


-- CONFIG --
local NPCKillXP = 40
local PlayerKillXP = 200

------------



hook.Add("loadCustomDarkRPItems", "WOS.Custom.OnStart", function()
    TeamsAllowed_wiltOS = {}
    local index = 1 
    for id,value in pairs (team.GetAllTeams()) do
        local currentName = value.Name
        if string.match(currentName, "Jedi") then
            TeamsAllowed_wiltOS[index] = id
            index = index + 1
        elseif string.match(currentName, "General") then
            TeamsAllowed_wiltOS[index] = id
            index = index + 1
        end
    end
end)


timer.Create("WOS.AllowXP", 15, 0, function()

    if TeamsAllowed_wiltOS == {} then return end
    
    for i, ply in pairs (player.GetAll()) do
        ply.AllowXP = false
        for key, currentTeamAllowed in pairs (TeamsAllowed_wiltOS) do

            if ply:Team() == currentTeamAllowed then
                ply.AllowXP = true
                break
            end
        end
    end
end)


hook.Add("PlayerDeath", "WOS.Custom.XP.PlayerKilled", function(ply, inflictor, attacker) 
    if not IsValid(attacker) or not attacker:IsPlayer() or ply == attacker or attacker.AllowXP == false or attacker.AllowXP == nil then return end
    attacker:AddSkillXP(PlayerKillXP)
end)

hook.Add("OnNPCKilled", "WOS.Custom.XP.NPCKilled", function(npc, attacker, inflictor)
    if not IsValid(attacker) or not attacker:IsPlayer() or ply == attacker or attacker.AllowXP == false or attacker.AllowXP == nil then return end
    attacker:AddSkillXP(NPCKillXP)
end)