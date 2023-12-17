if not ATTACHMENT then

	ATTACHMENT = {}

end



ATTACHMENT.Name = "Sniper Module"

ATTACHMENT.ShortName = "S.M."

ATTACHMENT.Icon = "entities/dc17m_sniper.png"

ATTACHMENT.Description = {

    TFA.AttachmentColors["="], "Change for the Sniper module.", 

    TFA.AttachmentColors["+"], "+550 Damage", 

    TFA.AttachmentColors["+"], "+600% Accuracy",

    TFA.AttachmentColors["-"], "+180 RPM",

    TFA.AttachmentColors["-"], "+100% Kickback",

    TFA.AttachmentColors["="], "2 Cells/Clip",

}



ATTACHMENT.WeaponTable = {

	["VElements"] = {

		["rifle_module"] = {["active"] = false},

		["rifle_mag"] = {["active"] = false},

		["sniper_module"] = {["active"] = true},

		["sniper_module_scope"] = {["active"] = true},

		["sniper_module_hp1"] = {["active"] = true},

		["sniper_module_hp2"] = {["active"] = true},

		["sniper_mag"] = {["active"] = true},

	},

	["WElements"] = {

		["rifle_module"] = {["active"] = false},

		["rifle_mag"] = {["active"] = false},

		["sniper_module"] = {["active"] = true},

		["sniper_module_scope"] = {["active"] = true},

		["sniper_module_hp1"] = {["active"] = true},

		["sniper_module_hp2"] = {["active"] = true},

		["sniper_mag"] = {["active"] = true},

	},



	["Primary"] = {

		["Sound"] = "w/dc19.wav",

		["KickUp"] = function(wep,stat) return stat * 2 end,

		["KickDown"] = function(wep,stat) return stat * 2 end,

		["ClipSize"] = 5,

		["RPM"] = 50,

		["Damage"] = 500,

		["IronAccuracy"] = 0.0005,

	},

	["IronSightsPos"] = function( wep, val ) return wep.Scope1Pos or val, true end,

	["IronSightTime"] = function( wep, stat ) return stat * 1.5 end,

	["IronSightMoveSpeed"] = function(stat) return stat * 0.8 end,

	["RTOpaque"] = true,

	["RTMaterialOverride"] = -1,

	["RTScopeAttachment"] = -1,

	["Secondary"] = {

		["ScopeZoom"] = function(wep, val) return 12 end,

		

	},

	["AllowSprintAttack"] = false,

	["Scoped_3D"] = true,

}



ATTACHMENT.Reticule = "cs574/scopes/battlefront_hd/sw_ret_redux_black"





function ATTACHMENT:Attach(wep)

	wep:Unload()

end



function ATTACHMENT:Detach(wep)

	wep:Unload()

end



if not TFA_ATTACHMENT_ISUPDATING then

	TFAUpdateAttachments()

end