--[[-------------------------------------------------------------------]]--[[
							  
	Copyright wiltOS Technologies LLC, 2019
	
	Contact: www.wiltostech.com
		
----------------------------------------]]--

wOS = wOS or {}
wOS.Lightsaber = wOS.Lightsaber or {}

local string = string
local file = file

if SERVER then	
	
	AddCSLuaFile( "wos/advswl/dark-ascension-files/core/cl_core.lua" )
	
else
	include( "wos/advswl/dark-ascension-files/core/cl_core.lua" )
	
end