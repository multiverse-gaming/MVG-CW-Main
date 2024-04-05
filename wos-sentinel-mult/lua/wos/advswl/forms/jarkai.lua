local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Jar'Kai"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_DUAL

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
	[ "run" ] = "r_run",
	[ "idle" ] = "r_idle",
	[ "light_left" ] = {
		Sequence = "r_c2_t2",
		Time = 0.7,
		Rate = 0.6,
	},
	[ "light_right" ] = {
		Sequence = "r_right_t2",
		Time = 1.1,
		Rate = 0.9,
	},
	[ "light_forward" ] = {
		Sequence = "r_c6_t3",
		Time = 0.65,
		Rate = 0.7,
	},
	[ "air_left" ] = {
		Sequence =  "vanguard_a_left_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 0.5,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.6,
		Rate = 1.5,
	},
	[ "heavy" ] = {
		Sequence = "r_c4_t3",
		Time = 0.7,
		Rate = 0.7,
	},
	[ "heavy_charge" ] = "r_c6_charge",
}

FORM.Stances[2] = {
	[ "run" ] = "b_run",
	[ "idle" ] = "b_idle",
	[ "light_left" ] = {
		Sequence = "b_left_t2",
		Time = 1.0,
		Rate = 0.5,
	},
	[ "light_right" ] = {
		Sequence = "pure_h_s1_t3",
		Time = 0.8,
		Rate = 0.6,
	},
	[ "light_forward" ] = {
		Sequence = "b_c2_t3",
		Time = 0.5,
		Rate = 0.4,
	},
	[ "air_left" ] = {
		Sequence =  "vanguard_a_left_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 0.5,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.6,
		Rate = 1.5,
	},
	[ "heavy" ] = {
		Sequence = "pure_r_s2_t1",
		Time = 0.7,
		Rate = 0.3,
	},
	[ "heavy_charge" ] = "b_left_charge",
}

FORM.Stances[3] = {
	[ "run" ] = "vanguard_f_run",
	[ "idle" ] = "vanguard_f_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_r_left_t3",
		Time = 1.0,
		Rate = 0.8,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_r_s3_t2",
		Time = 1.2,
		Rate = 0.9,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_r_right_t3",
		Time = 0.55,
		Rate = 0.7,
	},
	[ "air_left" ] = {
		Sequence =  "vanguard_a_left_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 0.5,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.6,
		Rate = 1.5,
	},
	[ "heavy" ] = {
		Sequence = "vanguard_r_right_t2",
		Time = 1.0,
		Rate = 0.5,
	},
	[ "heavy_charge" ] = "vanguard_taunt_reverse",
}

wOS:RegisterNewForm( FORM )