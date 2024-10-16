AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "'Dead Man's Revenge'"
SWEP.Trivia_Class = "Blaster Lever-Action Rifle"
SWEP.Trivia_Desc = "Galactic Lever-Action rifle. Unkown origin. 'Long, short, they all end the same way.'"
SWEP.IconOverride = "entities/sopsmisc/lever1.png"

SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_dead_mans_revenge.mdl"
SWEP.WorldModel = "models/tor/weapons/w_quadblaster.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = true
SWEP.WorldModelOffset = {
    pos = Vector(-12, 6, -5),
    ang = Angle(-10, 0, 180)
}

-- Special properties
SWEP.ShotgunReload = true
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 2

-- Damage & Entity Options
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 39
SWEP.DamageMin = 26
SWEP.RangeMin = 190
SWEP.Range = 450
SWEP.Penetration = 8
SWEP.DamageType = DMG_BULLET
SWEP.DamageTypeHandled = false

SWEP.MuzzleVelocity = 800

SWEP.TracerNum = 1
SWEP.TracerCol = Color(25, 125, 255)
SWEP.TracerWidth = 10
SWEP.PhysTracerProfile = "apex_bullet_energy"
SWEP.Tracer = "arccw_apex_tracer_energy_sniper"
SWEP.HullSize = 0.5
SWEP.ChamberSize = 1
SWEP.Primary.ClipSize = 14
SWEP.AmmoPerShot = 1

SWEP.Recoil = 1.23
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.76
SWEP.RecoilPunch = 1.28

SWEP.Delay = 60 / 102
SWEP.Num = 1 
SWEP.Firemode = 1
SWEP.Firemodes = {
    {
		Mode = 1,
    },
	{
		Mode = 0,
   	}
}

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 200
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "ar2" 
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "sops-v2/weapons/rifles/deadmansfire1.wav"
SWEP.ShootSound = "sops-v2/weapons/rifles/deadmansfire3.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false 

SWEP.MuzzleEffectAttachment = 1 
SWEP.CaseEffectAttachment = 2
SWEP.ProceduralViewBobAttachment = 1
SWEP.MuzzleFlashColor = Color(0, 0, 250)

SWEP.IronSightStruct = {
    Pos = Vector(-5.237, -10.469, 0),
    Ang = Angle(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"
SWEP.HoldtypeCustomize = "slam"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, -5, 0)
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
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle_retracted",
    },
	["fire"] = {
        Source = "shoot",
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shootiron",
        ShellEjectAt = 0,
    },
    ["sgreload_start"] = {
        Source = "start reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
                        {s = "sops-v2/weapons/rifles/deadmansreloadstart.wav", t = 0.1},
                    },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "insert",
        RestoreAmmo = 1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        SoundTable = {
                        {s = "sops-v2/weapons/rifles/deadmansreloadinsert.wav", t = 3/30},
                    },
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "finish reload",
        SoundTable = {
                        {s = "sops-v2/weapons/rifles/deadmansreloadend.wav", t = 0.01},
                    },
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },  
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "sops-v2/weapons/rifles/deadmansdraw.wav", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "sops-v2/weapons/rifles/deadmansdraw.wav", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
}