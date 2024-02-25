local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Vos"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_SINGLE

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
		Sequence = "vanguard_h_left_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "ryoku_b_right_t1",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_r_left_t1",
		Time = 0.7,
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
		Sequence = "pure_h_s1_t3",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "pure_r_s2_charge",
}

wOS:RegisterNewForm( FORM )