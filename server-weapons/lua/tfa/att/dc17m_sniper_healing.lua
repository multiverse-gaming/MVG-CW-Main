if not ATTACHMENT then

	ATTACHMENT = {}

end



ATTACHMENT.Name = "Sniper Module Healing"

ATTACHMENT.ShortName = "S.M.H"

ATTACHMENT.Icon = "entities/atts/dc15sa_overload_cell.png"

ATTACHMENT.Description = {

    TFA.AttachmentColors["="], "Change for the Sniper module healing version.",

    TFA.AttachmentColors["+"], "100 Healing",

    TFA.AttachmentColors["+"], " 1||0 Accuracy",

    TFA.AttachmentColors["-"], "60 RPM",

    TFA.AttachmentColors["-"], "+100% Kickback",

    TFA.AttachmentColors["="], "6 Cells/Clip",

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

		["Sound"] = "w/dc17msniper.wav",

		["KickUp"] = function(wep,stat) return stat * 2 end,

		["KickDown"] = function(wep,stat) return stat * 2 end,

		["ClipSize"] = 6,

		["RPM"] = 150,

		["Damage"] = 0,

		["IronAccuracy"] = 0.0010,

		["Spread"] = 0.07,

	},

	["IronSightsPos"] = function( wep, val ) return wep.Scope1Pos or val, true end,

	["IronSightTime"] = function( wep, stat ) return stat * 1.5 end,

	["IronSightMoveSpeed"] = function(stat) return stat * 0.8 end,

	["RTOpaque"] = true,

	["RTMaterialOverride"] = -1,

	["RTScopeAttachment"] = -1,

	["ProceduralReloadTime"] = 3.5,

	["AllowSprintAttack"] = false,

	["FireModes"] = {"Single"},



	["Secondary"] = {

		["ScopeZoom"] = 5,

	},



	["ScopeReticule_Scale"] = {1.025,1.025},



	["ScopeReticule"] = "cs574/scopes/battlefront_hd/sw_ret_redux_black",

	["Scoped_3D"] = true,

}





function ATTACHMENT:Attach(wep)

	wep:Unload()

	wep:Reload( true )

end





function ATTACHMENT:Detach(wep)

	wep:Unload()

	wep:Reload( true )

end



if not TFA_ATTACHMENT_ISUPDATING then

	TFAUpdateAttachments()

end
