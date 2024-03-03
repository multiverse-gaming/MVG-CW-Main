local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end

AddPlayerModel( "NGR Coleman", 				"models/cultist_kun/sw/coleman.mdl" )
AddPlayerModel( "NGR MM", 				"models/cultist_kun/sw/mm.mdl" )
AddPlayerModel( "NGR Saesee", 				"models/cultist_kun/sw/saesee_tiin.mdl" )
AddPlayerModel( "NGR Poof", 				"models/cultist_kun/sw/yarael_poof.mdl" )
