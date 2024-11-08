AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.Slot = 3

SWEP.Category = "[ArcCW] Kraken's Empire Essentials"
SWEP.Credits = "Kraken"
SWEP.PrintName = "E-11D"
SWEP.Trivia_Class = "Blaster Carabine"
SWEP.Trivia_Desc = "The experimental version of the E-11D blaster carbine, manufactured by BlasTech Industries. Very similar in design to the experimental E-11 medium blaster rifle, it featured a stock and a large-bore reinforced barrel in order to maximize its rate of fire and intensity."
SWEP.Trivia_Manufacturer = "BlastTech Industries"
SWEP.Trivia_Calibre = "Condensed Tibanna-Gas"
SWEP.Trivia_Country = "Galactic Republic"
SWEP.IconOverride = "entities/kraken/empire-v2/e11d.png"

SWEP.MirrorVMWM = true -- Base
SWEP.UseHands = true
SWEP.NoHideLeftHandInCustomization = false
SWEP.ViewModel = "models/arccw/kraken/empire-essentials-v2/v_e11d_v2.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(-15, 8.5, -10),
    ang = Angle(-30, 25, -180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1,
}

SWEP.Damage = 35
SWEP.DamageMin = 35
SWEP.RangeMin = 0
SWEP.Range = 580
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 1200

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_orange"
SWEP.TracerCol = Color(255, 170, 0)
SWEP.HullSize = 1.5
SWEP.HullSize = 1

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 45

SWEP.Recoil = 0.29
SWEP.RecoilSide = 0.11
SWEP.RecoilRise = 0.22

SWEP.Delay = 60 / 500
SWEP.Num = 1
SWEP.Firemode = 1
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
        RunawayBurst = true,
        AutoBurst = true,
        Mult_RPM = 3,
        PostBurstDelay = 0.3,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0,
    }
}

SWEP.AccuracyMOA = 5.7 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200
SWEP.SightsDispersion = 0
SWEP.SpeedMult = 0.85

SWEP.Primary.Ammo = "ar2" -- Ammo, Sounds & MuzzleEffect
SWEP.ShootVol = 120
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2
SWEP.FirstShootSound = "empire-essentials/weapons/e-series/e11d.wav"
SWEP.ShootSound = "empire-essentials/weapons/e-series/e11d.wav"
SWEP.ShootSoundSilenced = "masita/weapons/imperiale11/e11supp.wav"
SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false

SWEP.MuzzleFlashColor = Color(250, 183, 0)
SWEP.IronSightStruct = {
    Pos = Vector(-3.379, -6.961, 2.73), -- Ironsight
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    SwitchToSound = "empire-essentials/interaction/zoom_start.mp3",
    SwitchFromSound = "empire-essentials/interaction/zoom_end.mp3",
    ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive" -- Holdtype
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.HoltypeCustomize = "slam"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ActivePos = Vector(0, -2, 2)
SWEP.ActiveAng = Angle(0, 0, 0)
SWEP.SprintPos = Vector(4.019, -5.226, -0.805)
SWEP.SprintAng = Angle(5, 40, 0)
SWEP.CustomizePos = Vector(10, 0, 0)
SWEP.CustomizeAng = Angle(6.8, 30.7, 10.3)
SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)
SWEP.DefaultElements = {
    "muzzle", -- Attachments
    "e11_flashlight",
    "e11_stock_grid",
    "e11_artop"
}

SWEP.AttachmentElements = {
    ["e11_flashlight"] = {
        VMBodygroups = {
            {
                ind = 2,
                bg = 1
            }
        },
    },
    ["e11_powerpack"] = {
        VMBodygroups = {
            {
                ind = 6,
                bg = 1
            }
        },
    },
    ["e11_stock_complete"] = {
        VMBodygroups = {
            {
                ind = 5,
                bg = 1
            }
        },
    },
    ["e11_stock_grid2"] = {
        VMBodygroups = {
            {
                ind = 3,
                bg = 2
            }
        },
    },
    ["e11_stock_grid"] = {
        VMBodygroups = {
            {
                ind = 3,
                bg = 1
            }
        },
    },
    ["e11_artop"] = {
        VMBodygroups = {
            {
                ind = 4,
                bg = 1
            }
        },
    },
    ["muzzle"] = {
        VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "E11_GUN",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(-3, 18, -4),
                    ang = Angle(0, 180, 0)
                },
                IsMuzzleDevice = true
            }
        }
    }
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Standard",
        Slot = {"optic", "extraoptic", "thermaloptic"},
        Bone = "E11_GUN",
        Offset = {
            vpos = Vector(0.15, -1, 2),
            vang = Angle(0, -90, 0),
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0),
    },
    {
        PrintName = "Internal Modifications", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = {"e11d_shotgun","sw_ammo"},
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["fire"] = {
        Source = "fire"
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "empire-essentials/interaction/equip.wav",
                p = 100,
                v = 100,
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "empire-essentials/interaction/equip2.wav",
                p = 100,
                v = 100,
                t = 0.1,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "fnuxreload",
        LHIK = true,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {
                s = "armas/disparos/dc17m/dc17m_reload.wav",
                t = 0.1
            },
        },
    },
    ["reload_empty"] = {
        LHIK = true,
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {
                s = "masita/weapons/imperiale11/standard_reload.ogg",
                t = 0.1
            },
        },
    },
}