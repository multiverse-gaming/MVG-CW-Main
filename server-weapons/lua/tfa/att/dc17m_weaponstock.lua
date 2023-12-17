if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Stock"
ATTACHMENT.ShortName = "St"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Stock",
    TFA.AttachmentColors["+"], "Increased Stability",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.6 end,
		["KickDown"] = function(wep,stat) return stat * 0.6 end,
		["Spread"] = function(wep,stat) return stat * 0.4 end,
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