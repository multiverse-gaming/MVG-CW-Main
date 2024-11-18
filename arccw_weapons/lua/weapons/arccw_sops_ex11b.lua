AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Trivia
SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = "Kraken"
SWEP.PrintName = "EX-11b"
SWEP.Trivia_Class = "Experimental Blaster SMG"
SWEP.Trivia_Desc = "Experimental SMG Blaster, short-range desired."
SWEP.IconOverride = "entities/sopsmisc/ex-11.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/masita/viewmodels/base_rifle_animations.mdl"
SWEP.WorldModel = "models/weapons/synbf3/w_t21.mdl"
SWEP.ViewModelFOV = 66
SWEP.UseHands = true
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
}

SWEP.Damage = 30
SWEP.RangeMin = 0
SWEP.DamageMin = 25
SWEP.Range = 200
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_blue"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 25

SWEP.Recoil = 1.35
SWEP.RecoilSide = 0.46
SWEP.RecoilRise = 0.22
SWEP.Delay = 60 / 500

SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 2
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 12.5
SWEP.HipDispersion = 400
SWEP.MoveDispersion = 200

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 60
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/rx21.wav"
SWEP.ShootSound = "sops-v2/weapons/rx21.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-3.35, 0, 1),
    Ang = Angle(1.5, -0.5, -3),
     Magnification = 2,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 5, 0)
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
                Model = "models/arccw/kraken/sops-v2/ex11b/ex11b.mdl",
                Bone = "E11S_CONTR",
                ModelBodygroups = "00000",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-2, -5.5, -8.4),
                    ang = Angle(0, 0,    0)
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
                   pos = Vector(-3, 10, -6),
                   ang = Angle(-90, 180, 0)
               },
               IsMuzzleDevice = true
           }
        },
        WMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/ex11b/ex11b.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                ModelBodygroups = "00000",
                Offset = {
                    pos = Vector(50, -5, 60),
                    ang = Angle(-15, -90, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(150, 15, -70),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },              
        },
    }
}
WMOverride = "models/arccw/kraken/sops-v2/ex11b/ex11b.mdl"


SWEP.Attachments = {
    {
        PrintName = "Optic", 
        DefaultAttName = "Standard", 
        Slot = { "extraoptic"},
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(-0.11, -3, 1.2),
            vang = Angle(0, -90, 0),
            wpos = Vector(30, 15.5, -47),
            wang = Angle(-15, 0, 180)
        },
        CorrectiveAng = Angle(1.8, 180, 0),
        CorrectivePos = Vector(0, 0, 0)
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