if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Compensator"
ATTACHMENT.ShortName = "C"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Compensators",
    TFA.AttachmentColors["+"], "Reduced Vertical Recoil",
    TFA.AttachmentColors["-"], "Reduced Movement",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.5 end,
	},
	["MoveSpeed"] = 0.95,
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