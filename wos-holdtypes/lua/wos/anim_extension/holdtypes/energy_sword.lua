--=====================================================================
/*		My Custom Holdtype
			Created by Stan( STEAM_0:1:62885296 )*/
local DATA = {}
DATA.Name = "Energy Sword"
DATA.HoldType = "wos-energy-sword"
DATA.BaseHoldType = "knife"
DATA.Translations = {} 

DATA.Translations[ ACT_MP_STAND_IDLE ] = {
	{ Sequence = "phalanx_r_idle", Weight = 1 },
}

DATA.Translations[ ACT_MP_WALK ] = {
	{ Sequence = "ryoku_walk_lower_2", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = {
	{ Sequence = "b_right_t3", Weight = 1 },
	{ Sequence = "b_right_t2", Weight = 1 },
	{ Sequence = "phalanx_r_s2_t3", Weight = 1 },
}


DATA.Translations[ ACT_MP_RUN ] = {
	{ Sequence = "phalanx_b_run", Weight = 1 },
}

DATA.Translations[ ACT_MP_JUMP ] = {
	{ Sequence = "jump", Weight = 1 },
}

wOS.AnimExtension:RegisterHoldtype( DATA )
--=====================================================================