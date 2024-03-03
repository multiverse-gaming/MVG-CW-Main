player_manager.AddValidModel("TFA-SW-Trandoshan-Bounty-Hunter-V1-Skin1","models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v1.mdl")
player_manager.AddValidModel("TFA-SW-Trandoshan-Bounty-Hunter-V2-Skin1","models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v2.mdl")
player_manager.AddValidModel("TFA-SW-Trandoshan-Bounty-Hunter-V1-Skin2","models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v1_skin2.mdl")
player_manager.AddValidModel("TFA-SW-Trandoshan-Bounty-Hunter-V2-Skin2","models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v2_skin2.mdl")

local NPC = {
	Name = "Trandoshan 1 (Friendly) [200hp]",
	Class = "npc_citizen",
	Category = "CGI Trandoshan NPC/Playermodels",
	Model = "models/tfa/comm/gg/npc_cit_sw_trandoshan_bounty_hunter_v1.mdl",
	Health = "200",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_sw_tbh_v1s1f", NPC )

local NPC = {
	Name = "Trandoshan 2 (Friendly) [200hp]",
	Class = "npc_citizen",
	Category = "CGI Trandoshan NPC/Playermodels",
	Model = "models/tfa/comm/gg/npc_cit_sw_trandoshan_bounty_hunter_v1_skin2.mdl",
	Health = "200",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_sw_tbh_v1s2f", NPC )
local NPC = {
	Name = "Trandoshan 3 (Friendly)",
	Class = "npc_citizen",
	Category = "CGI Trandoshan NPC/Playermodels",
	Model = "models/tfa/comm/gg/npc_cit_sw_trandoshan_bounty_hunter_v2.mdl",
	Health = "200",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_sw_tbh_v2s1f", NPC )

local NPC = {
	Name = "Trandoshan 4 (Friendly) [200hp]",
	Class = "npc_citizen",
	Category = "CGI Trandoshan NPC/Playermodels",
	Model = "models/tfa/comm/gg/npc_cit_sw_trandoshan_bounty_hunter_v2_skin2.mdl",
	Health = "200",
	KeyValues = { citizentype = CT_UNIQUE }
}
list.Set( "NPC", "npc_sw_tbh_v2s2f", NPC )





local NPC = {
	Name = "Trandoshan 1 (Hostile) [200hp]",
	Class = "npc_combine_s",
	Category = "CGI Trandoshan NPC/Playermodels",
	Health = "200",
	Model = "models/tfa/comm/gg/npc_comb_sw_trandoshan_bounty_hunter_v1.mdl"
}
list.Set( "NPC", "npc_sw_tbh_v1s1h", NPC )

local NPC = {
	Name = "Trandoshan 2 (Hostile) [200hp]",
	Class = "npc_combine_s",
	Category = "CGI Trandoshan NPC/Playermodels",
	Health = "200",
	Model = "models/tfa/comm/gg/npc_comb_sw_trandoshan_bounty_hunter_v1_skin2.mdl"
}
list.Set( "NPC", "npc_sw_tbh_v1s2h", NPC )
local NPC = {
	Name = "Trandoshan 3 (Hostile) [200hp]",
	Class = "npc_combine_s",
	Category = "CGI Trandoshan NPC/Playermodels",
	Health = "200",
	Model = "models/tfa/comm/gg/npc_comb_sw_trandoshan_bounty_hunter_v2.mdl"
}
list.Set( "NPC", "npc_sw_tbh_v2s1h", NPC )

local NPC = {
	Name = "Trandoshan 4 (Hostile) [200hp]",
	Class = "npc_combine_s",
	Category = "CGI Trandoshan NPC/Playermodels",
	Health = "200",
	Model = "models/tfa/comm/gg/npc_comb_sw_trandoshan_bounty_hunter_v2_skin2.mdl"
}
list.Set( "NPC", "npc_sw_tbh_v2s2h", NPC )