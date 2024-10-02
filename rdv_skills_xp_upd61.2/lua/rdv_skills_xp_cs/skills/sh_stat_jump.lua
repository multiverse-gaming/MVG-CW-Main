local OBJ = RDV.SAL.AddSkill("Jump Increase")

OBJ:SetMaxTiers(5)

OBJ:SetCategory("Stats")

OBJ:SetDescription("1/10 jump power per skillpoint.")

OBJ:SetColor(Color(0, 255, 0))

local OLD = {}

OBJ:AddHook("PlayerLoadout", function(ply)
    -- Make sure the player can benefit from this system
    local teams = RDV.LIBRARY.GetConfigOption("SAL_expTEAMS")
    local clientTeam = team.GetName(ply:Team())
    if teams[clientTeam] == nil or teams[clientTeam] == false then return end

    -- Apply the skill.
    local TIER = OBJ:GetSkillTier(ply)
    if TIER > 0 then
        if not OLD[ply] then
            OLD[ply] = ply:GetJumpPower()
        end

        timer.Simple(1, function()
            local JUMP = OLD[ply] + (TIER * 10)

            ply:SetJumpPower(JUMP)
        end)
    end
end)