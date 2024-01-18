AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces - Republic Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "MD-12x"
SWEP.Trivia_Class = "Blaster-Experimental Shotgun"
SWEP.Trivia_Desc = "The MD-12x heavy shotgun, also known as MD-12 shotgun, was a heavy blaster shotgun wielded by the Clone Trooper 'Hunter' of the Grand Army of the Galactic Republic during the Clone Wars."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/md12.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
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
SWEP.RangeMin = 28
SWEP.DamageMin = 30
SWEP.Range = 119
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 7
SWEP.ExtendedClipSize = 9
SWEP.ReducedClipSize = 4

SWEP.Recoil = 2
SWEP.RecoilSide = 2

SWEP.Delay = 90 / 240
SWEP.Num = 5
SWEP.Firemodes = {
	{
		Mode = -2
	},
    {
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 50
SWEP.HipDispersion = 460
SWEP.MoveDispersion = 100

-- Speed Mult
SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.3

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 120
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "weapons/x8/x8_fire_2.ogg"
SWEP.ShootSound = "weapons/x8/x8_fire_2.ogg"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-3.950, 0, -3.5),
    Ang = Angle(0,0,0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 6.5, -3)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -4, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(12, 2, -9)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, -4)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments
SWEP.DefaultElements = {"md12", "muzzle"}
SWEP.AttachmentElements = {
    ["md12"] = {
        VMElements = {
            {
                Model = "models/holo/md12/md12.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1.2, 1.1, 1.2),
                Offset = {
                    pos = Vector(-0.8, -5, 3.8),
                    ang = Angle(0,-90, 0)
                }
            }
        }
    },
    ["muzzle"] = {
         VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "dlt19_sight",
                Scale = Vector(0, 0, 0),                
                Offset = {
                    pos = Vector(-0.5, 4, 14),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/holo/md12/md12.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(400, 100, -300),
                    ang = Angle(-20, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(2100, 0, -600),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        },
    }
}
WMOverride = "models/holo/md12/md12.mdl"

--[[SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "None", 
        Slot = "optic", 
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(-0.8, -4.3, -6),
            vang = Angle(90, 0, -90),
            wpos = Vector(670, 140, -790),
            wang = Angle(-20, 0, 180)
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },  
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },     
    {
        PrintName = "Internal-Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        NoVM = true,
        NoWM = true,
    },   
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(1, 2, 6),
            vang = Angle(90, 0, 0),
            wpos = Vector(1700, 440, -700),
            wang = Angle(-20, 0, 90)
        },
    },      
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"ammo", "ammo_masita", "ammo_stun"},
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
        PrintName = "Charms/Killcounter",
        DefaultAttName = "None",
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0.9, -2, -7.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(600, 300, -530),
            wang = Angle(-20, 0, 180)
        },
    },          
}--]]

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["fire_iron"] = {
        Source = "fire_iron"
    },
    ["draw"] = {
        SoundTable = {
            {
                s = "weapons/blades/deploy.mp3",
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
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 80/30},
        },
    },
}