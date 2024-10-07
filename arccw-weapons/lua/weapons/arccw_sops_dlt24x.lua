AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 4

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "DLT-24x"
SWEP.Trivia_Class = "Blaster Heavy Repeater"
SWEP.Trivia_Desc = "In need of a heavy weapon capable of destroying Rebel scum, Blastech Industries designed and created a portable destruction machine. The DLT-23v was born with a single objective: that nothing and no one who is the target remains alive."
SWEP.IconOverride = "entities/sopsmisc/dlt24x.png"

-- Viewmodel & Entity Properties
SWEP.HideViewmodel = false
SWEP.UseHands = true
SWEP.WorldModel = "models/arccw/kraken/sops-v2/w_wk_stik_helg.mdl"
SWEP.ViewModel = "models/arccw/kraken/sops-v2/v_wk_stik_helg.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}


-- Damage & Tracer
SWEP.Damage = 32
SWEP.RangeMin = 220
SWEP.DamageMin = 21
SWEP.Range = 470
SWEP.Penetration = 8
SWEP.DamageType = DMG_BULLET

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 185
SWEP.ExtendedClipSize = 220
SWEP.ReducedClipSize = 125

SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_red"
SWEP.TracerCol = Color(250, 0, 0)
SWEP.HullSize = 1.5

SWEP.VisualRecoilMult = 1.28
SWEP.Recoil = 0.72
SWEP.RecoilSide = 0.22
SWEP.RecoilRise = 0.76

SWEP.Delay = 60 / 200
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 250
SWEP.MoveDispersion = 150

-- Speed Mult
SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.4

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 110 
SWEP.ShootPitch = 50 
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "sops-v2/weapons/dlt24x.wav"
SWEP.ShootSound = "sops-v2/weapons/dlt24x.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_red"
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(250, 0, 0)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-5.022, -10.058, 4.631),
    Ang = Angle(0, -0.274, 0),
     Magnification = 1.5,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "smg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 2)
SWEP.ActiveAng = Angle(1, -0.5, -5)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.Bipod_Integral = true 
SWEP.BipodDispersion = 1
SWEP.BipodRecoil = 1 

-- Attachments
SWEP.DefaultElements = {"muzzle"}
SWEP.AttachmentElements = {
    ["muzzle"] = {
        WMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/w_wk_stik_helg.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(700, 0, -100),
                    ang = Angle(0, 0, -180),
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(4700, 140, -200),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, 
    }
}WMOverride = "models/weapons/jackswan/krieg/w_wk_stik_helg.mdl"

SWEP.Attachments = {   
    {
        PrintName = "Optic",
        DefaultAttName = "None",
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "WeaponBone",
        Offset = {
            vpos = Vector(-4.2, -14, -0.2),
            vang = Angle(0, 90, 90),
            wpos = Vector(1200, 0, -760),
            wang = Angle(0, 0, 180)
        },
        CorrectiveAng = Angle(0, -180, -180),
        CorrectivePos = Vector(0, 0, 0),
    },  
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(111, 111, 111),
        Bone = "WeaponBone",
        Offset = {
            vpos = Vector(-6.5, -29, 0.95),
            vang = Angle(0, 90, -180),
            wpos = Vector(2600, 100, -520),
            wang = Angle(0, 0, -90)
        },
    },  
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle"},
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(111, 111, 111),
        Bone = "WeaponBone",
        Offset = {
            vpos = Vector(-6.2, -48, 0.2),
            vang = Angle(0, 90, -180),
            wpos = Vector(5100, 0, -500),
            wang = Angle(0, -1, 180)
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
        PrintName = "Charm",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "WeaponBone",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(-5.8, -14, 1.4),
            vang = Angle(0, 90, 90),
            wpos = Vector(1200, 170, -580),
            wang = Angle(0, 0, 180)
        },
    },        
    {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "WeaponBone",
        WMScale = Vector(111, 111, 111),
        Offset = {
            vpos = Vector(-6.5, -10, 1.2),
            vang = Angle(0, 90, 90),
            wpos = Vector(670, 140, -550),
            wang = Angle(0, 0, 180)
        },
    },     
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "shoot",
    },
    ["fire_iron"] = {
        Source = "shoot",
    },
    ["trigger"] = {
        Source = "fidget",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "sops-v2/weapons/z6_chain/trigger.wav", t = 0.1/30},
        },
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapon_hand/reload_gentle/other/023d-000000b6.mp3", t = 0.1 / 30},
            {s = "weapon_hand/reload_gentle/other/023d-000003f5.mp3", t = 20 / 30},
            {s = "weapon_hand/reload_gentle/other/023d-000000b7.mp3", t = 30 / 30},
            {s = "weapon_hand/reload_gentle/locknload/023d-00000a92.mp3", t = 3.2},
        },
    },
}

SWEP.Hook_ModifyRPM = function(wep, delay)
    return delay / Lerp(wep:GetBurstCount() / 15, 1, 3)
end