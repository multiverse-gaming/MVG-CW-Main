/*local OBJ = RDV.SAL.AddOpportunity("Killing Vehicles")

OBJ:AddHook("PostEntityTakeDamage", function(vehicle, damage)
    local ATT = damage:GetAttacker()

    if vehicle.LFS and vehicle:IsDestroyed() and vehicle.GetAITEAM and IsValid(ATT) then
        if !ATT:IsPlayer() or !ATT.lfsGetAITeam then
            return
        end
            
        if vehicle:GetAITEAM() == ATT:lfsGetAITeam() then
            return
        end
            
        if vehicle.SALDamApplied then
            return
        end

        vehicle.SALDamApplied = true

        OBJ:AddExperience(ATT, 500 )
    end
end)
*/