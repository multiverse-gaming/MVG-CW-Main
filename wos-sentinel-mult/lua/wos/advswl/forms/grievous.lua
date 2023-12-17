local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "General Grievous"

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
    ["pac3"] = { 1, 2, 3 },
}

FORM.Stances = {}

FORM.Stances[1] = {
	[ "run" ] = "b_run",
	[ "idle" ] = "idle_all_angry",
	[ "light_left" ] = {
		Sequence = "pure_h_left_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_r_s3_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_r_c4_t1",
		Time = nil,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "phalanx_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "phalanx_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "grievous_heavy",
		Time = nil,
		Rate = 0.2,
	},
	[ "heavy_charge" ] = "b_left_charge",
}

FORM.Stances[2] = {
	[ "run" ] = "b_run",
	[ "idle" ] = "idle_all_angry",
	[ "light_left" ] = {
		Sequence = "r_left_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "r_right_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_b_s2_t2",
		Time = nil,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "phalanx_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "phalanx_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "vanguard_r_s1_t2",
		Time = nil,
		Rate = 0.2,
	},
	[ "heavy_charge" ] = "b_left_charge",
}

FORM.Stances[3] = {
	[ "run" ] = "b_run",
	[ "idle" ] = "idle_all_angry",
	[ "light_left" ] = {
		Sequence = "r_left_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "r_right_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_b_s2_t2",
		Time = nil,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "phalanx_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "phalanx_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "vanguard_r_s1_t2",
		Time = nil,
		Rate = 0.2,
	},
	[ "heavy_charge" ] = "b_left_charge",
}

wOS:RegisterNewForm( FORM )