att.PrintName = "Close Range"
att.Description = "Uses the previous iteration of the quake launcher's missile before the update. It can't hurt combine gunships or helicopters, but makes up for it by not having a fuze timer, allowing for point blank explosions"
att.Icon = Material("interfaz/iconos/kraken/jedi comm combat medic/1545019367_770535378.png")

att.Desc_Pros = {
    "close range explosions"
}
att.Desc_Cons = {
    "doesn't damage vehicles",
    "slightly slower velocity",
}
att.AutoStats = true
att.Slot = "ammo_rocket"

att.Override_ShootEntity = "arccw_rocket"