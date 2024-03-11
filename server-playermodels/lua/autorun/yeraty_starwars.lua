local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end

AddPlayerModel( "Yeray Swimmer", 			      "models/mando/clan/nerr.mdl" )





