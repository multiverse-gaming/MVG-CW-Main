local function AddPlayerModel( name, model )

	list.Set( "PlayerOptionsModel", name, model )
	player_manager.AddValidModel( name, model )
	
end



AddPlayerModel( "deathwatch", 		"models/grealms/characters/deathwatch/deathwatch_infantry.mdl" )
AddPlayerModel( "pre vizla", 		"models/grealms/characters/deathwatch/deathwatch_previszla.mdl" )
