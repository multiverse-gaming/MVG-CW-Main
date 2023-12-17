if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Ion Shot Module"
ATTACHMENT.ShortName = "I.S.M"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Activate Ion shots",
    TFA.AttachmentColors["+"], "Bonus damage to vehicles",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ClipSize"] = 30
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

function ATTACHMENT:CustomBulletCallback(wep, attacker, trace, dmginfo)
	if CLIENT then return end
	local currentTarget = trace.Entity
	if (IsValid(currentTarget) and currentTarget:IsPlayer()) then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.75) 
	elseif (IsValid(currentTarget) and currentTarget:IsNPC()) then
		dmginfo:SetDamage(dmginfo:GetDamage() * 0.5) 
	else 
		dmginfo:SetDamage(dmginfo:GetDamage() * 2.5) 
	end
end
