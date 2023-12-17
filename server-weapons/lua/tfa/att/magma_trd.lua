
if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Munitions d'Entrainement"
ATTACHMENT.ShortName = "TRD"
ATTACHMENT.Icon = "entities/zoom/zoom.png"

ATTACHMENT.WeaponTable = {
    ["TracerName"] = "rw_sw_laser_green",
}

function ATTACHMENT:Attach(wep)
	wep.ImpactEffect = "rw_sw_impact_green"
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep.ImpactEffect = "rw_sw_impact_blue"
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end