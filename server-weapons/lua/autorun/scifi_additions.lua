

--------------------My first SciFi weapon base--------------------
--		    	SciFi Weapons v16 - by Darken217		 		--
------------------------------------------------------------------
-- Please do NOT use any of my code without further permission! --
------------------------------------------------------------------
-- Purpose: RPG functions and not required and additional stuff --
-- cvars and so on...											--
------------------------------------------------------------------
-- Initialized via autorun.										--
------------------------------------------------------------------

--AddCSLuaFile()

local fams = {
	[ "mtm" ] = { "sfw_grinder", "sfw_hellfire", "sfw_acidrain", "sfw_neutrino" },
	[ "hwave" ] = { "sfw_ember", "sfw_hwave", "sfw_phoenix", "sfw_seraphim" },
	[ "vprtec" ] = { "sfw_eblade", "sfw_fallingstar", "sfw_saphyre", "sfw_storm", "sfw_vapor" },
	[ "nxs" ] = { "sfw_pulsar", "sfw_stinger", "sfw_trace", "sfw_hornet" },
	[ "t3i" ] = { "sfw_blizzard", "sfw_cryon", "sfw_thunderbolt", "sfw_pandemic" },
	[ "dev" ] = { "sfw_custom", "sfw_ignis", "sfw_meteor", "sfw_powerfist", "sfw_hwave_tx", "sfw_pyre" },
	[ "ancient" ] = { "sfw_alchemy", "sfw_prisma", "sfw_supra" },
	[ "all" ] = { 
			"sfw_acidrain", 
			"sfw_alchemy", 
			"sfw_blizzard", 
			"sfw_behemoth", 
			"sfw_cryon", 
			"sfw_custom", 
			"sfw_eblade", 
			"sfw_ember",
			"sfw_fallingstar",
			"sfw_grinder", 
			"sfw_hellfire", 
			"sfw_hornet",
			"sfw_hwave", 
			"sfw_neutrino",
			"sfw_pandemic",
			"sfw_phoenix", 
			"sfw_pulsar", 
			"sfw_saphyre",
			"sfw_seraphim",
			"sfw_stinger", 
			"sfw_storm",
			"sfw_thunderbolt",
			"sfw_trace",
			"sfw_vapor"
		}
}

local function GiveWeapon( ply, cmd, args )

	local input = args[1]
	local position = args[2]
	local mobdrop = args[3]
	
	if ( table.HasValue( table.GetKeys( fams ), input ) ) then
		for k,v in pairs ( fams[ input ] ) do 
			if ( position == "setpos" ) then
				local ent = ents.Create( v )
				if ( !IsValid( ent ) ) then return end	
				ent:SetPos( ply:GetEyeTrace().HitPos )
				ent:Spawn()
				ent:Activate()
				if ( mobdrop == "1" ) then
					ent:SetNWBool( "MobDrop", true )
				end
			else
				ply:Give( v )
			end
		end
	else
		MsgC( Color( 255, 80, 80 ), "@SciFiWeapons : !Error, Unknown family type.\n" )
	end

end

local function AutoComplete( cmd, stringargs )

	stringargs = string.Trim( stringargs )
	stringargs = string.lower( stringargs )

	local tbl = {}

	for k, v in pairs( table.GetKeys( fams ) ) do
		local set = v
		if string.find( string.lower( set ), stringargs ) then
			set = cmd.." "..set
			table.insert( tbl, set )
		end
	end

	return tbl
	
end

concommand.Add( 
	"sfw_give", 
	
	GiveWeapon, -- callback

	AutoComplete, -- autocomplete

	"Gives the player a certain pack of weapons depending on the given weapon family. Type 'setpos' behind the family to spawn the weapons where you're looking at and '1' at the end, to force it to drop in rng mode.", -- helptext
	
	0 -- cvar enums
)

local function ForceChaos()

	for k,v in pairs( ents.GetAll() ) do 
		if ( v:IsNPC() ) then 
			for k,x in pairs( ents.FindInSphere( v:GetPos(), 1024) ) do
				if ( x:IsNPC() ) then
					v:AddEntityRelationship( x, D_HT, 99 )
				end
				if ( x:IsPlayer() ) then
					v:AddEntityRelationship( x, D_NU, 1 )
				end
				v:SetSchedule( SCHED_WAKE_ANGRY )
			end 
		--	v:Fire( "setsquad", "", 0 )
		--	v:Fire( "updateenemymemory", "", 0 )
		end
	end

end

concommand.Add( 
	"sfw_forcechaos", 
	
	ForceChaos, -- callback

	nil, -- autocomplete

	"Causes a rampage...", -- helptext
	
	0 -- cvar enums
)

CreateClientConVar( "vh_campaign", "0", true, false )

local actions = { 
"add",
"remove",
"clear",
"print"
}

local function Loadout( ply, cmd, args )

	local action = args[1]
	local classname = args[2]
	local cmdmsgclr = Color( 200, 175, 255 )
	
	if ( !table.HasValue( actions, action ) ) then
		MsgC( Color( 255, 80, 80 ), "!Error; Unknown action!\n" )
	return
	end
		
	if ( action == "print" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = file.Read( "vh_loadout.txt", "DATA" )
			local tab = util.JSONToTable( content ) 
			
			MsgC( cmdmsgclr, "DATA/vh_loadout.txt: \n" )
			if ( tab ) then
				for k,v in pairs ( tab ) do
					print( v )
				end
			else
				MsgC( cmdmsgclr, "!Warning, Save file contains no data." )
			end
		else
			MsgC( cmdmsgclr, "!Error, failed to locate save file!\n" )
		end
	end

	if ( action == "clear" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = file.Read( "vh_loadout.txt", "DATA" )

			file.Write( "vh_loadout.txt", "" )
			
			MsgC( cmdmsgclr, "!Warning; DATA/vh_loadout.txt has been cleared!\n" .. content .. "\n" )
		else
			MsgC( cmdmsgclr, "!Error; failed to locate save file!\n" )
		end
	end
	
	if ( action == "add" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = util.JSONToTable( file.Read( "vh_loadout.txt", "DATA" ) )

			MsgC( cmdmsgclr, "Saving loadout...\n" )
			
			if ( content == nil ) then
				content = { classname }
			end
			
			if ( !table.HasValue( content, classname ) ) then
				table.Add( content, { classname } )

				file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
				
				MsgC( cmdmsgclr, "Done!\n" )
			else
				MsgC( cmdmsgclr, "!Error; Weapon is already listed in save file.\n" )
			end
		else
			MsgC( cmdmsgclr, "!Error, failed to locate save file. Creating new one...\n" )
			MsgC( cmdmsgclr, "Saving loadout...\n" )
			
			file.Write( "vh_loadout.txt", classname )
			
			MsgC( cmdmsgclr, "Done!\n" )
		end
	end
	
	if ( action == "remove" ) then
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
			local content = util.JSONToTable( file.Read( "vh_loadout.txt", "DATA" ) )

			
			if ( content == nil ) then
				MsgC( cmdmsgclr, "!Error, Save file contains no data.\n" )
			else
				MsgC( cmdmsgclr, "Saving loadout...\n" )
				
				table.RemoveByValue( content, classname )

				file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
				
				MsgC( cmdmsgclr, "Done!\n" )
			end
		else
			MsgC( cmdmsgclr, "!Error, failed to locate save file!\n" )
		end
	end

end

local function GetLoadout()
	local cmdmsgclr = Color( 200, 175, 255 )
	
	if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then
		local content = file.Read( "vh_loadout.txt", "DATA" )
		local tab = util.JSONToTable( content ) 
		
		MsgC( cmdmsgclr, "DATA/vh_loadout.txt: \n" )
		
		return tab
	else
		MsgC( cmdmsgclr, "!Error, failed to locate save file!\n" )
		local tab = { "sfw_basetest", "sfw_frag" }
		return tab
	end
end

concommand.Add( 
	"vh_campaign_loadout", 
	Loadout,
	nil, 
	"Change the loadout that is auto-given to the player on spawn. Actions are: 'add', 'remove', 'clear' and 'print'. Structure is: *action* *classname*. Print will just dump the current save data's contents to the console. Note, that if the file is not present yet, you'll need to use 'add' in order to create a new one.", 
	{ FCVAR_DONTRECORD }
)

concommand.Add( 
	"vh_campaign_loadout_give", 
	function( player, command, arguments, args )
		local cmd_storymode = GetConVarNumber( "vh_campaign" )
		local cmdmsgclr = Color( 200, 175, 255 )
		
		if ( cmd_storymode >= 1 ) then
			local loadout = GetLoadout()
			if ( loadout ) then
				for i, weapon in pairs( loadout ) do
					player:Give( weapon )
				end
			end
		else
			MsgC( "!Error; Game not running in story mode!" )
		end
	end, 
	nil, 
	"", 
	{ FCVAR_DONTRECORD }
)

CreateClientConVar( "vh_campaign_loadout_autocompose", "0", true, false )
 
concommand.Add( 
	"vh_campaign_removegear", 
	function( player, command, arguments, args )
		local cmd_storymode = GetConVarNumber( "vh_campaign" )
		local cmdmsgclr = Color( 200, 175, 255 )
		
		if ( cmd_storymode >= 1 ) then
			player:StripWeapons()
			MsgC( cmdmsgclr, "Done!\n" )
		else
			MsgC( "!Error; Game not running in story mode!" )
		end
	end, 
	nil, 
	"Disarms the player.", 
	{ FCVAR_DONTRECORD }
)

hook.Add( "PlayerSpawn", "OnSpawnApplyStoryLoadout", function( ply )

	local cmd_storymode = GetConVarNumber( "vh_campaign" )
	
	if ( cmd_storymode >= 1 ) then
		if ( SERVER ) then
			timer.Simple( 0.2, function() 
				ply:StripWeapons()
				local loadout = GetLoadout()
				if ( loadout ) then
					for i, weapon in pairs( loadout ) do
						ply:Give( weapon )
					end
				end
			end )
			
			ply:SetRunSpeed( 350 )
		end
	end

end )

hook.Add( "PlayerCanPickupWeapon", "VHCampaignLoadoutAutoCompose", function( ply, wep )

	if ( CurTime() >= 20 ) && ( GetConVarNumber( "vh_campaign" ) == 1 && GetConVarNumber( "vh_campaign_loadout_autocompose" ) == 1 ) then
		local cmdmsgclr = Color( 200, 175, 255 )
		local classname = wep:GetClass()
	
		if ( file.Exists( "vh_loadout.txt", "DATA" ) ) then

			local content = util.JSONToTable( file.Read( "vh_loadout.txt", "DATA" ) )
			
			if ( content == nil ) then
				content = { classname }
				file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
				MsgC( cmdmsgclr, "Added " .. classname .. "to loadout save.\n" )
			else
				if ( !table.HasValue( content, classname ) ) then
					table.Add( content, { classname } )
					file.Write( "vh_loadout.txt", util.TableToJSON( content ) )
					MsgC( cmdmsgclr, "Added " .. classname .. " to loadout save.\n" )
				end
			end
		else
			MsgC( cmdmsgclr, "!Error, failed to locate save file. Creating new one...\n" )
			MsgC( cmdmsgclr, "Saving loadout...\n" )
			
			file.Write( "vh_loadout.txt", classname )
			
			MsgC( cmdmsgclr, "Done!\n" )
		end
	end
	
end )

CreateClientConVar( "vh_rtlight_maxprojextures", "10", false, false )
CreateClientConVar( "vh_rtlight_brightness", "1", false, false )
CreateClientConVar( "vh_rtlight_color", "255 255 255 255", false, false )

concommand.Add( 
	"vh_rtlight_overridespotlights", 
	function( player, command, arguments, args )
		if ( SERVER ) then
			
			local cmdmsgclr = Color( 200, 175, 255 )
			
			local counter = 0
			local cmd_limit = GetConVarNumber( "vh_rtlight_maxprojextures" )
			local cmd_color = GetConVarString( "vh_rtlight_color" )
			local cmd_brightness = GetConVarNumber( "vh_rtlight_brightness" )	
		
			local colormod = string.ToColor( cmd_color )

			local color = Format( "%i %i %i 255", colormod.r * cmd_brightness, colormod.g * cmd_brightness, colormod.b * cmd_brightness )
			
			local targets = ents.FindByClass( "point_spotlight" )
			local checkback = ents.FindByName( "realtimelight" )
			
			MsgC( cmdmsgclr, "Fetching spotlights ... " .. #targets .. " found.\n" )
			
			if ( #checkback > 0 ) then
				for k, v in pairs ( checkback ) do
					v:Remove()
				end
				MsgC( cmdmsgclr, "!Warning; Detected already existing realtimelights... removing!\n" )
			end
			
			for k, v in pairs ( targets ) do
				if ( cmd_limit > counter ) then
					local spotvars = v:GetKeyValues()
					
					local realtime = ents.Create( "env_projectedtexture" )
					realtime:SetKeyValue( "targetname", "realtimelight" )
					realtime:SetPos( v:GetPos() )
					realtime:SetAngles( v:GetAngles() )	
					realtime:SetParent( v )		
					realtime:SetKeyValue( "lightfov", spotvars.SpotlightWidth )
					realtime:SetKeyValue( "lightworld", 1 )	
					realtime:SetKeyValue( "lightcolor", color )
					realtime:SetKeyValue( "enableshadows", 1 )
					realtime:SetKeyValue( "farz", 1768 + spotvars.SpotlightLength )
					realtime:SetKeyValue( "nearz", 16 )
					realtime:Fire( "SpotlightTexture", "effects/flashlight/hard", 0 )
					
					v:SetKeyValue( "rendercolor", "0 0 0" )
					v:Fire( "TurnOff", "", 0 )

					ParticleEffectAttach( "flare_halo_0", 1, realtime, -1 )
					counter = counter + 1
				end
			end
			
			MsgC( cmdmsgclr, counter .. " realtimelights have been created.\n" )
			
			if ( #targets > counter ) then
				MsgC( cmdmsgclr, "!Error; Can't create more realtimelights! Limit exceeding!\n" )
			end
		end
	end, 
	nil, 
	"", 
	{ FCVAR_DONTRECORD }
)

-- local candrop = true

hook.Add( "PlayerCanPickupWeapon", "rpPreventAutoEquip", function( ply, wep )

	if ( ( GetConVarNumber( "sfw_debug_preventautoequip" ) == 1 ) ) then 
		if ( !ply:KeyDown( IN_USE ) ) then
			return false
		else
		--	if ( #ply:GetWeapons() < 3 ) || ( table.HasValue( ply:GetWeapons(), wep ) ) then
				return true
				
		--[[
			else
				if ( candrop ) then
					ply:DropWeapon( ply:GetActiveWeapon() )
					candrop = false
					timer.Simple( 1, function() candrop = true end )
				end
				return false
			end
		]]--
		end
	end

--	if ( IsSciFiWeapon( wep ) && !ply:KeyDown( IN_USE ) ) and ( GetConVarNumber( "sfw_debug_preventautoequip" ) == 1 ) then return false end
	
end )