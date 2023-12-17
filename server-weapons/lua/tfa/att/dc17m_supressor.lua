if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Supressor"
ATTACHMENT.ShortName = "S"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Supressor",
    TFA.AttachmentColors["+"], "Better Accuracy",
    TFA.AttachmentColors["+"], "Silent",
    TFA.AttachmentColors["-"], "Reduced RPM",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.8 end,
		["KickDown"] = function(wep,stat) return stat * 0.8 end,
		["Spread"] = function(wep,stat) return stat * 0.4 end,
		["Spread"] = function(wep,stat) return stat / 2 end,
		["IronAccuracy"] = function(wep,stat) return stat / 2 end,
		["RPM"] = function(wep,stat) return stat * 0.7 end,
		["Sound"] = "",
	},
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