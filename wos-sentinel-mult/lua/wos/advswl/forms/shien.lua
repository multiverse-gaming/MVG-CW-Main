local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Shien"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_BOTH

--What user groups are able to use this form? And which stances?
FORM.UserGroups = { 
    ["superadmin"] = { 1, 2, 3 },
    ["headadmin"] = { 1, 2, 3 },
    ["admin"] = { 1, 2, 3 },
    ["mod"] = { 1, 2, 3 },
    ["trialmod"] = { 1, 2, 3 },
    ["advisor"] = { 1, 2, 3 },
    ["veteran"] = { 1, 2, 3 },
    ["pacvip"] = { 1, 2, 3 },
	["user"] = { 1, 2, 3 },
    ["noaccess"] = { 1, 2, 3 },
    ["pac3"] = { 1, 2, 3 },
}

FORM.Stances = {}

FORM.Stances[1] = {
	[ "run" ] = "vanguard_f_run",
	[ "idle" ] = "wos_bs_shared_Run_lower", --zombie_run_upperbody_layer --vanguard_b_idle
	[ "light_left" ] = {
		Sequence = "h_right_t3", --vanguard_b_s4_t2
		Time = 0.5,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "r_right_t2", --vanguard_taunt_heavy
		Time = 0.5,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_b_s3_t2",
		Time = 0.6,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s1_t1",
		Time = 0.6,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "h_right_t2", --phalanx_h_right_t1
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "judge_r_s3_charge",
}

FORM.Stances[2] = {
	[ "run" ] = "vanguard_b_run",
	[ "idle" ] = "wos_bs_shared_Run_lower", 
	[ "light_left" ] = {
		Sequence = "h_right_t3", --ryoku_r_c4_t3
		Time = 0.4,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "r_right_t2",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_b_s2_t2",
		Time = 0.8,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s1_t1",
		Time = 0.6,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "h_right_t2",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "judge_r_s3_charge",
}

FORM.Stances[3] = {
	[ "run" ] = "vanguard_h_run",
	[ "idle" ] = "wos_bs_shared_Run_lower",
	[ "light_left" ] = {
		Sequence = "r_right_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "r_right_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_h_s1_t1",
		Time = 0.85,
		Rate = 1.5,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s1_t1",
		Time = 0.6,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "h_right_t2",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "judge_r_s3_charge",
}

wOS:RegisterNewForm( FORM )