AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3

SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "A-280CFE"
SWEP.Trivia_Class = "Blaster Rifle"
SWEP.Trivia_Desc = "The A280-CFE (covert field edition) convertible heavy blaster pistol, also known as an A280-CFE blaster rifle or simply a A280-CFE blaster, was a modular version of the A280 blaster rifle. It featured a core pistol that could be reconfigured into an assault rifle or sniper rifle.[1] Captain Cassian Andor used an A280-CFE during the Battle on Jedha, the mission to Eadu, and the Battle of Scarif."
SWEP.IconOverride = "entities/sopsmisc/a280cfe.png"

SWEP.DefaultBodygroups  = "000102"
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_a280cfe.mdl"
SWEP.WorldModel = "models/arccw/kraken/sops-v2/w_a280cfe.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-12, 4.5, -5),
    ang = Angle(-10, 0, 180),
    scale = 1.2,
}

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 2.5,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 0.9,
    [HITGROUP_RIGHTARM] = 0.9,
}

SWEP.Damage = 69
SWEP.RangeMin = 302
SWEP.DamageMin = 42
SWEP.Range = 502
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800
SWEP.TraceNum = 1
SWEP.Tracer = "tracer_green"
SWEP.TracerCol = Color(0, 250, 0)
SWEP.Primary.ClipSize = 40

SWEP.Recoil = 0.65
SWEP.RecoilSide = 0.23
SWEP.RecoilRise = 0.56
SWEP.Delay = 60 / 365

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
SWEP.HipDispersion = 250
SWEP.MoveDispersion = 100

-- Sounds & Muzzleflash
SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.05

SWEP.FirstShootSound = "sops-v2/weapons/a280cfe.wav"
SWEP.ShootSound = "sops-v2/weapons/a280cfe.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_green"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 250, 0)

SWEP.IronSightStruct = {
    Pos = Vector(-3.875, -12.188, 2.5),
    Ang = Angle(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
     SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
     ViewModelFOV = 55,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, -3, 2)
SWEP.ActiveAng = Angle(1, -0.5, -5)

SWEP.SprintPos = Vector(7, 0, -4)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(9.824, 2, -2.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

-- Attachments
SWEP.AttachmentElements = {
    ["a280cfe_barrel_short"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        AttPosMods = {
            [2] = {
                vpos = Vector(-0.175, -1.65, 15.5   ),
            },
        }
    },
    ["a280cfe_barrel_sniper"] = {
        NameChange = "Sniper A-280CFE",
        VMBodygroups = {{ind = 1, bg = 2}},
        AttPosMods = {
            [2] = {
                vpos = Vector(-0.175, -1.65, 24),
            },
        }
    },
    ["a280cfe_powerpack"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
    },
    ["a280cfe_stock_assault"] = {
        VMBodygroups = {
            {ind = 5, bg = 0},
        },
    },
    ["a280cfe_stock_heavy"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
}

SWEP.Attachments = {   
    {
        PrintName = "Optic",
        DefaultAttName = "None",
        Slot = "optic",
        Bone = "a280cfe",
        Offset = {
            vpos = Vector(-0.175, -2.6, 0),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, -0.025),
    }, 
    {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "a280cfe",
        Offset = {
            vpos = Vector(-0.175, -1.7, 19.2),
            vang = Angle(90, 0, -90),

        },
    },  
    {
        PrintName = "Tactical",
        DefaultAttName = "None",
        Slot = {"tactical", "tac_pistol", "tac"},
        VMScale = Vector(0.7, 0.7, 0.7),
        Bone = "a280cfe",
        Offset = {
            vpos = Vector(0.4, -1.7, 11),
            vang = Angle(90, 0, 20),
        },
    },  
    {
        PrintName = "Foregrip",
        DefaultAttName = "None",
        Slot = {"foregrip"},
        Bone = "a280cfe",
        Offset = {
            vpos = Vector(-0.175, -0.6, 11),
            vang = Angle(90, 0, -90),
        },
    },  
    {
        PrintName = "Barrel",
        DefaultAttName = "None",
        Slot = {"cfe_barrel"},
    },   
    {
        PrintName = "Stock",
        DefaultAttName = "None",
        Slot = {"cfe_stock"},
    },  
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },  
    {
        PrintName = "Powerpack", 
        DefaultAttName = "None",
        Slot = {"cfe_powerpack"},
    },
    {
        PrintName = "Ammunition", 
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
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "a280cfe",
        VMScale = Vector(0.8, 0.8, 0.8),
        Offset = {
            vpos = Vector(0.3, -1.7, 1),
            vang = Angle(90, 0, -70),
        },
    },     
    {
        PrintName = "Charms",
        DefaultAttName = "None",
        Slot = {"charm"},
        Bone = "a280cfe",
        VMScale = Vector(0.5, 0.5, 0.5),
        Offset = {
            vpos = Vector(0.35, -0.8, 1),
            vang = Angle(90, 0, -90),
        },
    },   
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
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
        LHIK = true,
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
        Mult = 0.9,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_manualcooling_var_02.mp3", t = 5 / 30},
            {s = "weapon_hand/reload_gentle/mag_eject/023d-00001014.mp3", t = 10 / 30},
            {s = "weapon_hand/reload_gentle/mag_load/023d-00000dda.mp3", t = 60 / 30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_04.mp3", t = 70 / 30},
        },
    },
}