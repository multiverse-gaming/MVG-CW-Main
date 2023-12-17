local translate = {
    [ACT_MP_STAND_IDLE] = ACT_HL2MP_IDLE_MAGIC,
    [ACT_MP_WALK] = ACT_HL2MP_WALK_MAGIC,
    [ACT_MP_RUN] = ACT_HL2MP_RUN_MAGIC,
    [ACT_MP_CROUCH_IDLE] = ACT_HL2MP_IDLE_CROUCH_MAGIC,
    [ACT_MP_CROUCHWALK] = ACT_HL2MP_WALK_CROUCH_MAGIC,
    [ACT_MP_ATTACK_STAND_PRIMARYFIRE] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MAGIC,
    [ACT_MP_RELOAD_STAND] = ACT_HL2MP_GESTURE_RELOAD_MAGIC,
    [ACT_MP_JUMP] = ACT_HL2MP_JUMP_MAGIC,
    [ACT_MP_SWIM] = ACT_HL2MP_SWIM_MAGIC,
}

hook.Add("TranslateActivity", "MagicPhysgun", function(ply, act)
    local wpn = ply:GetActiveWeapon()

    if !wpn:IsValid() then return end

    if wpn:GetClass() == "weapon_physgun" or wpn:GetClass() == "weapon_physcannon" then 
        if translate[act] then return translate[act] end
    end


end)

CAMI.RegisterPrivilege({
    	Name = "PhysgunBeam",
    	MinAccess = "superadmin"
})