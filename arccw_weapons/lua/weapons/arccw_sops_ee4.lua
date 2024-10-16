AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "EE-4"
SWEP.Trivia_Class = "Blaster Carabine"
SWEP.Trivia_Desc = "The EE-4 carbine, also known as the EE-4 blaster rifle, was a powerful medium-ranged blaster carbine model that was manufactured by BlasTech Industries during the reign of the Galactic Empire. Successor to the EE-3 carbine rifle, the EE-4's shorter and stubbier barrel allowed the blaster rifle to fire more effectively at close range with spread shots but at the cost of a reduced accuracy at range compared to its predecessor."
SWEP.IconOverride = "entities/sopsmisc/ee4.png"

SWEP.UseHands = true
SWEP.DefaultBodygroups  = "00111"
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_ee4.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/c_ee4.mdl"
SWEP.ViewModelFOV = 60
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-12, 6, -4),
    ang = Angle(-10, 0, 180),
    scale = 1.2,
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2.3,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 34
SWEP.RangeMin = 202
SWEP.DamageMin = 26
SWEP.Range = 401
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_red"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 55

SWEP.Recoil = 0.78
SWEP.RecoilSide = 0.23
SWEP.RecoilRise = 0.56
SWEP.Delay = 60 / 620

SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = -3
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

SWEP.FirstShootSound = "sops-v2/weapons/ee4.wav"
SWEP.ShootSound = "sops-v2/weapons/ee4.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

-- Ironsight Struct
SWEP.IronSightStruct = {
    Pos = Vector(-5.090, -8.242, 2.068),
    Ang = Angle(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
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
SWEP.Attachments = {
    {
        PrintName = "Opctic",
        DefaultAttName = "None", 
        Slot = "optic", 
        Bone = "ee4",
        VMScale = Vector(0.8, 0.8, 0.8),
        Offset = {
            vpos = Vector(-0.050, -2, -0.5),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },   
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "ee4",
        Offset = {
            vpos = Vector(0, -0.650, 12.4),
            vang = Angle(90, 0, -90),
        },
    },   
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.5, 0.5, 0.5),
        Bone = "ee4",
        Offset = {
            vpos = Vector(1.2, -0.8, 9),
            vang = Angle(90, 0, 0),
        },
    },        
    {
        PrintName = "Ammunition", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "ammo_masita"},
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
        Bone = "ee4",
        Offset = {
            vpos = Vector(0.8, -0.350, -0.425),
            vang = Angle(90, 0, -90),
        },
    },       
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "ee4",
        Offset = {
            vpos = Vector(0.650, -1.4, 0.750),
            vang = Angle(90, 0, -70),
        },
    },        
}

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
        Source = false,
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
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_02.mp3", t = 10 / 60},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheat_reset_var_04.mp3", t = 105 / 60},
        },
    },
}