EPS_ClaimPanel = {}

local pre = EPS_ClaimBoard_Config.Prefix
local precolor = EPS_ClaimBoard_Config.PrefixColor

function EPS_ClaimPanel:Unclaim(pl, entity, admin)
    entity:SetClaimBoardClaimed(false)
    entity:SetClaimBoardClaimer(nil)

    if IsValid(admin) then
	    if pl then
	    	pl:EPS_AddText(precolor, "["..pre.."] ", Color(255,255,255), "Your claimboard has been unclaimed by "..admin:Name()..".")
	    else
	    	pl:EPS_AddText(precolor, "["..pre.."] ", Color(255,255,255), "You've unclaimed a Claimboard owned previously by "..pl:Name()..".")
	    end
	else
		pl:EPS_AddText(precolor, "["..pre.."] ", Color(255,255,255), "You've unclaimed one of your Claim-Boards.")
	end
end