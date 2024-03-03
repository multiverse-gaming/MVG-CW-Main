list.Set( "PlayerOptionsModel", "Icefuse Networks Umbaran General", "models/player/icefusenetworks/ifnumbarangeneral.mdl"  )
player_manager.AddValidModel( "Icefuse Networks Umbaran General", "models/player/icefusenetworks/ifnumbarangeneral.mdl"  )

list.Set( "PlayerOptionsModel", "Icefuse Networks Umbaran Soldier", "models/player/icefusenetworks/ifnumbaran.mdl"  )
player_manager.AddValidModel( "Icefuse Networks Umbaran Soldier", "models/player/icefusenetworks/ifnumbaran.mdl"  )


local NPC = { Name = "Umbaran Friendly General", 
Class = "npc_citizen", 
Model = "models/player/icefusenetworks/gnpcifnumbarangeneral.mdl", 
Health = "100", 
KeyValues = { citizentype = 4 }, 
Category = "Icefuse Networks Umbarans" } 

list.Set( "NPC", "npc_gumbarangeneral", NPC )

local NPC = { Name = "Hostile Umbaran General", 
Class = "npc_combine_s", 
Model = "models/player/icefusenetworks/bnpcifnumbarangeneral.mdl", 
Squadname = "umbaranunit", 
Numgrenades = "5", 
Category = "Icefuse Networks Umbarans" } 

list.Set( "NPC", "npc_bnpcumbarangeneral", NPC )

local NPC = { Name = "Umbaran Friendly Soldier", 
Class = "npc_citizen", 
Model = "models/player/icefusenetworks/gnpcifnumbaran.mdl", 
Health = "100", 
KeyValues = { citizentype = 4 }, 
Category = "Icefuse Networks Umbarans" } 

list.Set( "NPC", "npc_gumbaran", NPC )

local NPC = { Name = "Hostile Umbaran Soldier", 
Class = "npc_combine_s", 
Model = "models/player/icefusenetworks/bnpcifnumbaran.mdl", 
Squadname = "umbaranunit", 
Numgrenades = "5", 
Category = "Icefuse Networks Umbarans" } 

list.Set( "NPC", "npc_bumbaran", NPC )



