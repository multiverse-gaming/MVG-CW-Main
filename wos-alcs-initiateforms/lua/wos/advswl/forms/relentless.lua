local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Relentless"

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
	[ "run" ] = "judge_b_run",
	[ "idle" ] = "judge_h_idle",
	[ "light_left" ] = {
		Sequence = "pure_r_s2_t3",
		Time = 0.9,
		Rate = 1.4,
	},
	[ "light_right" ] = {
		Sequence = "judge_r_s2_t2",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "light_forward" ] = {
		Sequence = "pure_r_s3_t1",
		Time = 0.7,
		Rate = 1.6,
	},
	[ "air_left" ] = {
		Sequence =  "ryoku_b_left_t1",
		Time = 0.7,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_b_right_t1",
		Time = 0.6,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_b_s2_t2",
		Time = 0.7,
		Rate = 1.3,
	},
	[ "heavy" ] = {
		Sequence = "judge_h_s3_t3",
		Time = 1.2,
		Rate = 1.8,
	},
	[ "heavy_charge" ] = "judge_h_s3_",
}

FORM.Stances[2] = {
	[ "run" ] = "ryoku_h_run",
	[ "idle" ] = "ryoku_h_idle",
	[ "light_left" ] = {
		Sequence = "ryoku_h_left_t3",
		Time = nil,
		Rate = 1.3,
	},
	[ "light_right" ] = {
		Sequence = "ryoku_h_right_t3",
		Time = 1.3,
		Rate = 1.6,
	},
	[ "light_forward" ] = {
		Sequence = "judge_r_s2_t1",
		Time = 0.7,
		Rate = 0.8,
	},
	[ "air_left" ] = {
		Sequence =  "pure_a_left_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "air_right" ] = {
		Sequence = "pure_a_right_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "air_forward" ] = {
		Sequence = "pure_a_s1_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "heavy" ] = {
		Sequence = "pure_h_s2_t2",
		Time = 1.4,
		Rate = 1.7,
	},
	[ "heavy_charge" ] = "pure_h_s2_charge",
}

FORM.Stances[3] = {
	[ "run" ] = "b_run",
	[ "idle" ] = "b_idle",
	[ "light_left" ] = {
		Sequence = "h_c3_t1",
		Time = 0.9,
		Rate = 1.3,
	},
	[ "light_right" ] = {
		Sequence = "b_c4_t2",
		Time = 1.2,
		Rate = 0.5,
	},
	[ "light_forward" ] = {
		Sequence = "b_c3_t3",
		Time = 1.2,
		Rate = 0.6,
	},
	[ "air_left" ] = {
		Sequence =  "pure_a_left_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "air_right" ] = {
		Sequence = "pure_a_right_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "air_forward" ] = {
		Sequence = "pure_a_s1_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "heavy" ] = {
		Sequence = "b_c3_t1",
		Time = 1.3,
		Rate = 0.4,
	},
	[ "heavy_charge" ] = "b_c3_charge",
}

wOS:RegisterNewForm( FORM )