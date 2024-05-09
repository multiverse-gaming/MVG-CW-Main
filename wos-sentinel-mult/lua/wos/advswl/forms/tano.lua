local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Ahsoka"

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
	[ "run" ] = "ryoku_r_run",
	[ "idle" ] = "ryoku_r_idle",
	[ "light_left" ] = {
		Sequence = "ryoku_r_left_t1",
		Time = 0.7,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 0.9,
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
		Sequence = "ryoku_b_s2_t3",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

wOS:RegisterNewForm( FORM )