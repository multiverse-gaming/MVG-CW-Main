AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/kingpommes/starwars/misc/imp_crate_single_closed.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end
    end
end

function ENT:Touch(ent)
    if SERVER and IsValid(ent) and ent:IsValid() and ent:GetClass() == "ventymcventface" then
        self:Remove()
        
        hook.Run("MoondustCrateTouchVent", self, ent)
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end