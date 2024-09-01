if SERVER then
	if not ConVarExists("macroping_play_sounds_all") then
		CreateConVar("macroping_play_sounds_all", 0, 0, "Play placing sounds to all players") -- yay.
	end
end