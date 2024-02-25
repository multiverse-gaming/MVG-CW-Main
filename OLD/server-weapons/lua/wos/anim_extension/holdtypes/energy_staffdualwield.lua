--=====================================================================
/*		My Custom Holdtype
			Created by SeZu( STEAM_0:0:27711570 )*/
local DATA = {}
DATA.Name = "energystaffdualwield"
DATA.HoldType = "wos-test1"
DATA.BaseHoldType = "melee"
DATA.Translations = {} 

DATA.Translations[ ACT_MP_CROUCHWALK ] = {
	{ Sequence = "judge_run_lower", Weight = 1 },
}

DATA.Translations[ ACT_MP_WALK ] = {
	{ Sequence = "vanguard_f_run", Weight = 1 },
}

DATA.Translations[ ACT_MP_RUN ] = {
	{ Sequence = "b_run", Weight = 1 },
}

DATA.Translations[ ACT_MP_STAND_IDLE ] = {
	{ Sequence = "run_lower", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = {
	{ Sequence = "r_c4_t3", Weight = 1 },
}

DATA.Translations[ ACT_MP_CROUCH_IDLE ] = {
	{ Sequence = "b_block_right", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = {
	{ Sequence = "vanguard_b_s3_t2", Weight = 1 },
	{ Sequence = "vanguard_b_s1_t3", Weight = 1 },
	{ Sequence = "vanguard_b_s4_t3", Weight = 1 },
	{ Sequence = "vanguard_b_s2_t2", Weight = 1 },
}

DATA.Translations[ ACT_MP_JUMP ] = {
	{ Sequence = "h_jump", Weight = 1 },
}

wOS.AnimExtension:RegisterHoldtype( DATA )
--=====================================================================
