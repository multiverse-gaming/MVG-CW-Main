AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Galactic Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "Westar-11"
SWEP.Trivia_Class = "Galactic Blaster Rifle"
SWEP.Trivia_Desc = "preffered for long-range combat and general allround usage."
SWEP.Trivia_Manufacturer = "Concordian Crescent Technologies"
SWEP.Trivia_Calibre = "Medium Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020
SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/bf2017/c_e11.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.IconOverride = "materials/entities/rw_sw_westar11.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 25
SWEP.RangeMin = 135
SWEP.DamageMin = 13
SWEP.Range = 350
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1


SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_yellow"
SWEP.TracerCol = Color(255, 165, 18)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 39

SWEP.Recoil = 0.27
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.13

SWEP.Delay = 60 / 270
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 2
	},
    {
        Mode = 1
    }, 
    {
        Mode = 0
    },   
}

SWEP.AccuracyMOA = 0.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 500 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "w/westar11.wav"

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false

SWEP.MuzzleFlashColor = Color(0, 250, 0)

SWEP.IronSightStruct = {
    Pos = Vector(-2.83, -11, 2.8),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "",
     ViewModelFOV = 50,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(2.9, -6, -4)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -10, 0)
SWEP.SprintAng = Angle(-10, 40, 0)

SWEP.HolsterPos = Vector(2, -5, 1)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -16, 4.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"westar11"}

SWEP.AttachmentElements = {
    ["westar11"] = {
        VMElements = {
            {
                Model = "models/arccw/sw_battlefront/weapons/westar_35_rifle.mdl",
                Bone = "v_e11_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-0.9, 0.55, 1.75),
                    ang = Angle(0, 0, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/sw_battlefront/weapons/westar_35_rifle.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(240, 50, -200.5),
                    ang = Angle(-15, -90, 180)
                }
            }
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    },
}

WMOverride = "models/arccw/sw_battlefront/weapons/westar_35_rifle.mdl"
--SWEP.Attachments 
--[[SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "e11_sight", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(0.3, 0.03, 3),
            vang = Angle(90, 0, -90),
            wpos = Vector(800, 45, -650),
            wang = Angle(-15, 0, 180)
        },
    },    
    [2] = {
        PrintName = "Foregrip", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = "foregrip",
        WMScale = Vector(111, 111, 111),
        Bone = "e11_sight", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(0, 3, 12),
            vang = Angle(90, 0, -90),
            wang = Angle(170, 180, 0),
        },
        SlideAmount = {
        vmin = Vector(-0.2, 2.8, 8),
        vmax = Vector(-0.2, 2.8, 14),
        wmin = Vector(1600, 50, -480), 
        wmax = Vector(1600, 50, -480) -- how far this attachment can slide in both directions.
        },        
    },
    [3] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        WMScale = Vector(111, 111, 111),
        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1, 1.5, 11),
            vang = Angle(90, 0, 0),
            wpos = Vector(1300, 150, -550),
            wang = Angle(-15, 0, -90)
        },
    },
    [4] = {
        PrintName = "Muzzle", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle"},
        WMScale = Vector(111, 111, 111),
        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.25, 0.8, 19),
            vang = Angle(90, 0, -90),
            wpos = Vector(2320, 50, -980),
            wang = Angle(-15, 0, -90)
        },
    },
    [5] = {
        PrintName = "Magazine", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {},
        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.3, 2.3, 4),
            vang = Angle(0, 0, 0),
        },
    },        
    [6] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
    },
    [7] = {
        PrintName = "Training/Perk", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "perk",
    },
    [8] = {
        PrintName = "Charms", -- print name
        DefaultAttName = "No Charm", -- used to display the "no attachment" text
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1.2, 2, 5),
            vang = Angle(90, 0, -90),
            wpos = Vector(900, 150, -470),
            wang = Angle(-10 , 0, 180)
        },
    },          
}--]]

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
        Time = 3.35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "ArcCW_dc15a.reload2", t = 1 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "ArcCW_dc15s.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/pistols.wav"
    }),
}