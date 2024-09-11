/*local OBJ = RDV.SAL.AddSkill("Experience Gain")

OBJ:SetMaxTiers(5)

OBJ:SetCategory("Stats")

OBJ:SetDescription("Increased Experience Gain.")

OBJ:SetColor(Color(184,93,93))

OBJ:AddHook("RDV_SAL_PreAddExperience", function(ply, exp)
    local TIER = OBJ:GetSkillTier(ply)

    if TIER > 0 then
        if OBJ:GetNoEffectTeams()[ply:Team()] then
            return
        end
        
        exp = exp + ( TIER * (exp * 0.125) )

        return exp
    end
end)*/