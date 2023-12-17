if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Bacta Grenade Launcher Module"
ATTACHMENT.ShortName = "B.G.L.M."
ATTACHMENT.Icon = "entities/dc17m_rocket.png"
ATTACHMENT.Description = {
    TFA.AttachmentColors["="], "Change for the Bacta Grenade Launcher module.",

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
		["RPM"] = 30,
		["Damage"] = 0,
		["ClipSize"] = 3,
	},
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
