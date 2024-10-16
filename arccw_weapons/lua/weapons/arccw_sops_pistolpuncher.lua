AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "Imperial Firepuncher Pistol"
SWEP.Trivia_Class = "Blaster Pistol"
SWEP.Trivia_Desc = "Heavy-Powered blaster produced by BlastTech Industries for the galactic citizens."
SWEP.IconOverride = "entities/sopsmisc/pistolpuncher.png"

-- Viewmodel & Entity Properties
SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/masita/viewmodels/blasterpistol_template.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 32
SWEP.RangeMin = 120
SWEP.DamageMin = 24
SWEP.Range = 199
SWEP.Penetration = 8
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_green"
SWEP.TracerCol = Color(0, 250, 0)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 29

SWEP.Recoil = 1.20
SWEP.RecoilSide = 0.12
SWEP.RecoilRise = 0.98
SWEP.Delay = 60 / 200

SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = -3
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 0.1
SWEP.HipDispersion = 250
SWEP.MoveDispersion = 150

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 90
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/firepuncher/firepuncher.wav"
SWEP.ShootSound = "sops-v2/weapons/firepuncher/firepuncher.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_green"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 250, 0)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(-5.7, -10, 1.1),
    Ang = Angle(0, 0, 0),
     Magnification = 1.3,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(-4, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, -20)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(10, -13, 0)
SWEP.CustomizeAng = Angle(12, 50.5, 45)

-- Attachments 
SWEP.DefaultElements = {"blaster", "muzzle"}
SWEP.AttachmentElements = {
    ["blaster"] = {
        VMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/pistolpuncher.mdl",
                Bone = "DC-15SA",
                Scale = Vector(0.6, 0.6, 0.6),
                Offset = {
                    pos = Vector(-0.7, -1, -8.3),
                    ang = Angle(90, 0, -90)
                }
            }
        },
    },
    ["muzzle"] = {
        VMElements = {
           {
               Model = "models/hunter/plates/plate.mdl",
               Bone = "DC-15SA",
               Scale = Vector(0, 0, 0),                
               Offset = {
                   pos = Vector(-5, 5, 10),
                   ang = Angle(-90, 180, 0)
               },
               IsMuzzleDevice = true
           }
        },
        WMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/pistolpuncher.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.6, 0.6, 0.6),
                Offset = {
                    pos = Vector(0, 10, -15),
                    ang = Angle(-15, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(130, 20, -55),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },              
        },
    }
}WMOverride = "models/arccw/kraken/sops-v2/pistolpuncher.mdl"

SWEP.Attachments = {
    {
        PrintName = "Optic", 
        DefaultAttName = "Standard", 
        Slot = "optic",
        VMScale = Vector(0.9, 0.9, 0.9),
        WMScale = Vector(11, 11, 11),
        Bone = "DC-15SA",
        Offset = {
            vpos = Vector(-0.64, -2.1, -3.3),
            vang = Angle(90, 0, -90),
            wpos = Vector(40, 11, -39),
            wang = Angle(-15, 0, 180)
        },
        CorrectiveAng = Angle(0, 0, 0)
    },    
    {
        PrintName = "Integrated Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.1, 0.1, 0.1),
        WMScale = Vector(1, 1, 1),
        Bone = "DC-15SA", 
        Offset = {
            vpos = Vector(-0.5, 1, 0),
            vang = Angle(90, 0, -90),
            wpos = Vector(110, 11, -25),
            wang = Angle(-15, 0, -180)
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(11, 11, 11),
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "DC-15SA",
        Offset = {
            vpos = Vector(-0.64 , -1.4, 5),
            vang = Angle(90, 0, -90),
            wpos = Vector(140, 11, -57),
            wang = Angle(-15, 0, 180)

        },
    },    
    {
        PrintName = "Ammunition",
        DefaultAttName = "Standard",
        Slot = {"ammo"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    },
    {
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "DC-15SA",
        VMScale = Vector(0.7, 0.7, 0.7),
        WMScale = Vector(7, 7, 7),
        Offset = {
            vpos = Vector(0.1, -1, 0),
            vang = Angle(90, 0, -90),
            wpos = Vector(86, 19, -20),
            wang = Angle(-15, 0, 180)
        },
    },     
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        WMScale = Vector(11, 11, 11),
        VMScale = Vector(1, 1, 1),
        Bone = "DC-15SA",
        Offset = {
            vpos = Vector(0.1, -1.2, -4),
            vang = Angle(90, 0, -90),
            wpos = Vector(70, 18, -36),
            wang = Angle(-15, 0, 180)
        },
    },      
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = false
    },
    ["fire"] = {
        Source = {"Fire"},
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1,
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
        LHIK = true,
        Mult = 1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_02.mp3", t = 10 / 60},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheat_reset_var_04.mp3", t = 105 / 60},
        },
    },
}