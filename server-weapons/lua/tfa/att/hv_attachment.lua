if not ATTACHMENT then
	ATTACHMENT = {}
end


ATTACHMENT.Name = "TL-50 Heat Coolant Component"
ATTACHMENT.ShortName = "TL-50 Hc"
ATTACHMENT.Icon = "entities/att/trd_mod.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "HV Attachment", 
    TFA.AttachmentColors["+"], "+ Damaged increased by 50%", 
	TFA.AttachmentColors["-"], "- Spread increased by 70%", 
	TFA.AttachmentColors["-"], "- Magazine reduced by 60%", 
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["hv_attachment"] = {
			["active"] = true
		},	
	},
	["WElements"] = {
		["hv_attachment"] = {
			["active"] = true
		},
	},
	["Primary"] = {
		["Sound"] = "w/plx1.wav",
		["Damage"] = function(wep,stat) return stat*1.5 end,
		["ClipSize"] = function(wep,stat) return stat*0.4 end,
		["Spread"] = function(wep,stat) return stat*1.7 end,
		["IronAccuracy"] = function(wep,stat) return stat*1.7 end,
	},
	["SelectiveFire"] = false,
	["FireModes"] = {
		"Single",
	}
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
