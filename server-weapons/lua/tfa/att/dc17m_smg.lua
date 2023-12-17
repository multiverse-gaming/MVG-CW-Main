if not ATTACHMENT then

	ATTACHMENT = {}

end



ATTACHMENT.Name = "SMG Module"

ATTACHMENT.ShortName = "SMG"

ATTACHMENT.Icon = "entities/dc17m_shotgun.png"

ATTACHMENT.Description = {

    TFA.AttachmentColors["="], "Change for the SMG module.",

    TFA.AttachmentColors["-"], "-50% Accuracy",

		TFA.AttachmentColors["-"], "-5 Damage",

    TFA.AttachmentColors["+"], "+900 RPM",

}



ATTACHMENT.WeaponTable = {



	["Primary"] = {

		["Damage"] = 30,

		["RPM"] = 900,

		["Spread"] = 12/360,

		["IronAccuracy"] = 4/360,

		["ProceduralReloadTime"] = 4,

	},

	["IronSightsPos"] = function( wep, val ) return wep.ScopeSgPos or val, true end,

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
