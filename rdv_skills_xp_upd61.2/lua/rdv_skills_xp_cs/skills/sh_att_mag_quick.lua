local OBJ = RDV.SAL.AddSkill("Quick Mag")

OBJ:SetMaxTiers(3)

OBJ:SetCategory("Magazine")

OBJ:SetDescription("Quicker reloads, less ammo.")

--OBJ:SetNoEffectTeams({
--    TEAM_CITIZEN,
--})

OBJ:SetColor(Color(255, 140, 0))

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
            attachment = "sw_dc17m_quickmag_1"
        elseif (TIER == 2) then
            attachment = "sw_dc17m_quickmag_2"
        else
            attachment = "sw_dc17m_quickmag_3"
        end
        
        timer.Simple(1, function()
            ArcCW:PlayerGiveAtt(ply, attachment, 1)
            ArcCW:PlayerSendAttInv(ply)
        end)
    end
end, 1)