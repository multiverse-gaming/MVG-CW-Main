att.PrintName = "733 Firepuncher - Overpressure Attachment"
att.Free = true
att.HideIfUnavailable = true

att.SortOrder = 20
att.Icon = Material("interfaz/armas/sw_powercore.png", "smooth mips")
att.Description = "Higher pressure compression allows for a harder hitting shot at the cost of stronger knockback."

att.Desc_Pros = {"Heavy Hitting Yellow Tibanna Gas Shot"
}
att.Desc_Cons = {"One in the chamber"
}
att.Desc_Neutrals = {
}
att.Slot = "mode_firepuncher"

att.AutoStats = true

-- Damage and Ammo
att.Mult_Damage = 6.1538461538461538461538461538462 -- 400 Damage
att.Mult_DamageMin = 6.1538461538461538461538461538462
att.Override_ClipSize = 1

att.Mult_HipDispersion = 2

-- Recoil
att.Mult_RecoilSide = 1.25
att.Mult_Recoil = 1.2

--att.Mult_RPM = 1
--att.Mult_ShootVol = 1.25
--att.Mult_ShootPitch = 0.9 please don't

-- att.Mult_MalfunctionMean = 0.7
-- att.Mult_PhysBulletMuzzleVelocity = 1.25