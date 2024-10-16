AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "T-7 Ion Disruptor"
SWEP.Trivia_Class = "Ion Disruptor"
SWEP.Trivia_Desc = "The T-7 ion disruptor rifle was a model of high-powered disruptor rifle designed to disable starships and take out multiple enemies at one time. The rifles would also have destructive effects when used on organic lifeforms. The rifles were responsible for the near-extinction of the Lasat species, and their destructive powers led the Imperial Senate to ban their use within the Galactic Empire. The rebel crew of the Ghost later stole a shipment of T-7 ion disruptors and destroyed them before they could fall into the hands of the Empire."
SWEP.IconOverride = "entities/sopsmisc/iondisruptor.png"

-- Viewmodel & Entity Properties
SWEP.HideViewmodel = false
SWEP.UseHands = true

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
SWEP.ShootEntity = "emp_throwed"
SWEP.MuzzleVelocity = 3400

SWEP.Jamming = true
SWEP.HeatGain = 1
SWEP.HeatCapacity = 2.5
SWEP.HeatDissipation = 2 -- rounds' worth of heat lost per second
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatDelayTime = 1.7
SWEP.HeatFix = true -- when the "fix" animation is played, all heat is restored.

SWEP.ChamberSize = 0 
SWEP.Primary.ClipSize = 6
SWEP.ExtendedClipSize = 8
SWEP.ReducedClipSize = 2

SWEP.Recoil = 1.87
SWEP.RecoilSide = 0.23
SWEP.RecoilRise = 0.78
SWEP.Delay = 60 / 102

SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = 2
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 200

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "RPG_Round"
SWEP.MagID = "rpg7"

SWEP.ShootVol = 125
SWEP.ShootPitch = 60
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/disruptor/disruptor_fire.mp3"
SWEP.ShootSound = "sops-v2/weapons/disruptor/disruptor_fire.mp3"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 250, 208)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-3.05, -5, 0.5),
    Ang = Angle(1, -0.5, -3),
     Magnification = 2,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
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
}WMOverride = "models/arccw/kraken/sops-v2/ion_disruptor.mdl"

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
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR", 
        Offset = {
            vpos = Vector(1.1, 18, 0.6),
            vang = Angle(0, -90, 90),
            wpos = Vector(220, 23, -89),
            wang = Angle(-15, 0, -90)
        },
    },  
    {
        PrintName = "Rocket", 
        DefaultAttName = "None",
        Slot = {"ammo_rocket"},
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "None"
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
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "E11S_CONTR",
        VMScale = Vector(0.7, 0.7, 0.7),
        WMScale = Vector(9, 9, 9),
        Offset = {
            vpos = Vector(1.7, -2, 2.05),
            vang = Angle(0, -90, 0),
            wpos = Vector(65, 28, -68),
            wang = Angle(-15, 0, 180)
        },
    },    
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
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_02.mp3", t = 10 / 60},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheat_reset_var_04.mp3", t = 120 / 60},
        },
    },
}