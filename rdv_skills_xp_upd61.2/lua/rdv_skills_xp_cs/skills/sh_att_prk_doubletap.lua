local OBJ = RDV.SAL.AddSkill("Double Tap")

OBJ:SetMaxTiers(3)

OBJ:SetCategory("Perks")

OBJ:SetDescription("Split the shots in two, become less accurate.")

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
            attachment = "rc_perk_doubletap_1"
        elseif (TIER == 2) then
            attachment = "rc_perk_doubletap_2"
        else
            attachment = "rc_perk_doubletap_3"
        end
        
        timer.Simple(1, function()
            ArcCW:PlayerGiveAtt(ply, attachment, 1)
            ArcCW:PlayerSendAttInv(ply)
        end)
    end
end, 1)