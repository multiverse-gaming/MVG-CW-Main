AddCSLuaFile("shared.lua")

include("shared.lua")



function ENT:Initialize()

	self.Entity:SetModel("models/elitelukas/imp/landeplattform_v2.mdl")

	self.Entity:PhysicsInit(SOLID_VPHYSICS)

	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)

	self.Entity:SetSolid(SOLID_VPHYSICS)

	self:NextThink(CurTime())

end



function ENT:Think()

	for _, e in pairs(ents.FindInSphere(self:GetPos(), self:GetRadius())) do

		if e.LFS then

			if IsValid( e ) then

				

				

				local RepairAmount = self:GetRepairAmount()

				

				local lfsHP = e:GetHP()

				local lfsMHP = e:GetMaxHP()

				if lfsHP < lfsMHP then

					e:SetHP( lfsHP + RepairAmount )

					e:EmitSound("lfs/repair_loop.wav", 100, 100)

				end

				

				local lfsAP = e:GetAmmoPrimary()

				local lfsMAP = e:GetMaxAmmoPrimary()

				local lfsAS = e:GetAmmoSecondary()

				local lfsMAS = e:GetMaxAmmoSecondary()

				if lfsAP < lfsMAP then

					local PrimaryBySegments = self:GetRearmPrimarySegment()

					local PrimaryRearmAmount = self:GetRearmPrimary()

					if PrimaryBySegments then

						e:SetAmmoPrimary( lfsAP + math.ceil( lfsMAP / PrimaryRearmAmount ) )

						e:EmitSound("items/ammo_pickup.wav", 100, 100)

					else

						e:SetAmmoPrimary( lfsAP + PrimaryRearmAmount )

						e:EmitSound("items/ammo_pickup.wav", 100, 100)

					end

				end

				if lfsAS < lfsMAS then

					local SecondaryBySegments = self:GetRearmSecondarySegment()

					local SecondaryRearmAmount = self:GetRearmSecondary()

					if SecondaryBySegments then

						e:SetAmmoSecondary( lfsAS + math.ceil( lfsMAS / SecondaryRearmAmount ) )

						e:EmitSound("items/ammo_pickup.wav", 100, 100)

					else

						e:SetAmmoSecondary( lfsAS + SecondaryRearmAmount )

						e:EmitSound("items/ammo_pickup.wav", 100, 100)

					end

				end

				

			

			end

		end

	end

	self:NextThink(CurTime()+1)

	return true

end