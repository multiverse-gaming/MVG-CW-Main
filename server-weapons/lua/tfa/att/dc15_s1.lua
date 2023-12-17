if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "DLT-19X Scope"
ATTACHMENT.ShortName = "S1"
ATTACHMENT.Icon = "entities/att/s1.png"
ATTACHMENT.Description = { 
    --TFA.AttachmentColors["="], "", 
    TFA.AttachmentColors["+"], "Zoom x12", 
    --TFA.AttachmentColors["-"], "", 
}

ATTACHMENT.WeaponTable = {

	["VElements"] = {
		["scope_base"] = {
			["active"] = true
		},
		["scope1"] = {
			["active"] = true
		},
		["scope1_ret"] = {
			["active"] = true
		},
		["ammo_counter_s1"] = {
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
		["scope1"] = {
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
	["IronSightsPos"] = function( wep, val ) return wep.Scope1Pos or val, true end,
	["IronSightsAng"] = function( wep, val ) return wep.Scope1Ang or val, true end,
	["IronSightTime"] = function( wep, val ) return val * 1.5 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.8 end,
	["RTOpaque"] = true,
	["RTMaterialOverride"] = -1,
	["RTScopeAttachment"] = -1,
	["IronSightsSensitivity"] = 0.1,

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