AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Galactic TFA Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "CR-2C"
SWEP.Trivia_Class = "Naboo Security Blaster Rifle"
SWEP.Trivia_Desc = "preffered for long-range combat and general allround usage."
SWEP.Trivia_Manufacturer = "Forged Industries"
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

SWEP.IconOverride = "materials/entities/rw_sw_cr2c.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 25
SWEP.RangeMin = 160
SWEP.DamageMin = 25
SWEP.Range = 350
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_green"
SWEP.TracerCol = Color(0, 250, 0)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 35

SWEP.Recoil = 0.6
SWEP.RecoilSide = 0.4
SWEP.RecoilRise = 0.13

SWEP.Delay = 60 / 800
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 2
	},
    {
        Mode = 0
    },    
}

SWEP.AccuracyMOA = 30 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200
SWEP.JumpDispersion = 1000

-- Mobility when weapon is out
SWEP.SpeedMult = 1

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(0, 255, 21)


----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "w/cr2.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-3.13, -11, 1.8),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "",
     ViewModelFOV = 50,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(2.9, -4, .5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -10, 0)
SWEP.SprintAng = Angle(-10, 40, 0)

SWEP.HolsterPos = Vector(0.2, -1, 1)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -13, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"cr2c"}

SWEP.AttachmentElements = {
    ["cr2c"] = {
        VMElements = {
            {
                Model = "models/arccw/sw_battlefront/weapons/CR2c_Base.mdl",
                Bone = "v_e11_reference001",
                Scale = Vector(1.3, 1.3, 1.3),
                Offset = {
                    pos = Vector(-1.2, -1.5, 0.5),
                    ang = Angle(0, -90, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/sw_battlefront/weapons/CR2c_Base.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(300, 120, -200),
                    ang = Angle(-15, 0, 180)
                }
            }
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    },
}


WMOverride = "models/arccw/sw_battlefront/weapons/CR2c_Base.mdl"
--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "e11_sight", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(0, -0.8, 2),
            vang = Angle(90, 0, -90),
            wpos = Vector(500, 110, -710),
            wang = Angle(-15, 0, 180)
        },
    }    
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
        Mult = 1.4,
        SoundTable = {
            {
                s = "w/dc15s/overheat_manualcooling_resetfoley_generic_var_01.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "w/dc15s/gunfoley_blaster_sheathe_var_03.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        Time = 2.5,
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