AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ ArcCW ] Special Forces Weapons"
SWEP.Credits = "Kraken"
SWEP.PrintName = "T-7 Ion Disruptor"
SWEP.Trivia_Class = "Ion Disruptor"
SWEP.Trivia_Desc = "The T-7 Ion Disruptor sniper rifle was a sniper rifle manufactured for the clone snipers of the Galactic Republic. It was commonly used by Green Company Marksmen during Clone Wars."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/iondisruptor.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/masita/viewmodels/base_rifle_animations.mdl"
SWEP.WorldModel = "models/weapons/synbf3/w_t21.mdl"
SWEP.ViewModelFOV = 66
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

-- Damage & Tracer
SWEP.Damage = 500
SWEP.DamageMin = 500
SWEP.Range = 1200000
SWEP.Penetration = 22

SWEP.DamageType = DMG_DISSOLVE --DMG_BULLET
SWEP.MuzzleVelocity = 500
SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue" --"pulsar_tracer"
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

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-3.05, -5, 0.5),
    Ang = Angle(1, -0.5, -3),
     Magnification = 2,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 2, 0)
SWEP.ActiveAng = Angle(1, -0.5, -5)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments
SWEP.DefaultElements = {"blaster", "muzzle"}
SWEP.AttachmentElements = {
    ["blaster"] = {
        VMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/ion_disruptor.mdl",
                Bone = "E11S_CONTR",
                ModelBodygroups = "0000000",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(0.1, 2, -9),
                    ang = Angle(0, -90, 0)
                }
            }
        },
    },
    ["muzzle"] = {
        VMElements = {
           {
               Model = "models/hunter/plates/plate.mdl",
               Bone = "E11S_CONTR",
               Scale = Vector(0, 0, 0),                
               Offset = {
                   pos = Vector(-3, 35, -6),
                   ang = Angle(-90, 180, 0)
               },
               IsMuzzleDevice = true
           }
        },
        WMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/ion_disruptor.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                ModelBodygroups = "0000000",
                Offset = {
                    pos = Vector(140, 10, 40),
                    ang = Angle(-15, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(430, 15, -150),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },              
        },
    }
}
WMOverride = "models/arccw/kraken/sops-v2/ion_disruptor.mdl"

SWEP.Attachments = {
    {
        PrintName = "Optic", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(0.8, -0.5, 2.5),
            vang = Angle(0, -90, 0),
            wpos = Vector(80, 18, -75),
            wang = Angle(-15, 0, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0)
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

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["fire"] = {
        Source = {"shoot"},
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1,
        SoundTable = {
            {
                s = "sops-v2/interaction/equip.wav",
                p = 100,
                v = 75,
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "sops-v2/interaction/equip2.wav",
                p = 100, 
                v = 75, 
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        LHIK = true,
        Mult = 1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 3.5,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_02.mp3", t = 10 / 60},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheat_reset_var_04.mp3", t = 120 / 60},
        },
    },
}