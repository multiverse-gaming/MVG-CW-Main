local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )

end


AddPlayerModel( "Neimoidian Viceroy",		"models/player/tiki/nm.mdl" )
