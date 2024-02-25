
net.Receive("deceive.disguise", function()
	local plyUID = net.ReadUInt(32)
	local targetUID = net.ReadUInt(32)
	local ply = Player(plyUID)
	local target = Player(targetUID)

	if not IsValid(target) or not target:IsPlayer() then
		ply.Disguised = nil
		ply.Disguised_Team = nil
	else
		ply.Disguised = target
		ply.Disguised_Team = target:Team(true)
	end
end)
