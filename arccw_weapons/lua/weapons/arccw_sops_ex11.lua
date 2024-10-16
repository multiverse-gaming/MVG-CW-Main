AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "EX-11"
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
    [HITGROUP_HEAD] = 2.3,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 33
SWEP.RangeMin = 98
SWEP.DamageMin = 24
SWEP.Range = 187
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_red"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 45

SWEP.Recoil = 0.65
SWEP.RecoilSide = 0.23
SWEP.RecoilRise = 0.56
SWEP.Delay = 60 / 457

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

SWEP.AccuracyMOA = 0.2
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 100

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/rx21.wav"
SWEP.ShootSound = "sops-v2/weapons/rx21.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

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
                Model = "models/arccw/kraken/sops-v2/prototype_blaster.mdl",
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
                Model = "models/arccw/kraken/sops-v2/prototype_blaster.mdl",
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
}WMOverride = "models/arccw/kraken/sops-v2/prototype_blaster.mdl"


SWEP.Attachments = {
    {
        PrintName = "Optic", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(-0.1, -3, 1.2),
            vang = Angle(0, -90, 0),
            wpos = Vector(30, 15.5, -47),
            wang = Angle(-15, 0, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0)
    },    
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.9, 0.9, 0.9),
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR", 
        Offset = {
            vpos = Vector(0.5, 7, 0.2),
            vang = Angle(0, -90, 90),
            wpos = Vector(140, 21, -64),
            wang = Angle(-15, 0, -90)
        },
    },
    {
        PrintName = "Foregrip",
        DefaultAttName = "None",
        Slot = "foregrip",
        WMScale = Vector(11, 11, 11),
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(-0.1, 1, -0.9),
            vang = Angle(0, -90, 0),
            wpos = Vector(100, 15.5, -40),
            wang = Angle(-15, 0, 180)
        },          
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        WMScale = Vector(11, 11, 11),
        VMScale = Vector(1, 1, 1),
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(-0.1, 10, 0.2),
            vang = Angle(0, -90, 0),
            wpos = Vector(193, 15.5, -78),
            wang = Angle(-15, 0, 180)
        },     
    },    
    {
        PrintName = "Ammunition",
        DefaultAttName = "Standard",
        Slot = {"ammo"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    },
    {
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "E11S_CONTR",
        VMScale = Vector(0.7, 0.7, 0.7),
        WMScale = Vector(11, 11, 11),
        Offset = {
            vpos = Vector(0.7, -10, 0.3),
            vang = Angle(0, -90, 0),
            wpos = Vector(-30, 24, -20),
            wang = Angle(-15, 0, 180)
        },
    },     
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        WMScale = Vector(11, 11, 11),
        VMScale = Vector(1, 1, 1),
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(0.7, -5, 0.3),
            vang = Angle(0, -90, 0),
            wpos = Vector(30, 28, -34),
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