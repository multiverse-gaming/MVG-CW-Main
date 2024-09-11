/*local OBJ = RDV.SAL.AddSkill("Weapon Speed")

OBJ:SetMaxTiers(5)

OBJ:SetCategory("Weapons")

OBJ:SetDescription("Increased weapon speed for every skillpoint.")

OBJ:SetColor(Color(135,120,120))

OBJ:AddHook("TFA_AnimationRate", function(ply, act, rate)
    local OWNER = ply:GetOwner()

    if !IsValid(OWNER) or !OWNER:IsPlayer() then return end
    
    local TIER = OBJ:GetSkillTier(OWNER)

    if TIER > 0 then
        if OBJ:GetNoEffectTeams()[OWNER:Team()] then
            return
        end
        
        rate = rate + (TIER * 0.2)

        return rate
    end
end)*/