
if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Pressostat Amélioré"
ATTACHMENT.ShortName = "PA"
ATTACHMENT.Icon = "entities/zoom/zoom.png"

ATTACHMENT.WeaponTable = {
}

function ATTACHMENT:Attach(wep)
	wep.Primary.Damage = 200
	wep.Primary.Range = 520
end

function ATTACHMENT:Detach(wep)
	wep.Primary.Damage = 150
	wep.Primary.Range = 800
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end