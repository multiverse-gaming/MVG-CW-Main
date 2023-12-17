





hook.Add("EntityTakeDamage", "wos_mvg_block_half_damage_reflect", function(target, dmginfo)

    if target:IsPlayer() and target:GetNWFloat("ReflectTimeHalf", 0) >= CurTime() then
        local damage = dmginfo:GetDamage()
        dmginfo:SetDamage(damage / 2)

        local AttackerDamageInfo = DamageInfo()
            local Attacker = dmginfo:GetAttacker()
            AttackerDamageInfo:SetAttacker(Attacker)
            AttackerDamageInfo:SetDamage(damage)
            AttackerDamageInfo:SetDamageType( DMG_GENERIC ) 
            Attacker:TakeDamageInfo(AttackerDamageInfo)





    end

end)

local TeamsAllowed_wiltOS = {}


-- CONFIG --
local NPCKillXP = 20
local PlayerKillXP = 100

------------


 
hook.Add("loadCustomDarkRPItems", "WOS.Custom.OnStart", function()
    TeamsAllowed_wiltOS = {}
    local index = 1 
    for id,value in pairs (team.GetAllTeams()) do
        local currentName = value.Name
        if string.StartWith(currentName, "Jedi") then
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