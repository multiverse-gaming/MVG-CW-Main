

AddCSLuaFile( "cl_init.lua" )

AddCSLuaFile( "shared.lua" )

include( 'shared.lua' )





function ENT:SpawnFunction( ply, tr )



	if ( !tr.Hit ) then return end

	

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	

	local ent = ents.Create( "cod-c4" )

	ent:SetPos( SpawnPos )

	ent:Spawn()

	ent:Activate()

	ent:GetOwner(self.C4Owner)



	return ent

	

end



function ENT:Initialize()

	

	self.Entity:SetModel( "models/props/starwars/weapons/detpack.mdl" )

	self.Entity:PhysicsInit( SOLID_VPHYSICS )

	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )

	self.Entity:SetSolid( SOLID_VPHYSICS )

	self.Entity:DrawShadow(false)

--	self.Entity:SetModelScale( 0.5, 0 )

	 

	local phys = self.Entity:GetPhysicsObject()

	

	if (phys:IsValid()) then

		phys:Wake()

		phys:SetMass(0.6)

		phys:ApplyForceCenter( self.Owner:GetAimVector()*1500)

		local angvel = Vector(0,math.random(-5000,-2000),math.random(-100,-900)) 

        angvel:Rotate(-1*self.Owner:EyeAngles())
        angvel:Rotate(Angle(0,self.Owner:EyeAngles().y,0))
        phys:AddAngleVelocity(angvel)
        self.Entity:SetGravity(50)

	end

	self.Hit = false


end






function ENT:Explode()



	self.Entity:EmitSound( "ambient/explosions/explode_4.wav" )
	self.Entity:SetOwner(self.C4Owner)

	

	local detonate = ents.Create( "env_explosion" )

		detonate:SetOwner(self.C4Owner)
		detonate:SetPos( self.Entity:GetPos() )
		detonate:SetKeyValue( "iMagnitude", "100" )
		detonate:Spawn()
		detonate:Activate()
		detonate:Fire( "Explode", "", 0 )

	

	local shake = ents.Create( "env_shake" )

		shake:SetOwner( self.Owner )
		shake:SetPos( self.Entity:GetPos() )
		shake:SetKeyValue( "amplitude", "2000" )
		shake:SetKeyValue( "radius", "400" )
		shake:SetKeyValue( "duration", "2.5" )
		shake:SetKeyValue( "frequency", "255" )
		shake:SetKeyValue( "spawnflags", "4" )
		shake:Spawn()
		shake:Activate()
		shake:Fire( "StartShake", "", 0 )

	local c4pos = self.Entity:GetPos()



	self.Entity:Remove()	

	for k,v in pairs(ents.FindInSphere(c4pos,100)) do

		if v:GetClass() == "cod-c4" then

			if !v:GetOwner():IsValid() then

				timer.Simple(0.1,function()

					if (type(v.Explode) == "function") then

						v:Explode()

					end

				end)

			end	

		end

	end

end



function ENT:PhysicsCollide(data,phys)	

	self:EmitSound("hoff/mpl/seal_c4/satchel_plant.wav")

	if self:IsValid() && !self.Hit then
		timer.Simple(0, function()
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		end)
		self.Hit = true
	end	

	if data.HitEntity:IsWorld() == false and data.HitEntity:GetClass() ~= "cod-c4" and data.HitEntity:IsNPC() == false and data.HitEntity:IsPlayer() == false and  data.HitEntity:IsValid() then
		timer.Simple(0, function()
			self:SetSolid(SOLID_NONE)

			self:SetMoveType(MOVETYPE_NONE)

			self:SetParent(data.HitEntity)
			self.Stuck = true

			self.Hit = true
		end)
	end

	if data.HitEntity:IsWorld() then
		timer.Simple(0, function()
			self:SetMoveType(MOVETYPE_NONE)
		end)
	end
	timer.Simple(0, function()
		local ang = data.HitNormal:Angle()
		ang.p = ang.p + 90		
		self:SetPos(data.HitPos + ((data.HitNormal / 5) * -11))
		local pos = self.C4Owner:GetPos() - self:GetPos()
		local normalized = pos:Angle()
		if (ang.p == 180 and ang.y == 0 and ang.r == 0) or (ang.p == 360 and ang.y == 0 and ang.r == 0) then

			self:SetAngles(Angle(0,normalized.y,0))
		else
			self:SetAngles(ang)
		end
	end)
end



--[[
function ENT:OnTakeDamage( dmginfo )
	self.Entity:TakePhysicsDamage( dmginfo )
end
]]



--[[
function ENT:Touch(ent)

	if IsValid(ent) && !self.Stuck then

		if ent == self.C4Owner then return false end

			if ent:IsNPC() || (ent:IsPlayer() && ent != self:GetOwner()) || ent:IsVehicle() then

				self:SetSolid(SOLID_NONE)

				self:SetMoveType(MOVETYPE_NONE)

				self:SetParent(ent)

				self.Stuck = true

				self.Hit = true

		end

	end

end
]]



function ENT:Use( activator, caller )

-- if activator == self.C4Owner then

-- self.Hit = false

-- self.Stuck = false

-- self:Remove()

-- if activator:HasWeapon("cod-c4") == false then activator:Give("cod-c4") end

-- activator:GiveAmmo(1,"slam")

-- end

end



function ENT:Think()



end





