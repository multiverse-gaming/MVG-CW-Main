att.PrintName = "Fast Hands"
att.Icon = nil
att.Description = [[You can loose shoots quickly, if inaccurately]]
att.Desc_Pros = {}
att.Desc_Cons = {}
att.Desc_Neutrals = {}

att.Slot = {"WPRevPerk"}
att.Free = true
att.HideIfUnavailable = true
att.AutoStats = true
att.NotForNPC = true

att.Hook_ShouldNotSight = function(wep)
    return true
end

att.LHIK = true
att.LHIKHide = true
att.Override_HoldtypeSights = "pistol"
att.Override_HoldtypeActive = "pistol"

att.Override_ShootWhileSprint = true
att.Mult_Recoil = 1.2
att.Mult_RPM = 1.3
att.Mult_Damage = 0.85
att.Mult_DamageMin = 0.30