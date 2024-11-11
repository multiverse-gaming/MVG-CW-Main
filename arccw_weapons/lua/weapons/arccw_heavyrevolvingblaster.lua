AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Trivia
SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = "Jota"
SWEP.PrintName = "Heavy Revolving Blaster"
SWEP.Trivia_Class = "Handheld Blaster"
SWEP.Trivia_Desc = "A sturdy and powerful single shot blaster"
SWEP.IconOverride = "entities/sopsmisc/thelastword.png"

SWEP.HideViewmodel = false
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_the_last_word_laconic.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = true
SWEP.WorldModelOffset = {
    pos = Vector(-19, 6, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.Damage = 75
SWEP.RangeMin = 150
SWEP.DamageMin = 75
SWEP.Range = 300
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.PhysTracerProfile = 1
SWEP.SpeedMult = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_yellow"
SWEP.TracerCol = Color(255, 255, 0)
SWEP.HullSize = 0.5
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 6
SWEP.AmmoPerShot = 1

SWEP.Recoil = 1.63
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.62

SWEP.ManualAction = false
SWEP.ReloadInSights = false

SWEP.Delay = 60 / 120
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
SWEP.HipDispersion = 200
SWEP.MoveDispersion = 50

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false 

SWEP.MuzzleEffectAttachment = 1 
SWEP.ProceduralViewBobAttachment = 1
SWEP.MuzzleFlashColor = Color(255, 255, 0)

-- Ammo & Stuff
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "sops-v2/weapons/revolvers.wav"
SWEP.ShootSound = "sops-v2/weapons/revolvers.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.IronSightStruct = {
    Pos = Vector(-5.373, -11.532, 1.552),
    Ang = Angle(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 60,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER

SWEP.ActivePos = Vector(-1, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, -20)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(10, -13, 0)
SWEP.CustomizeAng = Angle(12, 50.5, 45)
SWEP.DamageType = DMG_SHOCK

-- Attachments 
SWEP.Attachments = {
    {
        PrintName = "Energization",
        DefaultAttName = "Regular",
        Slot = { "WPRevEnergisation" },
    },
    {
        PrintName = "Inner Barrel",
        DefaultAttName = "Standard",
        Slot = { "WPRevBarrel" },
    },
    {
        PrintName = "Grip",
        DefaultAttName = "Standard",
        Slot = { "WPRevGrip" },
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = { "WPRevPerk", "PistolWhip" },
    },
    {
        PrintName = "Alternative Shot",
        DefaultAttName = "None",
        Slot = { "WPShot" },
    },
}


SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot"},
        Time = 0.9,
    },
    ["fire_iron"] = {
        ShellEjectAt = 0,
        Source = {"shoot"}
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        SoundTable = {
            {s = "sops-v2/weapons/revolver_reload.wav", t = 3 / 30},
        },
    },
}