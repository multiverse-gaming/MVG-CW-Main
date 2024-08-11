att.PrintName = "ZI CQ-9"
att.Icon = Material("entities/arccw_hcog.png", "mips smooth")
att.Description = "The ZI CQ Scope offers minimal magnification is a perfect for close quarters combat. "

att.SortOrder = 16

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

att.Model = "models/zeus/optic_zicq9.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 10, -1.35),
        Ang = Angle(0, 0, 0),
        Magnification = 1.2,
        IgnoreExtra = true
    },
}

att.Holosight = true
att.HolosightReticle = Material("zeus/scopes/scopecq/reticlecq.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 5
att.HolosightBone = "holosight"
att.Colorable = true
att.ModelScale = Vector(1.4, 1.4, 1.4)

att.HolosightMagnification = 1

att.Mult_SightTime = 1.01

att.Colorable = false