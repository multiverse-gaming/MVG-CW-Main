local OBJ = RDV.SAL.AddSkill("Armor Increase")

OBJ:SetMaxTiers(2)

OBJ:SetCategory("Stats")

OBJ:SetDescription("25 armor per skillpoint.")

--OBJ:SetNoEffectTeams({
--    TEAM_CITIZEN,
--})

OBJ:SetColor(Color(0, 255, 0))

OBJ:AddHook("PlayerLoadout", function(ply)
    -- Make sure the player can benefit from this system
    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(ply:Team())
    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    -- Apply the skill.
    local TIER = OBJ:GetSkillTier(ply)
    if TIER > 0 then
        timer.Simple(1, function()
            ply:SetArmor(ply:Armor() + (TIER * 25))
            ply:SetMaxArmor(ply:GetMaxArmor() + (TIER * 25))
        end)
    end
end, 1)