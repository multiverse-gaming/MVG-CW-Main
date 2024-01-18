AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces - Explosives"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "T-7"
SWEP.Trivia_Class = "Ion Disruptor"
SWEP.Trivia_Desc = "The T-7 ion disruptor rifle was a model of high-powered disruptor rifle designed to disable starships and take out multiple enemies at one time. The rifles would also have destructive effects when used on organic lifeforms. The rifles were responsible for the near-extinction of the Lasat species, and their destructive powers led the Imperial Senate to ban their use within the Galactic Empire. The rebel crew of the Ghost later stole a shipment of T-7 ion disruptors and destroyed them before they could fall into the hands of the Empire."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "Rocket"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/iondisruptor.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Grenade Launcher properties
SWEP.ShootEntity = "ion_nade"
SWEP.MuzzleVelocity = 3400

SWEP.Jamming = true
SWEP.HeatGain = 4
SWEP.HeatCapacity = 4
SWEP.HeatDissipation = 2 -- rounds' worth of heat lost per second
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatDelayTime = 3
SWEP.HeatFix = true -- when the "fix" animation is played, all heat is restored.

SWEP.InfiniteAmmo = true
SWEP.BottomlessClip = true

-- Damage & Tracer
SWEP.ChamberSize = 0 
SWEP.Primary.ClipSize = 4
SWEP.ExtendedClipSize = 6
SWEP.ReducedClipSize = 2

SWEP.Recoil = 2.8
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 1.5
SWEP.RecoilPunch = 6

SWEP.Delay = 60 / 80
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 8 
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "RPG_Round"
SWEP.MagID = "rpg7"

-- Speed Mult
SWEP.SightTime = 0.35
SWEP.SpeedMult = 0.875
SWEP.SightedSpeedMult = 0.75

SWEP.Jamming = true
SWEP.HeatGain = 4
SWEP.HeatCapacity = 4
SWEP.HeatDissipation = 2 -- rounds' worth of heat lost per second
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatDelayTime = 3
SWEP.HeatFix = true -- when the "fix" animation is played, all heat is restored.

SWEP.InfiniteAmmo = true
SWEP.BottomlessClip = true

-- Ammo, Sounds & MuzzleEffect
SWEP.ShootVol = 130
SWEP.ShootPitch = 90
SWEP.ShootPitchVariation = 0.2
SWEP.ShootSound = "masita/weapons/ion_disruptor/addon/blaster_iondisruptor_laser_addon_close_var_08.mp3"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-2.9, 5, -0.5),
    Ang = Vector(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 60,
}

-- Holdtype
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "rpg"
SWEP.HoldtypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(1, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -4, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(8, 4.8, -3)
SWEP.CustomizeAng = Angle(11.199, 38, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.ExtraSightDist = 8

-- Attachments
SWEP.DefaultElements = {"ion", "muzzle"}
SWEP.AttachmentElements = {
    ["ion"] = {
        VMElements = {
            {
                Model = "models/sw_battlefront/weapons/ion_disruptor.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(0.7, 6, -5),
                    ang = Angle(0, -90, 0)
                }
            }
        }
    },
    ["muzzle"] = {
        WMElements = {
            {
                Model = "models/sw_battlefront/weapons/ion_disruptor.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(1200, 100, 300),
                    ang = Angle(-12, 0, 180),
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(2800, 0, -600),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        },
    }
}
WMOverride = "models/sw_battlefront/weapons/ion_disruptor.mdl"

//SWEP.Attachments = {         
//}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire",
        SoundTable = {
            {s = "armas3/gl_fire_1.wav", t = 0.1/30},
        },
    },
    ["fire_iron"] = {
        Source = "fire_iron",
        SoundTable = {
            {s = "armas3/gl_fire_1.wav", t = 0.1/30},
        },
    },
    ["draw"] = {
        SoundTable = {
            {
                s = "armasclasicas/wpn_empire_lgequip.wav",
                p = 100, 
                v = 75,
                t = 0, 
                c = CHAN_ITEM,
            },
        }
    },
    ["holster"] = {
        SoundTable = {
            {
                s = "armasclasicas/wpn_empire_medequip.wav",
                p = 100,
                v = 75,
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
}