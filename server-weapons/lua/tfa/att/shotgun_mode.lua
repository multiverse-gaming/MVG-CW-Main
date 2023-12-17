if not ATTACHMENT then

	ATTACHMENT = {}

end





ATTACHMENT.Name = "Shotgun Mode"

ATTACHMENT.ShortName = "X-M"

ATTACHMENT.Icon = "entities/att/x_mod.png"

ATTACHMENT.Description = { 

    TFA.AttachmentColors["="], "Change to Shotgun Mod | 8 Pellets in a shot", 

    TFA.AttachmentColors["+"], "+ Shotgun Mode", 

	TFA.AttachmentColors["+"], "+ Each Pellet has increased 15% damage.", 

	TFA.AttachmentColors["-"], "- Semi Automatic only", 

	TFA.AttachmentColors["-"], "- RPM decreased by 80%", 

	TFA.AttachmentColors["-"], "- 1000% spread increase", 

	TFA.AttachmentColors["-"], "- 3000% Increased Knock up and down", 

	TFA.AttachmentColors["-"], "- 80% Magazine size", 

}



ATTACHMENT.WeaponTable = {

	["VElements"] = {

		["muzzle1"] = {

			["active"] = true

		},	

	},

	["WElements"] = {

		["muzzle1"] = {

			["active"] = true

		},

	},

	["Primary"] = {

		["Sound"] = function(wep,stat) return checksoundcurrently(stat) end,

		["Damage"] = function(wep,stat) return stat*1.8 end, --1.15

		["RPM"] = function(wep,stat) return stat*0.2 end,

		["ClipSize"] = function(wep,stat) return stat/5 end,

		["Automatic"] = false,

		["NumShots"] = 8,

		["Spread"] = function(wep,stat) return stat*11 end,

		["IronAccuracy"] = function(wep,stat) return stat*11 end,

		["KickUp"] = function(wep,stat) return stat*31 end,

		["KickDown"] = function(wep,stat) return stat*31 end,

	},

	["SelectiveFire"] = false,

	["FireModes"] = {

		"Single",

	}

}



function checksoundcurrently(stat)

	if(stat == "w/dc15a.wav") then

		return "w/scatter.wav"

	else

		return stat

	end

end



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

