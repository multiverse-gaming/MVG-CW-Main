AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "E-11s"
SWEP.Trivia_Class = "Blaster Sniper Rifle"
SWEP.Trivia_Desc = "Blastech's E-11 platform was considered to be one of the most successful blaster designs in history. It was no surprise that when the Galactic Empire wanted a dedicated sniper rifle, the company looked to its most successful design for inspiration. The E-11s used the same frame, but incorporated a composite alloy buttstock and the barrel was double the length than a regular E-11 medium blaster rifle. The elongated barrel featured the same perforated shroud and heat-abating fins the E-11 was known for. Unfortunately, heat management problems reduced the weapon's fire rate well below that of market competitors. The Empire deployed E-11s with scout troopers, infantry platoon sharpshooters and special forces snipers. Other than the Empire, Blastech sold E-11s to special law-enforcement units, planetary defense forces; and permitted bounty hunters and mercenaries. The prevalence of the weapon meant they found their way onto the black market usually through salvage from battlefields or hijacked factory shipments."
SWEP.IconOverride = "entities/sopsmisc/e11s.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/kraken/sops-v2/e11s_rifle.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/e11s_worldmodel.mdl"
SWEP.ViewModelFOV = 60
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-8, 3, -6),
    ang = Angle(-5, 0, -180),
    scale = 1.2,
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 146
SWEP.RangeMin = 627
SWEP.DamageMin = 101
SWEP.Range = 1210
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_red"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 18

SWEP.Recoil = 1.27
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

SWEP.AccuracyMOA = 0.2
SWEP.HipDispersion = 250
SWEP.MoveDispersion = 150

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/e11s.wav"
SWEP.ShootSound = "sops-v2/weapons/e11s.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-3.3, 0, 1.5),
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
SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "None", 
        Slot = "optic", 
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(0.1, -4, 1),
            vang = Angle(0, -90, 0),
        },
        CorrectiveAng = Angle(0, -180, 0),
        CorrectivePos = Vector(0, 0, -0.125),
    },    
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(0.1, 28, -0.3),
            vang = Angle(0, -90, 0),
        },
    },   
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(0.5, 17, -0.4),
            vang = Angle(90, -90, 0),
        },
    }, 
    {
        PrintName = "Foregrip",
        DefaultAttName = "None",
        Slot = "foregrip",
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(-0.1, 6, -1),
            vang = Angle(0, -90, 0),
        },          
    },       
    {
        PrintName = "Ammunition", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "ammo_masita", "ammo_stun"},
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
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
        Offset = {
            vpos = Vector(0.6, -0.65, 0),
            vang = Angle(0, -90, 0),
        },
    },       
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "E11S_CONTR",
        Offset = {
            vpos = Vector(0.9, 9, -0.3),
            vang = Angle(0, -90, 0),
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