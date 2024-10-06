att.PrintName = "Firepuncher Thermal Optic"
att.Icon = Material("entities/dlt19x_icon.png")
att.Description = "Thermal sniper rifle scope for long range combat."

att.SortOrder = 9

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "rccrosshairscope"

att.Model = "models/atts/e11_scope.mdl"
att.ModelOffset = Vector(0, 0, -0)
att.AdditionalSights = {
    {
        Pos = Vector(0.01, 9, -1.165),
        Ang = Angle(0, 0, 0),
        Magnification = 2,
        ScrollFunc = ArcCW.SCROLL_ZOOM,
        ZoomLevels = 10,
        ZoomSound = "weapons/arccw/fiveseven/fiveseven_slideback.wav",
        Thermal = true,
        ThermalScopeColor = Color(255, 255, 255),
        ThermalHighlightColor = Color(255, 0, 0),
        ThermalFullColor = true,
        ThermalScopeSimple = false,
        ThermalNoCC = false,
        ThermalBHOT = false, -- invert bright/dark
        IgnoreExtra = false, -- ignore gun-determined extra sight distance
    }
}

att.ScopeGlint = false

att.Holosight = true
att.HolosightReticle = Material("scope/star_ret.png", "smooth")
att.HolosightNoFlare = true
att.HolosightSize = 9
att.HolosightBone = "holosight"
att.HolosightPiece = "models/atts/e11_scope_hsp.mdl"
att.Colorable = false

att.HolosightMagnification = 0
att.HolosightBlackbox = true

att.HolosightConstDist = 44

att.HolosightMagnificationMin = 2
att.HolosightMagnificationMax = 3
att.HoloSightColorable = false

att.Mult_SightTime = 1.35
att.Mult_SightedSpeedMult = 0.8
att.Mult_SpeedMult = 0.9