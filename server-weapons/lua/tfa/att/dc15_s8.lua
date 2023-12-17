if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "A280-CFE Scope"
ATTACHMENT.ShortName = "S8"
ATTACHMENT.Icon = "entities/att/s8.png"
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
		["scope8"] = {
			["active"] = true
		},
		["scope8_ret"] = {
			["active"] = true
		},
		["ammo_counter_s8"] = {
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
		["scope8"] = {
			["active"] = true
		},
		["iron"] = {
			["active"] = false
		}
	},

	["Primary"] = {
		["IronAccuracy"] = 0.0005,
	},

	["BlowbackVector"] = Vector(0,-0.75,0),
	["IronSightsPos"] = function( wep, val ) return wep.Scope8Pos or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.Scope8Ang or val, true end,
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