AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4 

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "DLT-23v"
SWEP.Trivia_Class = "Blaster Heavy Repeater"
SWEP.Trivia_Desc = "In need of a heavy weapon capable of destroying Rebel scum, Blastech Industries designed and created a portable destruction machine. The DLT-23v was born with a single objective: that nothing and no one who is the target remains alive."
SWEP.IconOverride = "entities/sopsmisc/dlt23v.png"

-- Viewmodel & Entity Properties
SWEP.HideViewmodel = false
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/dlt23v2.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/w_dlt23v_2.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-12, 3, -7),
    ang = Angle(-10, 0, 200)
}

-- Jamming
SWEP.Jamming = true
SWEP.HeatGain = 1
SWEP.HeatCapacity = 75 
SWEP.HeatDissipation = 2 
SWEP.HeatLockout = true 
SWEP.HeatDelayTime = 0.5

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 26
SWEP.RangeMin = 207
SWEP.DamageMin = 22
SWEP.Range = 402
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_red"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 150

SWEP.Recoil = 0.65
SWEP.RecoilSide = 0.23
SWEP.RecoilRise = 0.78
SWEP.Delay = 60 / 402

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
SWEP.HipDispersion = 200
SWEP.MoveDispersion = 100

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/dlt23v/dlt23v.wav"
SWEP.ShootSound = "sops-v2/weapons/dlt23v/dlt23v.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-2.573, -7.072, 0),
    Ang = Angle(0, 0, 25.809),
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


-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-2.573, -7.072, 0),
    Ang = Angle(0, 0, 25.809),
     Magnification = 1.2,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "smg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 3, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5.226, -0, -1)
SWEP.SprintAng = Angle(-19, 42, -22)

SWEP.HolsterPos = Vector(8, -4.8, -3)
SWEP.HolsterAng = Angle(11.199, 38, 0)

SWEP.Bipod_Integral = true 
SWEP.BipodDispersion = 1
SWEP.BipodRecoil = 1 

-- Attachments
SWEP.Attachments = {            
    {
        PrintName = "Energization", 
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
}


-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = false,
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
            {s = "weapons/bf3/dlt23v_reload6.wav", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_04.mp3", t = 2},
        },
    },
}