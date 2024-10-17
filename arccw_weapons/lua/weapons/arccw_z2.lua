AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Galactic Weapons"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "Z-2"
SWEP.Trivia_Class = "Galactic Rotary Canon Blaster"
SWEP.Trivia_Desc = "A powerful chain gun."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Heavy Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/arccw/bf2017/c_t21.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_t21.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = true
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.009
}

SWEP.IconOverride = "materials/entities/rw_sw_z2.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 25
SWEP.RangeMin = 95
SWEP.DamageMin = 16
SWEP.Range = 325
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 400


SWEP.TraceNum = 1
SWEP.PhysTracerProfile = 1

SWEP.TracerNum = 1
SWEP.Tracer = "tfa_tracer_yellow"
SWEP.TracerCol = Color(255, 165, 18)
SWEP.HullSize = 1.5

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 150

SWEP.Recoil = 0.28
SWEP.RecoilSide = 0.25
SWEP.RecoilPunch = 2
SWEP.RecoilRise = 0.34

SWEP.Delay = 245 / 2400
SWEP.Num = 1

SWEP.BobMult = 1

SWEP.Firemodes = {
	{
		Mode = 2,
	},
}

SWEP.AccuracyMOA = 0.55 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 330 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Bipod_Integral = true -- Integral bipod (ie, weapon model has one)
SWEP.BipodDispersion = 0.8 -- Bipod dispersion for Integral bipods
SWEP.BipodRecoil = 0.5 -- Bipod recoil for Integral bipods

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(255, 165, 18)

SWEP.SpeedMult = 0.5
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 1

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.02

SWEP.ShootSound = "w/z6.wav"

SWEP.IronSightStruct = {
    Pos = Vector(0, -12, -4),
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_05.mp3",
    CrosshairInSights = true
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "crossbow"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(4, -10, -8)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5, -30, -20)
SWEP.SprintAng = Angle(40, 0, -10)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(0, 0, 0)

SWEP.CustomizePos = Vector(20.824, -4, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.DefaultElements = {"z6"}

SWEP.AttachmentElements = {
    ["z6"] = {
        VMElements = {
            {
                Model = "models/arccw/sw_battlefront/weapons/Z6_Rotary_Cannon_Skin.mdl",
                Bone = "v_t21_reference001",
                Scale = Vector(1.2, 1.1, 1.2),
                Offset = {
                    pos = Vector(.1, -0.3, 1),
                    ang = Angle(0,-90, 0)
                }
            }
        },
        WMElements = {
            {
                Model = "models/arccw/sw_battlefront/weapons/Z6_Rotary_Cannon_Skin.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(3.75, 2.5, -1.5),
                    ang = Angle(-10, 0, 180)
                }
            }
        }, -- change the world model to something else. Please make sure it's compatible with the last one.
    },
}

WMOverride = "models/arccw/sw_battlefront/weapons/Z6_Rotary_Cannon_Skin.mdl"

SWEP.Jamming = true
SWEP.HeatGain = 0.8 -- heat gained per shot
SWEP.HeatCapacity = 75 -- rounds that can be fired non-stop before the gun jams, playing the "fix" animation
SWEP.HeatDissipation = 10 -- rounds' worth of heat lost per second
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatDelayTime = 0.5

--SWEP.Attachments 
--[[SWEP.Attachments = {       
    [1] = {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = {"tactical","tac_pistol"},
        WMScale = Vector(111, 111, 111),
        Bone = "t21_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, 0.6, 35),
            vang = Angle(90, 0, 0),
            wpos = Vector(4000, 50, -1000),
            wang = Angle(-10, 0, -90)
        },
    },            
    [2] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "ammo",
    },
    [3] = {
        PrintName = "Training/Perk", -- print name
        DefaultAttName = "None", -- used to display the "no attachment" text
        Slot = "perk",
    },
    [4] = {
        PrintName = "Charms", -- print name
        DefaultAttName = "No Charm", -- used to display the "no attachment" text
        Slot = {"charm"},
        Bone = "t21_sight", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.2, 1, 29),
            vang = Angle(90, 0, -90),
        },
    },          
}--]]

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
                s = "draw/blasters_deathray_foley_undeploy_var_03.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 200, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["holster"] = {
        Source = "holster",
        SoundTable = {
            {
                s = "holster/blasters_deathray_foley_undeploy_var_02.mp3", -- sound; can be string or table
                p = 100, -- pitch
                v = 75, -- volume
                t = 0, -- time at which to play relative to Animations.Time
                c = CHAN_ITEM, -- channel to play the sound
            },
        }
    },
    ["reload"] = {
        Source = "reload", 
        SoundTable = {
            {s = "ArcCW_dc15a.reload2", t = 4 / 30}, --s sound file
        },
    },


sound.Add({
    name =          "ArcCW_z6.reload2",
    channel =       CHAN_ITEM,
    volume =        1.0,
    sound =             "weapons/bf3/heavy.wav"
    }),
}