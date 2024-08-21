local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Ataru"

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
	[ "run" ] = "vanguard_b_run",
	[ "idle" ] = "vanguard_b_idle",
	[ "light_left" ] = {
		Sequence = "pure_b_left_t3",
		Time = 1,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "pure_b_right_t3",
		Time = 1,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "pure_b_s2_t3",
		Time = 1,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "h_c1_t2",
		Time = 1,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "h_c2_t2",
		Time = 1,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "h_c3_t3",
		Time = 2,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "pure_b_s3_t3",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "walflip_back",
}

FORM.Stances[2] = {
	[ "run" ] = "vanguard_b_run",
	[ "idle" ] = "vanguard_b_idle",
	[ "light_left" ] = {
		Sequence = "pure_h_left_t1",
		Time = 0.4,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "pure_b_right_t2",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "pure_r_s3_t3",
		Time = 0.8,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "pure_a_left_t1",
		Time = 1,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "pure_a_right_t1",
		Time = 1,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "pure_a_s1_t1",
		Time = 1,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "pure_h_s2_t3",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "pure_r_s3_charge",
}

FORM.Stances[3] = {
		[ "run" ] = "vanguard_b_run",
	[ "idle" ] = "vanguard_b_idle",
	[ "light_left" ] = {
		Sequence = "pure_h_left_t1",
		Time = 0.4,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "pure_b_right_t3",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "pure_r_s2_t1",
		Time = 0.8,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "pure_a_left_t2",
		Time = 1,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "pure_a_right_t2",
		Time = 1,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "pure_a_s2_t1",
		Time = 1,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "pure_h_s1_t3",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "pure_r_s2_charge",
}

wOS:RegisterNewForm( FORM )