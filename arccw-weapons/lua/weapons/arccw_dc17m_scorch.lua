AddCSLuaFile()

SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-17m (Scorch)"
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

SWEP.IconOverride = "materials/entities/rw_sw_dc17m_launcher.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.ShootEntity = "arccw_scorchrocket"

SWEP.Damage = 500
SWEP.DamageMin = 500
SWEP.Range = 950000
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 2100


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1
SWEP.ImpactDecal = "FadingScorch"

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_blue"
SWEP.TracerCol = Color(0, 0, 255)
SWEP.HullSize = 1

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 1

SWEP.Recoil = 0.1
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.18

SWEP.Delay = 60 / 120
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1
    },
    {
        Mode = 0
    },         
}

SWEP.AccuracyMOA = 5.6 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

-- Mobility when weapon is out
SWEP.SpeedMult = 1

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(0, 0, 255)

SWEP.ShootWhileSprint = true

----AMMO / stuff----

SWEP.Primary.Ammo = "rpg_round"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "w/dc17mrocket.wav"

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

SWEP.CustomizePos = Vector(10.824, -2, -5.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.DefaultElements = {"dc17mrocket"}

SWEP.AttachmentElements = {
    ["dc17mrocket"] = {
        VMElements = {
            {
                Model = "models/arccw/sauce/dc17m_rocket.mdl",
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
                Model = "models/arccw/sauce/dc17m_rocket.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(250, 40, -1.5),
                    ang = Angle(-15, -90, 180)
                }
            }
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    },
}

WMOverride = "models/arccw/sauce/dc17m_rocket.mdl"
--SWEP.Attachments 
--[[SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(-0.5, -3, -2),
            vang = Angle(90, 0, -90),
            wpos = Vector(800, 40, -800),
            wang = Angle(-15, 0, 180)
        },
    },
    [2] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector( 1, -2.5, 5),
            vang = Angle(90, 0, 30),
            wpos = Vector(1600, 200, -900),
            wang = Angle(-15, 0, -90)
        },
    },    
    [3] = {
        PrintName = "Foregrip", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = "foregrip",
        Bone = "dlt19_sight", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(-0.3, 5, 4),
            vang = Angle(90, 0, -90),
        },
        NoWM = true,
    },    
    [1] = {
        PrintName = "Ammo", -- print name
        DefaultAttName = "Standard Rocket", -- used to display the "no attachment" text
        Slot = "rocketammo",
    },
    [5] = {
        PrintName = "Training/Perk", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "perk",
    },
    [6] = {
        PrintName = "Charms", -- print name
        DefaultAttName = "No Charm", -- used to display the "no attachment" text
        Slot = {"charm"},
        NoWM = true,
        Bone = "dlt19_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.8, -0.4, -6),
            vang = Angle(90, 0, -90),
        },
    },          
    [7] = {
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
    [8] = {
        PrintName = "Grip", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "grip",
    },    
    [9] = {
        PrintName = "Internal Modifications", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "uc_fg",
    },     
} --]]

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["draw"] = {
        Source = "draw",
        Mult = 2,
        SoundTable = {
            {
                s = "draw/gunfoley_blaster_dc17m_draw_var_03.mp3", -- sound; can be string or table
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