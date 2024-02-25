local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end



AddPlayerModel( "Cinn_drallig", 		    "models/player/imagundi/cinndrallig.mdl" )