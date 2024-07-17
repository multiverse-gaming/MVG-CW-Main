AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 1 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces - Republic Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "Dual X-11"
SWEP.Trivia_Class = "Blaster-Experimental Pistol"
SWEP.Trivia_Desc = "The X-11 hand blaster, also known as X-11 blaster pistol, was a heavy blaster pistol wielded by the Clone Trooper 'Echo' of the Grand Army of the Galactic Republic during the Clone Wars."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/dual x11.png"

SWEP.ViewModel = "models/rising/base/c_akimbo.mdl"
SWEP.WorldModel = "models/arccw/weapons/synbf3/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

-- Damage & Entity options
SWEP.Damage = 30
SWEP.RangeMin = 102
SWEP.DamageMin = 30
SWEP.Range = 20000
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
SWEP.Primary.ClipSize = 40

SWEP.Recoil = 0.34
SWEP.RecoilPunch = 1.4
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.17

SWEP.Delay = 60 / 568
SWEP.Num = 1
SWEP.Firemodes = {
    {
		Mode = -4,
        RunawayBurst = true,
        AutoBurst = true,
        PostBurstDelay = 0.2,
	},
	{
		Mode = -2
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 15.0 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
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
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.IronSightStruct = {
    Pos = Vector(0, -4, 1),
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
    SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
    ViewModelFOV = 60,
    CrosshairInSights = true,
}

SWEP.HoldtypeHolstered = "idle"
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = "duel"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, -5, -10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(-0.5, -8, -4.897)
SWEP.CustomizeAng = Angle(30, 0, 0)

-- Attachments 
SWEP.BarrelLength = 60
SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)

SWEP.DefaultElements = {"x11", "x11+"}

SWEP.AttachmentElements = {
    ["x11"] = {
        VMElements = {
            {
                Model = "models/holo/x11/holo_x11.mdl",
                Bone = "LeftHand_1stP",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(4.5, 2, -0.85),
                    ang = Angle(-7.5, 0, 75)
                }
            }
        },
    },
    ["x11+"] = {
         VMElements = {
            {
                Model = "models/holo/x11/holo_x11.mdl",
                Bone = "RightHand_1stP",
                Scale = Vector(1, 1, 1),                
                Offset = {
                    pos = Vector(-4.5, -2, 1.3),
                    ang = Angle(-5, 178, 90)
                }
            }
        }, 
        WMElements = {
            {
                Model = "models/holo/x11/holo_x11.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(30, 15, -10),
                    ang = Angle(180, -180, 2)
                }
            },
            {
                Model = "models/holo/x11/holo_x11.mdl",
                Bone = "ValveBiped.Bip01_L_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(-50, 230, -55),
                    ang = Angle(180, -180, 2)
                }
            },
        },
    }
}
WMOverride = "models/holo/x11/holo_x11.mdl"

--[[SWEP.Attachments = {    
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"No Attachment"},
    },
    {
        PrintName = "Grip",
        Slot = "No Attachment",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = {"No Attachment"},
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"No Attachment"},
    },       
}--]]


SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot_lw", "shoot_rw"}
    },
    ["fire_iron"] = {
        Source = {"shoot_lw", "shoot_rw"}
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
        Time = 3.35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 2.5},
        },
    },
}