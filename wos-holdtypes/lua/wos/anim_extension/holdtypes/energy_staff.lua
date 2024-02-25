--=====================================================================
/*		My Custom Holdtype
			Created by tanks( the lad )*/
local DATA = {}
DATA.Name = "Magna Staff2"
DATA.HoldType = "wos-test1"
DATA.BaseHoldType = "melee2"
DATA.Translations = {} 

DATA.Translations[ ACT_MP_STAND_IDLE ] = {
	{ Sequence = "vanguard_f_idle", Weight = 1 },
}

DATA.Translations[ ACT_MP_WALK ] = {
	{ Sequence = "ryoku_walk_lower_2", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = {
		{ Sequence = "r_c4_t3", Weight = 1 },
			{ Sequence = "phalanx_b_s3_t2", Weight = 1 },
			{ Sequence = "ryoku_r_c1_t3", Weight = 1 },
}



DATA.Translations[ ACT_MP_RUN ] = {
	{ Sequence = "ryoku_r_run", Weight = 1 },
}

DATA.Translations[ ACT_MP_JUMP ] = {
	{ Sequence = "wos_bs_shared_jump", Weight = 1 },
}

wOS.AnimExtension:RegisterHoldtype( DATA )
--=====================================================================