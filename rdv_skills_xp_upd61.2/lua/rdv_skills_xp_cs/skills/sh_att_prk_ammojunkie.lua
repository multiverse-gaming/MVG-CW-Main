local OBJ = RDV.SAL.AddSkill("Ammo Junkie")

OBJ:SetMaxTiers(3)

OBJ:SetCategory("Perks")

OBJ:SetDescription("Better accuracy, better stability.")

--OBJ:SetNoEffectTeams({
--    TEAM_CITIZEN,
--})

OBJ:SetColor(Color(138, 43, 226))

OBJ:AddHook("PlayerLoadout", function(ply)
    -- Make sure the player can benefit from this system
    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(ply:Team())
    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    -- Apply the skill.
    local TIER = OBJ:GetSkillTier(ply)
    if TIER > 0 then
        -- Get the attachment. Replacing upgraded version.
        local attachment
        if (TIER == 1) then
            attachment = "rc_perk_ammojunkie_1"
        elseif (TIER == 2) then
            attachment = "rc_perk_ammojunkie_2"
        else
            attachment = "rc_perk_ammojunkie_3"
        end
        
        timer.Simple(1, function()
            ArcCW:PlayerGiveAtt(ply, attachment, 1)
            ArcCW:PlayerSendAttInv(ply)
        end)
    end
end, 1)