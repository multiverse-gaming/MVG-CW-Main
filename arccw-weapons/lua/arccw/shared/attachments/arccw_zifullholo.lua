att.PrintName = "ZI Holo"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("entities/arccw_fullholo.png", "mips smooth")
att.Description = "For when you just need more sight picture and less sight."

att.SortOrder = 15

att.Desc_Pros = {
    "autostat.holosight",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "extraoptic"

att.Model = "models/zeus/optic_fullholo.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(0, 10, -1.28),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        ScrollFunc = ArcCW.SCROLL_NONE,
        IgnoreExtra = false
    }
}

att.ModelScale = Vector(1.2, 1.2, 1.2)
att.ModelOffset = Vector(-1.8, 0, 0.1)

att.Holosight = true
att.HolosightReticle = Material("zeus/scopes/fullholo/go_aimpoint.png", "mips smooth")
att.HolosightSize = 0.20
att.HolosightBone = "holosight"

att.Mult_SightTime = 1.01

att.Colorable = true