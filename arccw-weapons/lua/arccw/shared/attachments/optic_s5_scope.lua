att.PrintName = "S5 Magnifying Optic"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("entities/dlt19x_icon.png")
att.Description = "High-magnification sniper rifle scope for long range combat."

att.SortOrder = 9

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "optic"

att.Model = "models/atts/s5_default_scope.mdl"
att.ModelOffset = Vector(0, 0, -0)
att.AdditionalSights = {
    {
        Pos = Vector(0, 9, -1.2),
        Ang = Angle(0, 0, 0),
        Magnification = 1.5,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 10,
        ZoomSound = "weapons/arccw/fiveseven/fiveseven_slideback.wav",
        IgnoreExtra = true
    }
}

att.ScopeGlint = false

att.Holosight = true
att.HolosightReticle = Material("scope/star_ret.png", "smooth")
att.HolosightNoFlare = true
att.HolosightSize = 13
att.HolosightBone = "holosight"
att.HolosightPiece = "models/atts/s5_default_scope_hsp.mdl"
att.Colorable = false

att.HolosightMagnification = 0
att.HolosightBlackbox = true

att.HolosightConstDist = 64

att.HolosightMagnificationMin = 2
att.HolosightMagnificationMax = 3
att.HoloSightColorable = false

--[[att.Mult_SightTime = 1.35
att.Mult_SightedSpeedMult = 0.8
att.Mult_SpeedMult = 0.9--]]