local OBJ = RDV.SAL.AddSkill("Health Increase")

OBJ:SetMaxTiers(3)

OBJ:SetCategory("Stats")

OBJ:SetColor(Color(0, 255, 0))

OBJ:SetDescription("25 health per skillpoint.")

--OBJ:SetLevelRequirement(5) -- Level Requirement, Tier restricted or nil for all tiers.

OBJ:AddHook("PlayerLoadout", function(ply)
    -- Make sure the player can benefit from this system
    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(ply:Team())
    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    -- Apply the skill.
    local TIER = OBJ:GetSkillTier(ply)
    if TIER > 0 then
        timer.Simple(1, function()
            local HEALTH = ply:Health() + (TIER * 25)

            ply:SetHealth(HEALTH)
            ply:SetMaxHealth(HEALTH)
        end)
    end
end)