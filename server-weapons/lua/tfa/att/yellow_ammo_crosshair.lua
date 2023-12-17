if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Yellow Tibanna Gas Cartridges"
ATTACHMENT.ShortName = "YTG" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
TFA.AttachmentColors["="],"High energy ammo type - Single Shot. Meant to be used in place of the standard GTGC. Intended for single shot assassination.",
TFA.AttachmentColors["+"],"%400 Damage increase",
TFA.AttachmentColors["+"],"Disolve on kill",
TFA.AttachmentColors["+"],"Green Tracer",
TFA.AttachmentColors["-"],"%50 decrease to Clipsize",
TFA.AttachmentColors["-"],"%100 increase to ammo consumption",
TFA.AttachmentColors["-"],"LARGE DELAY ON RELOAD! DANGER!",
}
ATTACHMENT.Icon = "entities/tfa_ammo_fragshell.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.Damage = 75

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		--["Damage"] = function( wep, val) return val * 8 end,
		["Damage"] = 450,
		["ClipSize"] = 25,
		["DefaultClip"] = 25,
		["RPM"] = 60,
		["RPM_Burst"] = function( wep, val) return val * 0.75 end,
		["Sound"] = "weapons/explosives_cannons_superlazers/sw_vaporize.ogg",
		["DamageTypeHandled"] = true,
		["DamageType"] = DMG_DISSOLVE,
		--["DamageType"] = DMG_BLAST,
		--["ImpactEffect"] = "Explosion",
		--["ImpactDecal"] = "Explosion",
		["AmmoConsumption"] = 25,
		["Ammo"] = "AR2"
	},

	["TracerName"] = "effect_sw_laser_yellow",
	["DoProceduralReload"] = true,
	["ProceduralReloadTime"] = 3.5,
	["AllowSprintAttack"] = false
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end