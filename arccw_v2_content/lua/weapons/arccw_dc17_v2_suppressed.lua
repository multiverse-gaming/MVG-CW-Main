AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons - V2"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "DC-17 (Suppressed)"
SWEP.Trivia_Class = "Heavy Blaster Pistol"
SWEP.Trivia_Desc = "Heavy blaster pistol for CQB enviroments"
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Low Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/meeks/v_dc17_meeks.mdl"
SWEP.WorldModel = "models/meeks/worldmodels/w_dc17_v2.mdl"
SWEP.ViewModelFOV = 70
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(11, 0, -4.4),
    ang = Angle(175, 180, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}

SWEP.IconOverride = "materials/entities/dc17_supressed.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 30
SWEP.RangeMin = 90
SWEP.DamageMin = 30
SWEP.Range = 350000
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
SWEP.Primary.ClipSize = 20

SWEP.Recoil = 0.34
SWEP.RecoilPunch = 0.4
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.17

SWEP.Delay = 60 / 350
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
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --

SWEP.MuzzleEffectAttachment = "1" -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect
SWEP.MuzzleFlashColor = Color(0, 0, 250)

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 50
SWEP.ShootPitch = 100

SWEP.DistantShootSound = "dc17/SW01_Weapons_Blasters_Shared_Corebass_Close_Tight_VAR_02 0 0 0.mp3"
SWEP.ShootSound = "dc17/SW02_Weapons_Blasters_DC17_Laser_Close_VAR_07 0 0 0.mp3"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.IronSightStruct = {
    Pos = Vector(-5.4, -0, 0.4),
    Ang = Angle(0, 0, 0),
    Midpoint = { -- Where the gun should be at the middle of it's irons
        Pos = Vector(0, 0, 0),
        Ang = Angle(0, 0, 0),
    },
    Magnification = 1,
    CrosshairInSights = false,
}
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, -3, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(2, -10,-10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(20.824, -16, 4.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {""}

SWEP.Attachments = {
    [1] = {
        PrintName = "Muzzle", -- print name
        DefaultAttName = "No Attachment", -- used to display the "no attachment" text
        Slot = "Silencer",
        Bone = "DC-15SA", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-.4, -1.4, 2),
            vang = Angle(90, 0, -90),
            wpos = Vector(10.2, 1.12, -4.2),
            wang = Angle(-6, 0, 180)
        },
    },        
    [2] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "SDWAmmo",
    },
}


SWEP.Animations = {
    ["idle"] = {
        Source = "Idle",
    },
    ["fire"] = {
        Source = "Fire",
    },
    ["fire_sights"] = {
        Source = "",
        Time = -1,
    },
    ["idle_sights"] = {
        Source = "",
        Time = -1,
    },
    ["enter_sight"] = {
        Source = "neutral",
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
        Time = 2.5,
        SoundTable = {
            {s = "reloads/pistols.wav", t = 1 / 30}, --s sound file
        },
    },
}