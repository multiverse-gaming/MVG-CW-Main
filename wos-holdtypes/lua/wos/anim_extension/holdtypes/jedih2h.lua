--=====================================================================
/*		My Custom Holdtype
			Created by tanks( the lad )*/
local DATA = {}
DATA.Name = "jedi Melee"
DATA.HoldType = "wos-custom-jedi"
DATA.BaseHoldType = "melee"
DATA.Translations = {} 

DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = {
	{ Sequence = "ryoku_r_c2_t3", Weight = 1 },
}


DATA.Translations[ ACT_MP_WALK ] = {
	{ Sequence = "ryoku_walk_lower_2", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = {
	{ Sequence = "ryoku_r_c1_t1", Weight = 1 },
	{ Sequence = "ryoku_r_c4_t3", Weight = 1 },
	{ Sequence = "pure_b_s3_t2", Weight = 1 },
		{ Sequence = "pure_b_s3_t2", Weight = 1 },
}

DATA.Translations[ ACT_MP_STAND_IDLE ] = {
	{ Sequence = "phalanx_b_idle", Weight = 1 },
}




DATA.Translations[ ACT_MP_RUN ] = {
	{ Sequence = "judge_Run_lower", Weight = 1 },
}

DATA.Translations[ ACT_MP_JUMP ] = {
	{ Sequence = "jump", Weight = 1 },
}

wOS.AnimExtension:RegisterHoldtype( DATA )
--=====================================================================