att.PrintName = "Tandem Warhead"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("entities/acwatt_ammo_rpg7_he.png")
att.Description = "Load tandem shaped charge warheads that have excellent direct hit damage but very poor splash damage."
att.Desc_Pros = {
    "Increased Direct Hit Damage"
}
att.Desc_Cons = {
    "Poor Splash Damage",
}
att.AutoStats = true
att.Slot = "RPSRocket"

att.Mult_SightTime = 1.25
att.Mult_MoveSpeed = 0.8
att.Mult_ReloadTime = 1.2

att.Override_ShootEntity = "arccw_rocket_tandem"