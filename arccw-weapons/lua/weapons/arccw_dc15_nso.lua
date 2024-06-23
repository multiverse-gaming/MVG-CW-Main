AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-15 (NSO)"
SWEP.Trivia_Class = "Marksman Blaster"
SWEP.Trivia_Desc = "High tech long-range blaster rifle."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Medium Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/bf2017/c_dlt19.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_dlt19.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.IconOverride = "materials/entities/rw_sw_dc15x.png"

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


--- Mobility
att.Mult_SpeedMult = 0.85

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "weapons/bf3/dc15a.wav"
SWEP.ShootSoundSilenced = "w/dc15x.wav"

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false

SWEP.MuzzleFlashColor = Color(0, 0, 255)

SWEP.IronSightStruct = {
    Pos = Vector(-2.92, -12, 0.75),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_05.mp3",
     ViewModelFOV = 70,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, -4, -3)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(3, 0, 0)
SWEP.SprintAng = Angle(-10, 40, -40)

SWEP.HolsterPos = Vector(0.2, -1, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -10, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"dc15x", "muzzle"}

SWEP.AttachmentElements = {
    ["dc15x"] = {
        VMElements = {
            {
                Model = "models/arccw/cs574/weapons/dc15x_nobipod.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1.2, 1.2, 1.2),
                Offset = {
                    pos = Vector(.7, -0.3, 0.5),
                    ang = Angle(0,-90, 0)
                },
            }
        },
    },
    ["muzzle"] = {
         VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "dlt19_sight",
                Scale = Vector(0, 0, 0),                
                Offset = {
                    pos = Vector(-0.5, 4, 42),
                    ang = Angle(-90, 180, 0)
                },
                IsMuzzleDevice = true
            }
        },    
        WMElements = {
            {
                Model = "models/arccw/cs574/weapons/dc15x_nobipod.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(3.75, 2.5, -1.5),
                    ang = Angle(-15, 0, 180)
                }
            },
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(4600, 0, -1300),
                    ang = Angle(-15, 0, 180)
                },
                IsMuzzleDevice = true
            },            
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    }
}

WMOverride = "models/arccw/cs574/weapons/dc15x_nobipod.mdl" -- change the world model to something else. Please make sure it's compatible with the last one.
--SWEP.Attachments 

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.23, -0.7, 9),
            vang = Angle(90, 0, -90),
            wpos = Vector(1400, 0, -830),
            wang = Angle(-15, 0, 180)
        },
    },
    [2] = {
        PrintName = "Internal Modifications", -- print name
        DefaultAttName = "Standard", -- used to display the "no attachment" text
        Slot = {"ultimateshotgun","sw_ammo"}, --NSO shotgun and stunrounds
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
                s = "draw/overheat_manualcooling_resetfoley_generic_var_04.mp3", -- sound; can be string or table
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
                s = "w/dc15s/gunfoley_blaster_sheathe_var_03.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "ArcCW_dc15a.reload2", t = 4 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "ArcCW_dc15a.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/heavy.wav"
    }),
}