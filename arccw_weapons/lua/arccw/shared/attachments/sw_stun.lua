att.PrintName = "[ Starwars ] Stun Rounds"
att.Icon = Material("entities/atts/stun10.png")
att.AbbrevName = "Stun round (10 seconds)"
att.SortOrder = -2
att.Description = "Stun round."

att.Desc_Pros = {
    "Causes stun for 10 seconds!"
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}

att.Slot = {"sw_ammo"}

att.SortOrder = -9001
att.AutoStats = true

att.Override_AmmoPerShot = 5
att.Override_Num_Priority = 9001
att.Override_Tracer = "effect_sw_laser_blue_stun"

att.Override_ClipSize = 10

att.Mult_RPM = 0.16666666666666666666666666666667

att.Hook_BulletHit = function(wep, data)
	GMSERV:AddStatus(data.tr.Entity, data.att, "stun", 10, 5, true) --Entity,Owner,Status Effect Type (Yes, you can add the others),Duration, Damage, ParticleEffect
end

att.Hook_GetShootSound = function(wep, sound)
    return false
end

att.Hook_AddShootSound = function(wep, data)
    wep:MyEmitSound("w/stun_sound.wav", data.volume, data.pitch, 1, CHAN_WEAPON - 1)
end