local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Dynamic"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_SINGLE

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
}

FORM.Stances = {}

FORM.Stances[1] = {
	[ "run" ] = "vanguard_b_run",
	[ "idle" ] = "vanguard_f_idle",
	[ "light_left" ] = {
		Sequence = "b_left_t1",
		Time = 0.8,
		Rate = 0.9,
	},
	[ "light_right" ] = {
		Sequence = "b_right_t3",
		Time = 0.9,
		Rate = 0.9,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_r_left_t1",
		Time = 1.0,
		Rate = 0.4,
	},
	[ "air_left" ] = {
		Sequence =  "ryoku_a_left_t1",
		Time = 0.7,
		Rate = 0.9,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 0.7,
		Rate = 0.9,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.7,
		Rate = 1.3,
	},
	[ "heavy" ] = {
		Sequence = "vanguard_h_s1_t3",
		Time = 1.5,
		Rate = 0.5,
	},
	[ "heavy_charge" ] = "ryoku_r_c3_charge",
}

FORM.Stances[2] = {
	[ "run" ] = "ryoku_b_run",
	[ "idle" ] = "pure_h_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_r_s1_t3",
		Time = 0.9,
		Rate = 0.7,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_r_right_t2",
		Time = 1.1,
		Rate = 0.5,
	},
	[ "light_forward" ] = {
		Sequence = "r_c3_t3",
		Time = 0.8,
		Rate = 0.35,
	},
	[ "air_left" ] = {
		Sequence =  "ryoku_a_left_t1",
		Time = 0.7,
		Rate = 0.9,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 0.7,
		Rate = 0.9,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.7,
		Rate = 1.3,
	},
	[ "heavy" ] = {
		Sequence = "pure_h_left_t2",
		Time = 1.8,
		Rate = 1.1,
	},
	[ "heavy_charge" ] = "pure_h_right_charge",
}

FORM.Stances[3] = {
	[ "run" ] = "ryoku_b_run",
	[ "idle" ] = "b_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_r_left_t3",
		Time = 1.0,
		Rate = 0.9,
	},
	[ "light_right" ] = {
		Sequence = "judge_b_s3_t1",
		Time = 0.9,
		Rate = 0.8,
	},
	[ "light_forward" ] = {
		Sequence = "judge_r_s3_t1",
		Time = 0.9,
		Rate = 1.2,
	},
	[ "air_left" ] = {
		Sequence =  "ryoku_a_left_t1",
		Time = 0.7,
		Rate = 0.9,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 0.7,
		Rate = 0.9,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.7,
		Rate = 1.3,
	},
	[ "heavy" ] = {
		Sequence = "judge_b_left_t3",
		Time = 1.5,
		Rate = 0.7,
	},
	[ "heavy_charge" ] = "judge_b_s1_charge",
}

wOS:RegisterNewForm( FORM )