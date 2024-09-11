local OBJ = RDV.SAL.AddSkill("Health Increase")

OBJ:SetMaxTiers(4)

OBJ:SetCategory("Stats")

OBJ:SetColor(Color(80,230,80))

OBJ:SetDescription("Increased Health for every skillpoint.")

--OBJ:SetLevelRequirement(5) -- Level Requirement, Tier restricted or nil for all tiers.

OBJ:AddHook("PlayerLoadout", function(ply)
    -- Make sure the player can benefit from this system
    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(ply:Team())
    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    -- Apply the skill.
    local TIER = OBJ:GetSkillTier(ply)
    if TIER > 0 then
        if OBJ:GetNoEffectTeams()[ply:Team()] then
            return
        end
        
        timer.Simple(1, function()
            local HEALTH = ply:Health() + (TIER * 25)

            ply:SetHealth(HEALTH)
            ply:SetMaxHealth(HEALTH)
        end)
    end
end)