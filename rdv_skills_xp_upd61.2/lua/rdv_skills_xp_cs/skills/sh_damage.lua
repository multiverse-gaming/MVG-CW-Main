/*local OBJ = RDV.SAL.AddSkill("Damage Increase")

OBJ:SetMaxTiers(5)

OBJ:SetCategory("Weapons")

OBJ:SetDescription("Increased Damage for every skillpoint.")

OBJ:SetColor(Color(180,60,86))

OBJ:AddHook("EntityTakeDamage", function(ply, damage)
    local ATTACKER = damage:GetAttacker()

    if !ATTACKER:IsPlayer() then
        return
    end

    local TIER = OBJ:GetSkillTier(ATTACKER)

    if TIER > 0 then
        if OBJ:GetNoEffectTeams()[ATTACKER:Team()] then
            return
        end
        
        if ply.GetActiveWeapon and IsValid(ply:GetActiveWeapon()) then
            if ply:GetActiveWeapon().IsLightsaber then 
                return 
            end
        end
    
        damage:SetDamage(damage:GetDamage() + TIER * 5)
    end
end)*/