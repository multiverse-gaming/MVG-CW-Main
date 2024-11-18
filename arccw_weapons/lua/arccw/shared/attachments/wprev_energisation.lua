att.PrintName = "Superheated Plasma"
att.Icon = nil
att.Description = [[Improved damage, reduced RPM to deal with the heat, so hot it burns the air as it travels]]
att.Desc_Pros = {}
att.Desc_Cons = {"Longer Reload"}
att.Desc_Neutrals = {}

att.Slot = {"WPRevEnergisation"}
att.Free = false
att.HideIfUnavailable = true
att.AutoStats = true
att.NotForNPC = true

att.Override_Tracer = "arccw_apex_tracer_energy_sniper"
att.Override_DamageType = DMG_ENERGYBEAM

att.Mult_RPM = 0.7
att.Mult_Damage = 1.3
att.Add_ClipSize = -2
att.Hook_MultReload = function(wep, mult)
    return 1.2
end
att.Mult_Recoil = 1.2
att.Mult_RecoilSide = 1.2