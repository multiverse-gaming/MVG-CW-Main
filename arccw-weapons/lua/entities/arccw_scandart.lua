AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Scandart"
ENT.Category = "MVG"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.UseTimer = CurTime()

ENT.IconOverride = "materials/entities/rw_ammo_distributor.png"


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
        print("Test")

       --hook.Remove("PreDrawHalos", "MVG.Dandy.ScanDartHalo")

        timer.Simple( 5,function() if self:IsValid() then self:Remove() hook.Remove("PreDrawHalos", "MVG.Dandy.ScanDartHalo") end end) 
    end

    if CLIENT then
        --hook.Call("MVG.Dandy.ScanDartHalo", nil)

        players = {}
        for _, v in pairs(ents.FindInSphere(self:GetPos(), 216)) do
            if v:IsPlayer() then
                table.insert(players, v)
            end
        end 

        halo.Add(players, Color(255,0,0), 1 , 1, 1, true, false)

        print("Hello world")

        timer.Simple( 5,function() if self:IsValid() then self:Remove()end end) 
    end
end

function ENT:PhysicsCollide( data, phys )
end

