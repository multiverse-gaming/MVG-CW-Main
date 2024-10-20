AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ ArcCW ] Special Forces Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "X-11(Echo)"
SWEP.Trivia_Class = "Blaster-Experimental Pistol"
SWEP.Trivia_Desc = "The X-11 hand blaster, also known as X-11 blaster pistol, was a heavy blaster pistol wielded by the Clone Trooper 'Echo' of the Grand Army of the Galactic Republic during the Clone Wars."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/x11.png"

SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/bf2017/c_scoutblaster.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Damage & Entity options
SWEP.Damage = 30
SWEP.RangeMin = 102
SWEP.DamageMin = 30
SWEP.Range = 2000000
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 35

SWEP.Recoil = 0.34
SWEP.RecoilPunch = 1.4
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.17

SWEP.Delay = 60 / 550
SWEP.Num = 1
SWEP.Firemodes = {
    {
		Mode = 2
	},
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 17.2
SWEP.HipDispersion = 320 
SWEP.MoveDispersion = 50

-- Mobility when weapon is out
SWEP.SpeedMult = 1

SWEP.ShootWhileSprint = true
SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ammo & Stuff
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "armas3/x8_2.wav"
SWEP.ShootSound = "armas3/x8_4.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-3.940, -6.071, 1.2),
    Ang = Vector(0, 0, -2.5),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 60,
}

SWEP.HoldtypeHolstered = "idle"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(1, -6, -20)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(1, 0, 1)
SWEP.HolsterAng = Angle(-10, 12, 0)

SWEP.CustomizePos = Vector(25, -5, -1.08)
SWEP.CustomizeAng = Angle(6.8, 37.7, 10.3)

-- Attachments 
SWEP.DefaultElements = {"x11", "muzzle"}
SWEP.AttachmentElements = {
    ["x11"] = {
        VMElements = {
            {
                Model = "models/holo/x11/holo_x11.mdl",
                Bone = "v_scoutblaster_reference001",
                Scale = Vector(1,1,1),
                Offset = {
                    pos = Vector(-0.15, -0.5, 0),
                    ang = Angle(0.5, 88.9, 0)
                }
            }
        }
    },
    ["muzzle"] = {
         VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "v_scoutblaster_reference001",
                Scale = Vector(0, 0, 0),                
                Offset = {
                    pos = Vector(2, -8, -3),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/holo/x11/holo_x11.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(350, 150, -150),
                    ang = Angle(-10, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(4000, 0, -2100),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, 
    }
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Energization",
        DefaultAttName = "No Attachment",
        Slot = "dc17m_energization",
    },
    [2] = {
        PrintName = "Perks",
        DefaultAttName = "No Attachment",
        Slot = "dc17m_perk",
    },
}

WMOverride = "models/holo/x11/holo_x11.mdl"

--[[SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "None", 
        Slot = "optic", 
        WMScale = Vector(111, 111, 111),
        Bone = "v_scoutblaster_reference001",
        Offset = {
            vpos = Vector(0, -2, 3.5),
            vang = Angle(0, 90, 0),
            wpos = Vector(500, 140, -500),
            wang = Angle(-10, -1, 180)
        },
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, -180, 0)
    }, 
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    }, 
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        WMScale = Vector(111, 111, 111),
        Bone = "scoutblaster_sight",
        Offset = {
            vpos = Vector(-.1, 0, 11),
            vang = Angle(90, 0, -90),
            wpos = Vector(1450, 165, -620),
            wang = Angle(-10, 0, 180)
        },
    },  
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        WMScale = Vector(100, 100, 100),
        Bone = "v_scoutblaster_reference001",
        Offset = {
            vpos = Vector(-1, -8, 1.5),
            vang = Angle(-90, 90, 0),
            wpos = Vector(1200, 245, -480),
            wang = Angle(-10, 0, -85)
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
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"uc_fg"},
    },
    {
        PrintName = "Charms/Killcounter",
        DefaultAttName = "None",
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "scoutblaster_sight",
        Offset = {
            vpos = Vector(0.6, 0, 0),
            vang = Angle(90, 0, -90),
            wpos = Vector(450, 150, -420),
            wang = Angle(-10, 0, 180)
        },
    },     
}--]]

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2", "shoot3"}
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "draw/gunfoley_pistol_draw_var_06.mp3", -- sound; can be string or table
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
                s = "holster/gunfoley_pistol_sheathe_var_09.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Time = 2.5,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 2},
        },
    },
}