local OBJ = RDV.SAL.AddSkill("Scorch's Armor")

OBJ:SetMaxTiers(1)

OBJ:SetCategory("Character")

OBJ:SetDescription("Armor.")

-- This is actually a team whitelist for this skill. You know how it is.
-- Also the cadet has to stay. Still, don't know why. Don't fucking ask me man.
OBJ:SetNoEffectTeams({
    TEAM_RCSCORCH
})

OBJ:SetColor(Color(138, 43, 226))

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

        -- Get the attachment. Replacing upgraded version.
        local attachment
        if (TIER == 1) then
            timer.Simple(1, function()
                ply:SetArmor(ply:Armor() + (TIER * 25))
                ply:SetMaxArmor(ply:GetMaxArmor() + (TIER * 25))
            end)
        end
    end
end, 1)