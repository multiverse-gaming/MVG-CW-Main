ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"

ENT.Author			= "Ukushino"
ENT.PrintName 		= "Infected Leaves"
ENT.Category		= "Rakghoul Infection Entity"
ENT.Contact 		= ""
ENT.Purpose 		= ""
ENT.Information 	= ""

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.WorldModel	 	= "models/eoti/wolfsbane/woods_bush.mdl"

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end