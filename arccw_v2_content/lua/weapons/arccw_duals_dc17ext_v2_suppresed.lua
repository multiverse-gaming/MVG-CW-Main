AddCSLuaFile()

SWEP.Base = "arccw_meeks_sw_base"
SWEP.Spawnable = true
SWEP.Category = "[ ArcCW ] Republic TFA Weapons - V2"
SWEP.Credits = { Author1 = "cat"}
SWEP.PrintName = "Dual DC-17 Ext. (Suppressed)"
SWEP.Trivia_Class = "Heavy Blaster Pistol"
SWEP.Trivia_Desc = "Heavy blaster pistol for CQB enviroments"
SWEP.Trivia_Manufacturer = "BlasTech Industries"
SWEP.Trivia_Calibre = "Low Density Bolt"
SWEP.Trivia_Mechanism = "Energized Compressed Tibanna"
SWEP.Trivia_Country = "GAR"
SWEP.Trivia_Year = 2020

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/meeks/viewmodels/c_dc17_ext_1_dual.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_scoutblaster.mdl"
SWEP.ViewModelFOV = 90
SWEP.HideViewmodel = false
SWEP.WorldModelOffset = {
    pos = Vector(0, 0, 0),
    ang = Angle(0, 0, 0),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 0.09
}

SWEP.NoHideLeftHandInCustomization = true

SWEP.IconOverride = "materials/entities/dual_dc17ext_supressed.png"

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 30
SWEP.RangeMin = 135
SWEP.DamageMin = 30
SWEP.Range = 355
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

SWEP.Recoil = 0.29
SWEP.RecoilSide = 0.11
SWEP.RecoilRise = 0.22

SWEP.Delay = 60 / 520
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
SWEP.MoveDispersion = 50

---Mobility
SWEP.SpeedMult = 1
SWEP.ShootWhileSprint = true

SWEP.ShootWhileSprint = true

SWEP.NoFlash = true -- disable light flash
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false -- Use Gmod muzzle effects rather than particle effects

SWEP.MuzzleEffectAttachment = "1" -- which attachment to put the muzzle on
SWEP.ProceduralViewBobAttachment = 1 -- attachment on which coolview is affected by, default is muzzleeffect
SWEP.MuzzleFlashColor = Color(0, 0, 250)

----AMMO / stuff----

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 500
SWEP.ShootPitch = 100

SWEP.DistantShootSound = "w/dc19.wav"--"dc17/SW01_Weapons_Blasters_Shared_Corebass_Close_Tight_VAR_02 0 0 0.mp3"
SWEP.ShootSound = "w/dc19.wav"--"dc17/SW02_Weapons_Blasters_DC17_Laser_Close_VAR_07 0 0 0.mp3"
SWEP.ShootSoundSilenced = "w/dc19.wav"

SWEP.IronSightStruct = {
    Pos = Vector(0, -0, 0),
    Ang = Angle(0, 0, 0),
    Midpoint = { -- Where the gun should be at the middle of it's irons
        Pos = Vector(0, 0, 0),
        Ang = Angle(0, 0, 0),
    },
    Magnification = 1,
    CrosshairInSights = false,
}
SWEP.HoldtypeHolstered = ""
SWEP.HoldtypeActive = "duel"
SWEP.HoldtypeSights = ""

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, -5, -0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, -10,-10)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.ReloadPos = Vector(0, -4, 2)
SWEP.ReloadAng = Angle(-10, -0, -0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(-0.5, -8, -4.897)
SWEP.CustomizeAng = Angle(30, 0, 0)

SWEP.DefaultElements = {"nil", "dc17ext+"}

SWEP.AttachmentElements = {
    ["nil"] = {
        WMElements = {
            {
                Model = "models/arccw/fisher/extendeddc17/extendeddc17.mdl",
                Bone = "ValveBiped.Bip01_R_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(30, 15, -10),
                    ang = Angle(180, -90, 2)
                }
            },
            {
                Model = "models/arccw/fisher/extendeddc17/extendeddc17.mdl",
                Bone = "ValveBiped.Bip01_L_Hand",
                Scale = Vector(1.1, 1.1, 1.1),
                Offset = {
                    pos = Vector(-50, 230, -55),
                    ang = Angle(180, -90, 2)
                }
            },
        },            -- change the world model to something else. Please make sure it's compatible with the last one.
    }
}
WMOverride = "models/arccw/SW_Battlefront/Weapons/dc17_blaster.mdl" -- change the world model to something else. Please make sure it's compatible with the last one.

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 2,
    },
    ["fire"] = {
        Source = {"fire_left", "fire_right"},
    },
    ["ready"] = {
        Source = "deploy",
    },
    ["enter_sight"] = {
        Source = "neutral",
    },
    ["draw"] = {
        Source = "idle",
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
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PHYSGUN,
        Time = 2,
        SoundTable = {
            -- {s = "dc17ext/untitled.ogg", t = 1 / 30},
            {s = "dc17ext/SCIMisc_Insert Ammo_04.ogg", t = 4 / 30},
            {s = "dc17ext/wfoly_pi_mike9_reload_fast_xmags_end.ogg", t = 30 / 30}, --s sound file
        },
    },
    ["bash"] = {
        Source = "melee",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        Time = 2,
    },
}
function SWEP:ChooseShootAnim(ifp, ...)
	if self:Clip1() == 2 then
		return self:PlayAnimation(self:GetStat("Animations.shoot1_empty"))
	elseif self:Clip1() == 1 then
		return self:PlayAnimation(self:GetStat("Animations.shoot2_empty"))
	end

	return BaseClass.ChooseShootAnim(self, ifp, ...)
end
