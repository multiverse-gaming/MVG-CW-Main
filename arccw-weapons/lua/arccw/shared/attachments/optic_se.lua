att.PrintName = "Experimental Scope (SE)"
att.Free = true
att.HideIfUnavailable = true
att.Icon = Material("entities/acwatt_optic_micro.png")
att.Description = "test scope for swrp"

att.SortOrder = 2

att.Desc_Pros = {
    "autostat.holosight",
    "autostat.zoom",
}
att.Desc_Cons = {
}
att.AutoStats = false
att.Slot = "swoptic_module_dcse"

att.Model = "models/weapons/arccw/atts/dc17c_sight.mdl"
att.HideModel = false
att.ModelScale = Vector(1.4, 1.4, 1.4)
att.ModelOffset = Vector(0, 0, 0)
att.OffsetAng = Angle(0, 90, 0)
att.AdditionalSights = {
    {
        Pos = Vector(0, 11.5, -2.3),
        Ang = Angle(0, 0, 0),
        Magnification = 2,
    }
}

att.Holosight = true
att.HolosightReticle = Material("#sw/visor/sw_ret_redux_blue.png", "smooth")
att.HolosightNoFlare = false
att.HolosightSize = 6
att.HolosightBone = "holosight"
att.HolosightPiece = "models/weapons/arccw/atts/dc17c_hsp.mdl"

att.HolosightMagnification = 2
att.HolosightBlackbox = true
att.HolosightNoHSP = false

--[[att.Mult_SightTime = 1.08
att.Mult_SightedSpeedMult = 0.94--]]