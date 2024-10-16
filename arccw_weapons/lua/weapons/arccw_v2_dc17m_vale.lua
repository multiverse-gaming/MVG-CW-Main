AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-17m (Vale)"
SWEP.Trivia_Class = "Blaster Rifle"
SWEP.Trivia_Desc = "High tech DC-17m Blaster Rifle, preffered for long-range combat and general allround usage."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Medium Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/meeks/viewmodels/c_dc17m.mdl"
SWEP.WorldModel = "models/meeks/worldmodels/w_dc-17m.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(-26, 11, -4),
    ang = Angle(170, 180, 0),
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.IconOverride = "materials/entities/rw_sw_dc17m.png"
SWEP.NoHideLeftHandInCustomization = false
SWEP.DefaultBodygroups = "00000000000"
SWEP.DefaultWMBodygroups = "00000000"

SWEP.Damage = 30
SWEP.RangeMin = 550000
SWEP.DamageMin = 30
SWEP.Range = 50000
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 45

SWEP.Recoil = 0.29
SWEP.RecoilSide = 0.11
SWEP.RecoilRise = 0.22

SWEP.Delay = 60 / 900
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = -5,
        RunawayBurst = true,
        AutoBurst = false,
        PostBurstDelay = 0.2,
    },
    {
        Mode = 1
    },
    {
        Mode = 0
    },        
}

SWEP.AccuracyMOA = 4.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

-- Mobility when weapon is out
SWEP.SpeedMult = 1
SWEP.ShootWhileSprint = true
----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 50
SWEP.ShootPitch = 100


SWEP.DistantShootSound = "shared/SW01_Weapons_Blasters_Shared_Corebass_Close_Thumb_VAR_01 0 0 0.ogg"
SWEP.ShootSound = "dc17m/dc17m.wav"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --

SWEP.MuzzleEffectAttachment = "1" -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect
SWEP.MuzzleFlashColor = Color(0, 0, 250)

SWEP.IronSightStruct = {
    Pos = Vector(-6.53, -8, 0.9),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_01.mp3",
     ViewModelFOV = 60,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, -0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(3, 0, 0)
SWEP.SprintAng = Angle(-10, 40, -40)

SWEP.HolsterPos = Vector(0.2, -1, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -10, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"", ""}

SWEP.AttachmentElements = {
    ["dc17m_ext_v2"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
}

--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"rifleoptic","extraoptic"},
        Bone = "optic", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(0.05, 0.4, 3.15),
            vang = Angle(90, 0, -90),
            wpos = Vector(7, 1.5, -7),
            wang = Angle(-10, 0, 180)
        },
    },
    [2] = {
        PrintName = "Magazine",
        DefaultAttName = "No Attachment",
        Slot = "dc17m_magazine",
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.3, 2.3, -3),
            vang = Angle(0, 0, 0),
            wpos = Vector(0, 0, -0),
            wang = Angle(-15, 90, -90)
        },
    },
    [3] = {
        PrintName = "Muzzle",
        DefaultAttName = "No Attachment",
        Slot = "dc17m_muzzle",
        Bone = "optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.05, 1.15, 19.45),
            vang = Angle(90, 0, -90),
            wpos = Vector(22.1, 1.51, -8.7),
            wang = Angle(-10, 0, -90)
        },
    },
    [4] = {
        PrintName = "Energization",
        DefaultAttName = "No Attachment",
        Slot = "dc17m_energization",
    },
    [5] = {
        PrintName = "Perks",
        DefaultAttName = "No Attachment",
        Slot = "dc17m_perk",
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "Fire"
    },
    ["fire_iron"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "Draw",
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
        Source = "Holster",
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
        Source = "Reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        SoundTable = {
            --{s = "viper/weapons/sierra552/wfoly_ar_sierra552_reload_xmag_fast_empty_end.ogg", t = 20 / 60},
            {s = "dc17m/reload/SW02_Weapons_Overheat_ManualCooling_VAR_04 0 0 0.ogg", v = 10 , t = 23 / 60},
            {s = "dc17m/reload/magin.ogg", t = 115 / 60},
            {s = "dc17m/reload/maghit.ogg", t = 132 / 60},
            {s = "dc17m/reload/SCIMisc_Ammo Replenish_01.ogg", t = 139 / 60} --s sound file
        },
    },
}