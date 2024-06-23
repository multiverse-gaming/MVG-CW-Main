AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons - V2"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "Z-6 (V2)"
SWEP.Trivia_Class = "Rotary Blaster Cannon"
SWEP.Trivia_Desc = "A powerful chain gun."
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Heavy Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/meeks/viewmodels/z6-rotatory-blaster.mdl"
SWEP.WorldModel = "models/meeks/worldmodels/w_z6_me.mdl"
SWEP.ViewModelFOV = 60
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(9.5, 0, 0),
    ang = Angle(0, 0, -180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}

SWEP.IconOverride = "materials/entities/z6_pub.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.NoHideLeftHandInCustomization = true

SWEP.Damage = 25
SWEP.RangeMin = 120
SWEP.DamageMin = 25
SWEP.Range = 350
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
SWEP.Primary.ClipSize = 200

SWEP.Recoil = 0.28
SWEP.RecoilSide = 0.25
SWEP.RecoilPunch = 2
SWEP.VisualRecoilMult = 0
SWEP.RecoilRise = 0.34

--[[SWEP.Hook_ModifyRPM = function(wep, delay)
    return delay / Lerp(wep:GetBurstCount() / 15, 1, 3)
end --]]

SWEP.Delay = 60 / 900
SWEP.Num = 1

SWEP.BobMult = 1

SWEP.TriggerDelay = true

SWEP.Firemodes = {
    {
        Mode = 2,
    },
   --[[ {
        Mode = 2,
        Mult_RPM = 2800 / 2400,
        PrintName = "2800RPM"
    }, --]]
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 30 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Bipod_Integral = true -- Integral bipod (ie, weapon model has one)
SWEP.BipodDispersion = 0.8 -- Bipod dispersion for Integral bipods
SWEP.BipodRecoil = 0.5 -- Bipod recoil for Integral bipods

SWEP.NoFlash = nil -- disable light flash
SWEP.MuzzleEffect = nil
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false --
SWEP.MuzzleFlashColor = Color(0, 0, 255)

SWEP.SpeedMult = 0.7
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 1

------- Melee Stuff ---
SWEP.MeleeDamage = 25
SWEP.MeleeRange = 16
SWEP.MeleeDamageType = DMG_CLUB

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 50
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.02

SWEP.ShootSound = "firing/SW02_Blasters_Z6RotaryBlaster_Laser_Close_VAR_01.wav"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.IronSightStruct = {
    Pos = Vector(0, -6, 0),
    Ang = Angle(0, 2, 0),
    Magnification = 1,
    SwitchToSound = "zoom_in/gunfoley_zoomin_blasterheavy_05.mp3",
    CrosshairInSights = true
}
SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "crossbow"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(-2, 0, -3)
SWEP.ActiveAng = Angle(0, 2, 0)

SWEP.SprintPos = Vector(0, -15, -20)
SWEP.SprintAng = Angle(40, 0, -10)

SWEP.HolsterPos = Vector(4, -3, 2)
SWEP.HolsterAng = Vector(-15, 30, -15)

SWEP.CustomizePos = Vector(-2.824, -8, -14.897)
SWEP.CustomizeAng = Angle(30.149, 0.547, 0)


SWEP.DefaultElements = {""}

--[[SWEP.Jamming = true
SWEP.HeatGain = 0.65 -- heat gained per shot
SWEP.HeatCapacity = 75 -- rounds that can be fired non-stop before the gun jams, playing the "fix" animation
SWEP.HeatDissipation = 10 -- rounds' worth of heat lost per second
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatDelayTime = 0.5 ]]

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["fire"] = {
        Source = {"fire_1","fire_2", "fire_3"},
    },
    ["draw"] = {
        Source = "draw",
        Time = 2.1,
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
    ["trigger"] = {
        Source = {"fire_2"},
        SoundTable = {
        {s = "firing/SW02_Blasters_Z6RotaryBlaster_Start_Short_VAR_01.ogg", v = 75,t = 0 / 30, c = CHAN_ITEM},
        },
        Time = 0.5,
    },
    ["bash"] = {
        Source = {"melee_hit_01"},
        SoundTable = {
        {s = "weapons/arccw/melee_hitworld.wav", v = 75,t = 0 / 30, c = CHAN_ITEM},
        },
    },
    ["exit_inspect"] = {
        Source = {"idle"},
    },
    ["reload"] = {
        Source = "reload",
        Time = 4, 
        SoundTable = {
            {s = "reload/in/overheat_overheated_var_01.mp3", t = 0 / 30},
            {s = "reload/out/gunfoley_blaster_draw_var_01.mp3", t = 44 / 30},
            {s = "reload/misc/blasters_deathray_foley_undeploy_var_03.mp3", t = 2.6}, --s sound file
        },
    },
}