AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Slot = 3

SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = "Kraken / Kalin"
SWEP.PrintName = "DLT-19"
SWEP.Trivia_Class = "Blaster Heavy Rifle"
SWEP.Trivia_Desc = "The DLT-19 heavy blaster rifle was a model of heavy blaster rifle manufactured by BlasTech Industries. They were used by regular stormtroopers and Heavy Weapons Stormtroopers of the Galactic Empire, but they also saw use by other parties, including the Alliance to Restore the Republic and certain bounty hunters."
SWEP.Trivia_Manufacturer = "BlastTech Industries"
SWEP.Trivia_Calibre = "Condensed Tibanna-Gas"
SWEP.Trivia_Country = "Galactic Republic"
SWEP.IconOverride = "zeus/dlt19/dlt19.png"

-- Base
SWEP.MirrorVMWM = true
SWEP.UseHands = true
SWEP.NoHideLeftHandInCustomization = false
SWEP.ViewModel = "models/zeus/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(-9.1, 4.8, -5),
    ang = Angle(-6, 4, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1,
}

-- Damage & Tracer

SWEP.Damage = 35
SWEP.DamageMin = 35
SWEP.RangeMin = 0
SWEP.Range = 55000

SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 500

SWEP.TracerNum = 1
SWEP.TracerCol = Color(0, 0, 250)
SWEP.TracerWidth = 10
SWEP.Tracer = "tfa_tracer_blue"
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 50

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.29
SWEP.RecoilSide = 0.22
SWEP.RecoilRise = 0.33

SWEP.Delay = 60 / 450
SWEP.Num = 1

SWEP.Firemode = 1
SWEP.Firemodes = {
    {
		Mode = 2,
    },
	{
		Mode = 0,
   	}
}

SWEP.AccuracyMOA = 5.7
SWEP.HipDispersion = 400
SWEP.MoveDispersion = 200
-- SWEP.JumpDispersion = 1000

-- Speed Mult
SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.4 / 1.25

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 75
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.1

SWEP.FirstShootSound = "zeus/dlt19/dlt19_1.wav"
SWEP.ShootSound = "zeus/dlt19/dlt19_2.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.MuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.FastMuzzleEffect = nil
SWEP.MuzzleFlashColor = Color(0, 0, 250)
SWEP.Primary.Ammo = "ar2"

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-2.86, -6.961, -0),
    Ang = Angle(2.9, 0, 0),
     Magnification = 1.1,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.HoltypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 5.5, -0.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(4.019, -3.226, -4.805)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(10, 0, 0)
SWEP.CustomizeAng = Angle(6.8, 30.7, 10.3)

SWEP.HolsterPos = Vector(4, 3, -1)
SWEP.HolsterAng = Vector(-16, 30, -1)

-- Attachments
--[[SWEP.DefaultElements = {"muzzle"}
SWEP.AttachmentElements = {
    ["muzzle"] = {
        VMElements = {
           {
               Model = "models/hunter/plates/plate.mdl",
               Bone = "DC_15X_Rifle",
               Scale = Vector(1, 1, 1),                
               Offset = {
                   pos = Vector(-20, 30, -3),
                   ang = Angle(-90, 180, 0)
               },
               IsMuzzleDevice = true
           }
        },
    }
}--]]


SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "Iron Sights",
        Slot = {"extraoptic"},
        Bone = "DC_15X_Rifle",
        WMScale = Vector(1, 1, 1),
        VMScale = Vector (0.8, 0.8, 0.8),
        Offset = {
            vpos = Vector(0.085, -0.5, 2.73),
            vang = Angle(0, 270, 0),
            wpos = Vector(800, 0, -600),
            wang = Angle(-5, 0, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0),
    },
    {
        PrintName = "Bipod",
        DefaultAttName = "None",
        Slot = {"bipod"},
        WMScale = Vector(1, 1, 1),
        Bone = "DC_15X_Rifle",
        Offset = {
            vpos = Vector(0, 24, 0.6),
            vang = Angle(90, -90, -90),
            wpos = Vector(2500, 0, -500),
            wang = Angle(-5, 0, 180)

        },
    }, 
}
SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["fire"] = {
        Source = "fire"
    },
    ["idle_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "zeus/dlt19/out.wav",
                p = 100,
                v = 100,
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "zeus/dlt19/pull.wav",
                p = 100,
                v = 100,
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload",
        LHIK = true,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2, 
        SoundTable = {
            {s = "zeus/dlt19/magrelease.wav", t = 0.1 },
            {s = "zeus/dlt19/magout.wav", t = 0.2 },
            {s = "zeus/dlt19/magin.wav", t = 0.9 },
        },
    },
}