AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ ArcCW ] Republic TFA Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DLT-19d"
SWEP.Trivia_Class = "Blaster Sniper Rifle"
SWEP.Trivia_Desc = "The DLT-19D heavy blaster rifle was a long-range heavy blaster rifle, longblaster and a variant of the DLT-19 heavy blaster rifle, featuring a scope and two underbarrel devices, one of which was a glowrod."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.IconOverride = "entities/sopsmisc/dlt19d.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 56
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Damage & Tracer
SWEP.Damage = 35
SWEP.DamageMin = 35
SWEP.Range = 97200000
SWEP.RangeMin = 620
SWEP.Penetration = 22

SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 500
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 50

SWEP.VisualRecoilMult = 0
SWEP.Recoil = 0.29
SWEP.RecoilSide = 0.22
SWEP.RecoilRise = 0.33

SWEP.AccuracyMOA = 5.7
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Delay = 60 / 450
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 2,
    }, 
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.SpeedMult = 0.85
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.4 / 1.25

-- Ammo, Sounds & MuzzleEffect
SWEP.MuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.FastMuzzleEffect = nil
SWEP.MuzzleFlashColor = Color(250, 0, 0)
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 80
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.04

SWEP.FirstShootSound = "weapons/bf3/dc15a.wav"
SWEP.ShootSound = "weapons/bf3/dc15a.wav"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 1

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-3.250, -5, 0.8),
    Ang = Vector(2.85, 0, 0),
     Magnification = 1.50,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 34,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 2, 1)
SWEP.ActiveAng = Angle(1, -0.5, 0)

SWEP.SprintPos = Vector(7, -4, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

-- Attachments
SWEP.DefaultElements = {"dlt19d", "muzzle"}
SWEP.AttachmentElements = {
    ["dlt19d"] = {
        VMElements = {
            {
                Model = "models/markus/swbf2/gameplay/equipment/longrange/dlt19d/dlt19d_mesh1p_mesh.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(0.35, 0, 0),
                    ang = Angle(0, -180, 0),
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
                    pos = Vector(-1, 0, 20),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/markus/swbf2/gameplay/equipment/longrange/dlt19d/dlt19d_mesh1p_mesh.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(400, 0, -150),
                    ang = Angle(85, 90, -90),
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(4000, 140, -745),
                    ang = Angle(0, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, 
    }
}
WMOverride = "models/markus/swbf2/gameplay/equipment/longrange/dlt19d/dlt19d_mesh1p_mesh.mdl"

SWEP.Attachments = {
    {
        PrintName = "Sight",
        DefaultAttName = "None", 
        Slot = {"rifleoptic","extraoptic"}, 
        Bone = "dlt19_sight",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(-0.1, 0, -3.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(800, 0, -600),
            wang = Angle(-5, 0, 180)
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },     
    {
        PrintName = "Bipod",
        DefaultAttName = "None",
        Slot = {"bipod"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0, 2.4, 9),
            vang = Angle(90, 0, -90),
            wpos = Vector(2500, 0, -500),
            wang = Angle(-5, 0, 180)

        },
    }, 
   --[[ {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        Bone = "v_dlt19_reference001",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(0, 36, 2),
            vang = Angle(0, -90, 0),
            wpos = Vector(4100, 0, -720),
            wang = Angle(-5, 0, 180)
        },
    },  
  
    {
        PrintName = "Tactical", 
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        Bone = "v_dlt19_reference001",
        WMScale = Vector(90, 90, 90),
        VMScale = Vector(0.6, 0.6, 0.6),
        Offset = {
            vpos = Vector(0.7, 32, 2.2),
            vang = Angle(90, -90, 0),
            wpos = Vector(4200, 200, -1600),
            wang = Angle(-20, -1, 180)
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
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "v_dlt19_reference001",
        WMScale = Vector(70, 70, 70),
        VMScale = Vector(0.6, 0.6, 0.6),
        Offset = {
            vpos = Vector(1.3, -2, 2.2),
            vang = Angle(0, -90, 0),
            wpos = Vector(400, 90, -400),
            wang = Angle(-5, 0, 180)
        },
    },       
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        WMScale = Vector(111, 111, 111),
        Bone = "v_dlt19_reference001",
        Offset = {
            vpos = Vector(1.2, 1.5, 2.2),
            vang = Angle(0, -90, 0),
            wpos = Vector(100, 90, -370),
            wang = Angle(-5, 0, 180)
        },
    },    --]]     
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot1", "shoot2", "shoot3"},
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {s = "draw/gunfoley_pistol_draw_var_06.mp3", t = 0.1/30},
        },
    },
    ["holster"] = {
        SoundTable = {
            {s = "holster/gunfoley_pistol_sheathe_var_09.mp3", t = 0.1/30},
        },
    },
    ["reload"] = {
        Source = "reload",
        LHIK = true,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 2},
        },
    },
}