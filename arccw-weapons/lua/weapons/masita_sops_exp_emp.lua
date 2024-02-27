AddCSLuaFile()

SWEP.Base = "arccw_imperialmasita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 3 -- Change this if you want to select the weapon with other number

-- Trivia
SWEP.Category = "[ ArcCW ] Explosives" -- edit this if you like
SWEP.Credits = "Kraken/Masita"
SWEP.PrintName = "EMP Rifle"
SWEP.Trivia_Class = "EMP Weapon"
SWEP.Trivia_Desc = "The electromagnetic pulse (EMP) launcher was a devastating weapon when used against the battle droid forces of the Confederacy of Independent Systems as they were able to both deactivate droids by shorting out electronics and destroy their interior circuitry with powerful EMP waves. Clone jet troopers used these as their primary weapon."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "Rocket"
SWEP.Trivia_Year = 2023
SWEP.IconOverride = "entities/sopsmisc/emprifle.png"

-- Viewmodel & Entity Properties
SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

-- Grenade Launcher properties
SWEP.ShootEntity = "emp_nade"
SWEP.MuzzleVelocity = 3400

SWEP.Jamming = true
SWEP.HeatGain = 4
SWEP.HeatCapacity = 4
SWEP.HeatDissipation = 2 -- rounds' worth of heat lost per second
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatDelayTime = 3
SWEP.HeatFix = true -- when the "fix" animation is played, all heat is restored.

//SWEP.InfiniteAmmo = true
//SWEP.BottomlessClip = true

-- Damage & Tracer
SWEP.ChamberSize = 1
SWEP.Primary.ClipSize = 4
SWEP.ExtendedClipSize = 6
SWEP.ReducedClipSize = 2

SWEP.Recoil = 2
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 1.5
SWEP.RecoilPunch = 3

SWEP.Delay = 60 / 80
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 8 
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "RPG_Round"
SWEP.MagID = "rpg7"

-- Speed Mult
SWEP.SightTime = 0.35
SWEP.SpeedMult = 0.875
SWEP.SightedSpeedMult = 0.75

-- Ammo, Sounds & MuzzleEffect
SWEP.ShootVol = 130
SWEP.ShootPitch = 90
SWEP.ShootPitchVariation = 0.2
SWEP.ShootSound = "masita/weapons/ion_disruptor/addon/blaster_iondisruptor_laser_addon_close_var_08.mp3"
SWEP.ShootSoundSilenced = "weapon/venator/dc17_badbatch.wav"

SWEP.NoFlash = nil
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ironsight
SWEP.IronSightStruct = {
    Pos = Vector(-2.5, 5, 0.2),
    Ang = Vector(0, 0, 0),
     Magnification = 1.5,
     SwitchToSound = "weapon_hand/ads/0242-00001a46.mp3",
     SwitchFromSound = "weapon_hand/ads/0242-00001a43.mp3",
     ViewModelFOV = 60,
}

-- Holdtype
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(1, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0.0, 0, 07)
SWEP.SprintAng = Angle(-40, 0, 0)

SWEP.CustomizePos = Vector(8, 4.8, -3)
SWEP.CustomizeAng = Angle(11.199, 38, 0)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.ExtraSightDist = 8

-- Attachments
SWEP.DefaultElements = {"hh12", "muzzle"}
SWEP.AttachmentElements = {
    ["hh12"] = {
        VMElements = {
            {
                Model = "models/sw_battlefront/weapons/emp_rifle.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(1, 5, -7),
                    ang = Angle(0, -90, 0)
                }
            }
        }
    },
    ["muzzle"] = {
        WMElements = {
            {
                Model = "models/sw_battlefront/weapons/emp_rifle.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(1400, 100, 450),
                    ang = Angle(-12, 0, 180),
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(2800, 0, -600),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        },
    }
}
WMOverride = "models/sw_battlefront/weapons/emp_rifle.mdl"

--SWEP.Attachments = {         
--}

-- Don't touch this unless you know what you're doing
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire",
        SoundTable = {
            {s = "armas3/gl_fire_1.wav", t = 0.1/30},
        },
    },
    ["fire_iron"] = {
        Source = "fire_iron",
        SoundTable = {
            {s = "armas3/gl_fire_1.wav", t = 0.1/30},
        },
    },
    ["draw"] = {
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
        LHIK = true,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "everfall/weapons/miscellaneous/reload/overheat/overheat_overheated_large_var_04.mp3", t = 0.1/30},
            {s = "everfall/weapons/miscellaneous/reload/reset/overheatactivecoolingsuccess_var_01.mp3", t = 2},
        },
    },
}

SWEP.Hook_FireBullets = function(wep, data)
    if CLIENT then return end
    if not wep:GetOwner():IsPlayer() then wep:SetClip1(wep:Clip1() + 1) return end

    if wep:GetOwner():GetAmmoCount(wep.Primary.Ammo) <= 0 then return end
    wep:GetOwner():RemoveAmmo(1, wep.Primary.Ammo)

    if math.random() <= 1 then
        wep:SetClip1(wep:Clip1() + 1)
    end
end