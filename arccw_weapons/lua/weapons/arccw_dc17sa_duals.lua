AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-15SA Duals"
SWEP.Trivia_Class = "Republic Experimental Blaster Pistol"
SWEP.Trivia_Desc = "Heavy blaster pistol for CQB enviroments"
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Low Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.NoHideLeftHandInCustomization = true

SWEP.ViewModel = "models/meeks/viewmodels/v_dual_dc15sa.mdl"
SWEP.WorldModel = "models/shared/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

SWEP.IconOverride = "materials/entities/duals_dc15sa.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 40
SWEP.RangeMin = 135
SWEP.DamageMin = 40
SWEP.Range = 355000000000
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 30

SWEP.Recoil = 0.7
SWEP.RecoilPunch = 0.6
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.31

SWEP.Delay = 60 / 400
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

SWEP.AccuracyMOA = 5.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.SpeedMult = 1
SWEP.ShootWhileSprint = true


SWEP.NoFlash = nil -- disable light flash
-- SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false -- Use Gmod muzzle effects rather than particle effects

SWEP.MuzzleEffectAttachment = "1" -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect
SWEP.MuzzleFlashColor = Color(0, 0, 250)

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 50
SWEP.ShootPitch = 100

SWEP.DistantShootSound = "dc17/SW01_Weapons_Blasters_Shared_Corebass_Close_Tight_VAR_02 0 0 0.mp3"
SWEP.ShootSound = "w/dc15sa.wav"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-0.3, -2, 0.65),
    Ang = Angle(0, 0, 0),
    Midpoint = { -- Where the gun should be at the middle of it's irons
        Pos = Vector(0, 0, 0),
        Ang = Angle(0, 0, 0),
    },
    Magnification = 1,
    CrosshairInSights = true,
}
SWEP.HoldtypeHolstered = ""
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = ""

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-0, -5, -2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(-0.5, -10,-10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(0, -4, -1)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.DefaultElements = {"dc15sa+"}

SWEP.AttachmentElements = {
    ["dc15sa+"] = {
        WMElements = {
            {
                Model = "models/cs574/weapons/dc15sa.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(95, 15, 30),
                    ang = Angle(180, -180, 2)
                }
            },
            {
                Model = "models/cs574/weapons/dc15sa.mdl",
                Bone = "ValveBiped.Bip01_L_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(25, 230, -15),
                    ang = Angle(180, -180, 2)
                }
            },
        },            -- change the world model to something else. Please make sure it's compatible with the last one.
    }
}
WMOverride = "models/cs574/weapons/dc15sa.mdl"


SWEP.Animations = {
    ["idle"] = {
        Source = "Idle",
    },
    ["fire"] = {
        Source = {"shoot_l", "shoot_r"},
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
    ["bash"] = {
        Source = "bash",
    },
    ["enter_inspect"] = {
        Source = "lookat01",
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
        SoundTable = {
            {s = "w/dc15sa_reload.wav", t = 0 / 30}, --s sound file
        },
    },
}
