AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "EMP Anti-Vehicle"
SWEP.Trivia_Desc = "The electromagnetic pulse (EMP) launcher was a devastating weapon when used against the battle droid forces of the Confederacy of Independent Systems as they were able to both deactivate droids by shorting out electronics and destroy their interior circuitry with powerful EMP waves. Clone jet troopers used these as their primary weapon."
SWEP.IconOverride = "entities/sopsmisc/emprifle.png"

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
SWEP.ShootEntity = "ion_throwed"
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
SWEP.ShootPitch = 70
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/emp/emp.mp3"
SWEP.ShootSound = "sops-v2/weapons/emp/emp.mp3"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_orange"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 142, 0)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-3.05, -3, -1),
    Ang = Angle(1, -0.5, -3),
     Magnification = 2,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

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
                Model = "models/arccw/kraken/sops-v2/emp_rifle.mdl",
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
                   pos = Vector(-3, 20, -6),
                   ang = Angle(-90, 180, 0)
               },
               IsMuzzleDevice = true
           }
        },
        WMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/emp_rifle.mdl",
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
}WMOverride = "models/arccw/kraken/sops-v2/emp_rifle.mdl"

SWEP.Attachments = {     
    {
        PrintName = "Optic", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(0.2, -0.5, 3),
            vang = Angle(0, -90, 0),
            wpos = Vector(80, 11.5, -78),
            wang = Angle(-15, 0, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, -0)
    },  
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR", 
        Offset = {
            vpos = Vector(1.1, 18, 1.5),
            vang = Angle(0, -90, 90),
            wpos = Vector(220, 23, -105),
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
            vpos = Vector(1.8, -8.3, 1.2),
            vang = Angle(0, -90, 0),
            wpos = Vector(60, 30, -54),
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