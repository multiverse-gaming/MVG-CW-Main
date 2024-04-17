local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Vapaad"

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
	[ "run" ] = "ryoku_b_run",
	[ "idle" ] = "vanguard_f_idle",
	[ "light_left" ] = {
		Sequence = "pure_h_left_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_b_right_t1",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "b_c3_t1",
		Time = 1.3,
		Rate = 0.4,
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
		Sequence = "flourish_bow_basic",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "h_c1_charge",
}

FORM.Stances[2] = {
	[ "run" ] = "ryoku_b_run",
	[ "idle" ] = "vanguard_f_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_b_s4_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "phalanx_h_right_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "h_c2_t2",
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
		Sequence = "r_c4_t3",
		Time = nil,
		Rate = nil,
	},
	[ "heavy_charge" ] = "r_c4_charge",
}

FORM.Stances[3] = {
	[ "run" ] = "ryoku_b_run",
	[ "idle" ] = "vanguard_f_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_b_s4_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "phalanx_h_right_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "h_c2_t2",
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
		Sequence = "r_c4_t3",
		Time = nil,
		Rate = nil,
	},
	[ "heavy_charge" ] = "r_c4_charge",
}

wOS:RegisterNewForm( FORM )