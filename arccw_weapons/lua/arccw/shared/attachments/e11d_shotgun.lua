att.PrintName = "E-11D - Tibanna Splitter"
att.Free = true
att.HideIfUnavailable = true

att.SortOrder = 20
att.Icon = Material("interfaz/armas/sw_powercore.png", "smooth mips")
att.Description = "Component placed within the chamber of the rifle splitting the tibanna gases"
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.Slot = "e11d_shotgun"

att.AutoStats = true

att.Silencer = false
att.ActivateElements = {"e11_powerpack"}

att.Mult_Damage = 6 -- 210 Damage
//att.Mult_DamageMin = 6 --210 Damage
att.Mult_DamageMin = 6 --210 Damage
att.Mult_RPM = 0.22222222222222222222222222222222
att.Mult_Num = 6

att.Override_ClipSize = 10

att.Mult_AccuracyMOA = 21.0526315789
att.Mult_HipDispersion = 0.625

--- Mobility
att.Mult_SpeedMult = 1

att.Mult_RecoilSide = 1.25
att.Mult_Recoil = 1.2

att.Hook_AddShootSound = function(wep, data)
    wep:MyEmitSound("w/dp23.wav", data.volume, data.pitch, 1, CHAN_WEAPON - 1)
end