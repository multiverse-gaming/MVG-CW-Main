AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons - V2"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "Dual DC-17s (V1 - WIP)"
SWEP.Trivia_Class = "Blaster Carbine"
SWEP.Trivia_Desc = "High tech compact DC15S Blaster Carbine, preffered for CQB enviroments and general allround usage."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Medium Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/strasser/weapons/c_ddeagle.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 90
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

SWEP.IconOverride = "materials/entities/rw_sw_dual_dc17s.png"

SWEP.DefaultBodygroups = "000000000000"
SWEP.NoHideLeftHandInCustomization = true
SWEP.Damage = 30
SWEP.RangeMin = 145
SWEP.DamageMin = 17
SWEP.Range = 400
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

SWEP.Recoil = 0.44
SWEP.RecoilPunch = 0.6
SWEP.RecoilSide = 0.17
SWEP.RecoilRise = 0.22

SWEP.Delay = 60 / 340
SWEP.Num = 1
SWEP.Firemodes = {
	{
		Mode = 1
	},
    {
        Mode = 2
    },
    {
        Mode = 0
    },        
}

SWEP.AccuracyMOA = 0.45 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 410 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 35


----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100

SWEP.DistantShootSound = "dc17/SW01_Weapons_Blasters_Shared_Corebass_Close_Tight_VAR_02 0 0 0.mp3"
SWEP.ShootSound = "dc17/SW02_Weapons_Blasters_DC17_Laser_Close_VAR_07 0 0 0.mp3"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.MuzzleFlashColor = Color(0, 0, 255, 50)

SWEP.IronSightStruct = {
    Pos = Vector(0, -4, 1),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "",
     ViewModelFOV = 90,
}
SWEP.HoldtypeHolstered = ""
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = ""


SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, -5, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, -14,-10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-25, 0, 0)


SWEP.ReloadPos = Vector(0, -10, -5)

SWEP.CustomizePos = Vector(-0.5, -8, -4.897)
SWEP.CustomizeAng = Angle(30, 0, 0)

SWEP.InBipodPos = Vector(-8, 0, -4)
SWEP.InBipodMult = Vector(2, 1, 1)
SWEP.DrawCrosshair = true

SWEP.BarrelLength = 60
SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(3, 0, -3)
SWEP.DefaultElements = {"dc17s", "dc17s+"}

SWEP.AttachmentElements = {
    ["dc17s"] = {
        VMElements = {
            {
                Model = "models/arccw/fisher/dc17s/dc17s.mdl",
                Bone = "LeftHand_1stP",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(9.5, 2.5, -0.7),
                    ang = Angle(85, -10, 90)
                }
            }
        },
    },
    ["dc17s+"] = {
         VMElements = {
            {
                Model = "models/arccw/fisher/dc17s/dc17s.mdl",
                Bone = "RightHand_1stP",
                Scale = Vector(1, 1, 1),                
                Offset = {
                    pos = Vector(-9, -3.3, 2.2),
                    ang = Angle(85, -10, -90)
                }
            }
        }, 
        WMElements = {
            {
                Model = "models/arccw/fisher/dc17s/dc17s.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(80, 20, -30),
                    ang = Angle(180, -90, 2)
                }
            },
            {
                Model = "models/arccw/fisher/dc17s/dc17s.mdl",
                Bone = "ValveBiped.Bip01_L_Hand",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(-10, 230, -80),
                    ang = Angle(180, -90, 2)
                }
            },
        },            -- change the world model to something else. Please make sure it's compatible with the last one.
    }
}
WMOverride = "models/arccw/fisher/dc17s/dc17s.mdl"

--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        Bone = "RightHand_1stP", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-9.5, -2.3, 2),
            vang = Angle(168, 4, -90),
        },
    },    
    [2] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
    },
    [3] = {
        PrintName = "Grip", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "grip",
    },    
    [4] = {
        PrintName = "Internal Modifications", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "uc_fg",
    },   
}   


SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"shoot_lw", "shoot_rw"},
    },
    ["draw"] = {
        Source = "draw",
        Mult = 1.5,
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
        Time = 3.35,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
        SoundTable = {
            {s = "ArcCW_dc17.reload2", t = 4 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "ArcCW_dc17.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/pistols.wav"
    }),
}