AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DC-19"
SWEP.Trivia_Class = "Blaster Stealth Carabine"
SWEP.Trivia_Desc = "The DC-19 'Stealth' carbine was a blaster carbine in BlasTech Industries' DC-15 blaster line. The DC-19 was equipped with a sound suppressor unit for silent operations and an optional stealth function, which used a refined tibanna gas mixture that made the DC-19's plasma bolts invisible to the naked eye. However, the tibanna mixture was highly expensive, had to be reloaded after ten shots, and needed to be cooled down after each shot to prevent damage to the carbine's dampeners. The DC-19 was used almost exclusively by clone shadow troopers in the Grand Army of the Republic during the Clone Wars and for a short time afterward, when the clone shadow troopers became part of the Imperial Army."
SWEP.IconOverride = "entities/sopsmisc/dc19.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = false

SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_dc19.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/w_dc19.mdl"
SWEP.ViewModelFOV = 58
SWEP.WorldModelOffset = {
    pos = Vector(-9, 3.5, -4.5),
    ang = Angle(-10, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.6,
    [HITGROUP_CHEST] = 1.2,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 56
SWEP.RangeMin = 202
SWEP.DamageMin = 28
SWEP.Range = 402
SWEP.Penetration = 10
SWEP.DamageType = DMG_BULLET

SWEP.MuzzleVelocity = 900

SWEP.AlwaysPhysBullet = true
SWEP.PhysTracerProfile = 0
SWEP.PhysBulletDontInheritPlayerVelocity = true

SWEP.PhysTracerProfile = 1

SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 50

SWEP.Recoil = 0.89
SWEP.RecoilSide = 0.34
SWEP.RecoilRise = 0.53
SWEP.Delay = 60 / 255

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

SWEP.AccuracyMOA = 0.1
SWEP.HipDispersion = 250
SWEP.MoveDispersion = 60

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/dc19.wav"
SWEP.ShootSound = "sops-v2/weapons/dc19.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = nil

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-2.837, 0.619, 1.656),
    Ang = Angle(0, 0, 0),
     Magnification = 1.3,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(0, 2, 2)
SWEP.ActiveAng = Angle(0, 0, 0)

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
        DefaultAttName = "Standard", 
        Slot = "optic",
        Bone = "DC15",
        Offset = {
            vpos = Vector(0, -1.6, -0.5),
            vang = Angle(90, 0, -90),
        },
    },    
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "DC15", 
        Offset = {
            vpos = Vector(0.8, -0.5, 10),
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "DC15",
        Offset = {
            vpos = Vector(0.1, -0.442, 11.638),
            vang = Angle(90, 0, -90),

        },
    },    
    {
        PrintName = "Ammo",
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
        Bone = "DC15",
        VMScale = Vector(0.7, 0.7, 0.7),
        Offset = {
            vpos = Vector(0.9, -0.7, 5.7),
            vang = Angle(90, 0, -90),
        },
    },     
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "DC15",
        Offset = {
            vpos = Vector(0.8, -0.2, -5),
            vang = Angle(90, 0, -90),
        },
    },      
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "neutral",
    },
    ["fire"] = {
        Source = "fire"
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.4,
        SoundTable = {
            {
                s = "w/dc15s/overheat_manualcooling_resetfoley_generic_var_01.mp3",
                p = 100,
                v = 75,
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "w/dc15s/gunfoley_blaster_sheathe_var_03.mp3",
                p = 100, 
                v = 75, 
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "dc15s_1", t = 1.68 / 60},
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 0.1},
        },
    },

sound.Add({
    name =          "dc15s_1",
    channel =       CHAN_ITEM,
    volume =        1.5,
    sound =             "armasclasicas/wpn_empire_medreload.wav"
    }),

}