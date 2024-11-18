att.PrintName = "[ Starwars ] Suppressive Rounds"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("entities/atts/stun10.png")
att.AbbrevName = "Suppressive Rounds"
att.SortOrder = -2
att.Description = "Stun round."

att.Desc_Pros = {
    "Slows and disables an enemy"
}
att.Desc_Cons = {
    "Only works when enemy is heavily injured"
}
att.Desc_Neutrals = {
}

att.Slot = {"sw_ammo"}

att.SortOrder = -9001
att.AutoStats = true

att.Override_Num_Priority = 9001
att.Override_Tracer = "effect_sw_laser_blue_stun"
att.Mult_Damage = 0.9
att.Mult_DamageMin = 0.9
att.Mult_RPM = 0.9

att.Hook_BulletHit = function(wep, data)
    -- Return if invalid.
    if !data.tr.Entity then return end
    if data.tr.HitWorld then return end
    if !data.tr.Entity:IsPlayer() && !data.tr.Entity:IsNPC() then return end

    -- Deal damage through this hook instead. Don't edit the gun's base damage to keep stats the same.
    local target = data.tr.Entity
    target:SetHealth(math.max(target:Health() - data.damage, 1))
    if (target:Health() == 1) then
        target:SetNW2Float( "WOS_CripplingSlow", CurTime() + 2 )
        GMSERV:AddStatus(data.tr.Entity, data.att, "slow", 2, 0, true)
    end

    -- Get rid of damage done by the actual weapon.
    data.damage = 0
end

att.Hook_GetShootSound = function(wep, sound)
    return false
end

att.Hook_AddShootSound = function(wep, data)
    wep:MyEmitSound("w/stun_sound.wav", data.volume, data.pitch, 1, CHAN_WEAPON - 1)
end