if not ATTACHMENT then

	ATTACHMENT = {}

end



ATTACHMENT.Name = "Battle Rifle Module"

ATTACHMENT.ShortName = "BRM"

ATTACHMENT.Icon = "entities/dc17m_shotgun.png"

ATTACHMENT.Description = {

    TFA.AttachmentColors["="], "Change for the Battle Rifle module.",

    TFA.AttachmentColors["+"], "+100% RPM",

    TFA.AttachmentColors["+"], "+50 Clip Size",

    TFA.AttachmentColors["+"], "+20% Accuracy",

    TFA.AttachmentColors["-"], "+20% Recoil",

    TFA.AttachmentColors["-"], "+100% Burst Fire Delay",

    TFA.AttachmentColors["-"], "-20% Damage",

    TFA.AttachmentColors["="],
	"----------------------------------------------",
	TFA.AttachmentColors["+"],
	"Weapon fires five rounds per burst",
	TFA.AttachmentColors["+"],
	"Weapon is silenced",
	TFA.AttachmentColors["-"],
	"Weapon cannot be fired fully-automatically"


}



ATTACHMENT.WeaponTable = {



	["Primary"] = {

        ["Sound"] = Sound("w/dc19.wav"),
        
		["RPM"] = 900,

        ["ClipSize"] = 45,

		["Spread"] = 0.016,

		["IronAccuracy"] = 0.0024,

		["KickUp"] = 0.09,

        ["KickDown"] = 0.071,

        ["KickHorizontal"] = 0.06,

        ["StaticRecoilFactor"] = 0.72,

        ["BurstDelay"] = 0.3,

        ["Damage"] = 30,

	},

	["IronSightsPos"] = function( wep, val ) return wep.ScopeSgPos or val, true end,

}



local firemode = "5Burst"

function ATTACHMENT:Attach(wep)
	wep:Unload()

	for k, v in pairs(wep:GetStat("FireModes")) do
		if v:EndsWith("Auto") then
			wep.BurstBakIndex = k
			wep.BurstBakName = v

			wep.FireModes[k] = firemode

			wep.FireModeCache = {}
			wep.BurstCountCache = {}
			wep:CreateFireModes()

			break
		end
	end
end

function ATTACHMENT:Detach(wep)
	wep:Unload()

	if wep.BurstBakIndex and wep.BurstBakName then
		wep.FireModes[wep:GetStat("BurstBakIndex")] = wep:GetStat("BurstBakName")

		wep.FireModeCache = {}
		wep.BurstCountCache = {}
		wep:CreateFireModes()

		wep.BurstBakIndex = nil
		wep.BurstBakName = nil
	end
end



if not TFA_ATTACHMENT_ISUPDATING then

	TFAUpdateAttachments()

end

