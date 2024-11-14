att.PrintName = "Steady Shots"
att.Icon = nil
att.Description = [[Nigh-perfect accuracy, and the ability to place headshots]]
att.Desc_Pros = {}
att.Desc_Cons = {}
att.Desc_Neutrals = {}

att.Slot = {"WPRevPerk"}
att.Free = true
att.HideIfUnavailable = true
att.AutoStats = true
att.NotForNPC = true

att.Override_BodyDamageMults  =  {
    [HITGROUP_HEAD] = 1.3,
}

att.Mult_RPM = 0.7
att.Mult_Damage = 1.10
att.Mult_DamageMin = 1.10
att.Mult_AccuracyMOA = 0.1
att.Mult_SpeedMult = 0.9
att.Mult_SightedSpeedMult = 0.9