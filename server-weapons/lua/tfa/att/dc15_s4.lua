if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "E-11 Scope"
ATTACHMENT.ShortName = "S4"
ATTACHMENT.Icon = "entities/att/s4.png"
ATTACHMENT.Description = { 
    --TFA.AttachmentColors["="], "", 
    TFA.AttachmentColors["+"], "Zoom x6", 
    --TFA.AttachmentColors["-"], "", 
}

ATTACHMENT.WeaponTable = {

	["VElements"] = {
		["scope_base"] = {
			["active"] = true
		},
		["scope4"] = {
			["active"] = true
		},
		["scope4_ret"] = {
			["active"] = true
		},
		["ammo_counter_s4"] = {
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
		["scope4"] = {
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
	["IronSightsPos"] = function( wep, val ) return wep.Scope4Pos or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.Scope4Ang or val, true end,
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