local exceptions = {

["models/props_combine/combine_intmonitor001.mdl"] = true,
["models/props_combine/combine_intmonitor003.mdl"] = true,
["models/props_combine/combinebutton.mdl"] = true,
["models/props_wasteland/controlroom_desk001b.mdl"] = true,
["models/props_wasteland/controlroom_desk001a.mdl"] = true,
["models/props_trainstation/traincar_seats001.mdl"] = true,
["models/props_trainstation/traincar_bars003.mdl"] = true,
["models/props_trainstation/traincar_bars002.mdl"] = true,
["models/props_trainstation/traincar_seats001.mdl"] = true,
["models/props_c17/chair_stool01a.mdl"] = true,
["models/props_lab/reciever01a.mdl"] = true,
["models/props_wasteland/prison_heavydoor001a.mdl"] = true,
["models/props_combine/health_charger001.mdl"] = true,
["models/props_c17/furnitureshelf001b.mdl"] = true,
["models/props_c17/furniturefireplace001a.mdl"] = true,
["models/props_citizen_tech/windmill_blade002a.mdl"] = true,
["models/props_wasteland/interior_fence001g.mdl"] = true,
["models/props_wasteland/exterior_fence001a.mdl"] = true,
["models/props_wasteland/exterior_fence003b.mdl"] = true,
["models/props_lab/workspace001.mdl"] = true,
["models/props_lab/workspace002.mdl"] = true,
["models/props_lab/workspace003.mdl"] = true,
["models/props_lab/workspace004.mdl"] = true,
["models/props/power_train/power_train01.mdl"] = true,
["models/props_wasteland/panel_leverhandle001a.mdl"] = true,
["models/props_c17/furnituremattress001a.mdl"] = true,		--Add special ragdoll exception
["models/props_c17/playground_carousel01.mdl"] = true,
["models/props_c17/furnitureradiator001a.mdl"] = true,
["models/props_c17/streetsign004e.mdl"] = true,
["models/props_c17/signpole001.mdl"] = true,
["models/props_lab/keypad.mdl"] = true,
["models/combine_camera/combine_camera.mdl"] = true,
["models/props_lab/corkboard001.mdl"] = true,
["models/gibs/glass_shard.mdl"] = true,
["models/props_interiors/lights_florescent01a.mdl"] = true,
["models/props_c17/clock01.mdl"] = true,
}

local _maps = {
["gm_aftermath_night_v1_0"] = true,
["gm_aftermath_night"] = true,
["gm_aftermath_day_v1_0"] = true,
["gm_aftermath_v2"] = true,
}

-- Checks whether the console is set to verbose output. If so, print the message. If not, don't.
local function _ChkMsg ( col, str )
	if GetConVarNumber( "debug_Aftermath_VerboseConversion" ) > 0 then
		MsgC( col, str )
	end
end


local function DoPhysics ( ply, cmd, args )
	print( GetConVarNumber( "Aftermath_ConvertProps" ) == 1 )
	print( GetConVarNumber( "Aftermath_ConvertProps" ) )
	if not( _maps[game.GetMap( )] == true ) then return end
	if not( GetConVarNumber( "Aftermath_ConvertProps" ) == 1 ) then MsgC( Color( 78, 209, 255 ), "Loading Aftermath props normally. Set Aftermath_ConvertProps to 1 to convert many decorative props to physics props.\n" ) return end
	MsgC( Color( 78, 209, 255 ), "Converting Aftermath prop_dynamic to prop_physics...\n" )

	for k, v in pairs ( ents.GetAll( ) ) do
		
		if (v:GetClass( ) == "prop_dynamic_override" or v:GetClass( ) == "prop_dynamic" ) then
			
			local mdl = v:GetModel( )
			local pos = v:GetPos( )
			local ang = v:GetAngles( )
			
			if mdl and pos and ang then
			
				if not exceptions[mdl] then
				
					local ent = ents.Create( "prop_physics" )
					ent:SetModel( mdl )
					ent:SetPos( pos )
					ent:SetAngles( ang )
					
					ent:Spawn( )
					
					if IsValid( ent ) then
					
						if IsValid( ent:GetPhysicsObject( ) ) then
					
							v:Remove( )
						
							_ChkMsg( Color( 78, 209, 255 ), "Successfully converted "..mdl.."\n" )
							
						else
						
							ent:Remove( )
							
							MsgC( Color( 255, 0, 0 ), "Attempted to spawn "..mdl.." but there was no physics object! Removed.\n" )
							
						end
						
						-- -- Physics stuff
						-- self:SetMoveType( MOVETYPE_VPHYSICS )
						-- self:SetSolid( SOLID_VPHYSICS )

						-- -- Init physics only on server, so it doesn't mess up physgun beam
						-- if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
						
						-- -- Make prop to fall on spawn
						-- local phys = self:GetPhysicsObject()
						-- if ( IsValid( phys ) ) then phys:Wake() end
							-- end
						-- end

					
					else
						
						MsgC( Color( 255, 0, 0 ), "Attempted spawn was invalid.\n" )
						
					end
					
				else
					
					_ChkMsg( Color( 255, 255, 0 ), "Model "..mdl.." is an exception, ignored.\n" )

				end
				
			else
				MsgC( Color( 255, 0, 0 ), "Mdl, pos, or ang was invalid.\n" )	
			end
			
		end
		
	end
	
	MsgC( Color( 78, 209, 255 ), "Done converting Aftermath props. Set Aftermath_ConvertProps to 0 to leave many physics props static.\n" )			
end

concommand.Add( "debug_Aftermath_DoConversion", DoPhysics )
CreateConVar( "Aftermath_ConvertProps", 0, FCVAR_PROTECTED + FCVAR_ARCHIVE, [[
Set this to 1 to load Gm_Aftermath_V2 or Gm_Aftermath_Night with many decorative props converted to physics props. Set this to 0 to load the maps normally.
]])
CreateConVar( "debug_Aftermath_VerboseConversion", 0, FCVAR_PROTECTED + FCVAR_ARCHIVE, "Set this to 1 to output more prop conversion information to the console.")

hook.Add( "InitPostEntity", "AftermathPropConversion", DoPhysics)


-- local function PrintModel( ply, cmd, args )

	-- local tr = ply:GetEyeTrace( )
	
	-- if tr.Hit then
	
		-- if IsValid( tr.Entity ) then
		
			-- print( tr.Entity:GetModel( ) )
		
		-- end
		
	-- end
	

-- end

-- concommand.Add( "Aftermath_GetModel", PrintModel )

-- local function GetAttach( ply, cmd, args )

	-- local tr = ply:GetEyeTrace( )
	
	-- if tr.Hit then
	
		-- if IsValid( tr.Entity ) then
		
			-- local tbl = tr.Entity:GetAttachments( )
			
			-- if tbl then
				
				-- print(tbl)
				-- print(table.Count(tbl) )
				
				-- for k, v in pairs(tbl) do
					
					-- print("Key: "..v.."     Value: "..v )
				
				-- end
				
			-- end
		
		-- end
		
	-- end
	
-- end
-- concommand.Add( "Endure_GetAttachments", GetAttach )