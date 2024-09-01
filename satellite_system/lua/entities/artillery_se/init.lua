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

    local isDistPlayed = GetConVar("kplayartdistantsound"):GetInt()
    local getTBI = (GetConVar("kshellwaitingtime"):GetInt())-5

    if (isDistPlayed >= 1) then
      net.Start("kaito_net_sound_new_art_basefire")
		    net.WriteString("placeholder")
	    net.Broadcast()
    end

    

    timer.Simple(getTBI, function ()
		  net.Start("kaito_net_sound_new_art_se")
		    net.WriteVector(colData.HitPos)
	    net.Broadcast()
	  end)

    local soffset = getTBI+5

    timer.Simple(soffset, function()
		  local cx,cy,cz = colData.HitPos:Unpack()
	    pos = Vector(cx,cy,cz)
	    ParticleEffect("doi_smoke_artillery", Vector(cx,cy,cz), Angle(0,0,0), nil)
	  end)
    
    local sdeloffset = soffset+2

    timer.Simple(sdeloffset, function() 
		  colData.PhysObject:GetEntity():Remove()
	  end)
end