AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Tibanna Charge Pack (Riggs version)"
ENT.Category = "Osmonium Armory"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.UseTimer = CurTime()

ENT.Model = "models/cs574/objects/ammo_box.mdl"

function ENT:SpawnFunction( ply, tr, ClassName )
if ( !tr.Hit ) then return end
    local SpawnPos = tr.HitPos + tr.HitNormal * 10
    pAngle = ply:GetAngles()
    pAngle.pitch = pAngle.pitch
    pAngle.roll = pAngle.roll 
    pAngle.yaw = pAngle.yaw + 180
    local ent = ents.Create( ClassName ) 
    ent:SetPos( SpawnPos - Vector(0,0,-10) )
    ent:SetAngles( pAngle )
    ent:Spawn()
    ent:Activate()
    return ent	
end

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    if SERVER then
        self:SetModel( "models/cs574/objects/ammo_box.mdl" )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:DrawShadow( true )

        local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
        self:SetTrigger(true)
        print(self:EntIndex())

        timer.Simple( 5,function() if self:IsValid() then self:Remove() end end) 
    end
end

function ENT:Use( activator, caller )
	local clip1 = activator:GetActiveWeapon():GetMaxClip1()
    local ammoType1 = activator:GetActiveWeapon():GetPrimaryAmmoType()
	local ammoType2 = activator:GetActiveWeapon():GetSecondaryAmmoType()
    local mul = 6
    if self.UseTimer <= CurTime() and activator:IsPlayer() and ammoType1 != -1 then
		activator:GiveAmmo(clip1*mul, ammoType1, false)
		activator:GiveAmmo(3 --[[clip2*mul]] , ammoType2, false)

        self:Remove()
    end
end

function ENT:PhysicsCollide( data, phys )
end