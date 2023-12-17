if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Blaster Actuating Module"
ATTACHMENT.ShortName = "B.A.M"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Activate Blaster Actuating Module",
    TFA.AttachmentColors["+"], "Increased Damage",
    TFA.AttachmentColors["-"], "Reduced Clipsize",
    TFA.AttachmentColors["-"], "Reduced RPM",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ClipSize"] = function(wep,stat) return stat * 0.25 end,
		["Damage"] = function(wep,stat) return stat * 1.85 end,
		["RPM"] = function(wep,stat) return stat * 0.4 end,
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
