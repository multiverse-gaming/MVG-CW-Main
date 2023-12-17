local NPC = {
	Name = "zygerrian Guard (Friendly)",
	Class = "npc_citizen",
	Category = "CGI Zygerrian Slavers",
	Model = "models/player/zygerrian/zygerrian_soldier.mdl",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_zygerrian_guard_f", NPC )


local NPC = {
	Name = "zygerrian Guard (Hostile)",
	Class = "npc_combine_s",
	Category = "CGI Zygerrian Slavers",
	Model = "models/player/zygerrian/zygerrian_soldier.mdl",
}
list.Set( "NPC", "npc_zygerrian_guard_h", NPC )
