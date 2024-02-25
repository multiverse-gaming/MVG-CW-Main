hook.Add("PhysgunPickup", "PropHr:PhysgunPickup", function(ply, ent)
	if (
		ent:IsNPC() and
		ent:GetParent().prophr != nil and
		ent:GetClass() == prophr_ent_npc_class
	) then
		--
		return true
	end
end)