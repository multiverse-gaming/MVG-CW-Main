/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

function zpn.Print(msg)
	MsgC(Color(226, 147, 45), "[Zero´s PumpkinNight] -> ", Color(255, 255, 255), msg .. "\n")
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

if (CLIENT) then
	// Returns the correct Icon depending on Candy Amount
	function zpn.CandyIcon(candy,max)
		if candy >= max then
			return "zpn_candy_large"
		elseif candy >= max / 2 then
			return "zpn_candy_medium"
		else
			return "zpn_candy_small"
		end
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040
