local OBJ = RDV.SAL.AddOpportunity("Killing NPC")

OBJ:AddHook("OnNPCKilled", function(npc, attacker, inflictor)
    if attacker:IsPlayer() then
        OBJ:AddExperience( attacker, 20 )
    end
end)


