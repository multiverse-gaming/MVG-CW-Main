local OBJ = RDV.SAL.AddSkill("Knife")

OBJ:SetMaxTiers(1)

OBJ:SetCategory("Weapons")

OBJ:SetDescription("Invest in a knife for yourself.")

--OBJ:SetNoEffectTeams({
--    TEAM_CITIZEN,
--})

OBJ:SetColor(Color(0, 0, 255))

OBJ:AddHook("PlayerLoadout", function(ply)
    -- Make sure the player can benefit from this system
    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(ply:Team())
    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    -- Apply the skill.
    local TIER = OBJ:GetSkillTier(ply)
    if TIER > 0 then
        -- Get the weapon. Replacing upgraded version.
        local wep
        if (TIER == 1) then
            wep = "base"
        end
        
        timer.Simple(1, function()
            ply:Give(wep, true)
        end)
    end
end, 1)