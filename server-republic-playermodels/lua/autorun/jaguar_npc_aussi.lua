local NPC = {
	Name = "Jaguar Soldier (Hostile) [275hp]",
	Class = "npc_combine_s",
	Category = "[GG] Jaguar NPCs",
	Model = "models/aussiwozzi/cgi/base/jaguar_trooper_npc.mdl",
	Health = "275",
	Weapons = { "rw_swnpc_random_rep" },
        KeyValues = { SquadName = "rebels", Numgrenades = 3, }
}

list.Set( "NPC", "npc_jaguarsoldier", NPC )


local NPC = {
	Name = "Jaguar Soldier (Friendly) [275hp]",
	Class = "npc_citizen",
	Category = "[GG] Jaguar NPCs",
	Model = "models/aussiwozzi/cgi/base/jaguar_trooper_npc.mdl",
	Health = "275",
	Weapons = { "rw_swnpc_random_rep" },
        KeyValues = { SquadName = "senate", Numgrenades = 3, }
}

list.Set( "NPC", "npc_jaguarsoldier_fr", NPC )


local NPC = {
	Name = "Senate Commando (Hostile) [275hp]",
	Class = "npc_combine_s",
	Category = "[GG] Senate Commando NPCs",
	Model = "models/aussiwozzi/cgi/base/senate_trp_npc.mdl",
	Health = "275",
	Weapons = { "rw_swnpc_dc15s", "rw_swnpc_dc15a" },
        KeyValues = { SquadName = "rebels", Numgrenades = 3, }
}

list.Set( "NPC", "npc_senatecomhostile", NPC )


local NPC = {
	Name = "Senate Commando (Friendly) [275hp]",
	Class = "npc_citizen",
	Category = "[GG] Senate Commando NPCs",
	Model = "models/aussiwozzi/cgi/base/senate_trp_npc.mdl",
	Health = "275",
	Weapons = { "rw_swnpc_dc15s", "rw_swnpc_dc15a" },
        KeyValues = { SquadName = "senate", Numgrenades = 3, }
}

list.Set( "NPC", "npc_senatecomfriendly", NPC )


local NPC = {
	Name = "Clone Trooper (Friendly) [275hp]",
	Class = "npc_citizen",
	Category = "[GG] Star Wars NPCs",
	Model = "models/aussiwozzi/cgi/base/trooper_npc.mdl",
	Health = "275",
	Weapons = { "rw_swnpc_dc15s", "rw_swnpc_dc15a" },
        KeyValues = { SquadName = "senate", Numgrenades = 3, }
}

list.Set( "NPC", "npc_clonefriendly", NPC )


local NPC = {
	Name = "Clone Trooper (Hostile) [275hp]",
	Class = "npc_combine_s",
	Category = "[GG] Star Wars NPCs",
	Model = "models/aussiwozzi/cgi/base/trooper_npc.mdl",
	Health = "275",
	Weapons = { "rw_swnpc_dc15s", "rw_swnpc_dc15a" },
        KeyValues = { SquadName = "rebels", Numgrenades = 3, }
}

list.Set( "NPC", "npc_clonehostile", NPC )


local NPC = {
	Name = "Jaguar Heavy (Hostile) [475hp]",
	Class = "npc_combine_s",
	Category = "[GG] Jaguar NPCs",
	Model = "models/aussiwozzi/cgi/base/jaguar_trooper_npc.mdl",
	Health = "475",
	Weapons = { "rw_swnpc_dp23", "rw_swnpc_dc15a" },
        KeyValues = { SquadName = "rebels", Numgrenades = 3, }
}

list.Set( "NPC", "npc_jaguarheavy", NPC )


local NPC = {
	Name = "Jaguar Heavy (Friendly) [475hp]",
	Class = "npc_citizen",
	Category = "[GG] Jaguar NPCs",
	Model = "models/aussiwozzi/cgi/base/jaguar_trooper_npc.mdl",
	Health = "475",
	Weapons = { "rw_swnpc_dp23", "rw_swnpc_dc15a" },
        KeyValues = { SquadName = "senate", Numgrenades = 3, }
}

list.Set( "NPC", "npc_jaguarheavy_fr", NPC )


local NPC = {
	Name = "Jaguar Marksman (Hostile) [375hp]",
	Class = "npc_combine_s",
	Category = "[GG] Jaguar NPCs",
	Model = "models/aussiwozzi/cgi/base/jaguar_arf_npc.mdl",
	Health = "375",
	Weapons = { "rw_swnpc_dc15a", "rw_swnpc_valkenx38" },
        KeyValues = { SquadName = "rebels", Numgrenades = 3, }
}


list.Set( "NPC", "npc_jaguararf", NPC )

local NPC = {
	Name = "Jaguar Marksman (Friendly) [375hp]",
	Class = "npc_citizen",
	Category = "[GG] Jaguar NPCs",
	Model = "models/aussiwozzi/cgi/base/jaguar_arf_npc.mdl",
	Health = "375",
	Weapons = { "rw_swnpc_dc15a", "rw_swnpc_valkenx38" },
        KeyValues = { SquadName = "senate", Numgrenades = 3, }
}

list.Set( "NPC", "npc_jaguararf_fr", NPC )
