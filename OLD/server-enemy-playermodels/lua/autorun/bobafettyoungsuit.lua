player_manager.AddValidModel( "CGI Young Boba", "models/player/valley/BobaFettYoungSuit.mdl" )

local Category = "CGI Young Boba"

local NPC =
{
	Name = "Young Boba Friendly",
	Class = "npc_citizen",
	KeyValues =
	{
		citizentype = 4
	},
	Model = "models/player/valley/npc/BobaFettYoungSuitNPC.mdl",
	Health = "1000",
	Category = "CGI Young Boba"
}

list.Set( "NPC", "npc_valley_youngbobaf", NPC )

local Category = "CGI Young Boba"

local NPC =
{
	Name = "Young Boba Enemy",
	Class = "npc_combine_s",
	Model = "models/player/valley/npc/BobaFettYoungSuitNPC.mdl",
	Health = "1000",
	Category = "CGI Young Boba"
}

list.Set( "NPC", "npc_valley_youngbobae", NPC )

if SERVER then
	resource.AddWorkshop("884888084")
end