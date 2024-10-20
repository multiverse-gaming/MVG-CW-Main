AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ ArcCW ] Special Forces Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "Z-6 Chaingun"
SWEP.Trivia_Class = "Blaster Heavy Canon"
SWEP.Trivia_Desc = "Available only to the Clone Commander class of the Republic, or the Rail ARC Troopers of Kamino, the Chaingun is a large shoulder-worn weapon, which is particularly effective, and indeed intended for attacking infantry, especially droids."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/z6chain.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV = 55
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Damage & Tracer
SWEP.Damage = 30
SWEP.RangeMin = 210
SWEP.DamageMin = 30
SWEP.Range = 329
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5
SWEP.PhysTracerProfile = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 250
SWEP.Recoil = 0.65
SWEP.RecoilSide = 0.24
SWEP.RecoilRise = 0.34
SWEP.RecoilPunch = 1.1
SWEP.RecoilVMShake = 1.3
SWEP.Delay = 60 / 200
SWEP.TriggerDelay = true
SWEP.Num = 1
SWEP.BobMult = 2

SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 2,
        Mult_RPM = 2800 / 2400,
        PrintName = "2800RPM"
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 0.56
SWEP.HipDispersion = 443
SWEP.MoveDispersion = 50

-- Speed Mult
SWEP.SpeedMult = 0.7
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.3

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 150
SWEP.ShootPitch = 98
SWEP.ShootPitchVariation = 0.04
SWEP.FirstShootSound = "everfall/weapons/z6/blasters_z6rotaryblaster_laser_close_var_06.mp3"                      
SWEP.ShootSound = "everfall/weapons/z6/fire/blasters_z6rotaryblaster_laser_close_var_08.mp3"
SWEP.DistantShootSound = "everfall/weapons/z6/blasters_z6rotaryblaster_laser_close_var_06.mp3"              

SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-11, -12, 3.5),
    Ang = Vector(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a45.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a47.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-7, -12, 4)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5.226, -2, 0)
SWEP.SprintAng = Angle(-18, 36, -13.5)

SWEP.CustomizePos = Vector(8, -4.8, -3)
SWEP.CustomizeAng = Angle(11.199, 38, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.Jamming = true
SWEP.HeatGain = 0.95 
SWEP.HeatCapacity = 100
SWEP.HeatDissipation = 10
SWEP.HeatLockout = true
SWEP.HeatDelayTime = 0.5

-- Attachments
SWEP.DefaultElements = {"chain", "muzzle"}
SWEP.AttachmentElements = {
    ["chain"] = {
        VMElements = {
            {
                Model = "models/tor/weapons/chaingun_base.mdl",
                Bone = "base",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-1, 4, 13.5),
                    ang = Angle(0, -180, 90),
                }
            }
        }
    },
    ["muzzle"] = {
         VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "base",
                Scale = Vector(0, 0, 0),                
                Offset = {
                    pos = Vector(-3, 0, 13),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/tor/weapons/chaingun_base.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(900, 0, -320),
                    ang = Angle(0, 90, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(2000, 0, -650),
                    ang = Angle(0, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        },
    }
}

--[[SWEP.Attachments = {    
    {
        PrintName = "Energization", 
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
        Bone = "base",
        VMScale = Vector(0.7, 0.7, 0.7),
        WMScale = Vector(111, 111, 111),
        Offset = {   
            vpos = Vector(2.7, 1, 8),
            vang = Angle(90, 0, -90),
            wpos = Vector(450, 345, -575),
            wang = Angle(0, 0, 180)
        },
    },    
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "base",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(2.9, 2, 4),
            vang = Angle(90, 0, -90),
            wpos = Vector(0, 395, -450),
            wang = Angle(0, 0, 180)
        },
    },    
}--]]

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle1"
    },
    ["trigger"] = {
        Source = "fire",
        SoundTable = {
            {s = "masita/weapons/z6/start/blasters_z6rotaryblaster_gunner_start_var_03.mp3", t = 0.1/30},
        },
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
                s = "armasclasicas/wpn_empire_lgequip.wav",
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
                s = "armasclasicas/wpn_empire_medequip.wav",
                p = 100,
                v = 75,
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload",
        Time = 3.4, 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 70/30},
        },
    },
}

SWEP.Hook_ModifyRPM = function(wep, delay)
    return delay / Lerp(wep:GetBurstCount() / 15, 1, 3)
end