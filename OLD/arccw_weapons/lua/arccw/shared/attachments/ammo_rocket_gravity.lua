att.PrintName = "Gravity Rocket"
att.Description = ""
att.Icon = Material("interfaz/iconos/jedi/2908166817_3227357796.png")

att.Desc_Pros = {
    "duds behave normally, falling to the ground",
}
att.Desc_Cons = {
    "missiles have a slight arc",
}
att.AutoStats = true
att.Slot = "ammo_rocket"

att.Override_ShootEntity = "arccw_rocket_gravity"