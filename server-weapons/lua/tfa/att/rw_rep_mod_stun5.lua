if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Stun Charge"
ATTACHMENT.ShortName = "S5s" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { 
	TFA.AttachmentColors["="],"Freeze the target for 5 seconds",
}
ATTACHMENT.Icon = "entities/atts/stun5.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["RPM"] = 95,
		["Sound"] = Sound ("w/stun_sound.wav"),
		["Damage"] = 0,
		["AmmoConsumption"] = 20,
		["StatusEffect"] = "stun",
		["StatusEffectDmg"] = 5,
		["StatusEffectDur"] = 5,
		["Spread"] = function(wep,stat) return stat * 0.25 end,
		["StatusEffectParticle"] = true,
	},
	["TracerName"] = "rw_sw_stunwave_blue",
	["MoveSpeed"] = 1
}

function ATTACHMENT:Attach(wep)
	wep.CustomBulletCallbackOld = wep.CustomBulletCallbackOld or wep.CustomBulletCallback
	wep.CustomBulletCallback = function(a, tr, dmg)
		local wep = dmg:GetInflictor()
		if wep:GetStat("Primary.StatusEffect") then
			GMSNX:AddStatus(tr.Entity, wep:GetOwner(), wep:GetStat("Primary.StatusEffect"), wep:GetStat("Primary.StatusEffectDur"), wep:GetStat("Primary.StatusEffectDmg"), wep:GetStat("Primary.StatusEffectParticle"))
		end
	end
	wep.ImpactEffect = "none"
	wep.ImpactDecal = "none"
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep.CustomBulletCallback = wep.CustomBulletCallbackOld
	wep.CustomBulletCallbackOld = nil
	wep.ImpactEffect = "rw_sw_impact_blue"
	wep.ImpactDecal = "FadingScorch"
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end