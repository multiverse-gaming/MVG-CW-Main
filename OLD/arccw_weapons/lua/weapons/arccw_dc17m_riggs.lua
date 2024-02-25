AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-17m (Riggs)"
SWEP.Trivia_Class = "Republic Heavy Modular Blaster Rifle"
SWEP.Trivia_Desc = "A rifle built for modular things."
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

SWEP.IconOverride = "materials/entities/rw_sw_dc17m.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 35
SWEP.RangeMin = 190
SWEP.DamageMin = 35
SWEP.Range = 50000
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
SWEP.Primary.ClipSize = 40

SWEP.Recoil = 0.25
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.17

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

SWEP.AccuracyMOA = 4.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

-- Mobility when weapon is out
SWEP.SpeedMult = 1

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(0, 0, 255)

SWEP.ShootWhileSprint = true

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "w/dc17m.wav"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-3.66, -4, -2),
    Ang = Angle(0, 0, 0),
     Magnification = 1.1,
     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_05.mp3",
     ViewModelFOV = 55,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(2, 0, -3)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(1, 0, -1)
SWEP.SprintAng = Angle(-10, 40, -40)

SWEP.HolsterPos = Vector(0.2, -1, -1)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -10, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"dc17mr", "muzzle"}

SWEP.AttachmentElements = {
    ["dc17mr"] = {
        VMElements = {
            {
                Model = "models/arccw/sauce/dc17m_base.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-0.05, 0, 2),
                    ang = Angle(0, 0, 0),
                },
            }
        }
    },
    ["muzzle"] = {
        VMElements = {
            {
                Model = "models/hunter/plates/plate.mdl",
                Bone = "dlt19_sight",
                Scale = Vector(0, 0, 0),
                Offset = {
                    pos = Vector(-2.5, -1, 8),
                    ang = Angle(90, 0, 90)
                },
                IsMuzzleDevice = true,
            },
        }
    },
    ["dc17mag"] = {
        VMElements = {
            {
                Model = "models/arccw/cs574/dc17m/dc17m_mag.mdl",
                Bone = "v_dlt19_reference001",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-0.05, 0, 2),
                    ang = Angle(0, 0, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/sauce/dc17m_base.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(250, 40, -1.5),
                    ang = Angle(-15, -90, 180)
                }
            },
            {
            Model = "models/hunter/plates/plate.mdl",
            Bone = "ValveBiped.Bip01_R_Hand",
            Scale = Vector(0, 0, 0),
            Offset = {
                pos = Vector(2500, 0, -1200),
                ang = Angle(-15, 0, 180)
            },
            IsMuzzleDevice = true
        },            
    }, -- change the world model to something else. Please make sure it's compatible with the last one.
}}

WMOverride = "models/arccw/sauce/dc17m_base.mdl"

SWEP.Attachments = {
    [1] = {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "rifleoptic",
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(-0.5, -3, -2),
            vang = Angle(90, 0, -90),
            wpos = Vector(800, 40, -800),
            wang = Angle(-15, 0, 180)
        },
    },
--[[    [2] = {
        PrintName = "Tactical",
        DefaultAttName = "No Attachment",
        Slot = {"tactical", "tac_pistol"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(1, -2.5, 5),
            vang = Angle(90, 0, 30),
            wpos = Vector(1600, 200, -900),
            wang = Angle(-15, 0, -90)
        },
    },
    [3] = {
        PrintName = "Foregrip",
        DefaultAttName = "No Attachment",
        Slot = "foregrip",
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(-0.3, 5, 4),
            vang = Angle(90, 0, -90),
        },
    },
    [4] = {
        PrintName = "Magazine",
        DefaultAttName = "No Attachment",
        Slot = {},
        NoWM = true,
        DefaultEles = {"dc17mag"},
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, 0, 0),
        },
    },
    [5] = {
        PrintName = "Muzzle",
        DefaultAttName = "No Attachment",
        Slot = {"muzzle", "dlt19_muzzle", "dc15a_muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(-0.4, -2.25, 10),
            vang = Angle(90, 0, -90),
            wpos = Vector(2350, 40, -1120),
            wang = Angle(-15, 0, -90)
        },
    },--]]
    [2] = {
        PrintName = "Energization",
        DefaultAttName = "Standard Energization",
        Slot = "riggsbacta",
    },
--[[    [7] = {
        PrintName = "Training/Perk",
        DefaultAttName = "None",
        Slot = "perk",
    },
    [8] = {
        PrintName = "Charms",
        DefaultAttName = "No Charm",
        Slot = {"charm"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight",
        Offset = {
            vpos = Vector(0.5, -0.4, 5),
            vang = Angle(90, 0, -90),
            wpos = Vector(1500, 200, -670),
            wang = Angle(-10 , 0, 180)
        },
    },
    [9] = {
        PrintName = "Killcounter", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = {"killcounter"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.8, -0.4, -4),
            vang = Angle(90, 0, -90),
            wpos = Vector(400, 200, -390),
            wang = Angle(-15 , 0, 180)
        },
    },   
    [10] = {
        PrintName = "Grip", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "grip",
    },    
    [11] = {
        PrintName = "Internal Modifications", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "uc_fg",
    }--]]
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
        Mult = 1.4,
        SoundTable = {
            {
                s = "draw/gunfoley_blaster_draw_var_01.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 100, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "holster/gunfoley_blaster_sheathe_var_04.mp3", -- sound; can be string or table
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
            {s = "ArcCW_dp24.reload2", t = 4 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "ArcCW_dp24.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "w/rifles.wav"
    }),
}