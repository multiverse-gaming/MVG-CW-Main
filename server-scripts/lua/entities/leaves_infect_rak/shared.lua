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

ENT.WorldModel	 	= "models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/plants/moss_flower.mdl"

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end