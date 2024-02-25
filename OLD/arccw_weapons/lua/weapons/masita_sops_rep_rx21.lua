AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces - Republic Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "RX-21"
SWEP.Trivia_Class = "Blaster-Experimental Rifle"
SWEP.Trivia_Desc = "The RX-21 Rifle, also known as RX-21 blaster, was a experimental blaster rifle wielded by the Task-Force 99 Clone Troopers of the Grand Army of the Galactic Republic during the Clone Wars."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/r21x.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 65
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Damage & Tracer
SWEP.Damage = 35
SWEP.DamageMin = 35
SWEP.RangeMin = 320
SWEP.Range = 512000
SWEP.Penetration = 7
SWEP.DamageType = DMG_BULLET

SWEP.Primary.ClipSize = 40
SWEP.ExtendedClipSize = 45
SWEP.ReducedClipSize = 15

SWEP.MuzzleVelocity = 400
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5

SWEP.Recoil = 0.3
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.2

SWEP.Delay = 60 / 550
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

-- Speed Mult
SWEP.AccuracyMOA = 4.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

-- Mobility when weapon is out
SWEP.SpeedMult = 1

SWEP.ShootWhileSprint = true

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 110 
SWEP.ShootPitch = 100 
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "armas3/el16hfe.wav"
SWEP.ShootSound = "armas3/el16hfe.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-3.450, -8, -1.5),
    Ang = Angle(-0.8, -0.3, 0),
     Magnification = 1.2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(2, 0, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -4, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.HolsterPos = Vector(4, -3, -2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments
SWEP.DefaultElements = {"rx21", "muzzle"}
SWEP.AttachmentElements = {
    ["rx21"] = {
        VMElements = {
            {
                Model = "models/holo/r21xdawnbreaker/holo_r21x.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(0.35, -9, 2),
                    ang = Angle(0, -90, 0),
                }
            }
        }
    },
    ["muzzle"] = {
         VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "dlt19_sight",
                Scale = Vector(0, 0, 0),                
                Offset = {
                    pos = Vector(-4, 0, 20),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/holo/r21xdawnbreaker/holo_r21x.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.7, 0.7, 0.7),
                Offset = {
                    pos = Vector(-180, 140, -200),
                    ang = Angle(-13, 0, 180),
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(2200, 140, -745),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, 
    }
}
WMOverride = "models/holo/r21xdawnbreaker/holo_r21x.mdl"

SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "None", 
        Slot = "rifleoptic", 
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(-0.3, -2.3, -8),
            vang = Angle(90, 0, -90),
            wpos = Vector(600, 130, -720),
            wang = Angle(-15, -0.50, 180)
        },
        CorrectiveAng = Angle(0, -0.3, 0),
        CorrectivePos = Vector(0, 0, 0),
    },  
--[[    {
        PrintName = "Grip",
        Slot = "No Attachment",
        DefaultAttName = "Standard Grip"
    },       
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"No Attachment"},
        VMScale = Vector(2,2,2),
        WMScale = Vector(140, 140, 140),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0, 0.5, 20),
            vang = Angle(90, 0, -90),
            wpos = Vector(2450, 130, -945),
            wang = Angle(-15, -1, 180)
        },
    },   
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"No Attachment"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(1.1, 3, 14),
            vang = Angle(90, 0, 0),
            wpos = Vector(2250, 275, -650),
            wang = Angle(-10, -1, -90)
        },
    },  
    {
        PrintName = "Underbarrel",
        DefaultAttName = "None",
        Slot = {"No Attachment"},
        WMScale = Vector(111, 111, 111),
        VMScale = Vector(1.2,1.2,1.2),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(-0.5, 6, 9),
            vang = Angle(90, 0, -90),
            wpos = Vector(1550, 145, -320),
            wang = Angle(-15, -1, -180)

        },
    },                
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"No Attachment"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = {"No Attachment"},
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"No Attachment"},
    },
    {
        PrintName = "Charms/Killcounter",
        DefaultAttName = "None",
        Slot = {"No Attachment"},
        WMScale = Vector(90, 90, 90),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(1.3, -1, -4),
            vang = Angle(90, 0, -90),
            wpos = Vector(670, 250, -620),
            wang = Angle(0, 0, 180)
        },
    },      --]]   
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2", "shoot3"}
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "draw/gunfoley_pistol_draw_var_06.mp3", -- sound; can be string or table
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
                s = "holster/gunfoley_pistol_sheathe_var_09.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 80/30},
        },
    },
}