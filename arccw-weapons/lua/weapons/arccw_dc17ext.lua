AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-17 Extended"
SWEP.Trivia_Class = "Blaster Pistol"
SWEP.Trivia_Desc = "Blaster pistol for CQB."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Low Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/bf2017/c_scoutblaster.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.IconOverride = "materials/entities/rw_sw_dc17ext.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 30
SWEP.RangeMin = 120
SWEP.DamageMin = 30
SWEP.Range = 350
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
SWEP.Primary.ClipSize = 25

SWEP.Recoil = 0.7
SWEP.RecoilPunch = 0.6
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.31

SWEP.Delay = 60 / 255
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
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

--- Mobility
SWEP.SpeedMult = 1

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --

SWEP.MuzzleFlashColor = Color(0, 0, 255)


----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "weapons/bf3/dc17.wav"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-3.945, -12, 1.15),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterpistol_04.mp3",
     ViewModelFOV = 60,
}
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(3, -4, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5, -10,-20)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(20.824, -16, 4.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"dc17"}

SWEP.AttachmentElements = {
    ["dc17"] = {
        VMElements = {
            {
                Model = "models/arccw/fisher/extendeddc17/extendeddc17.mdl",
                Bone = "v_scoutblaster_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(0, 0, 0.2),
                    ang = Angle(0, 180, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/fisher/extendeddc17/extendeddc17.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(450.5, 150.5, -200.53),
                    ang = Angle(0, -90, 180)
                }
            }
        },-- change the world model to something else. Please make sure it's compatible with the last one.
    },
}
WMOverride = "models/arccw/fisher/extendeddc17/extendeddc17.mdl"


SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.1,
        SoundTable = {
            {
                s = "draw/gunfoley_pistol_draw_var_10.mp3", -- sound; can be string or table
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
 --       Time = 3.35,
        SoundTable = {
            {s = "ArcCW_dc17.reload2", t = 1 / 30}, --s sound file
        },
    },

sound.Add({
    name =          "ArcCW_dc17.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/pistols.wav"
    }),
}