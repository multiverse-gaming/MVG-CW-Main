if not ATTACHMENT then

	ATTACHMENT = {}

end





ATTACHMENT.Name = "Slug Component"

ATTACHMENT.ShortName = "Slug"

ATTACHMENT.Icon = "entities/att/m4.png"

ATTACHMENT.Description = { 

    TFA.AttachmentColors["="], "Slug Attachment", 

    TFA.AttachmentColors["+"], "+ Spread decreased by 40%", 

	TFA.AttachmentColors["-"], "- Magazine decreased by 40%", 

}



ATTACHMENT.WeaponTable = {

	["VElements"] = {

		["muzzle1"] = {

			["active"] = false

		},	

		["muzzle4"] = {

			["active"] = true

		},	

	},

	["WElements"] = {

		["muzzle1"] = {

			["active"] = false

		},

		["muzzle4"] = {

			["active"] = true

		},	

	},

	["Primary"] = {

		["Sound"] = "w/hunter.wav",

		["ClipSize"] = function(wep,stat) return stat*0.6 end,

		["Spread"] = function(wep,stat) return stat*0.6 end,

		["IronAccuracy"] = function(wep,stat) return stat*0.6 end,

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

