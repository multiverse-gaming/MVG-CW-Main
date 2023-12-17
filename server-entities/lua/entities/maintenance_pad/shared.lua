ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.PrintName = "Maintenance Station"
ENT.Author = "Stan"
ENT.Category = "[LFS]"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Editable = true

ENT.RepairAmount = 50
ENT.Radius = 500
ENT.RearmPrimarySegment = true
ENT.RearmSecondarySegment = true
ENT.RearmPrimaryAmount = 10
ENT.RearmSecondaryAmount = 10

function ENT:SetupDataTables()

	self:NetworkVar( "Float", 0, "Radius", { KeyName = "radius", Edit = { type = "Float", order = 1,min = 0, max = 5000, category = "Area"} } )
	self:NetworkVar( "Float", 1, "RepairAmount", { KeyName = "repairamount", Edit = { type = "Float", order = 2,min = 0, max = 10000, category = "Repairing"} } )
	
	self:NetworkVar( "Int", 0, "RearmPrimary", { KeyName = "rearmprimary", Edit = { type = "Int", order = 3, min = 0, max = 10000, category = "Rearming"} } )
	self:NetworkVar( "Int", 1, "RearmSecondary", { KeyName = "rearmsecondary", Edit = { type = "Int", order = 5, min = 0, max = 10000, category = "Rearming"} } )
	
	self:NetworkVar( "Bool", 0, "RearmPrimarySegment", { KeyName = "rearmprimarysegment", Edit = { type = "Boolean", order = 2, category = "Rearming"} } )
	self:NetworkVar( "Bool", 1, "RearmSecondarySegment", { KeyName = "rearmsecondarysegment", Edit = { type = "Boolean", order = 4, category = "Rearming"} } )

	if SERVER then
		self:SetRepairAmount( self.RepairAmount )
		self:SetRadius( self.Radius )
		self:SetRearmPrimarySegment( self.RearmPrimarySegment )
		self:SetRearmPrimary( self.RearmPrimaryAmount )
		self:SetRearmSecondarySegment( self.RearmSecondarySegment )
		self:SetRearmSecondary( self.RearmSecondaryAmount )
	end

end