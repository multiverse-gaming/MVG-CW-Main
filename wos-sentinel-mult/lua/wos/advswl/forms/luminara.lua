local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Luminara"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_BOTH

--What user groups are able to use this form? And which stances?
FORM.UserGroups = { 
    ["superadmin"] = { 1, 2 },
    ["headadmin"] = { 1, 2 },
    ["admin"] = { 1, 2 },
    ["mod"] = { 1, 2 },
    ["trialmod"] = { 1, 2 },
    ["advisor"] = { 1, 2 },
    ["veteran"] = { 1, 2 },
    ["pacvip"] = { 1, 2 },
	["user"] = { 1, 2 },
    ["noaccess"] = { 1, 2 },
    ["pac3"] = { 1, 2 },
}

FORM.Stances = {}

FORM.Stances[1] = {
	[ "run" ] = "b_run",
	[ "idle" ] = "b_idle",
	[ "light_left" ] = {
		Sequence = "h_right_t3", --vanguard_b_s4_t2
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "judge_r_s3_t2",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "b_c3_t1",
		Time = 1.3,
		Rate = 0.4,
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
		Sequence = "phalanx_b_s1_t1",
		Time = 2.0,
		Rate = 0.5,
	},
	[ "heavy_charge" ] = "phalanx_b_s4_charge",
}

FORM.Stances[2] = {
	[ "run" ] = "ryoku_b_run",
	[ "idle" ] = "ryoku_b_idle",
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
		Sequence = "phalanx_r_s1_t2",
		Time = 0.5,
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
		Sequence = "phalanx_b_s1_t1",
		Time = 2.0,
		Rate = 0.5,
	},
	[ "heavy_charge" ] = "phalanx_b_s4_charge",
}

wOS:RegisterNewForm( FORM )