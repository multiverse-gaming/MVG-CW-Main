local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end

AddPlayerModel( "Clone Recruit Medic", 			      "models/player/olive/cr_med/cr_med.mdl" )
AddPlayerModel( "Clone Recruit Heavy", 			      "models/player/olive/cr_heavy/cr_heavy.mdl" )
AddPlayerModel( "Clone Recruit Sniper", 			      "models/player/olive/cr_sniper/cr_sniper.mdl" )
AddPlayerModel( "Clone Recruit", 			      "models/player/olive/cr/cr.mdl" )
AddPlayerModel( "Clone Cadet", 			      "models/player/olive/cadet/cadet.mdl" )


