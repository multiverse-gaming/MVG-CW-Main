if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Sniper Mod"
ATTACHMENT.ShortName = "S-M"
ATTACHMENT.Icon = "entities/att/x_mod.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Change to Anti-Material Mod", 
    TFA.AttachmentColors["+"], "+500 Damage", 
    TFA.AttachmentColors["-"], "-80% RPM", 
    TFA.AttachmentColors["-"], "-80% ClipSize", 
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Sound"] = "w/dc15x.wav",
		["Damage"] = 550,
		["RPM"] = function(wep,stat) return stat/15 end,
		["ClipSize"] = function(wep,stat) return stat/22.5 end,
		["Automatic"] = false,
	},
	["SelectiveFire"] = false,
	["FireModes"] = {
		"Single",
	}
}

function ATTACHMENT:Attach(wep)
	wep:SetFireMode(3)

	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
