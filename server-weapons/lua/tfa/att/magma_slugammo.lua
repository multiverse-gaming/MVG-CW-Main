
if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Slug Ammo"
ATTACHMENT.ShortName = "SA"
ATTACHMENT.Icon = "entities/zoom/zoom.png"

ATTACHMENT.WeaponTable = {
    ["Primary"] = { 
        ["ClipSize"] = 1,
        ["NumShots"] = 1,
        ["Damage"] = 50*8,
        ["Spread"] = 0.005,
        ["IronAccuracy"] = 0.005,
    }, 
    ["TracerName"] = "rw_sw_laser_purple",
}

function ATTACHMENT:Attach(wep)
	wep.ImpactEffect = "rw_sw_impact_purple"
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep.ImpactEffect = "rw_sw_impact_green"
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end