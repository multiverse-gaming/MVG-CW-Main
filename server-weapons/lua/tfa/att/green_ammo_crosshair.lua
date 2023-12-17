if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Green Tibanna Gas Cartridges"
ATTACHMENT.ShortName = "GTGa" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { 
	TFA.AttachmentColors["="],"High energy ammo type - Slow rate of fire, heavy damage. Explosive plasma. CAUTION!",
	TFA.AttachmentColors["+"],"%200 Damage increase",
	TFA.AttachmentColors["+"],"Explosive Damage; Area of effect",
	TFA.AttachmentColors["="],"Chance to set the environment on fire. CAUTION!",
	TFA.AttachmentColors["+"],"Green Tracer",
	TFA.AttachmentColors["-"],"5 ammo per shot",
	TFA.AttachmentColors["-"],"%60 decrease to RPM",
}
ATTACHMENT.Icon = "entities/tfa_ammo_fragshell.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.Damage = 60.5

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = 350,
		["ClipSize"] = 25,
		["DefaultClip"] = 25,
		["RPM"] = 60,
		["RPM_Burst"] = 80,
		["Sound"] = "weapons/bf3/e11_heavy.wav",
		["DamageTypeHandled"] = true,
		--["DamageType"] = DMG_DISSOLVE,
		["DamageType"] = DMG_BLAST,
		["AmmoConsumption"] = 5,
		["Ammo"] = "AR2"
	},
	
	["TracerName"] = "effect_sw_laser_green",
	["ImpactEffect"] = "Explosion",
	["MoveSpeed"] = 1,
	--["ImpactDecal"] = "Explosion",
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end