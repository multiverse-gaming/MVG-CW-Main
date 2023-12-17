if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Tripod"
ATTACHMENT.ShortName = "T"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Tripod",
    TFA.AttachmentColors["+"], "Perfect Accuracy",
    TFA.AttachmentColors["-"], "Cannot move",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.01 end,
		["KickDown"] = function(wep,stat) return stat * 0.01 end,
		["Spread"] = function(wep,stat) return stat * 0.01 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.01 end,
	},
	["MoveSpeed"] = 0.01,
    ["IronSightsMoveSpeed"] = 0.01,
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end