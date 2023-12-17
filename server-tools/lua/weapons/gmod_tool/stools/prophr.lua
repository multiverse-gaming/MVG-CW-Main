--[[
	Version : v4.02 - 08. Mai 2019 (08.05.2019)

	This tool is made by : ravo Norway
	This tool is *not made* to be copied; please *do not* copy code; feel free to read it though.
--]]

 --[[ 
	 if SERVER then
		GetConVar("prophr_healthbarcolor"):SetString('{"r": 20, "g": 0, "b": 0}')
	end
  ]]

  -- NÅR e-blir linka, og det er allereie vanlig PropHr, så blir den ikkje resett fyrst ser det ut som... hitboxane...
AddCSLuaFile('toolgun/prophr_toolgun_buildCPanel.lua')
--
AddCSLuaFile('functions/prophr_func_setVarible.lua')
AddCSLuaFile('functions/prophr_func_logic_print_out.lua')
AddCSLuaFile('functions/prophr_func_logic_addentityrelationship.lua')
AddCSLuaFile('functions/prophr_func_lagreforreforhold.lua')
AddCSLuaFile('functions/prophr_func_single_connection.lua')
AddCSLuaFile('functions/prophr_func_addentityrelationship.lua')
AddCSLuaFile('functions/prophr_func_npcneutralrelationshippropfunc.lua')
AddCSLuaFile('functions/prophr_func_npcneutralrelationshipnpcfunc.lua')
--
AddCSLuaFile('functions/prophr_func_npcrelationshippropfunc.lua')
--
AddCSLuaFile('functions/prophr_func_createnpcforhittarget.lua')
AddCSLuaFile('hooks/prophr_hook_hudpaint_healthbar.lua') -- On every frame
AddCSLuaFile('hooks/prophr_hook_physgunpickup.lua') 	-- Playerpickup with physgun
--
AddCSLuaFile('duplicator/prophr_dup_prop.lua') 		-- Register for duplication
AddCSLuaFile('duplicator/prophr_dup_npc.lua') 		-- For a normal NPC duplication
--
AddCSLuaFile('hooks/prophr_hook_entitytakedamage_prop_npc.lua') 	-- On entity taking damage
AddCSLuaFile('hooks/prophr_hook_onentitycreated_prophr.lua') 	-- On new entity created
AddCSLuaFile('hooks/prophr_hook_onentityremoved.lua') 	-- On new entity removed
--
AddCSLuaFile('toolgun/prophr_toolgun_leftclick.lua') 	-- Apply settings to prop
AddCSLuaFile('toolgun/prophr_toolgun_rightclick.lua') 	-- Copy settings of prop with PropHr-property
AddCSLuaFile('toolgun/prophr_toolgun_reload.lua') 		-- Remove PropHr-property
--
 --
  --
 -- Custom Console-Varibles
--
CreateClientConVar("prophr_health", 100, true, false, "Change the health-setting. (PropHr-tool)")
CreateClientConVar("prophr_health_bar_active", 1, true, false, "Changes the health-bar's visibility. (PropHr-tool)")
CreateClientConVar("prophr_health_left_text_active", 0, true, false, "Change if the health-left is going to be displayed as text. (PropHr-tool)")
--
CreateClientConVar("prophr_health_reset_timer_value", 1, true, false, "Change the value for the timer that resets the health after X seconds. (PropHr-tool)")
CreateClientConVar("prophr_health_reset_timer_interval_value", 0, true, false, "Change the value for the amount the interval is going to loop (0 = infinite) (PropHr-tool)")
CreateClientConVar("prophr_health_reset_timer_checkbox", 1, true, false, "Enable health reset after X seconds or not. (PropHr-tool)")
--
CreateClientConVar("prophr_hostiles_attacks", 1, true, false, "Change if NPC's is going to attack the prop. (PropHr-tool)")
--
CreateClientConVar("prophr_Combines_attacks", 0, true, false, "Change if Combines is going to attack the prop. (PropHr-tool)")
CreateClientConVar("prophr_HumansResistance_attacks", 0, true, false, "Change if Humans + Resistance is going to attack the prop. (PropHr-tool)")
CreateClientConVar("prophr_Zombies_attacks", 0, true, false, "Change if Zombies + Enemy Aliens is going to attack the prop. (PropHr-tool)")
CreateClientConVar("prophr_EnemyAliens_attacks", 0, true, false, "Change if Enemy Aliens is going to attack the prop. (PropHr-tool)")
CreateClientConVar("prophr_EveryNPC_attacks", 0, true, false, "Change if Every NPC is going to attack the prop (PropHr-tool)")
--
CreateClientConVar("prophr_new_healthLeft_onchange", 1, true, false, "Change if the prop is going to get brand new health values or not on change. (PropHr-tool)")
CreateClientConVar("prophr_new_health_onchange", 1, true, false, "Change if the prop is going to get brand new health values or not on change. (PropHr-tool)")
--
CreateClientConVar("prophr_relationship_amount_npc", 99, true, false, "Change what the strenght of the 'NPC to Prop'-relationship-strenght is going to be. (PropHr-tool)")
--
CreateClientConVar("prophr_disable_thinking", 0, true, false, "Change if the NPC is going to be able to think. (PropHr-tool)")
--
CreateClientConVar("prophr_fear_the_hostile_npc", 0, true, false, "Change if the NPC that have PropHr attached to it, will fear the NPC(s) that hate it. (PropHr-tool)")
CreateClientConVar("prophr_hate_the_hostile_npc", 0, true, false, "Change if the NPC that have PropHr attached to it, will hate the NPC(s) that hate it. (PropHr-tool)")
--
CreateClientConVar("prophr_single_connection_with_class", 0, true, false, "Choose wether when holding 'E' to choose the entity nr.1's class-group to be hostile agains entity nr.2. (PropHr-tool)")
--
CreateClientConVar("prophr_optimized_hitbox_system", 0, true, false, "Choose if the prop is going to have only one hitbox in the center (opimized), or on all sides also; then totalling five hitboxes for each prop. (PropHr-tool)")
--
CreateClientConVar("prophr_print_out_relationships_in_console", 0, true, false, "Print out relationships in console when using the PropHr tool. Good for debugging (PropHr-tool)")
--
 -- Globale Variabler (for alle andre addons også ! Unikt namn må til)
--
prophr_ent_npc_class 		 	= "npc_bullseye"	-- Make NPC's like e.g. zombies attack the prop (this is an invisible hitbox sphere)
prophr_spesific_relationship 	= {}				-- For single connection (or NPC class) between two entities
prophr_healthbarcolor			= {					-- Healthbar color
	r = 250,
	g = 0,
	b = 0
}
prophr_npc_blood_color = BLOOD_COLOR_RED -- Blood color
--
if SERVER then
	util.AddNetworkString("prophr_health")
	util.AddNetworkString("prophr_health_bar_active")
	util.AddNetworkString("prophr_health_left_text_active")
	util.AddNetworkString("prophr_health_reset_timer_interval_value")
	util.AddNetworkString("prophr_health_reset_timer_checkbox")
	util.AddNetworkString("prophr_hostiles_attacks")
	util.AddNetworkString("prophr_Combines_attacks")
	util.AddNetworkString("prophr_HumansResistance_attacks")
	util.AddNetworkString("prophr_Zombies_attacks")
	util.AddNetworkString("prophr_EnemyAliens_attacks")
	util.AddNetworkString("prophr_EveryNPC_attacks")
	util.AddNetworkString("prophr_new_healthLeft_onchange")
	util.AddNetworkString("prophr_new_health_onchange")
	util.AddNetworkString("prophr_relationship_amount_npc")
	util.AddNetworkString("prophr_disable_thinking")
	util.AddNetworkString("prophr_fear_the_hostile_npc")
	util.AddNetworkString("prophr_hate_the_hostile_npc")
	util.AddNetworkString("prophr_single_connection_with_class")
	util.AddNetworkString("prophr_optimized_hitbox_system")
	util.AddNetworkString("prophr_print_out_relationships_in_console")
	util.AddNetworkString("prophr_health_reset_timer_value")
	util.AddNetworkString("prophr_bloodColor")
	--
	-- DETTE ER KLIENT-DATA NO TILGJENGELIG FOR SERVER
	-- Skriv nettverkvariabel (deles mellom spelarar på SERVER) og klientdata
	-- INTENGER
	net.Receive("prophr_health", function(_Length, _Player)
		setVarible(_Player, "prophr_health", "int", net.ReadInt(18))
	end)
	net.Receive("prophr_health_bar_active", function(_Length, _Player)
		setVarible(_Player, "prophr_health_bar_active", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_health_left_text_active", function(_Length, _Player)
		setVarible(_Player, "prophr_health_left_text_active", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_health_reset_timer_interval_value", function(_Length, _Player)
		setVarible(_Player, "prophr_health_reset_timer_interval_value", "int", net.ReadInt(16))
	end)
	net.Receive("prophr_health_reset_timer_checkbox", function(_Length, _Player)
		setVarible(_Player, "prophr_health_reset_timer_checkbox", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_hostiles_attacks", function(_Length, _Player)
		setVarible(_Player, "prophr_hostiles_attacks", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_Combines_attacks", function(_Length, _Player)
		setVarible(_Player, "prophr_Combines_attacks", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_HumansResistance_attacks", function(_Length, _Player)
		setVarible(_Player, "prophr_HumansResistance_attacks", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_Zombies_attacks", function(_Length, _Player)
		setVarible(_Player, "prophr_Zombies_attacks", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_EnemyAliens_attacks", function(_Length, _Player)
		setVarible(_Player, "prophr_EnemyAliens_attacks", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_EveryNPC_attacks", function(_Length, _Player)
		setVarible(_Player, "prophr_EveryNPC_attacks", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_new_healthLeft_onchange", function(_Length, _Player)
		setVarible(_Player, "prophr_new_healthLeft_onchange", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_new_health_onchange", function(_Length, _Player)
		setVarible(_Player, "prophr_new_health_onchange", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_relationship_amount_npc", function(_Length, _Player)
		setVarible(_Player, "prophr_relationship_amount_npc", "int", net.ReadInt(12))
	end)
	net.Receive("prophr_disable_thinking", function(_Length, _Player)
		setVarible(_Player, "prophr_disable_thinking", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_fear_the_hostile_npc", function(_Length, _Player)
		setVarible(_Player, "prophr_fear_the_hostile_npc", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_hate_the_hostile_npc", function(_Length, _Player)
		setVarible(_Player, "prophr_hate_the_hostile_npc", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_single_connection_with_class", function(_Length, _Player)
		setVarible(_Player, "prophr_single_connection_with_class", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_optimized_hitbox_system", function(_Length, _Player)
		setVarible(_Player, "prophr_optimized_hitbox_system", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_print_out_relationships_in_console", function(_Length, _Player)
		setVarible(_Player, "prophr_print_out_relationships_in_console", "int", net.ReadInt(3))
	end)
	net.Receive("prophr_bloodColor", function(_Length, _Player)
		prophr_npc_blood_color = net.ReadInt(3) -- giddaskje å endre på denne no
	end)
	-- FLOAT
	net.Receive("prophr_health_reset_timer_value", function(_Length, _Player)
		setVarible(_Player, "prophr_health_reset_timer_value", "float", net.ReadFloat())
	end)
end
-- Sett NW-variabler på innlasting
if CLIENT then
	local function sendTilServer(
		bits,
		Var,
		typeNet
	)
		--Skriv
		if (typeNet == 'int') then
			--
			net.Start(Var)
			net.WriteInt(GetConVar(Var):GetInt(), bits)
			net.SendToServer()
		else
			if (typeNet == 'float') then
				--
				net.Start(Var)
				net.WriteFloat(GetConVar(Var):GetFloat(), bits)
				net.SendToServer()
			end
		end
	end
	--
	--
	-- Sett ein timer på, sånn da ikkje blir kluss...
	-- INTENGER
	timer.Simple((5 / 1000), function()
		sendTilServer(
			18,
			'prophr_health',
			'int'
		)	
	end)
	timer.Simple((10 / 1000), function()
		sendTilServer(
			3,
			'prophr_health_bar_active',
			'int'
		)	
	end)
	timer.Simple((15 / 1000), function()
		sendTilServer(
			3,
			'prophr_health_left_text_active',
			'int'
		)	
	end)
	timer.Simple((20 / 1000), function()
		sendTilServer(
			16,
			'prophr_health_reset_timer_interval_value',
			'int'
		)	
	end)
	timer.Simple((25 / 1000), function()
		sendTilServer(
			3,
			'prophr_health_reset_timer_checkbox',
			'int'
		)	
	end)
	timer.Simple((30 / 1000), function()
		sendTilServer(
			3,
			'prophr_hostiles_attacks',
			'int'
		)
	end)
	timer.Simple((35 / 1000), function()
		sendTilServer(
			3,
			'prophr_Combines_attacks',
			'int'
		)	
	end)
	timer.Simple((40 / 1000), function()
		sendTilServer(
			3,
			'prophr_HumansResistance_attacks',
			'int'
		)	
	end)
	timer.Simple((45 / 1000), function()
		sendTilServer(
			3,
			'prophr_Zombies_attacks',
			'int'
		)	
	end)
	timer.Simple((50 / 1000), function()
		sendTilServer(
			3,
			'prophr_EnemyAliens_attacks',
			'int'
		)	
	end)
	timer.Simple((55 / 1000), function()
		sendTilServer(
			3,
			'prophr_EveryNPC_attacks',
			'int'
		)	
	end)
	timer.Simple((60 / 1000), function()
		sendTilServer(
			3,
			'prophr_new_healthLeft_onchange',
			'int'
		)	
	end)
	timer.Simple((65 / 1000), function()
		sendTilServer(
			3,
			'prophr_new_health_onchange',
			'int'
		)	
	end)
	timer.Simple((70 / 1000), function()
		sendTilServer(
			12,
			'prophr_relationship_amount_npc',
			'int'
		)	
	end)
	timer.Simple((75 / 1000), function()
		sendTilServer(
			3,
			'prophr_disable_thinking',
			'int'
		)	
	end)
	timer.Simple((80 / 1000), function()
		sendTilServer(
			3,
			'prophr_fear_the_hostile_npc',
			'int'
		)	
	end)
	timer.Simple((85 / 1000), function()
		sendTilServer(
			3,
			'prophr_hate_the_hostile_npc',
			'int'
		)	
	end)
	timer.Simple((90 / 1000), function()
		sendTilServer(
			3,
			'prophr_single_connection_with_class',
			'int'
		)	
	end)
	timer.Simple((95 / 1000), function()
		sendTilServer(
			3,
			'prophr_optimized_hitbox_system',
			'int'
		)	
	end)
	timer.Simple((100 / 1000), function()
		sendTilServer(
			3,
			'prophr_print_out_relationships_in_console',
			'int'
		)	
	end)
	-- FLOAT
	timer.Simple((105 / 1000), function()
		sendTilServer(
			9,
			'prophr_health_reset_timer_value',
			'float'
		)
	end)
	--
	--
	-- BLODFARGE BLIR IKKJE OPPDATERT
end
--
 -- Build control-panel for tool-gun
--
include('toolgun/prophr_toolgun_buildCPanel.lua')
--
if CLIENT then
	TOOL.Category = "Event Tools"
	TOOL.Name	    = "#Tool.prophr.name"

	TOOL.Information = {
		{ name = "left" },
		{ name = "left_use" },
		{ name = "right" },
		{ name = "reload" }
	}

	--
	  -- Toolgun-UI-tekst
	--
	language.Add("Tool.prophr.name", "PropHr")
	language.Add("Tool.prophr.desc", "Add custom break and/or attack settings to almost any prop or NPC")
	
	language.Add( "tool.prophr.left", "Apply PropHr constraints" )
	language.Add( "tool.prophr.left_use", "Add a Single Connection-link between NPC-PROP/NPC-NPC" )
	language.Add( "tool.prophr.right", "Copy PropHr constraints" )
	language.Add( "tool.prophr.reload", "Clear all PropHr constraints" )
	--
	 -- Fonts
	--
	surface.CreateFont( "healthText", {
		font 		= "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended 	= false,
		size 		= 19,
		weight 		= 600,
		blursize 	= 0,
		scanlines 	= 0,
		antialias 	= true,
		underline 	= false,
		italic 		= false,
		strikeout 	= false,
		symbol 		= false,
		rotary 		= false,
		shadow 		= false,
		additive 	= false,
		outline 	= true,
	})
end
--
 -- Funksjoner for diverse operasjoner
--
function prophr_print_out_relationships_in_console()
	if (
		GetConVar("prophr_print_out_relationships_in_console"):GetInt() == 1
	) then return true else return false end
end
function prophr_slett_entity(ent, id_)
	if (prophr_print_out_relationships_in_console()) then
		print("- -- - --- -")
		print("(PROP-hitbox:"..id_..")", "Deleted/removed   =>", ent)
		print("- -- - --- -")
	end
	ent:Remove()
end
function dup_prophr_SEM(Entity, Name, StaticData)
	if (GetConVar("prophr_hostiles_attacks"):GetInt() == 0) then
		duplicator.StoreEntityModifier(Entity, Name, {
			Entity 		= Entity,
			StaticData 	= StaticData
		}) --[[ Entity, (Duplicator-ID for Entity), Data ]]
	else
		for k, v in pairs(Entity:GetChildren()) do
			if (
				v:GetName() == "prophr_npc_ent"
			) then
				duplicator.StoreEntityModifier(Entity, Name, {
					Entity 		= v,
					StaticData 	= StaticData
				}) --[[ Entity, (Duplicator-ID for Entity), Data ]]
	
				return
			end
		end
	end
end
--
include('functions/prophr_func_setVarible.lua')
include('functions/prophr_func_logic_print_out.lua')
include('functions/prophr_func_logic_addentityrelationship.lua')
include('functions/prophr_func_lagreforreforhold.lua')
include('functions/prophr_func_single_connection.lua')
include('functions/prophr_func_addentityrelationship.lua')
include('functions/prophr_func_npcneutralrelationshippropfunc.lua')
include('functions/prophr_func_npcneutralrelationshipnpcfunc.lua')

include('functions/prophr_func_npcrelationshippropfunc.lua')
--
include('functions/prophr_func_createnpcforhittarget.lua')
--
 -- Hooks og duplikator-instillinger
--
--
if CLIENT then
	include('hooks/prophr_hook_hudpaint_healthbar.lua') -- On every frame
end
include('hooks/prophr_hook_physgunpickup.lua') 	-- Playerpickup with physgun
include('duplicator/prophr_dup_prop.lua') 		-- Register for duplication
include('duplicator/prophr_dup_npc.lua') 		-- For a normal NPC duplication
--
if SERVER then
	include('hooks/prophr_hook_entitytakedamage_prop_npc.lua') 	-- On entity taking damage
	include('hooks/prophr_hook_onentitycreated_prophr.lua') 	-- On new entity created
end
include('hooks/prophr_hook_onentityremoved.lua') 	-- On new entity removed
--
 -- Toolgun sine funksjoner
--
--
include('toolgun/prophr_toolgun_leftclick.lua') 	-- Apply settings to prop
include('toolgun/prophr_toolgun_rightclick.lua') 	-- Copy settings of prop with PropHr-property
include('toolgun/prophr_toolgun_reload.lua') 		-- Remove PropHr-property
