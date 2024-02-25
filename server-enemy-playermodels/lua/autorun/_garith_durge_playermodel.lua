--14th BT Platoon--
---------------------------------------------------------------------------------------------------------------------------------------
CreateConVar( "player_blaze_sounds", "1", { FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_NOTIFY } ) 
CreateConVar( "player_blaze_footsteps", "1", { FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_NOTIFY } ) 
blaze_sounds = "models/player/garith/golden/durge.mdl"

sound.AddSoundOverrides( "lua/juggernaut_sounds.lua" )

list.Set( "PlayerOptionsModel", "Durge", "models/player/garith/golden/durge.mdl" )
player_manager.AddValidModel( "Durge", "models/player/garith/golden/durge.mdl" )

hook.Add("PlayerFootstep","blaze_PlayerFootstep",function(ply,velocity)
	if GetConVarNumber( "player_blaze_footsteps" ) == 1 then	
if(ply:GetModel() == blaze_sounds)then
ply:EmitSound("playermodel_blaze.footsteps")
return true
end
end
end)


