local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end



AddPlayerModel( "cad bane", 		"models/grealms/characters/cadbane/cadbane.mdl" )
