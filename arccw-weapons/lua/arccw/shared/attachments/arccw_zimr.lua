att.PrintName = "ZI MR-6"
att.Icon = Material("entities/arccw_titholo.png", "mips smooth")
att.Description = "The ZI Medium Quarters scope offers 2 magnifying lenses. It is perfect for Close-to-Medium range combat."

att.SortOrder = 4

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.Desc_Neutrals = {
}
att.AutoStats = true
att.Slot = "extraoptic"

att.Model = "models/zeus/optic_zimr6.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 10, -1.35),
        Ang = Angle(0, 0, 0),
        Magnification = 2.5,
        IgnoreExtra = true
    },
}

att.Holosight = true
att.HolosightReticle = Material("zeus/scopes/scopemr/reticlemr.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 3.5
att.HolosightBone = "holosight"
att.Colorable = true
att.ModelScale = Vector(1.4, 1.4, 1.4)

att.HolosightMagnification = 1

att.Mult_SightTime = 1.01

att.Colorable = false