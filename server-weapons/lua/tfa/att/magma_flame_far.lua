
if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Cellule de gaz amplifiée"
ATTACHMENT.ShortName = "CGA"
ATTACHMENT.Icon = "entities/zoom/zoom.png"

ATTACHMENT.WeaponTable = {
    ["Primary"] = { 
        ["Damage"] = 100,
        ["Range"] = 380,
    },
}

function ATTACHMENT:Attach(wep)
	wep.Primary.Damage = 100
	wep.Primary.Range = 1100
end

function ATTACHMENT:Detach(wep)
	wep.Primary.Damage = 150
	wep.Primary.Range = 800
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end