local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Djem So"

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
	[ "idle" ] = "ryoku_idle_lower",
	[ "run" ] = "ryoku_run_lower",
	[ "light_left" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 1.3,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "judge_r_s3_t2",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "judge_h_left_t3",
		Time = 1.5,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence = "ryoku_a_left_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "vanguard_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "vanguard_b_s4_t3",
		Time = 1.2,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

FORM.Stances[2] = {
	[ "idle" ] = "ryoku_idle_lower",
	[ "run" ] = "ryoku_run_lower",
	[ "light_left" ] = {
		Sequence = "h_right_t3",
		Time = 1.6,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "r_c6_t1",
		Time = 1.2,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_r_c6_t3",
		Time = 1.0,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence = "ryoku_a_left_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "vanguard_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "vanguard_b_s4_t3",
		Time = 1.8,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

FORM.Stances[3] = {
	[ "idle" ] = "ryoku_idle_lower",
	[ "run" ] = "ryoku_run_lower",
	[ "light_left" ] = {
		Sequence = "ryoku_r_c4_t1",
		Time = 1.0,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_h_right_t3",
		Time = 0.8,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = nil,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence = "ryoku_a_left_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "vanguard_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "vanguard_b_s4_t3",
		Time = 1.5,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

wOS:RegisterNewForm( FORM )