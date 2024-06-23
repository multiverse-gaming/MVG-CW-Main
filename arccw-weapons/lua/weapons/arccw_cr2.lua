AddCSLuaFile()



SWEP.Base = "arccw_meeks_sw_base"

SWEP.Spawnable = true

SWEP.Category = "[ ArcCW ] Galactic TFA Weapons"

SWEP.Credits = { Author1 = "cat"}

SWEP.PrintName = "CR-2"

SWEP.Trivia_Class = "Naboo Security Blaster Rifle"

SWEP.Trivia_Desc = "preffered for long-range combat and general allround usage."

SWEP.Trivia_Manufacturer = "Forged Industries"

SWEP.Trivia_Calibre = "Medium Density Bolt"

SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"

SWEP.Trivia_Country = "GAR"

SWEP.Trivia_Year = 2020

SWEP.Slot = 3



SWEP.UseHands = true



SWEP.ViewModel = "models/arccw/bf2017/c_e11.mdl"

SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"

SWEP.ViewModelFOV = 70

SWEP.HideViewmodel = true

SWEP.WorldModelOffset = {

    pos = Vector(0, 0, 0),

    ang = Angle(0, 0, 0),

    bone = "ValveBiped.Bip01_R_Hand",

    scale = 0.009

}



SWEP.IconOverride = "materials/entities/rw_sw_cr2.png"



SWEP.DefaultBodygroups = "000000000000"



SWEP.Damage = 30

SWEP.RangeMin = 80

SWEP.DamageMin = 30

SWEP.Range = 330

SWEP.Penetration = 1

SWEP.DamageType = DMG_BULLET

SWEP.MuzzleVelocity = 400





SWEP.TraceNum = 1

SWEP.PhysTracerProfile = 1



SWEP.TracerNum = 1

SWEP.Tracer = "tfa_tracer_green"

SWEP.TracerCol = Color(0, 255, 0)

SWEP.HullSize = 1.5



SWEP.ChamberSize = 0

SWEP.Primary.ClipSize = 45



SWEP.Recoil = 0.6

SWEP.RecoilSide = 0.2

--SWEP.RecoilRise = 0.22



SWEP.Delay = 60 / 600

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



SWEP.AccuracyMOA = 50 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.

SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.

SWEP.MoveDispersion = 200

-- SWEP.JumpDispersion = 1000



-- Mobility when weapon is out

SWEP.SpeedMult = 1





----AMMO / stuff----



SWEP.Primary.Ammo = "ar2"



SWEP.ShootVol = 100

SWEP.ShootPitch = 100



SWEP.ShootSound = "w/cr2.wav"



SWEP.NoFlash = nil -- disable light flash

SWEP.MuzzleEffect = nil

SWEP.FastMuzzleEffect = nil

SWEP.GMMuzzleEffect = false



SWEP.MuzzleFlashColor = Color(0, 250, 0)



SWEP.IronSightStruct = {

    Pos = Vector(-3.13, -11, 1.85),

    Ang = Angle(0, 0, 0),

     Magnification = 1,

     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_01.mp3",

     ViewModelFOV = 50,

}

SWEP.HoldtypeHolstered = "passive"

SWEP.HoldtypeActive = "smg"

SWEP.HoldtypeSights = "rpg"



SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2



SWEP.ActivePos = Vector(2.9, -4, .5)

SWEP.ActiveAng = Angle(0, 0, 0)



SWEP.SprintPos = Vector(7, -10, 0)

SWEP.SprintAng = Angle(-10, 40, 0)



SWEP.HolsterPos = Vector(0.2, -1, 1)

SWEP.HolsterAng = Vector(-15, 30, -15)



SWEP.CustomizePos = Vector(20.824, -13, 3.897)

SWEP.CustomizeAng = Angle(12.149, 50.547, 45)



SWEP.DefaultElements = {"cr2"}



SWEP.AttachmentElements = {

    ["cr2"] = {

        VMElements = {

            {

                Model = "models/arccw/sw_battlefront/weapons/CR2_Base.mdl",

                Bone = "v_e11_reference001",

                Scale = Vector(1.3, 1.3, 1.3),

                Offset = {

                    pos = Vector(-1.2, -1.5, 0.5),

                    ang = Angle(0, -90, 0)

                }

            }

        },

        WMElements = {

            {

                Model = "models/arccw/sw_battlefront/weapons/CR2_Base.mdl",

                Bone = "ValveBiped.Bip01_R_Hand",

                Scale = Vector(1.1, 1.1, 1.1),

                Offset = {

                    pos = Vector(300, 120, -200),

                    ang = Angle(-15, 0, 180)

                }

            }

        }, -- change the world model to something else. Please make sure it's compatible with the last one.

    },

}



WMOverride = "models/arccw/sw_battlefront/weapons/CR2_Base.mdl"

--SWEP.Attachments 

SWEP.Attachments = {

    [1] = {

        PrintName = "Optic", -- print name

        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text

        Slot = "optic",

        WMScale = Vector(111, 111, 111),

        Bone = "e11_sight", -- relevant bone any attachments wwill be mostly referring to

        Offset = {

            vpos = Vector(0, -0.8, 2),

            vang = Angle(90, 0, -90),

            wpos = Vector(500, 110, -710),

            wang = Angle(-15, 0, 180)

        },

    }

 --[[   [2] = {

        PrintName = "Foregrip", -- print name

        DefaultAttName = "No Attachment", -- used to display the "no attachment" text

        Slot = "foregrip",

        WMScale = Vector(111, 111, 111),

        Bone = "e11_sight", -- relevant bone any attachments wwill be mostly referring to

        Offset = {

            vpos = Vector(0, 3, 12),

            vang = Angle(90, 0, -90),

            wang = Angle(170, 180, 0),

        },

        SlideAmount = {

            vmin = Vector(-0.2, 2.5, 8),

            vmax = Vector(-0.2, 2.5, 11),

            wmin = Vector(1200, 120, -480), 

            wmax = Vector(1200, 120, -480)  -- how far this attachment can slide in both directions.

        },                 

    },

    [3] = {

        PrintName = "Tactical", -- print name

        DefaultAttName = "No Attachment", -- used to display the "no attachment" text

        Slot = {"tactical","tac_pistol"},

        WMScale = Vector(111, 111, 111),

        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to

        Offset = {

            vpos = Vector(1, 1.5, 11),

            vang = Angle(90, 0, 0),

            wpos = Vector(1150, 230, -550),

            wang = Angle(-15, 0, -90)

        },

    },

    [4] = {

        PrintName = "Muzzle", -- print name

        DefaultAttName = "No Attachment", -- used to display the "no attachment" text

        WMScale = Vector(111, 111, 111),

        Slot = {"muzzle","dlt19_muzzle", "dc15a_muzzle", "cr2_muzzle", "cr2c_muzzle", "stealth_muzzle", "b1120_muzzle"},

        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to

        Offset = {

            vpos = Vector(0.1, 2.2, 16.5),

            vang = Angle(90, 0, -90),

            wpos = Vector(1820, 120, -750),

            wang = Angle(-15, 0, -90)

        },

    },             

    [5] = {

        PrintName = "Energization", -- print name

        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text

        Slot = "ammo",

    },

    [6] = {

        PrintName = "Magazine", -- print name

        DefaultAttName = "No Attachment", -- used to display the "no attachment" text

        Slot = {},

        WMScale = true,

        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to

        Offset = {

            vpos = Vector(0.3, 2.3, 4),

            vang = Angle(0, 0, 0),

            wpos = Vector(650, 10, -300),

            wang = Angle(-15, 90, -90)

        },

    },   

    [7] = {

        PrintName = "Training/Perk", -- print name

        DefaultAttName = "None", -- used to display the "no attachment" text

        Slot = "perk",

    },

    [8] = {

        PrintName = "Charms", -- print name

        DefaultAttName = "No Charm", -- used to display the "no attachment" text

        Slot = {"charm"},

        WMScale = Vector(111, 111, 111),

        Bone = "e11_sight", -- relevant bone any attachments will be mostly referring to

        Offset = {

            vpos = Vector(0.7, 1.5, 0),

            vang = Angle(90, 0, -70),

            wpos = Vector(400, 200, -470),

            wang = Angle(-10 , 0, 180)

        },

    },--]]          

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

                s = "w/dc15s/overheat_manualcooling_resetfoley_generic_var_01.mp3", -- sound; can be string or table

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

        Time = 3.35,

        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,

        SoundTable = {

            {s = "ArcCW_dc15a.reload2", t = 1 / 30}, --s sound file

        },

    },





sound.Add({

    name =          "ArcCW_dc15s.reload2",

    channel =       CHAN_ITEM,

    volume =        1.0,

    sound =             "weapons/bf3/pistols.wav"

    }),

}