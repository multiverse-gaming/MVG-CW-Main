if EPS_ClaimBoard_Config.Death then
	hook.Add("PlayerDeath", "EPS_Claimboard_PlayerDeathRemove", function(ply)
		print("test")
		for k, v in pairs(ents.FindByClass("claimboard")) do
			if v:GetClaimBoardClaimer() == ply then
				EPS_ClaimPanel:Unclaim(ply, v)
			end
		end
	end)
end

if EPS_ClaimBoard_Config.Arrest then
	hook.Add("playerArrested", "EPS_Claimboard_PlayerArrestRemove", function(ply)
		for k, v in pairs(ents.FindByClass("claimboard")) do
			if v:GetClaimBoardClaimer() == ply then
				EPS_ClaimPanel:Unclaim(ply, v)
			end
		end
	end)
end

hook.Add("PlayerDisconnected", "EPS_Claimboard_PlayerDisconnectRemove", function(ply)
	for k, v in pairs(ents.FindByClass("claimboard")) do
		if v:GetClaimBoardClaimer() == ply then
			EPS_ClaimPanel:Unclaim(ply, v)
		end
	end
end)