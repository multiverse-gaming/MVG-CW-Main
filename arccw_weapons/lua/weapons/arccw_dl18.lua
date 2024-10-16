AddCSLuaFile()

SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Galactic Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DL-18"
SWEP.Trivia_Class = "Galactic Blaster Pistol"
SWEP.Trivia_Desc = "A Blaster pistol for shooting enviroments"
SWEP.Trivia_Manufacturer = "Forged Armory"
SWEP.Trivia_Calibre = "Low Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/bf2017/c_scoutblaster.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

SWEP.IconOverride = "materials/entities/rw_sw_dl18.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 30
SWEP.RangeMin = 80
SWEP.DamageMin = 14
SWEP.Range = 325
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 1050


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.ImpactDecal = "FadingScorch"

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_red"
SWEP.TracerCol = Color(255, 0, 0)
SWEP.HullSize = 2

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 18

SWEP.Recoil = 0.34
SWEP.RecoilPunch = 0.4
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.17

SWEP.Delay = 60 / 300
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 0.22 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 530 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(250, 0, 0)


----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "w/dl18.wav"
SWEP.IronSightStruct = {
    Pos = Vector(-4.125, -8, 1.5),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "",
     ViewModelFOV = 60,
}
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(3, -4, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5, -10,-20)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(20.824, -16, 4.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"dl18"}

SWEP.AttachmentElements = {
    ["dl18"] = {
        VMElements = {
            {
                Model = "models/arccw/hauptmann/star wars/weapons/dl18.mdl",
                Bone = "v_scoutblaster_reference001",
                Scale = Vector(1.05, 1.05, 1.05),
                Offset = {
                    pos = Vector(0.2, -3.5, -3.75),
                    ang = Angle(0, 90, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/hauptmann/star wars/weapons/dl18.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(80, 20, 20),
                    ang = Angle(-15, 0, 180)
                }
            }
        },
    },
}
WMOverride = "models/arccw/hauptmann/star wars/weapons/dl18.mdl" -- change the world model to something else. Please make sure it's compatible with the last one.

--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = "swoptic_module",
        VMScale = Vector(0.8, 0.8, 0.8),
        Bone = "v_scoutblaster_reference001", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(0.2, -0.5, 3),
            vang = Angle(0, 180, 0),
        },
    },
--[[    [2] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment",
        VMScale = Vector(0.8, 0.8, 0.8), -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        Bone = "v_scoutblaster_reference001", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, -5, 1.3),
            vang = Angle(0, 90, 0),
        },
    },    
    [3] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
    },
    [4] = {
        PrintName = "Training/Perk", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "perk",
    },
    [5] = {
        PrintName = "Charms", -- print name
        DefaultAttName = "No Charm", -- used to display the "no attachment" text
        Slot = {"charm"},
        Bone = "scoutblaster_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.35, 0.9, 1),
            vang = Angle(90, 0, -90),
        },
    },          --]]
}


SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["draw"] = {
        Source = "draw",
    },
    ["holster"] = {
        Source = "holster",
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
 --       Time = 3.35,
        SoundTable = {
            {s = "ArcCW_dc17.reload2", t = 1 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "ArcCW_dc17.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/pistols.wav"
    }),
}