AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

-- Trivia
SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = "Kraken"
SWEP.PrintName = "TL-50 Mod 1"
SWEP.Trivia_Class = "Blaster Heavy Repeater"
SWEP.Trivia_Desc = "The TL-50 Heavy Repeater was a model of heavy repeating blaster rifle that was manufactured for the special forces of the Galactic Empire. In addition to sending storms of blaster bolts from its multiple barrels, the rifle could gather its energy into a powerful concussion blast. It could also be modified with an extended barrel for reduced spread and with a power cell for increased cooling power. During the Galactic Civil War against the Rebel Alliance, Commander Iden Versio of the Empire's elite Inferno Squad carried a TL-50 Heavy Repeater."
SWEP.IconOverride = "entities/sopsmisc/tl50.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_tl-50.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/w_tl-50.mdl"
SWEP.ViewModelFOV = 55
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-22, 10, -6),
    ang = Angle(-10, 0, 180)
}

-- Damage & Tracer
SWEP.Damage = 25
SWEP.RangeMin = 35
SWEP.DamageMin = 15
SWEP.Range = 45
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 55
SWEP.ExtendedClipSize = 75
SWEP.ReducedClipSize = 30

SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tfa_tracer_purple"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 0.5

SWEP.Recoil = 0.29
SWEP.RecoilSide = 0.35
SWEP.RecoilRise = 0.22

SWEP.Delay = 60 / 850
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

SWEP.AccuracyMOA = 15 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

-- Speed Mult
SWEP.SpeedMult = 1

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/tl50.wav"
SWEP.ShootSound = "sops-v2/weapons/tl50.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-9.122, -19.1, 2.43),
    Ang = Angle(0, 0, 0),
     Magnification = 1.2,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-4, -7, 2)
SWEP.ActiveAng = Angle(1, -0.5, -5)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, -10, 0)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments
SWEP.Attachments = {   
    {
        PrintName = "Optic",
        DefaultAttName = "None",
        Slot = "extraoptic",
        Bone = "TL-50",
        Offset = {
            vpos = Vector(-0.1, -5, -2.7),
            vang = Angle(0, 90, 180),
        },
        CorrectiveAng = Angle(0, -180, 0),
        CorrectivePos = Vector(0, 0, 0),
    }, 
    {
        PrintName = "Blaster Frame",
        DefaultAttName = "Factory Frame",
        Slot = "tl50_frame",
        Bone = "TL-50",
        Offset = {
            vpos = Vector(-0.1, -10, -1),
            vang = Angle(0, 90, -180),
        },
    },
	{
		PrintName = "Underbarrel",
		DefaultAttName = "None",
		Slot = "tl50_ubgl"
	}
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
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
        Time = 3,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 5 / 30},
            {s = "weapon_hand/reload_gentle/mag_eject/023d-00001014.mp3", t = 10 / 30},
            {s = "weapon_hand/reload_gentle/mag_load/023d-00000dda.mp3", t = 65 / 30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_04.mp3", t = 90 / 30},
        },
    },
}