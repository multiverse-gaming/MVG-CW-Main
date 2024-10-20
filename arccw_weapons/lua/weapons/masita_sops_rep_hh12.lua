AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ ArcCW ] Special Forces Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "HH-12"
SWEP.Trivia_Class = "Rocket Launcher"
SWEP.Trivia_Desc = "The HH-12 rocket launcher was a model of black-colored missile launcher used by the Special Forces of the Alliance to Restore the Republic during the Galactic Civil War against the Galactic Empire. In the year 0 BBY, the Rogue One special forces unit brought HH-12s with them on their mission to steal the plans for the Empire's Death Star superweapon from the Citadel Tower on the planet Scarif. The former Guardians of the Whills, Baze Malbus, appropriated one of the launchers to use on an All Terrain Armored Cargo Transport attacking Alliance forces, but the weapon was not strong enough to penetrate the walker's armor."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "Rocket"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/hh12.png"

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

-- Grenade Launcher properties
SWEP.ShootEntity = "rocket_imp"
SWEP.MuzzleVelocity = 9000

-- Damage & Tracer
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 1
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 2.21
SWEP.RecoilSide = 0.175
SWEP.RecoilRise = 2.3

SWEP.Delay = 60 / 302
SWEP.Num = 1
SWEP.Firemode = 1
SWEP.Firemodes = {
    {
		Mode = 1,
        PrintName = "ROCKET",
    },
	{
		Mode = 0,
   	}
}

SWEP.AccuracyMOA = 1
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 125 
SWEP.SightsDispersion = 0 
SWEP.JumpDispersion = 200

SWEP.Primary.Ammo = "RPG_Round"

-- Speed Mult
SWEP.SpeedMult = 0.7
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.3

-- Ammo, Sounds & MuzzleEffect
SWEP.ShootVol = 130
SWEP.ShootPitch = 90
SWEP.ShootPitchVariation = 0.2
SWEP.ShootSound = "weapons/masita/rocketl/rl_fire1.wav", "weapons/masita/rocketl/rl_fire2.wav", "weapons/masita/rocketl/rl_fire3.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(85, 255, 0)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-11, -12, 3.5),
    Ang = Vector(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 60,
}

-- Holdtype
SWEP.HoldtypeHolstered = "rpg"
SWEP.HoldtypeActive = "rpg"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_RPG

SWEP.ActivePos = Vector(-7, -12, 4)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5.226, -2, 0)
SWEP.SprintAng = Angle(-18, 36, -13.5)

SWEP.CustomizePos = Vector(8, -4.8, -3)
SWEP.CustomizeAng = Angle(11.199, 38, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments
SWEP.DefaultElements = {"hh12", "muzzle"}
SWEP.AttachmentElements = {
    ["hh12"] = {
        VMElements = {
            {
                Model = "models/holo/hh12/hh12.mdl",
                Bone = "base",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(0.6, 2, 8),
                    ang = Angle(-90, -180, 90),
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
                Model = "models/holo/hh12/hh12.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(350, 200, -800),
                    ang = Angle(0, 0, 180)
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
        PrintName = "Rocket", 
        DefaultAttName = "None",
        Slot = {"ammo_rocket"},
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
        PrintName = "Charms",
        DefaultAttName = "None",
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(3.9, 1, -4),
            vang = Angle(90, 0, -90),
            wpos = Vector(850, 90, -370),
            wang = Angle(0, 0, 180)
        },
    }, 
    {
        PrintName = "Kill-Counter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(2.2, -0.5, -11.6),
            vang = Angle(90, 0, -90),
            wpos = Vector(850, 90, -370),
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
        Source = "fire",
    },
    ["fire_iron"] = {
        Source = "fire",
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