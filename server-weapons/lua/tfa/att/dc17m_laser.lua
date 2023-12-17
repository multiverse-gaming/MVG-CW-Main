if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Laser"
ATTACHMENT.ShortName = "L"
ATTACHMENT.Icon = "entities/dc17m_laser.png"
ATTACHMENT.Description = {
    TFA.AttachmentColors["="], "Activate the Laser.",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["dc17m_laser"] = {["active"] = true},
	},
	["WElements"] = {
		["dc17m_laser"] = {["active"] = true},
	}
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
