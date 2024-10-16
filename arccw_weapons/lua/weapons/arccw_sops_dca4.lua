AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "DC-A4"
SWEP.Trivia_Class = "Blaster-Experimental Rifle"
SWEP.Trivia_Desc = "An ancient instrument of war, renewed and enhanced by BlasTech Industries."
SWEP.IconOverride = "entities/sopsmisc/dc16a4.png"

SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_khvostov7g0x.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = false
SWEP.NoHideLeftHandInCustomization = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Special properties
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.4

-- Damage & Entity Options
SWEP.Damage = 45
SWEP.DamageMin = 25
SWEP.RangeMin = 239
SWEP.Range = 540
SWEP.DamageType = DMG_BULLET
SWEP.Penetration = 1
SWEP.MuzzleVelocity = 800

SWEP.TracerNum = 1
SWEP.TracerCol = Color(25, 125, 255)
SWEP.TracerWidth = 10
SWEP.PhysTracerProfile = "apex_bullet_energy"
SWEP.Tracer = "arccw_apex_tracer_energy_sniper"
SWEP.HullSize = 0.5
SWEP.Num = 1 

SWEP.AmmoPerShot = 1
SWEP.ChamberSize = 1
SWEP.Primary.ClipSize = 40
SWEP.ExtendedClipSize = 60
SWEP.ReducedClipSize = 30

SWEP.Recoil = 0.68
SWEP.RecoilRise = 0.73
SWEP.RecoilSide = 0.32

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 250
SWEP.MoveDispersion = 100

SWEP.Delay = 60 / 402
SWEP.Firemode = 1
SWEP.Firemodes = {
    {
		Mode = 1,
    },
    {
		Mode = 2,
    },
	{
		Mode = 0,
   	}
}

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.40

SWEP.Primary.Ammo = "ar2" 
SWEP.ShootVol = 125
SWEP.ShootPitch = 90
SWEP.ShootPitchVariation = 0.2
SWEP.FirstShootSound = "sops-v2/weapons/dca4/kvfire1.wav"
SWEP.ShootSound = "sops-v2/weapons/dca4/kvfire2.wav", "sops-v2/weapons/dca4/kvfire3.wav", "sops-v2/weapons/dca4/kvfire4.wav", "sops-v2/weapons/dca4/kvfire5.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false 

SWEP.CaseEffectAttachment = 2
SWEP.MuzzleEffectAttachment = 1 
SWEP.MuzzleFlashColor = Color(0, 0, 250)

SWEP.IronSightStruct = {
    Pos = Vector(-6.244, -9.494, 1.947),
    Ang = Angle(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-2, 0, 0)
SWEP.ActiveAng = Angle(1, -0.5, -5)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments
SWEP.DefaultElements = {"dca4"}
SWEP.AttachmentElements = {
    ["dca4"] = {
        WMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/c_khvostov7g0x.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                ModelSkin = 1,
                Offset = {
                    pos = Vector(-1650, 800, -450),
                    ang = Angle(-10, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(3200, 200, -800),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, 
    }
}WMOverride = "models/arccw/kraken/sops-v2/c_khvostov7g0x.mdl"


SWEP.Attachments = {    
    {
        PrintName = "Sight",
        DefaultAttName = "None",
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "WeaponBone",
        Offset = {
            vpos = Vector(0, -6, 1.8),
            vang = Angle(0, 90, 180),
            wpos = Vector(600, 100, -535),
            wang = Angle(-10, -0.50, 180)
        },
        CorrectiveAng = Angle(0, -180, 0),
        CorrectivePos = Vector(0, 0, -0),
    },    
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "WeaponBone",
        WMScale = Vector(111, 111, 111),
        VMScale = Vector(1.3,1.3,1.3),
        Offset = {
            vpos = Vector(0.1, -30, 3),
            vang = Angle(0, 90, 180),
            wpos = Vector(3520, 100, -908),
            wang = Angle(-10, -1, 180)
        },
    },    
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "ammo_masita"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = {"perk", "mw3_pro"},
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"uc_fg"},
    },      
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        WMScale = Vector(111, 111, 111),
        Bone = "WeaponBone",
        Offset = {
            vpos = Vector(0.5, -4, 4.5),
            vang = Angle(90, 90, -90),
            wpos = Vector(500, 145, -200),
            wang = Angle(-10, 0, 180)
        },
    },     
    {
        PrintName = "Charms",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "WeaponBone",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(0.9, -7.5, 7.5),
            vang = Angle(90, 90, -90),
            wpos = Vector(1100, 210, -0),
            wang = Angle(-10, 0, 180)
        },
    },   
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "shoot1",
        ShellEjectAt = 0.1,
    },
    ["fire_iron"] = {
        Source = "shoot1",
        ShellEjectAt = 0.1,
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
                s = "sops-v2/interaction/equip1.wav",
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
            {s = "sops-v2/weapons/dca4/kvreload.wav", t = 0.1 },
        },
    },
}