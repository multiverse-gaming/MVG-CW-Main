--=====================================================================
/*		My Custom Holdtype
			Created by SeZu( STEAM_0:0:27711570 )*/
local DATA = {}
DATA.Name = "Magna Staff"
DATA.HoldType = "electrostaff [wos]"
DATA.BaseHoldType = "melee"
DATA.Translations = {} 

DATA.Translations[ ACT_MP_STAND_IDLE ] = {
	{ Sequence = "H_idle", Weight = 1 },
}

DATA.Translations[ ACT_MP_WALK ] = {
	{ Sequence = "ryoku_walk_lower_2", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = {
	{ Sequence = "ryoku_r_c2_t3", Weight = 1 },
	{ Sequence = "vanguard_r_right_t2", Weight = 1 },
	{ Sequence = "vanguard_b_s3_t2", Weight = 1 },
	{ Sequence = "vanguard_r_right_t3", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_SECONDARYFIRE ] = {
	{ Sequence = "phalanx_r_block", Weight = 1 },

}

DATA.Translations[ ACT_MP_RELOAD_STAND ] = {
	{ Sequence = "taunt_heavy", Weight = 1 },
}



DATA.Translations[ ACT_MP_RUN ] = {
	{ Sequence = "phalanx_b_run", Weight = 1 },
}

DATA.Translations[ ACT_MP_JUMP ] = {
	{ Sequence = "balanced_jump", Weight = 1 },
}
DATA.Translations[ ACT_MP_CROUCH_IDLE ] = {
	{ Sequence = "judge_b_block_right", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = {
	{ Sequence = "pure_b_s2_t1", Weight = 1 },
}

DATA.Translations[ ACT_MP_CROUCHWALK ] = {
	{ Sequence = "ryoku_walk_lower_2", Weight = 1 },
}
wOS.AnimExtension:RegisterHoldtype( DATA )
--=====================================================================