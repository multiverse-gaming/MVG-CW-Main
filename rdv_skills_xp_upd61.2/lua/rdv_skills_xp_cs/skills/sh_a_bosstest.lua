local OBJ = RDV.SAL.AddSkill("Boss Skill")

OBJ:SetMaxTiers(1)

OBJ:SetCategory("Character")

OBJ:SetDescription("Testing if I can have per-team skills.")

-- This is actually a team whitelist for this skill. You know how it is.
-- Also the cadet has to stay. Still, don't know why. Don't fucking ask me man.
OBJ:SetNoEffectTeams({
    TEAM_RCBOSS
})

OBJ:SetColor(Color(60,60,180))

OBJ:AddHook("PlayerLoadout", function(ply)
    -- Make sure the player can benefit from this system
    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(ply:Team())
    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    -- Apply the skill.
    local TIER = OBJ:GetSkillTier(ply)
    if TIER > 0 then
        if !OBJ:GetNoEffectTeams()[ply:Team()] then
            return
        end
        
        timer.Simple(1, function()
            print("Have hit the Boss Hook!!!")
        end)
    end
end, 1)