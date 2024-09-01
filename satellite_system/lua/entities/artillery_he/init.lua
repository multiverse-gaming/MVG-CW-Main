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
	local getArtHEDamage = GetConVar("k_art_he_damage"):GetInt()
	local getArtHESplashRadius = GetConVar("k_art_he_splash_radius"):GetInt()

	if (isDistPlayed >= 1) then
      net.Start("kaito_net_sound_new_art_basefire")
		    net.WriteString("placeholder")
	    net.Broadcast()
    end



	timer.Simple(getTBI, function ()
		net.Start("kaito_net_sound_new_art_he")
		net.WriteVector(colData.HitPos)
	net.Broadcast()
	end)
	
	local hoffset = getTBI+5

	timer.Simple(hoffset, function()
		local cx,cy,cz = colData.HitPos:Unpack()
		pos = Vector(cx,cy,cz)
	    ParticleEffect("doi_artillery_explosion", Vector(cx,cy,cz), Angle(-90,0,0), nil)
		util.BlastDamage(colData.PhysObject:GetEntity(), colData.PhysObject:GetEntity(), Vector(cx,cy,cz), getArtHESplashRadius, getArtHEDamage)
		util.Decal("Scorch", Vector(cx,cy,cz),pos-Vector(0, 0, 30))
	end)

	local hdeloffset = hoffset+2

	timer.Simple(hdeloffset, function() 
		colData.PhysObject:GetEntity():Remove()
	end)

end

