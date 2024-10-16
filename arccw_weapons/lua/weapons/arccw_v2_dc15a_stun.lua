AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic Weapons"
SWEP.Credits = { Author1 = "Meeks"}
SWEP.PrintName = "DC-15A (Stun)"
SWEP.Trivia_Class = "Blaster Rifle"
SWEP.Trivia_Desc = "High tech DC-15A Blaster Rifle, preffered for long-range combat and general allround usage."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Medium Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/meeks/dc15a_rifle_meeks.mdl"
SWEP.WorldModel = "models/meeks/worldmodels/w_dc15a_rifle.mdl"
SWEP.ViewModelFOV = 65
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(10, 0, -4),
    ang = Angle(165, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
}

SWEP.IconOverride = "materials/entities/dc15a_stun.png"
SWEP.NoHideLeftHandInCustomization = false
SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 35 -- 35
SWEP.RangeMin = 190
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
SWEP.HullSize = 1

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 30 -- 30

SWEP.Recoil = 0.29 -- 0.29
SWEP.RecoilSide = 0.11 -- 0.11
SWEP.RecoilRise = 0.22 -- 0.22

SWEP.Delay = 60 / 450 -- 60 / 450
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

SWEP.AccuracyMOA = 5.7 -- accuracy in Minutes of Angle. There are 60 MOA in a degree. -- 5.7
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 50 -- 50
SWEP.ShootPitch = 100 -- 100


SWEP.DistantShootSound = "dc15a/SW02_Weapons_Blasters_DC15_Laser_Close_VAR_03 4 1 0.mp3" //dc15a/SW02_Weapons_Blasters_Shared_Corebass_Tight_Close_VAR_02 0 0 0.mp3
SWEP.ShootSound = "dc15a/SW02_Weapons_Blasters_DC15_Laser_Close_VAR_03 4 1 0.mp3"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false

SWEP.MuzzleEffectAttachment = "1" -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect
SWEP.MuzzleFlashColor = Color(0, 0, 250)

SWEP.IronSightStruct = {
    Pos = Vector(-2.82, -12, 1.3),
    Ang = Angle(0, 0, 0),
     Magnification = 1,
     SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_01.mp3",
     ViewModelFOV = 60,
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(1.5, -4, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(3, 0, 0)
SWEP.SprintAng = Angle(-10, 40, -40)

SWEP.HolsterPos = Vector(0.2, -1, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(20.824, -10, 3.897)
SWEP.CustomizeAng = Angle(12.149, 50.547, 45)

SWEP.DefaultElements = {"", ""}

--SWEP.Attachments 
SWEP.Attachments = {
    [1] = {
        PrintName = "Energization", -- print name
        DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
        Slot = "sw_ammo",
    },
}
SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = "fire",
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
        Time = 3,
        LHIK = true,
        LHIKOut = 0.6,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "reloads/heavy.wav", t = 4 / 30}, --s sound file
        },
    },

}