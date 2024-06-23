AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces - Republic Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "T-702 Sniper Rifle"
SWEP.Trivia_Class = "Blaster-Experimental Sniper Rifle"
SWEP.Trivia_Desc = "The T-702 sniper rifle was a sniper rifle manufactured for the clone snipers of the Galactic Republic. It was commonly used by Alpha-Class ARC Troopers during Clone Wars."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/t702.png"

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
SWEP.Damage = 450
SWEP.DamageMin = 450
SWEP.Range = 1200000
SWEP.Penetration = 22

SWEP.DamageType = DMG_DISSOLVE --DMG_BULLET
SWEP.MuzzleVelocity = 500
SWEP.TracerNum = 1
SWEP.Tracer = "pulsar_tracer" --"tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 1
SWEP.ExtendedClipSize = 10
SWEP.ReducedClipSize = 5

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 2.1
SWEP.RecoilSide = 1.02
SWEP.AccuracyMOA = 0.06 
SWEP.HipDispersion = 600
SWEP.MoveDispersion = 600

SWEP.Delay = 60 / 150
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1,
    }, 
    {
        Mode = 0
    }
}

SWEP.SpeedMult = 0.8
SWEP.SightedSpeedMult = 0.40
SWEP.SightTime = 0.4 / 1.25

-- Ammo, Sounds & MuzzleEffect
SWEP.MuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 140
SWEP.ShootPitch = 80
SWEP.ShootPitchVariation = 0.04

SWEP.FirstShootSound = "armas3/mando_rifle.mp3"
SWEP.ShootSound = "armas3/mando_rifle.mp3"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 1

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector( -3.2, 3, 1),
    Ang = Vector(0, 0, 0),
     Magnification = 1.50,
     SwitchToSound = "weapon_hand/ads/0242-00001a45.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a47.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -4, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

-- Attachments
SWEP.DefaultElements = {"comsniper", "muzzle"}
SWEP.AttachmentElements = {
    ["comsniper"] = {
        VMElements = {
            {
                Model = "models/arccw/comsniper_base.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-0.3, 5.4, 1.2),
                    ang = Angle(0, -180, 0)
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
                    pos = Vector(-0.5, 0, 20),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/arccw/comsniper_base.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(1000, 0, -420),
                    ang = Angle(0, 90, 190)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(7800, 0, -1750),
                    ang = Angle(0, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, 
    }
}
WMOverride = "models/arccw/comsniper_base.mdl"

SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "None", 
        Slot = "optic", 
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0, 0.6, -6),
            vang = Angle(90, 0, -90),
            wpos = Vector(1000, 100, -740),
            wang = Angle(-10, -1, 180)
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },       
--[[    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        VMScale = Vector(1.5, 1.5 , 1.5),
        WMScale = Vector(140, 140, 140),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0, 2.3, 55),
            vang = Angle(90, 0, -90),
            wpos = Vector(7870, 100, -1750),
            wang = Angle(-10, -1, 180)
        },
    },   
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0.3, 2.9, 26),
            vang = Angle(90, 0, -90),
            wpos = Vector(4200, 100, -1000),
            wang = Angle(-10, -1, 180)
        },
    }, 
    {
        PrintName = "Bipod",
        DefaultAttName = "None",
        Slot = {"bipod"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0, 3.1, 12),
            vang = Angle(90, 0, -90),
            wpos = Vector(2500, 100, -700),
            wang = Angle(-10, -1, 180)

        },
    },         
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "ammo_masita", "ammo_stun"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = {"perk", "mw3_pro"},
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"uc_fg"},
    },
    {
        PrintName = "Charms/Killcounter",
        DefaultAttName = "None",
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0.9, 1.5, -2),
            vang = Angle(90, 0, -70),
            wpos = Vector(1220, 210, -620),
            wang = Angle(-10, 0, 200)
        },
    },          --]]
}

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
        Time = 3.5,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 80/30},
        },
    },
}