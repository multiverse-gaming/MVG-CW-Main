local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Cin"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_BOTH

--What user groups are able to use this form? And which stances?
FORM.UserGroups = { 
    ["superadmin"] = { 1 },
    ["headadmin"] = { 1 },
    ["admin"] = { 1 },
    ["mod"] = { 1 },
    ["trialmod"] = { 1 },
    ["advisor"] = { 1 },
    ["veteran"] = { 1 },
    ["pacvip"] = { 1 },
	["user"] = { 1 },
    ["noaccess"] = { 1 },
    ["pac3"] = { 1 },
}

FORM.Stances = {}

FORM.Stances[1] = {
	[ "run" ] = "vanguard_h_run",
	[ "idle" ] = "vanguard_h_idle",
	[ "light_left" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 1.3,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_b_right_t1",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "judge_b_s2_t2",
		Time = nil,
		Rate = 0.9,
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
		Sequence = "h_c3_t3",
		Time = 2,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "b_c3_t1",
		Time = nil,
		Rate = 1,
	},
	[ "heavy_charge" ] = "judge_r_s3_charge",
}

wOS:RegisterNewForm( FORM )