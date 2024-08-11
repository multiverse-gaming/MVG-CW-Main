att.PrintName = "ZI NV"
att.Icon = Material("entities/arccw_tracker.png", "mips smooth")
att.Description = "Advanced targeting sight highlights and tracks enemies."

att.SortOrder = 4

att.Desc_Pros = {
    "autostat.holosight",
	"+ Thermal vision"
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "thermaloptic"

att.Model = "models/zeus/optic_tracker.mdl"

att.AdditionalSights = {
    {
        Pos = Vector(-0.018321, 10, -1.33),
        Ang = Angle(0, 0, 0),
        Magnification = 1.1,
        Thermal = true,
		ThermalScopeColor = Color(255, 135, 0),
        ThermalHighlightColor = Color(255, 135, 0),
        ThermalScopeSimple = false,
        ThermalNoCC = true,
    }
}

att.Holosight = true
att.HolosightReticle = Material("zeus/scopes/tracker/arccw_tracker1.png", "mips smooth")
att.HolosightNoFlare = true
att.HolosightSize = 5.5
att.HolosightBone = "holosight"
att.HolosightPiece = "models/zeus/optic_tracker_hsp.mdl"

att.HolosightMagnification = 1.1
att.HolosightBlackbox = false

att.HolosightConstDist = 42

att.Mult_SightTime = 1.4