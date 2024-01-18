--
-- This checks if a player joined your server using a lent account that is banned
-- eg. player got banned so he decided to make an alt account and used https://store.steampowered.com/promotion/familysharing
--

--
-- Whitelisted players from checking if they have family sharing or not
-- You can have steamid/steamid64 here
--
local Whitelisted_SteamIDs = {
	"STEAM_0:0:150794857",
	"76561198261855442",
}

local BanMessage = "Bypassing a ban using an alt. (alt: %s)"

--
-- Do you want to kick players using family shared accounts?
--
-- True = Kick | False = Ban
local BlockFamilySharing = true
local BlockFamilySharingMessage = "Family share detected, switch back you mop."

--
--
-- DO NOT TOUCH --
--
--

for k, v in pairs(Whitelisted_SteamIDs) do
	Whitelisted_SteamIDs[v] = true
	Whitelisted_SteamIDs[k] = nil
end

hook.Add("SAM.AuthedPlayer", "CheckSteamFamily", function(ply)
	local ply_steamid = ply:SteamID()
	local ply_steamid64 = ply:SteamID64()
	if Whitelisted_SteamIDs[ply_steamid] or Whitelisted_SteamIDs[ply_steamid64] then return end

	local lender = ply:OwnerSteamID64()

	if (ply_steamid64 == lender) then return end


	if BlockFamilySharing then
		--ply:Kick(BlockFamilySharingMessage)
		--PrintMessage(HUD_PRINTTALK, "Family share detected from last joined user!")
		RunConsoleCommand("sam", "asay", "Family share detected from last joined user!", ply_steamid64 ,ply_steamid)
		
	else
		lender = util.SteamIDFrom64(lender)
		sam.player.is_banned(lender, function(banned)
			if banned then
				RunConsoleCommand("sam", "banid", ply_steamid, "0", BanMessage:format(lender))
			end
		end)

	end
	
end)