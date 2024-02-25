
--=====================================================================
/*		My Custom Holdtype
			Created by Drugz*/
local DATA = {}
DATA.Name = "Energy Sword"
DATA.HoldType = "bigsword"
DATA.BaseHoldType = "melee"
DATA.Translations = {} 

DATA.Translations[ ACT_MP_STAND_IDLE ] = {
	{ Sequence = "b_idle", Weight = 1 },
}

DATA.Translations[ ACT_MP_WALK ] = {
	{ Sequence = "walk_suitcase", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = {
	{ Sequence = "vanguard_b_s4_t3", Weight = 1 },
	{ Sequence = "vanguard_b_left_t1", Weight = 1 },
	{ Sequence = "wos_ryoku_r_c6_t3", Weight = 1 },
	{ Sequence = "wos_ryoku_r_c6_t1", Weight = 1 },
}

DATA.Translations[ ACT_MP_ATTACK_STAND_SECONDARYFIRE ] = {
	{ Sequence = "judge_b_block_left", Weight = 1 },

}

DATA.Translations[ ACT_MP_RELOAD_STAND ] = {
	{ Sequence = "taunt_zombie", Weight = 1 },
}



DATA.Translations[ ACT_MP_RUN ] = {
	{ Sequence = "ryoku_h_run", Weight = 1 },
}

DATA.Translations[ ACT_MP_JUMP ] = {
	{ Sequence = "balanced_jump", Weight = 1 },
}

wOS.AnimExtension:RegisterHoldtype( DATA )
--=====================================================================