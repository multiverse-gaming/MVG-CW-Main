AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "A-180"
SWEP.Trivia_Class = "Blaster Pistol"
SWEP.Trivia_Desc = "The A-180 blaster, also known as the A180 pistol, was a modular blaster manufactured by BlasTech Industries. It was a highly versatile design with multiple configurations that could be easily reconfigured from a blaster pistol to a blaster rifle, a sniper rifle/longblaster, or an portable ion launcher depending on the situation."
SWEP.IconOverride = "entities/sopsmisc/a180.png"

-- Viewmodel properties
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_a180.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/w_a180.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-15, 7.5, -5),
    ang = Angle(-10, 0, 180)
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1.3,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 36
SWEP.RangeMin = 102
SWEP.DamageMin = 23
SWEP.Range = 306
SWEP.Penetration = 8
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_red"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 20

SWEP.Recoil = 0.64
SWEP.RecoilSide = 0.12
SWEP.RecoilRise = 0.65
SWEP.Delay = 60 / 302

SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 150
SWEP.MoveDispersion = 100

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/a180.wav"
SWEP.ShootSound = "sops-v2/weapons/a180.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-6.126, -4.178, 3.4),
    Ang = Angle(0, 0, 0),
     Magnification = 1.3,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.SprintPos = Vector(1, -6, -5)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.ActivePos = Vector(-2, 3, 3)
SWEP.ActiveAng = Angle(1, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-4.633, 36.881, 0)

SWEP.CustomizePos = Vector(8, 0, 3)
SWEP.CustomizeAng = Angle(5, 30, 30)

-- Attachments
SWEP.AttachmentElements = {
    ["a180_barrele"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        AttPosMods = {
            [2] = {
                vpos = Vector(0.3, -0.5, 11),
            },
        }
    },
    ["a180_grip"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
}
SWEP.Attachments = {   
    {
        PrintName = "Optic",
        DefaultAttName = "None",
        Slot = "optic",
        Bone = "a180",
        Offset = {
            vpos = Vector(0.3, -1, 0),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, -0.025),
    },  
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "a180",
        Offset = {
            vpos = Vector(0.3, -0.5, 9),
            vang = Angle(90, 0, 0),

        },
    },  
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.8, 0.8, 0.8),
        Bone = "a180",
        Offset = {
            vpos = Vector(0.5, -0.5, 5),
            vang = Angle(90, 0, 0),
        },
    },  
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Barrel",
        DefaultAttName = "None",
        Slot = "a180_barrele",
    },    
    {
        PrintName = "Grip",
        DefaultAttName = "None",
        Slot = "a180_grip",

    },  
    {
        PrintName = "Ammunition", 
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
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "a180",
        VMScale = Vector(0.6, 0.6, 0.6),
        Offset = {
            vpos = Vector(1, -0.9, -1.4),
            vang = Angle(90, 0, -90),
        },
    },       
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "a180",
        Offset = {
            vpos = Vector(0.9, -0.5, 1),
            vang = Angle(90, 0, -90),
        },
    },     
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "shoot",
    },
    ["draw"] = {
        Source = "draw",
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_04.mp3", t = 1.20},
        },
    },
}