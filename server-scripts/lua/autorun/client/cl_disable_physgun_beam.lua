hook.Add("DrawPhysgunBeam", "disablephysgunbeam", function(ply)
	if CAMI and CAMI.PlayerHasAccess(ply, "PhysgunBeam", nil) then
		return true
	end	
	return false
end )