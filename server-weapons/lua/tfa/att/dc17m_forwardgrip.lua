if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Forward Grip"
ATTACHMENT.ShortName = "FG"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Forwrd Grip",
    TFA.AttachmentColors["+"], "Increased accuracy",
    TFA.AttachmentColors["-"], "Reduced Movement",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.85 end,
		["KickDown"] = function(wep,stat) return stat * 0.85 end,
		["Spread"] = function(wep,stat) return stat * 0.5 end,
	},
	["MoveSpeed"] = 0.85,
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