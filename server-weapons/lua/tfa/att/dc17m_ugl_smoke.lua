if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "UGL Smoke Module"
ATTACHMENT.ShortName = "G.L.M."
ATTACHMENT.Icon = "entities/dc17m_rocket.png"
ATTACHMENT.Description = {
    TFA.AttachmentColors["="], "Change for the Grenade Launcher module.",
    TFA.AttachmentColors["+"], "+1250% Damage",
    TFA.AttachmentColors["-"], "-165% RPM",
    TFA.AttachmentColors["-"], "+300% Kickback",
    TFA.AttachmentColors["="], "3 Grenades",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["RPM"] = 200,
		["ClipSize"] = 3,
		["DefaultClip"] = 3,
		["Ammo"] = "grenade",
		["Sound"] = Sound("w/dc17mrocket.wav")
	},
	["ProceduralReloadTime"] = 4
}

--[[function ATTACHMENT:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
	self:SetNextPrimaryFire(CurTime() + 1)
	if CLIENT then return end
	local ent = ents.Create ( "rw_sw_ent_nade_smoke" );
		ent:Spawn();
		ent:SetPos ( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) );
		ent:SetAngles( self.Owner:EyeAngles() + Angle( 0, 0, 0 ) )
		ent:SetOwner( self.Owner )
		ent.GrenadeOwner = self.Owner
		ent.KaboomTime = CurTime() + 1.2
		local phys = ent:GetPhysicsObject();																															--remove when on server
		phys:SetVelocity( self.Owner:GetAimVector():GetNormalized() * 1000 )
end --]]

function ATTACHMENT:Attach(wep)
	//wep.ShootBullet = self.ShootBullet
	//wep.Owner:SetAmmo(wep.Owner:GetAmmoCount(wep:GetStat("Primary.Ammo")) + wep:Clip1(), wep:GetStat("Primary.Ammo"))
	wep:Unload()
	wep:Reload( true )
end

function ATTACHMENT:Detach(wep)
	//wep.ShootBullet = baseclass.Get(wep.Base).ShootBullet
	//wep.Owner:SetAmmo(wep.Owner:GetAmmoCount(wep:GetStat("Primary.Ammo")) + wep:Clip1(), wep:GetStat("Primary.Ammo"))
	wep:Unload()
	wep:Reload( true )
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end