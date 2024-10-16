AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "CR-2"
SWEP.Trivia_Class = "Heavy-Blaster Pistol"
SWEP.Trivia_Desc = "The CR-2 heavy blaster pistol was a heavy blaster pistol manufactured by Corellian Arms that was utilized by the Royal Naboo Security Forces. Small and agile, it had an extreme rate of fire and shoot ionized bolts. It also could be configured with night vision scopes or have an extended stock for reduced recoil."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/masita/cr2.png"

-- Viewmodel & Entity Properties
SWEP.MirrorVMWM = true
SWEP.UseHands = true
SWEP.ViewModel = "models/everfall/weapons/viewmodels/c_cr2.mdl"
SWEP.WorldModel = "models/everfall/weapons/worldmodels/w_cr2.mdl"
SWEP.ViewModelFOV = 50
SWEP.WorldModelOffset = {
    pos = Vector(-11.4, 5, -5),
    ang = Angle(-10, 0, 180),
    scale = 1.2,
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.NoHideLeftHandInCustomization = true

-- Damage & Tracer
SWEP.BodyDamageMults =  {
    [HITGROUP_HEAD] = 1.8,
    [HITGROUP_CHEST] = 1.5,
    [HITGROUP_LEFTARM] = 1.1,
    [HITGROUP_RIGHTARM] = 1.1,
}

SWEP.Damage = 37
SWEP.RangeMin = 197
SWEP.DamageMin = 24
SWEP.Range = 480
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 413
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tracer_green"
SWEP.TracerCol = Color(0, 250, 0)
SWEP.HullSize = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 55
SWEP.Recoil = 0.23
SWEP.RecoilSide = 0.11
SWEP.RecoilRise = 0.11
SWEP.Delay = 60 / 427
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
SWEP.AccuracyMOA = 0.59
SWEP.HipDispersion = 447
SWEP.MoveDispersion = 54

-- Speed Mult
SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.2

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 90
SWEP.FirstShootSound = "armas/disparos/cr-2/blasters_cr2_laser_close_var_07.mp3"
SWEP.ShootSound = "armas/disparos/cr-2/blasters_cr2_laser_close_var_08.mp3"
SWEP.ShootSoundSilenced = "armas/disparos/dc19.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17_green"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 250, 0)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-4.152, -5.928, 2.367),
    Ang = Angle(0, 0, 0),
     Magnification = 1.4,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 55,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 3, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(4.019, -5.226, -0.805)
SWEP.SprintAng = Angle(5, 40, 0)

SWEP.CustomizePos = Vector(15, -5, -1.321)
SWEP.CustomizeAng = Angle(18.2, 39.4, 14.8)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)

SWEP.Bipod_Integral = true -- Integral bipod (ie, weapon model has one)
SWEP.BipodDispersion = 1 -- Bipod dispersion for Integral bipods
SWEP.BipodRecoil = 1 -- Bipod recoil for Integral bipods
-- Attachments
SWEP.AttachmentElements = {
    ["cr2_barrel_extended"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        AttPosMods = {
            [2] = {
                vpos = Vector(-0.45, 0.7, 13.4),
            },
        }
    },
    ["cr2_stock"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
}

SWEP.Attachments = {
    [1] = {
        PrintName = "Sight",
        DefaultAttName = "Standard", 
        Slot = "optic", 
        Bone = "cr2",
        Offset = {
            vpos = Vector(-0.45, -1.7, -1),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
        CorrectivePos = Vector(0, 0, 0),
    },     
    [2] = {
        PrintName = "Muzzle",
        DefaultAttName = "None",
        Slot = {"muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        Bone = "cr2",
        Offset = {
            vpos = Vector(-0.45, 0.7, 11.4),
            vang = Angle(90, 0, -90),

        },
    },       
    [3] = {
        PrintName = "Barrel",
        DefaultAttName = "None",
        Slot = "cr2_barrel",
    },   
    [4] = {
        PrintName = "Stock",
        DefaultAttName = "None",
        Slot = "cr2_stock",
    },  
    [5] = {
        PrintName = "Internal Modifications",
        DefaultAttName = "None",
        Slot = "uc_fg",
    },   
    [6] = {
        PrintName = "Ammo", 
        DefaultAttName = "Standard",
        Slot = "ammo",
    },
    [7] = {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    [8] = {
        PrintName = "Charms",
        DefaultAttName = "None",
        VMScale = Vector(0.7, 0.7, 0.7),
        Slot = {"charm"},
        Bone = "cr2",
        Offset = {
            vpos = Vector(0, -1.4, 3.3),
            vang = Angle(90, 0, -90),
        },
    },    
    [9] = {
        PrintName = "Killcounter",
        DefaultAttName = "None",
        Slot = {"killcounter"},
        Bone = "cr2",
        Offset = {
            vpos = Vector(0.7, -0.7, -1),
            vang = Angle(90, 0, -90),
        },
    },         
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "Idle"
    },
    ["fire"] = {
        Source = "Fire"
    },
    ["fire_iron"] = {
        Source = "Neutral"
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "armasclasicas/wpn_empire_lgequip.wav",
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
                s = "armasclasicas/wpn_empire_medequip.wav",
                p = 100,
                v = 75,
                t = 0,
                c = CHAN_ITEM,
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_03.mp3", t = 2.2 },
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_03.mp3", t = 0.1 / 30},
        },
    },
}