AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons - V2"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-15 (Ultimate)"
SWEP.Trivia_Class = "Blaster Rifle"
SWEP.Trivia_Desc = "High tech DC-15A Blaster Rifle, preffered for long-range combat and general allround usage."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Medium Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/meeks/v_dc15x.mdl"
SWEP.WorldModel = "models/meeks/worldmodels/w_dc15x_v2.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(10, 0, -4),
    ang = Angle(165, 180, 0),
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.IconOverride = "materials/entities/rw_sw_dc15x.png"
SWEP.NoHideLeftHandInCustomization = false
SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 35
SWEP.RangeMin = 1
SWEP.DamageMin = 35
SWEP.Range = 550000
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
SWEP.Primary.ClipSize = 45

SWEP.Recoil = 0.29
SWEP.RecoilSide = 0.11
SWEP.RecoilRise = 0.22

SWEP.Delay = 60 / 450
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

SWEP.AccuracyMOA = 5.7 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200
SWEP.SightsDispersion = 0

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 50
SWEP.ShootPitch = 100

SWEP.SpeedMult = 0.85



--SWEP.DistantShootSound = "shared/snipers/Shared_Corebass_Close_Sniper_VAR_03 0 4 0.ogg"
--SWEP.ShootSound = "dc15x/SW02_Weapons_Blaster_DLT19X_Laser_Close_VAR_01 3 0 0.mp3"
--SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.DistantShootSound = "dc15a/SW02_Weapons_Blasters_Shared_Corebass_Tight_Close_VAR_02 0 0 0.mp3"
SWEP.ShootSound = "dc15a/SW02_Weapons_Blasters_DC15_Laser_Close_VAR_03 4 1 0.mp3"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false

SWEP.MuzzleEffectAttachment = "1" -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect
SWEP.MuzzleFlashColor = Color(0, 0, 250)

SWEP.IronSightStruct = {
    Pos = Vector(-2.74, -12, 1.45),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_01.mp3",
     ViewModelFOV = 60,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(1.5, -5, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(3, 0, 0)
SWEP.SprintAng = Angle(-10, 40, -40)

SWEP.HolsterPos = Vector(0.2, -1, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -10, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"dc15x", ""}

-- SWEP.AttachmentElements = {
--     ["dc15x"] = {
--         VMMaterial = "asdzxc.vmt",
--     }
-- }

--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = {"optic","extraoptic","thermaloptic"},
        -- WMScale = Vector(111, 111, 111),
        Bone = "sights", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(-0.03, -0.87, 8.0),
            vang = Angle(90, 0, -90),
            wpos = Vector(17, 1, -8.5),
            wang = Angle(-16, 0, 180)
        },
        --CorrectiveAng = Angle(-2.2, -0, 0)
    },
    [2] = {
        PrintName = "Internal Modifications", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = {"ultimatesniper","ultimateshotgun","sw_ammo"},
    },
}
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["draw"] = {
        Source = "draw",
        SoundTable = {
            {
                s = "draw/gunfoley_blaster_draw_var_04.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "draw/gunfoley_blaster_draw_var_08.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        Time = 3,
        LHIK = true,
        LHIKOut = 0.6,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "reloads/heavy.wav", t = 4 / 30}, --s sound file
        },
    },

}