AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "X-11 Dual"
SWEP.Trivia_Class = "Blaster-Experimental Pistol"
SWEP.Trivia_Desc = "The X-11 hand blaster, also known as X-11 blaster pistol, was a heavy blaster pistol wielded by the Clone Trooper 'Echo' of the Grand Army of the Galactic Republic during the Clone Wars."
SWEP.IconOverride = "entities/sopsmisc/dual x11.png"

-- Viewmodel & Entity Properties
SWEP.HideViewmodel = false
SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/masita/viewmodels/blasterdualpistol_template.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 65
SWEP.NoHideLeftHandInCustomization = true
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 38
SWEP.RangeMin = 132
SWEP.DamageMin = 23
SWEP.Range = 304
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 46

SWEP.Recoil = 1.04
SWEP.RecoilSide = 0.12
SWEP.RecoilRise = 0.56
SWEP.Delay = 60 / 402

SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = 2
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 0.2 
SWEP.HipDispersion = 350
SWEP.MoveDispersion = 100

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/x11.wav"
SWEP.ShootSound = "sops-v2/weapons/x11.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = false
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight & Holdtype
SWEP.IronSightStruct = {
    Pos = Vector(0, -5, 0.6),
    Ang = Angle(0, 0, 0),
     Magnification = 1.3,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = "duel"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, -5, -1)
SWEP.ActiveAng = Angle(5, 0, 0)

SWEP.SprintPos = Vector(0, -14,-10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-25, 0, 0)

SWEP.ReloadPos = Vector(0, -5, -0)

SWEP.CustomizePos = Vector(-0.5, -8, -4.897)
SWEP.CustomizeAng = Angle(10, 0, 0)

-- Attachments 
SWEP.DefaultElements = {"blaster", "blasterdual"}
SWEP.AttachmentElements = {
    ["blaster"] = {
        VMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/holo_x11.mdl",
                Bone = "Gun1",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(0, 2.5, -0.4),
                    ang = Angle(90, 90, 175)
                }
            },
            {
                Model = "models/arccw/kraken/sops-v2/holo_x11.mdl",
                Bone = "Gun2",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(0.1, 3, -0.2),
                    ang = Angle(80, 95, 175)
                }
            },
        },
    },
    ["blasterdual"] = {
        WMElements = {
            {
                Model = "models/arccw/kraken/sops-v2/holo_x11.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(70, 15, -10),
                    ang = Angle(180, -180, 2)
                }
            },
            {
                Model = "models/arccw/kraken/sops-v2/holo_x11.mdl",
                Bone = "ValveBiped.Bip01_L_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-23, 230, -55),
                    ang = Angle(180, -180, 2)
                }
            },
        },              
    }
}WMOverride = "models/arccw/kraken/sops-v2/holo_x11.mdl"

SWEP.Attachments = { 
    {
        PrintName = "Ammo",
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
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = false
    },
    ["idle_inspect"] = {
        Source = "lookat01",
        Time = 7,
    },
    ["exit_inspect"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot_l", "shoot_r"},
    },
    ["fire_iron"] = {
        Source = {"shoot_l", "shoot_r"},
    },
    ["bash"] = {
        Source = "bash"
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1,
        SoundTable = {
            {
                s = "weapons/valken1908/retrofitescapadedraw2.wav",
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
                s = "weapons/valken1908/retrofitescapadedraw2.wav",
                p = 100, 
                v = 75, 
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        LHIK = true,
        Mult = 1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_02.mp3", t = 10 / 60},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheat_reset_var_04.mp3", t = 105 / 60},
        },
    },
}