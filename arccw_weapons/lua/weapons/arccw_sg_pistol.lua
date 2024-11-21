AddCSLuaFile()

SWEP.Base = "arccw_masita_base"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2

-- Trivia
SWEP.Category = "[ArcCW] Kraken's Special Forces Pack"
SWEP.Credits = "Kraken"
SWEP.PrintName = "The Last Word"
SWEP.Trivia_Class = "Blaster Revolver"
SWEP.Trivia_Desc = "Yours, until the last flame dies and all words have been spoken."
SWEP.IconOverride = "entities/sopsmisc/thelastword.png"

SWEP.HideViewmodel = false
SWEP.UseHands = true
SWEP.ViewModel = "models/arccw/kraken/sops-v2/c_the_last_word.mdl"
SWEP.WorldModel = "models/arccw/bf2017/w_e11.mdl"
SWEP.ViewModelFOV = 58
SWEP.MirrorVMWM = true
SWEP.NoHideLeftHandInCustomization = true
SWEP.WorldModelOffset = {
	pos = Vector(-19, 6, -5),
	ang = Angle(-10, 0, 180)
}

SWEP.Damage = 250
SWEP.RangeMin = 143
SWEP.DamageMin = 250
SWEP.Range = 298
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.MuzzleVelocity = 800

SWEP.TracerNum = 1
SWEP.TracerCol = Color(25, 125, 255)
SWEP.TracerWidth = 10
SWEP.PhysTracerProfile = "apex_bullet_energy"
SWEP.Tracer = "arccw_apex_tracer_energy_sniper"
SWEP.HullSize = 0.5
SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 8
SWEP.AmmoPerShot = 1

SWEP.Recoil = 1.63
SWEP.RecoilSide = 0.2
SWEP.RecoilRise = 0.62

SWEP.Delay = 60 / 150
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

SWEP.AccuracyMOA = 0.5
SWEP.HipDispersion = 200
SWEP.MoveDispersion = 50

SWEP.NoFlash = nil
--SWEP.MuzzleEffect = "wpn_muzzleflash_dc17"
SWEP.FastMuzzleEffect = nil
SWEP.GMMuzzleEffect = false 

SWEP.MuzzleEffectAttachment = 1 
SWEP.ProceduralViewBobAttachment = 1
SWEP.MuzzleFlashColor = Color(0, 0, 250)

-- Ammo & Stuff
SWEP.Primary.Ammo = "ar2"
SWEP.ShootVol = 150
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0.2

SWEP.FirstShootSound = "sops-v2/weapons/revolvers.wav"
SWEP.ShootSound = "sops-v2/weapons/revolvers.wav"
SWEP.ShootSoundSilenced = "sops-v2/weapons/silenced.mp3"

SWEP.IronSightStruct = {
	Pos = Vector(-5.373, -11.532, 1.552),
	Ang = Angle(0, 0, 0),
	 Magnification = 1.5,
	 SwitchToSound = "sops-v2/interaction/zoom_start.mp3",
	 SwitchFromSound = "sops-v2/interaction/zoom_end.mp3",
	 ViewModelFOV = 60,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "revolver"
SWEP.HoldtypeSights = "revolver"
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER

SWEP.ActivePos = Vector(-1, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, -20)
SWEP.SprintAng = Angle(40, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Vector(-15, 0, 0)

SWEP.CustomizePos = Vector(10, -13, 0)
SWEP.CustomizeAng = Angle(12, 50.5, 45)

-- Attachments 
SWEP.Attachments = {
	[1] = {
		PrintName = "Energization", -- print name
		DefaultAttName = "Standard Energization", -- used to display the "no attachment" text
		Slot = {"sw_ammo","gaexecute"},
	},
    [2] = {
        PrintName = "Perk",
        DefaultAttName = "None",
        Slot = { "WPRevPerk", "PistolWhip" },
    },
}

SWEP.Animations = {
	["idle"] = {
		Source = "idle"
	},
	["fire"] = {
		Source = {"shoot"},
		Time = 0.9,
	},
	["fire_iron"] = {
		ShellEjectAt = 0,
		Source = {"shoot"}
	},
	["draw"] = {
		Source = "draw",
		SoundTable = {
			{
				s = "sops-v2/interaction/equip.wav",
				p = 100, 
				v = 75, 
				t = 0.1,
				c = CHAN_ITEM,
			},
		}
	},
	["holster"] = {
		Source = "holster",
		SoundTable = {
			{
				s = "sops-v2/interaction/equip2.wav",
				p = 100, 
				v = 75, 
				t = 0.1,
				c = CHAN_ITEM,
			},
		}
	},
	["reload"] = {
		Source = "reload",
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
		SoundTable = {
			{s = "sops-v2/weapons/revolver_reload.wav", t = 0.1 / 30},
		},
	},
}
