AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 5

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "Wrecker's HH-12"
SWEP.Trivia_Class = "Rocket Launcher"
SWEP.Trivia_Desc = "The HH-12 rocket launcher was a model of black-colored missile launcher used by the Special Forces of the Alliance to Restore the Republic during the Galactic Civil War against the Galactic Empire. In the year 0 BBY, the Rogue One special forces unit brought HH-12s with them on their mission to steal the plans for the Empire's Death Star superweapon from the Citadel Tower on the planet Scarif. The former Guardians of the Whills, Baze Malbus, appropriated one of the launchers to use on an All Terrain Armored Cargo Transport attacking Alliance forces, but the weapon was not strong enough to penetrate the walker's armor."
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
SWEP.MuzzleVelocity = 12000

-- Damage & Tracer
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 1
SWEP.ExtendedClipSize = 1
SWEP.ReducedClipSize = 1

SWEP.Recoil = 2.21
SWEP.RecoilSide = 0.175
SWEP.RecoilRise = 2.3

SWEP.Delay = 60 / 102
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

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 500
SWEP.MoveDispersion = 125 
SWEP.Primary.Ammo = "RPG_Round"

-- Speed Mult
SWEP.SpeedMult = 0.7
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.3

-- Ammo, Sounds & MuzzleEffect
SWEP.ShootVol = 130
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2
SWEP.ShootSound = "sops-v2/weapons/hh12.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_green"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(85, 255, 0)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-11, -12, 3.5),
    Ang = Vector(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
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
                Model = "models/arccw/kraken/sops-v2/hh12.mdl",
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
                Model = "models/arccw/kraken/sops-v2/hh12.mdl",
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

SWEP.Attachments = {      
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(111, 111, 111),
        Bone = "base", 
        Offset = {
            vpos = Vector(3.5, 1.5, 16),
            vang = Angle(90, 0, 0),
            wpos = Vector(600, 550, -820),
            wang = Angle(0, 0, -90)
        },
    },   
    {
        PrintName = "Ammunition", 
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
        Bone = "base",
        Offset = {
            vpos = Vector(3.6, 0, 2.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(200, 535, -820),
            wang = Angle(0, 0, 180)
        },
    }, 
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle1"
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
        Time = 3.4, 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_04.mp3", t = 70/30},
        },
    },
}