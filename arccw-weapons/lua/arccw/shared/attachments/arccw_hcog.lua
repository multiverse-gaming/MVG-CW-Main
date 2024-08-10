att.PrintName = "Lawai HCOG (1.85x)"
att.Icon = Material("entities/arccw_hcog.png", "mips smooth")
att.Description = "The HCOG is available for most primary Pilot weapons. The sight consists of a red chevron surrounded by a clear frame, giving the user a less obstructed view than the default iron sights. It has a low zoom level. "

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

att.Model = "models/weapons/arccw/optic_hcog.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 10, -1.35),
        Ang = Angle(0, 0, 0),
        Magnification = 1,
        IgnoreExtra = true
    },
}

att.Holosight = true
att.HolosightReticle = Material("hud/holosight/tit_hcog.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 5
att.HolosightBone = "holosight"
att.Colorable = true
att.ModelScale = Vector(1.4, 1.4, 1.4)

att.HolosightMagnification = 1

att.Mult_SightTime = 1.01

att.Colorable = false