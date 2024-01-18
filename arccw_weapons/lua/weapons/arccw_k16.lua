AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Galactic TFA Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "K-16 'Bryar'"
SWEP.Trivia_Class = "Galactic Blaster Pistol"
SWEP.Trivia_Desc = "A Blaster pistol for shooting enviroments"
SWEP.Trivia_Manufacturer = "Forged Armory"
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
    scale = 0.09
}

SWEP.IconOverride = "materials/entities/rw_sw_k16.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 65
SWEP.RangeMin = 80
SWEP.DamageMin = 65
SWEP.Range = 310
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 1050


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_purple"
SWEP.TracerCol = Color(148, 0, 211)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 12

SWEP.Recoil = 0.34
SWEP.RecoilPunch = 0.4
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.17

SWEP.Delay = 60 / 145
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 0
    },
}

SWEP.AccuracyMOA = 5.7 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(148, 0, 211)


----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.ShootSound = "w/m57.wav"
SWEP.IronSightStruct = {
    Pos = Vector(-3.94, -8, 0.85),
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

SWEP.DefaultElements = {"k16"}

SWEP.AttachmentElements = {
    ["k16"] = {
        VMElements = {
            {
                Model = "models/arccw/hauptmann/star wars/weapons/bryar_pistol.mdl",
                Bone = "v_scoutblaster_reference001",
                Scale = Vector(1.05, 1.05, 1.05),
                Offset = {
                    pos = Vector(-0, -05, -05.3),
                    ang = Angle(0, 90, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/hauptmann/star wars/weapons/bryar_pistol.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(100, 20, 20.3),
                    ang = Angle(-15, 0, 180)
                }
            }
        },
    },
}
WMOverride = "models/arccw/hauptmann/star wars/weapons/bryar_pistol.mdl" -- change the world model to something else. Please make sure it's compatible with the last one.

--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights", -- used to display the "no attachment" text
        Slot = "swoptic_module",
        VMScale = Vector(0.8, 0.8, 0.8),
        WMScale = Vector(9, 9, 9),
        Bone = "v_scoutblaster_reference001", -- relevant bone any attachments wwill be mostly referring to
        Offset = {
            vpos = Vector(0, -2.4, 3.1),
            vang = Angle(0, 180, 0),
            wpos = Vector(70, 20, -70),
            wang = Angle(-15, 90, 180)
        },
    },
--[[    [2] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment",
        VMScale = Vector(0.8, 0.8, 0.8), -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        WMScale = Vector(9, 9, 9),
        Bone = "v_scoutblaster_reference001", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, -12, -0.5),
            vang = Angle(0, 90, 0),
            wpos = Vector(160, 20, -50),
            wang = Angle(-15, 0, 180)
        },
    },    
    [3] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
    },
    [4] = {
        PrintName = "Training/Perk", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "perk",
    },
    [5] = {
        PrintName = "Charms", -- print name
        DefaultAttName = "No Charm", -- used to display the "no attachment" text
        Slot = {"charm"},
        WMScale = Vector(8, 8, 8),
        Bone = "scoutblaster_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1.2, 0.9, 7),
            vang = Angle(90, 0, -90),
            wpos = Vector(100, 30, -50),
            wang = Angle(-10, 0, 180)
        },
    },    --]]      
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
                s = "draw/gunfoley_pistol_draw_var_06.mp3", -- sound; can be string or table
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