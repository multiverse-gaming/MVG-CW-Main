AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ArcCW] Special Forces - Republic Weapons"
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "ZX-6"
SWEP.Trivia_Class = "Blaster-Experimental Heavy Canon"
SWEP.Trivia_Desc = "The Zx-6 rotary blaster cannon was a blaster cannon used by the Galactic Republic during the Clone Wars. Later, during the reign of the Galactic Empire, these weapons were used by both the Imperial Army's Heavy Weapons Stormtroopers and Rebel Alliance's Heavy Soldiers during the Galactic Civil War."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Tibanna Gas"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/z6x.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/weapons/synbf3/c_t21.mdl"
SWEP.WorldModel = "models/arccw/weapons/synbf3/w_t21.mdl"
SWEP.ViewModelFOV = 55
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Damage & Tracer
SWEP.Damage = 25
SWEP.RangeMin = 197
SWEP.DamageMin = 25
SWEP.Range = 4800000
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 413
SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 250)
SWEP.HullSize = 1.5
SWEP.PhysTracerProfile = 1
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 200
SWEP.Recoil = 0.44
SWEP.RecoilSide = 0.26
SWEP.RecoilRise = 0.34
SWEP.RecoilPunch = 1.1
SWEP.RecoilVMShake = 1.3
SWEP.Delay = 60 / 600
SWEP.TriggerDelay = true
SWEP.Num = 1
SWEP.BobMult = 2

SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 2,
        Mult_RPM = 2800 / 3400,
        PrintName = "2800RPM"
    },
    {
        Mode = 0
    }
}

SWEP.ShootWhileSprint = true

SWEP.AccuracyMOA = 4.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

-- Speed Mult
SWEP.SpeedMult = 0.7
SWEP.SightedSpeedMult = 0.83
SWEP.SightTime = 0.3

-- Ammo, Sounds & MuzzleEffect
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 100
SWEP.ShootPitch = 78
SWEP.ShootPitchVariation = 0.04
SWEP.FirstShootSound = "everfall/weapons/z6/blasters_z6rotaryblaster_laser_close_var_06.mp3"                      
SWEP.ShootSound = "everfall/weapons/z6/fire/blasters_z6rotaryblaster_laser_close_var_08.mp3"
SWEP.DistantShootSound = "everfall/weapons/z6/blasters_z6rotaryblaster_laser_close_var_06.mp3"              

SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-1.4, -3, -3),
    Ang = Vector(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a45.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a47.mp3",
     ViewModelFOV = 60,
}

-- Holdtype
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(6, 6, -3)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5.226, -2, 0)
SWEP.SprintAng = Angle(-18, 36, -13.5)

SWEP.CustomizePos = Vector(8, -4.8, -3)
SWEP.CustomizeAng = Angle(11.199, 38, 0)

SWEP.HolsterPos = Vector(4, -3, -2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.Jamming = false
SWEP.HeatGain = 0.05 
SWEP.HeatCapacity = 1000000
SWEP.HeatDissipation = 10
SWEP.HeatLockout = true
SWEP.HeatDelayTime = 0.5

-- Attachments
SWEP.DefaultElements = {"ZX6", "muzzle"}
SWEP.AttachmentElements = {
    ["ZX6"] = {
        VMElements = {
            {
                Model = "models/holo/zx6/holo_zx6.mdl",
                Bone = "v_t21_reference001",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(1, -9, 5),
                    ang = Angle(0,-90, 0)
                }
            }
        }
    },
    ["muzzle"] = {
         VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "v_t21_reference001",
                Scale = Vector(0, 0, 0),                
                Offset = {
                    pos = Vector(-0.3, 14, 0),
                    ang = Angle(90, 0, 0)
                },
                IsMuzzleDevice = true
            }
        },
        WMElements = {
            {
                Model = "models/holo/zx6/holo_zx6.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0.9, 0.9, 0.9),
                Offset = {
                    pos = Vector(0, 100, -50),
                    ang = Angle(-20, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(4500, 0, -1800),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        },
    }
}

SWEP.Attachments = {    
    {
        PrintName = "Sight",
        DefaultAttName = "None", 
        Slot = {"rifleoptic","extraoptic"}, 
        WMScale = Vector(111, 111, 111),
        Bone = "v_t21_reference001",
        Offset = {
            vpos = Vector(1, 6, 10.5),
            vang = Angle(0, -90, 0),
            wpos = Vector(1500, 110, -1250),
            wang = Angle(-20, 0, 180)
        },
        CorrectiveAng = Angle(0, 180, 0),
        CorrectivePos = Vector(0, 0, 0),
    },  
    {
        PrintName = "Muzzle", 
        DefaultAttName = "None",
        Slot = {"dc17m_muzzle"},
    },  
    {
        PrintName = "Energization", 
        DefaultAttName = "Standard",
        Slot = {"dc17m_energization"},
    },
    {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = {"dc17m_perk"},
    },
}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire",
    },
    ["fire_iron"] = {
        Source = false,
    },
    ["trigger"] = {
        Source = "fire",
        SoundTable = {
            {s = "everfall/weapons/z6/start/blasters_z6rotaryblaster_start_short_var_04.mp3", t = 0.1},
        },
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
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 80/30},
        },
    },


sound.Add({
    name =          "dc15a_reload1",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "armas/misc/dc17s_reload.wav"
    }),
}

--[[SWEP.Hook_ModifyRPM = function(wep, delay)
    return delay / Lerp(wep:GetBurstCount() / 15, 1, 3)
end--]]