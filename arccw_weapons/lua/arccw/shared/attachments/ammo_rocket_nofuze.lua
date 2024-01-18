att.PrintName = "No Fuze"
att.Description = "No fuze timer. Also slightly faster velocity"
att.Icon = Material("interfaz/iconos/jedi/2721145501_3098306349.png")

att.Desc_Pros = {
    "close range explosions",
    "can be used on other launchers",
}
att.Desc_Cons = {
    "the fuze timer was there for a reason",
    "missiles have a very slight arc",
}
att.AutoStats = true
att.Slot = "ammo_rocket"

att.Override_ShootEntity = "arccw_rocket_nofuze"