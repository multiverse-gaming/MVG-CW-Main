AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

	function ENT:Initialize()
		self:SetModel("models/star wars the force unleashed/thermal_detonator.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		Glow = ents.Create("env_sprite")
		Glow:SetKeyValue("model","orangecore2.vmt")
		Glow:SetKeyValue("rendercolor","255 0 0")
		Glow:SetKeyValue("scale","0.16")
		Glow:SetPos(self.Entity:GetPos())
		Glow:SetParent(self.Entity)
		Glow:Spawn()
		Glow:Activate()
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()
		phys:Wake()
		util.SpriteTrail(self, 0, Color(255 * 2,0 * 2,0 * 2), false, 5, .5, .1, 1/(15+1)*0.5, "trails/tube.vmt")
		self.countsounds = 100
		timer.Simple(1,function()
			if not IsValid(self) then return end
			local entidex = self:EntIndex()
			timer.Create("babysounds"..entidex,0.2,0,function()
				if not IsValid(self) then timer.Destroy("babysounds"..entidex) return end
				if self.countsounds == 200 then
					local explode = ents.Create("env_explosion")
					explode:SetPos(self:GetPos())
					explode:SetOwner(self:GetOwner())
					explode:Spawn()
					explode:SetKeyValue("iMagnitude","200")
					explode:Fire("Explode",0,0)
					
					explode:EmitSound("weapons/explosives_cannons_superlazers/sw_detonator_explosion.ogg",90,60)

					timer.Destroy("babysounds"..self:EntIndex())
					self:Remove()
				else
					self:EmitSound("weapons/explosives_cannons_superlazers/wpn_thermdet_chargeup_01.ogg",80,self.countsounds)
					self.countsounds = self.countsounds + 10
				end
			end)
		end)
	end

function ENT:Use() end

function ENT:OnTakeDamage()
	timer.Create("explodeonimpact"..self:EntIndex(),0.08,1,function()
		if not IsValid(self) then return end
		local explode = ents.Create("env_explosion")
		explode:SetPos(self:GetPos())
		explode:SetOwner(self:GetOwner())
		explode:Spawn()
		explode:SetKeyValue("iMagnitude","200")
		explode:Fire("Explode",0,0)
		
		explode:EmitSound("weapons/explosives_cannons_superlazers/sw_detonator_explosion.ogg",90,60)

		timer.Destroy("babysounds"..self:EntIndex())
		self:Remove()
	end)
end