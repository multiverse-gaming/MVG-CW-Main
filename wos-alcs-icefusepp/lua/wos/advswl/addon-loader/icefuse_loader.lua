
--Icefuse LODA

if SERVER then
	AddCSLuaFile( "wos/advswl/icefuse/wos_blink_extension.lua" )
	AddCSLuaFile( "wos/advswl/icefuse/cl_core.lua" )
	include( "wos/advswl/icefuse/sv_core.lua" )
else
	include( "wos/advswl/icefuse/cl_core.lua" )
	include( "wos/advswl/icefuse/wos_blink_extension.lua" )
end