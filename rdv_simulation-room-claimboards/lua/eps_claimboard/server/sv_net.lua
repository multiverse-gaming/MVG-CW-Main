local pre = EPS_ClaimBoard_Config.Prefix
local precolor = EPS_ClaimBoard_Config.PrefixColor

util.AddNetworkString("EPS_Admin_Unclaim")
util.AddNetworkString("OpenClaimPanel")
util.AddNetworkString("UpdateClaimPanel")
util.AddNetworkString("UnclaimClaimPanel")
util.AddNetworkString("EPS_ClaimBoard_Inspect")

net.Receive("UpdateClaimPanel", function(len, pl)
    local entity = net.ReadEntity()
    local battalion = net.ReadString()
    local title = net.ReadString()
    local close = net.ReadBool()

    if battalion == "Battalion" then
        return
    end

    if title == "" then
        return
    end

    if entity:GetClaimBoardClaimer() == pl or not entity:GetClaimBoardClaimed() then

        if not entity:GetClaimBoardClaimed() then
            entity:SetClaimBoardClaimed(true)
        end
            
        entity:SetClaimBoardOpen(close)
        entity:SetClaimBoardBat(battalion)
        entity:SetClaimBoardTitle(title)
        entity:SetClaimBoardClaimer(pl)


	    pl:EPS_AddText(precolor, "["..pre.."] ", Color(255,255,255), "The Claim-Board has been updated.")
	else
		pl:EPS_AddText(precolor, "["..pre.."] ", Color(255,255,255), "You don't have the permissions to update this.")
	end
end)

net.Receive("UnclaimClaimPanel", function(len, pl)
    local entity = net.ReadEntity()

    if entity:GetClaimBoardClaimed() and entity:GetClaimBoardClaimer() == pl then
		EPS_ClaimPanel:Unclaim(pl, entity)
    end
end)

net.Receive("EPS_Admin_Unclaim", function(len, pl)
    local ent = net.ReadEntity()

    if IsValid(ent) and IsValid(pl) and IsValid(ent:GetClaimBoardClaimer()) then
        if EPS_ClaimBoard_Config.Admins[pl:GetUserGroup()] then
            EPS_ClaimPanel:Unclaim(ent:GetClaimBoardClaimer(), ent, pl)
        else
            pl:EPS_AddText(precolor, "["..pre.."] ", Color(255,255,255), "You don't have permission to unclaim this.")
        end
    end
end)