att.PrintName = "SW-Half Drum Magazine"
att.AbbrevName = "75-Round Mag"
att.SortOrder = 100
att.Icon = nil
att.Description = "Half Drum magazine, ideal for additional fire support. Slight Bulky construction and additional ammo capacity increases weight, making the weapon difficult to handle"
att.Desc_Pros = {}
att.Desc_Cons = {}

att.Desc_Neutrals = {}
att.Slot = "dc15a_magazine_75"

att.Model = "models/weapons/arccw/atts/magazine/rt97c_mag_half.mdl"
att.DroppedModel = "models/Items/BoxSRounds.mdl"
att.OffsetAng = Angle(0, 0, -90)
att.ModelOffset = Vector(4.2, 0, -0.33)

att.AutoStats = true

att.HideIfBlocked = true

att.Override_ClipSize = 75

att.Mult_SightTime = 1.05
att.Mult_Sway = 2.1

att.Mult_SpeedMult = 0.95
att.Mult_ShootSpeedMult = 0.95

att.Mult_DrawTime = 1.25
att.Mult_HolsterTime = 1.25

att.Mult_HipDispersion = 1.3

--[[]
att.Override_Jamming = true
att.Override_HeatCapacity = 200
att.Override_HeatDissipation = 4
att.Override_HeatDelayTime = 3
]]
