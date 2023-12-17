if not ATTACHMENT then

	ATTACHMENT = {}

end



ATTACHMENT.Name = "Tibanna Cartridge Drum - Grip"

ATTACHMENT.ShortName = "TCtdEx"

ATTACHMENT.Icon = "entities/dc17m_drummag.png"

ATTACHMENT.Description = {

    TFA.AttachmentColors["+"], "+60 Tibanna Gaz", 

    TFA.AttachmentColors["-"], "-15% Movement Speed", 

}



ATTACHMENT.WeaponTable = {

	["VElements"] = {

		["rifle_mag"] = {["active"] = false},

		["sniper_magext"] = {["active"] = false},

		["rifle_magdrum"] = {["active"] = true},

	},

	["WElements"] = {

		["rifle_mag"] = {["active"] = false},

		["sniper_magext"] = {["active"] = false},

		["rifle_magdrum"] = {["active"] = true},

	},



	["Primary"] = {

		["ClipSize"] = 60,

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

