AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Charge Pack"
ENT.Category = "ArcCW - Ammo"
ENT.Editable = true
ENT.Spawnable = false
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
        timer.Simple(0.5, function()
            local spawnPosition = self:GetPos()
            local spawnangle = self:GetAngles()

            local chargePack = ents.Create("arccw_ammo_chargepack")
            if IsValid(chargePack) then
                chargePack:SetPos(spawnPosition)
                chargePack:SetAngles(spawnangle)
                chargePack:SetModel("models/cs574/objects/ammo_box.mdl")
                chargePack:Spawn()
            end
            self:Remove()
        end)
    end
end

function ENT:PhysicsCollide( data, phys )
end

