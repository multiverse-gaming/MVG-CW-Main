AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Galactic TFA Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "Bowcaster"
SWEP.Trivia_Class = "Laser Crossbow"
SWEP.Trivia_Desc = "preffered for long-range combat and general allround usage."
SWEP.Trivia_Manufacturer = "Forged Industries"
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

SWEP.IconOverride = "materials/entities/rw_sw_bowcaster.png"
SWEP.NoHideLeftHandInCustomization = false
SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 80
SWEP.RangeMin = 135
SWEP.DamageMin = 80
SWEP.Range = 400
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400

SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_green"
SWEP.TracerCol = Color(0, 250, 0)
SWEP.HullSize = 1

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 15

SWEP.Recoil = 0.54
SWEP.RecoilSide = 0.11
SWEP.RecoilRise = 0.22

SWEP.Delay = 60 / 138
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },          
}

SWEP.AccuracyMOA = 0.01 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200
SWEP.SightsDispersion = 0

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "w/bowcaster.wav"

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false

SWEP.MuzzleFlashColor = Color(0, 255, 0)

SWEP.IronSightStruct = {
    Pos = Vector(-3.2, -3, 1.2),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_01.mp3",
     ViewModelFOV = 60,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(1, -4, -2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(3, 0, 0)
SWEP.SprintAng = Angle(-10, 40, -40)

SWEP.HolsterPos = Vector(1, -2, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -10, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"bowcaster"}

SWEP.AttachmentElements = {
    ["bowcaster"] = {
        VMElements = {
            {
                Model = "models/arccw/hauptmann/star wars/weapons/bowcaster.mdl", -- using the model-edit i made in like 2 mins lol
                Bone = "v_dlt19_reference001",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(0.4, 3, -6.8),
                    ang = Angle(0,-90, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/hauptmann/star wars/weapons/bowcaster.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(600, 2.5, 500),
                    ang = Angle(-15, 0, 180)
                }
            }
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    },
}
WMOverride = "models/arccw/hauptmann/star wars/weapons/bowcaster.mdl"
--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = "optic",
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(-0.01, -0.2, -4.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(360, 0, -600),
            wang = Angle(-15, 0, 180)
        },
    },
--[[    [2] = {
        PrintName = "Foregrip", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = "foregrip",
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(-0.1, 3.28, 7),
            vang = Angle(90, 0, -90),
            wang = Angle(170, 180, 0),
        },
        SlideAmount = {
            vmin = Vector(-0, 3.0, 8),
            vmax = Vector(-0, 3.0, 8),
            wmin = Vector(1500, 0, -580), 
            wmax = Vector(1500, 0, -580)  -- how far this attachment can slide in both directions.
        },
    },          
    [3] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, 3.5, 10),
            vang = Angle(90, 0, -90),
            wpos = Vector(1750, 0, -600),
            wang = Angle(-15, 0, -180)
        },
    },     
    [4] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
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
        WMScale = Vector(111, 111, 111),
        Bone = "dlt19_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, 3, 0),
            vang = Angle(90, 0, -90),
            wpos = Vector(900, 70, -470),
            wang = Angle(-10 , 0, 180)
        },
    },          --]]
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