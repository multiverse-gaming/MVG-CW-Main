if SERVER then
	include("eps_claimboard/config.lua")
	AddCSLuaFile("eps_claimboard/config.lua")

	include("eps_claimboard/server/sv_functions.lua")
	include("eps_claimboard/server/sv_main.lua")
	include("eps_claimboard/server/sv_net.lua")

	AddCSLuaFile("eps_claimboard/client/cl_functions.lua")
	AddCSLuaFile("eps_claimboard/client/cl_main.lua")
	AddCSLuaFile("eps_claimboard/client/cl_net.lua")
else
	include("eps_claimboard/config.lua")

	--include("eps_claimboard/client/cl_functions.lua")
	include("eps_claimboard/client/cl_main.lua")
	include("eps_claimboard/client/cl_net.lua")
end
