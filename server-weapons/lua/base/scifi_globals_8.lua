
AddCSLuaFile()

function DevMsg( text )

	if ( GetConVarNumber( "developer" ) == 0 ) then return end
	
	print( text )

end

function ArrangeElements( minvalue, maxvalue )

	if ( amt == nil ) then
		amt = minvalue
		return amt
	end
 
	if ( ( amt + 1 ) >= maxvalue ) then 
		amt = minvalue 
		return amt 
	end 

	if ( amt >= minvalue ) then
		amt = amt + 1
		return amt
	end 

end

function IsExistent( ent )

	if ( ent == nil ) or ( ent == NULL ) then
	
	return false
	
	end
	
	return true

end

function IsVisibleToEntity( ent1, observer )

	local vistrace = util.TraceEntity( {
		start = ent1:GetPos(),
		endpos = observer:GetPos(),
		filter = function( ent ) if ( ent == ent1 ) or ( ent:GetClass() == "prop_ragdoll" ) then return false else return true end end,
		mask = MASK_SHOT,
		ignoreworld = false
	}, ent1 )

	if ( vistrace.Entity == observer ) or ( vistrace.HitPos:Distance( observer:GetPos() ) <= 1 ) then
		return true
	else
		return false
	end

end

function DLightFade( light, minradius, maxradius, fadeamt, dietime )
		
	local brightness = maxbright
	local range = maxradius
	local srange = range / 2
	
	timer.Create( "daylightdies" .. light:EntIndex(), 0, 0, function()
	
		range = range - fadeamt
		srange = range / 2
		
		if ( light == NULL ) then 
			timer.Destroy( "daylightdies" .. light:EntIndex() ) 
		else
			light:Fire( "distance", range, 0 )
			light:Fire( "spotlight_distance", srange, 0 )
		end
		
		if ( range == minradius ) then
			timer.Destroy( "daylightdies" .. light:EntIndex() )
		end
		
	end )
	
	timer.Create( "SafeRemoveTimer" .. light:EntIndex(), dietime, 0, function()
	
		timer.Destroy( "daylightdies" .. light:EntIndex() )
		timer.Destroy( "SafeRemoveTimer" .. light:EntIndex() )
		
	end )
	
end

function GetRelChance( perc ) 

	local rng = math.random( 0.000, 100.000 )
	
	if ( rng < math.Clamp( perc, 0, 100 ) ) then
	
		return true
	
	else 
	
		return false
	
	end

end