/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

zpn = zpn or {}
zpn.Boss = zpn.Boss or {}

if SERVER then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	// Displays all the boss spawns to the user
	util.AddNetworkString("zpn_Boss_ShowSpawns_net")
	function zpn.Boss.ShowSpawnHints(ply)
	    if not IsValid(ply) then return end

		local positions = {}

		for k,v in pairs(zpn.BossPositions) do
			if v and v.pos then
				table.insert(positions,v.pos)
			end
		end

	    local dataString = util.TableToJSON(positions)
	    local dataCompressed = util.Compress(dataString)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

	    net.Start("zpn_Boss_ShowSpawns_net")
	    net.WriteUInt(#dataCompressed, 16)
	    net.WriteData(dataCompressed, #dataCompressed)
	    net.Send(ply)
	end
else

	local zpn_BossSpawn_Hints = {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619065

	net.Receive("zpn_Boss_ShowSpawns_net", function(len, ply)
		zclib.Debug("zpn_Boss_ShowSpawns_net Len: " .. len)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4

		local dataLength = net.ReadUInt(16)
		local d_Decompressed = util.Decompress(net.ReadData(dataLength))
		local positions = util.JSONToTable(d_Decompressed)

		zpn_BossSpawn_Hints = {}

		for k,v in pairs(positions) do
			table.insert(zpn_BossSpawn_Hints,{time = CurTime(),pos = v})
		end
	end)

	function zpn.Boss.DrawSpawnHints()
		if zpn_BossSpawn_Hints and table.Count(zpn_BossSpawn_Hints) > 0 then
			for k, v in pairs(zpn_BossSpawn_Hints) do
				if v then

					if (v.time + 10) < CurTime() then
						table.remove(zpn_BossSpawn_Hints,k)
						continue
					end

					local pos = v.pos:ToScreen()
					local size = 100
					surface.SetDrawColor(zpn.Theme.Design.color01)
					surface.DrawRect(pos.x - (size * zclib.wM) / 2, pos.y - (size * zclib.hM) / 2, size * zclib.wM, size * zclib.hM)
				end
			end
		end
	end

	zclib.Hook.Add("HUDPaint", "zpn_BossSpawnHints", zpn.Boss.DrawSpawnHints)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73
