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
	[ "run" ] = "phalanx_h_run",
	[ "idle" ] = "phalanx_h_idle",
	[ "light_left" ] = {
		Sequence = "phalanx_r_left_t3",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "phalanx_b_left_t3",
		Time = 1.0,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "judge_r_s3_t2",
		Time = 1.4,
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