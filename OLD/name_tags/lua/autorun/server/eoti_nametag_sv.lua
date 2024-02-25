resource.AddFile("resource/fonts/OFL/Anton.ttf")
resource.AddFile("resource/fonts/OFL/Khand-Semibold.ttf")
resource.AddFile("resource/fonts/OFL/MetalMania-Regular.ttf")
resource.AddFile("resource/fonts/OFL/Montserrat-Bold.ttf")
resource.AddFile("resource/fonts/OFL/Montserrat-Regular.ttf")
resource.AddFile("resource/fonts/OFL/Orbitron-Bold.ttf")
resource.AddFile("resource/fonts/OFL/Oswald-Regular.ttf")
resource.AddFile("resource/fonts/Apache/Roboto-Bold.ttf")


EOTI_NameTag = EOTI_NameTag or {}
EOTI_NameTag.Draw = EOTI_NameTag.Draw or {}
EOTI_NameTag.Color = EOTI_NameTag.Color or {}
EOTI_NameTag.Target = EOTI_NameTag.Target or {}
EOTI_HPBar = EOTI_HPBar or {}

AddCSLuaFile( "autorun/client/eoti_nametag_cl.lua" )
AddCSLuaFile( "eoti_nametag_config.lua" )
include("eoti_nametag_config.lua")
AddCSLuaFile( "hud/"..EOTI_NameTag.Motif )
