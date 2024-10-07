AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "773 Firepuncher"
SWEP.Trivia_Class = "Blaster-Experimental Sniper Rifle"
SWEP.Trivia_Desc = "The 773 Firepuncher rifle, also known as the 773 Firepuncher, was a model of sniper rifle manufactured by Merr-Sonn Munitions, Inc. that featured ablative coating and a wide-beam 'burning' mode."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/firepuncher.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 65
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Damage & Tracer
SWEP.Damage = 65
SWEP.DamageMin = 65
SWEP.Range = 56000 * 0.025
SWEP.Penetration = 22

SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 500
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 20
--[[SWEP.ExtendedClipSize = 15
SWEP.ReducedClipSize = 5--]]

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.25
SWEP.RecoilSide = 0.2
SWEP.AccuracyMOA = 0.01 
SWEP.HipDispersion = 400
SWEP.MoveDispersion = 200

SWEP.Delay = 60 / 200
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = -2,
    },
    {
        Mode = 1,
    }, 
    {
        Mode = 0
    }
}

SWEP.ShootWhileSprint = true

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.40
SWEP.SightTime = 0.4 / 1.25

-- Ammo, Sounds & MuzzleEffect
SWEP.MuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 140
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.04

SWEP.FirstShootSound = "armas3/a180_2.wav"
SWEP.ShootSound = "armas3/a180_3.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 1

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector( -2.5, 0, -0.5),
    Ang = Vector(0, 0, 0),
     Magnification = 1.50,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 50,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(2, 0, -2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(7, -4, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

-- Attachments
SWEP.DefaultElements = {"firepuncher", "muzzle"}
SWEP.AttachmentElements = {
    ["firepuncher"] = {
        VMElements = {
            {
                Model = "models/holo/773firepuncher/holo_773firepuncher.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(0.7, 0.7, 0.7),
                Offset = {
                    pos = Vector(0, 11, 1),
                    ang = Angle(0, -180, 0)
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
                    pos = Vector(-0.5, 0, 20),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/holo/773firepuncher/holo_773firepuncher.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.7, 0.7, 0.7),
                Offset = {
                    pos = Vector(1600, 200, -600),
                    ang = Angle(-10, 90, 190)
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
WMOverride = "models/holo/773firepuncher/holo_773firepuncher.mdl"

SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "None", 
        Slot = {"optic","rccrosshairscope"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(-0.45, 0.4, -6),
            vang = Angle(90, 0, -90),
            wpos = Vector(1000, 200, -720),
            wang = Angle(-20, -1, 180)
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },              
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = {"mode_firepuncher"},
    },         
}

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
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 80/30},
        },
    },
}