if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Magazine XL"
ATTACHMENT.ShortName = ""
ATTACHMENT.Icon = "entities/att/mxl.png"
ATTACHMENT.Description = {
    --TFA.AttachmentColors["="], "",
    TFA.AttachmentColors["+"], "+30% Clipsize",
    TFA.AttachmentColors["-"], "-15% Movement",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["magxl"] = {
			["active"] = true
		},
		["mag"] = {
			["active"] = false
		},
	},
	["WElements"] = {
		["magxl"] = {
			["active"] = true
		},
		["mag"] = {
			["active"] = false
		},
	},
	["Primary"] = {
		["ClipSize"] = function(wep,stat) return stat*1.3 end,
	},
    ["MoveSpeed"] = function(wep,stat) return stat*0.85 end,
    ["IronSightsMoveSpeed"] = function(wep,stat) return stat*0.85 end,
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
