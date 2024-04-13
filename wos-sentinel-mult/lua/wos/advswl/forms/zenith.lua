local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Zenith"

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
    ["pac3"] = { 1, 2, 3 },
}

FORM.Stances = {}

FORM.Stances[1] = {
	[ "run" ] = "judge_b_run",
	[ "idle" ] = "judge_h_idle",
	[ "light_left" ] = {
		Sequence = "judge_b_left_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_r_right_t2",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "judge_r_s3_t2",
		Time = 0.85,
		Rate = 1.5,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.4,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.4,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s1_t1",
		Time = 0.4,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "flourish_heavy",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "wos_bs_shared_taunt_heavy",
}

FORM.Stances[2] = {
	[ "run" ] = "ryoku_h_run",
	[ "idle" ] = "ryoku_h_idle",
	[ "light_left" ] = {
		Sequence = "r_left_t2",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_b_right_t2",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_h_left_t3",
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
		Sequence = "judge_r_s1_t1",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "pure_taunt_reverse",
}

FORM.Stances[3] = {
	[ "run" ] = "b_run",
	[ "idle" ] = "b_idle",
	[ "light_left" ] = {
		Sequence = "judge_b_left_t3",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "judge_h_s1_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "judge_r_s3_t2",
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
		Sequence = "vanguard_r_right_t1",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "taunt_balanced",
}

wOS:RegisterNewForm( FORM )