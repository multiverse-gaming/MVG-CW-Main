if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "E-44 Scope"
ATTACHMENT.ShortName = "S7"
ATTACHMENT.Icon = "entities/att/s7.png"
ATTACHMENT.Description = { 
    --TFA.AttachmentColors["="], "", 
    TFA.AttachmentColors["+"], "Zoom x8",
    --TFA.AttachmentColors["-"], "", 
}

ATTACHMENT.WeaponTable = {

	["VElements"] = {
		["scope_base"] = {
			["active"] = true
		},
		["scope7"] = {
			["active"] = true
		},
		["scope7_ret"] = {
			["active"] = true
		},
		["ammo_counter_s7"] = {
			["active"] = true
		},
		["iron"] = {
			["active"] = false
		}
	},

	["WElements"] = {
		["scope_base"] = {
			["active"] = true
		},
		["scope7"] = {
			["active"] = true
		},
		["iron"] = {
			["active"] = false
		}
	},

	["Primary"] = {
		["IronAccuracy"] = 0.0005,
	},

	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 12 end
	},

	["BlowbackVector"] = Vector(0,-0.75,0),
	["IronSightsPos"] = function( wep, val ) return wep.Scope7Pos or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.Scope7Ang or val, true end,
	["IronSightTime"] = function( wep, val ) return val * 1.5 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.8 end,
	["RTOpaque"] = true,
	["RTMaterialOverride"] = -1,
	["RTScopeAttachment"] = -1,
	["IronSightsSensitivity"] = 0.25,
	["Scoped_3D"] = true,
}


function ATTACHMENT:Attach(wep)
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end