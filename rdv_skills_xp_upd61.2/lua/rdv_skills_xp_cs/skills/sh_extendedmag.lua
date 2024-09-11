local OBJ = RDV.SAL.AddSkill("Extended Mag Upgrade")

OBJ:SetMaxTiers(3)

OBJ:SetCategory("Attachments")

OBJ:SetDescription("Invest in a slowly improving extended mag.")

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

        -- Get the attachment. Replacing upgraded version.
        local attachment
        if (TIER == 1) then
            attachment = "mag_1"
        elseif (TIER == 2) then
            attachment = "mag_2"
        else
            attachment = "mag_3"
        end
        
        timer.Simple(1, function()
            ArcCW:PlayerGiveAtt(ply, attachment, 1)
            ArcCW:PlayerSendAttInv(ply)
        end)
    end
end, 1)