if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "UGL Module"
ATTACHMENT.ShortName = "G.L.M."
ATTACHMENT.Icon = "entities/dc17m_rocket.png"
ATTACHMENT.Description = {
    TFA.AttachmentColors["="], "Change for the Grenade Launcher module.",
    TFA.AttachmentColors["+"], "+1250% Damage",
    TFA.AttachmentColors["-"], "-165% RPM",
    TFA.AttachmentColors["-"], "+300% Kickback",
    TFA.AttachmentColors["="], "3 Grenades",
}

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["rifle_module"] = {["active"] = false},
		["rifle_mag"] = {["active"] = false},
		["rocket_module"] = {["active"] = true},
	},
	["WElements"] = {
		["rifle_module"] = {["active"] = false},
		["rifle_mag"] = {["active"] = false},
		["rocket_module"] = {["active"] = true},
	},

	["Primary"] = {
		["Sound"] = "w/dc17mrocket.wav",
		["KickUp"] = function(wep,stat) return stat * 4 end,
		["KickDown"] = function(wep,stat) return stat * 4 end,
		["Damage"] = 100,
		["Ammo"] = "grenade",
		["ClipSize"] = 3,
		["RPM"] = 200,
	},
	["ProceduralReloadTime"] = 4,
}

function ATTACHMENT:Attach(wep)
	wep:Unload()
	wep:Reload( true )
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
	wep:Reload( true )
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
