local OBJ = RDV.SAL.AddSkill("Knife")

OBJ:SetMaxTiers(3)

OBJ:SetCategory("Weapon")

OBJ:SetDescription("Invest in a slowly improving knife.")

--OBJ:SetNoEffectTeams({
--    TEAM_CITIZEN,
--})

OBJ:SetColor(Color(60,60,180))

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

        -- Get the weapon. Replacing upgraded version.
        local wep
        if (TIER == 1) then
            wep = "knife1"
        elseif (TIER == 2) then
            wep = "knife2"
        else
            wep = "knife3"
        end
        
        timer.Simple(1, function()
            ply:Give(wep, true)
        end)
    end
end, 1)