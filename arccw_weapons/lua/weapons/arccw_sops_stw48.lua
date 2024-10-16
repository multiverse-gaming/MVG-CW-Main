AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "ST-W48"
SWEP.Trivia_Class = "Blaster Carabine"
SWEP.Trivia_Desc = "This is the ST-W48. The weapon could be used in a blaster rifle configuration or a blaster carbine configuration where the stock was removed for use in confined spaces. Each ST-W48 had a quarrel-bolt launcher installed below its barrel that used enhanced bowcaster technology for a powerful explosive attack. The rifle's power cell cartridge was located around the mid-point of the weapon's length, above the trigger. The weapon had an auto fire mode that provided a high rate of fire."
SWEP.IconOverride = "entities/sopsmisc/stw48.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_stw48.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/w_stw48.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-11, 4, -3.3),
    ang = Angle(-10, 0, -180),
    scale = 1.2,
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 31
SWEP.DamageMin = 22
SWEP.Range = 382
SWEP.RangeMin = 202
SWEP.Penetration = 1

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 45
SWEP.ExtendedClipSize = 50
SWEP.ReducedClipSize = 25

SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TracerNum = 1
SWEP.Tracer = "tracer_red"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.HullSize = 0.5

SWEP.Recoil = 0.68
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.62

SWEP.Delay = 60 / 387
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

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 200
SWEP.MoveDispersion = 150

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 110 
SWEP.ShootPitch = 120 
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "sops-v2/weapons/stw48.wav"
SWEP.ShootSound = "sops-v2/weapons/stw48.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-3.227, -1.923, 1),
    Ang = Angle(0,-0.7, 5),
     Magnification = 1.2,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

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
        Bone = "stw48",
        VMScale = Vector(0.8, 0.8, 0.8),
        Offset = {
            vpos = Vector(-0.250, -2, 2),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },      
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "stw48",
        VMScale = Vector(1, 1, 1),
        Offset = {
            vpos = Vector(-0.250, -1, 10.3),
            vang = Angle(90, 0, -90),
        },
    },   
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.8, 0.8, 0.8),
        Bone = "stw48",
        Offset = {
            vpos = Vector(0.8, -1, 6),
            vang = Angle(90, 0, 0),
        },
    },        
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "ammo_masita", "ammo_stun", "stw48_nade"},
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
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    }, 
    {
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "stw48",
        Offset = {
            vpos = Vector(0.6, -1.0, -0.425),
            vang = Angle(90, 0, -90),
        },
    },       
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "stw48",
        Offset = {
            vpos = Vector(0.3, -2, -2),
            vang = Angle(90, 0, -70),
        },
    },        
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "neutral"
    },
    ["fire"] = {
        Source = "fire",
    },
    ["fire_iron"] = {
        Source = false,
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 5 / 30},
            {s = "weapon_hand/reload_gentle/mag_eject/023d-00001014.mp3", t = 5 / 30},
            {s = "weapon_hand/reload_gentle/mag_load/023d-00000dda.mp3", t = 30 / 30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_04.mp3", t = 35 / 30},
        },
    },
}