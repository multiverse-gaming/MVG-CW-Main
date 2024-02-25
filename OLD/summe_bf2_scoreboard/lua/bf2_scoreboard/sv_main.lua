
hook.Add("OnNPCKilled", "BF2_Scoreboard.NPCKills", function(npc, attacker, inflictor)
    if not IsValid(attacker) or not attacker:IsPlayer() then return end

    attacker:SetNWInt("BF2SB_TotalKillsNPC", attacker:GetNWInt("BF2SB_TotalKillsNPC", 0) + 1)
end)



hook.Add("PlayerDeath", "BF2_Scoreboard.PlayerKills", function(ply, inflictor, attacker)
    if not IsValid(attacker) or not attacker:IsPlayer() then return end

    if ply == attacker then return end

    attacker:SetNWInt("BF2SB_TotalKills", attacker:GetNWInt("BF2SB_TotalKills", 0) + 1)
end)