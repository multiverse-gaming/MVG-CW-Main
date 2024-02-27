DEFINE_BASECLASS("swep_ai_base")

-- No modifications autorized ;)
-- by Xyzzy & ChanceSphere574

SWEP.WorldModel					= "models/weapons/synbf3/w_dlt19.mdl"
SWEP.HoldType					= "ar2"

SWEP.MuzzleEffect 				= ""
SWEP.EnableMuzzleEffect			= false
SWEP.ShellEffect				= ""
SWEP.EnableShellEffect			= false
SWEP.TracerEffect				= "tfa_tracer_red"
SWEP.ReloadSounds				= {{0, "rw_swnpc_reload_heavy"}}
SWEP.ImpactDecal 				= "FadingScorch"

SWEP.ReloadTime					= NPC_WEAPONS_RELOAD_TIME_MED
SWEP.Primary.Damage				= 35
SWEP.Primary.MinDropoffDistance	= NPC_WEAPONS_MIN_DROPOFF_DISTANCE_RIFLE
SWEP.Primary.MaxDropoffDistance	= NPC_WEAPONS_MAX_DROPOFF_DISTANCE_RIFLE
SWEP.Primary.Force				= 1
SWEP.Primary.Spread				= 0.035
SWEP.Primary.SpreadMoveMult		= NPC_WEAPONS_SPREAD_MOVE_MULT_MED
SWEP.Primary.BurstMinShots		= 1
SWEP.Primary.BurstMaxShots		= 1
SWEP.Primary.BurstMinDelay		= 0
SWEP.Primary.BurstMaxDelay		= 0
local RPM 						= 450
SWEP.Primary.FireDelay			= 1/(RPM/60)
SWEP.Primary.NumBullets			= 1
SWEP.Primary.ClipSize			= 36
SWEP.Primary.DefaultClip		= 36
SWEP.Primary.AimDelayMin		= NPC_WEAPONS_MIN_AIM_DELAY_MED
SWEP.Primary.AimDelayMax		= NPC_WEAPONS_MAX_AIM_DELAY_MED
SWEP.Primary.Sound				= "rw_swnpc_ee3a"

SWEP.ClientModel				= {
	model						= "models/arccw/sw_battlefront/weapons/ee3_noscope.mdl",
	pos							= Vector(0, -0.5, -0),
	angle						= Angle(180, 180, 0),
	size						= Vector(1.2, 1.2, 1.2),
	color						= Color(255, 255, 255, 255),
	skin						= 0,
	bodygroup					= {},
}