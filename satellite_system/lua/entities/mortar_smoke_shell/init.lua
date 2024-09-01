AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/dolunity/starwars/mortar/shell.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_NONE)
    self:PhysWake()
end

function ENT:PhysicsCollide(colData, collider)
    collider:EnableMotion(false)

    net.Start("kaito_net_sound_new_se")
		net.WriteVector(colData.HitPos)
	net.Broadcast()

    timer.Simple(5, function()
		local cx,cy,cz = colData.HitPos:Unpack()
	    local sfx = EffectData()
        sfx:SetOrigin(Vector(cx,cy,cz))
        util.Effect("effect_smoke_modified", sfx)
        util.ScreenShake(Vector(cx,cy,cz), 9, 5, 2, 8500)
	end)
    
    timer.Simple(6, function() 
		colData.PhysObject:GetEntity():Remove()
	end)
end