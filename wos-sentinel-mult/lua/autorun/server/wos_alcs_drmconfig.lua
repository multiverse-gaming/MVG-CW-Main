--[[-------------------------------------------------------------------]]--[[
							  
	Copyright wiltOS Technologies LLC, 2020
	
	Contact: www.wiltostech.com
		
----------------------------------------]]--


/*
	Please supply your Token and License if you are having
	any issues with the addon!
*/
local Token = "01d3b84e7c7f174"
local License = "wOS-56d60b67503d3f0"

----------------------------------------------------------------
local RegistryInt = -1;
 
require( "wos_crypt" )

wOS = wOS or {}
wOS.ALCS = wOS.ALCS or {}

local reset = GetConVar( "sv_hibernate_think" ):GetString()

local function GetDirectoryPath()
	local results = debug.getinfo( wOS.ALCS.Initialize, "S" )
	if not results then return end
	local path = results.source
	if not path then return end
	local pos = string.find( path, "/autorun", 2 )
	return string.sub( path, 2, pos )
end

function wOS.ALCS:Initialize()
	local path = GetDirectoryPath()
	if not path then return end
	print( "[wOS-ALCS] Successfully found addon path!", path )
	RegistryInt = cwyptOS.SetDirectory( path, reset )
end

function wOS.ALCS:ServerInclude( filepath )
	if RegistryInt < 0 then return end
	cwyptOS.include( filepath, RegistryInt )
end

hook.Add( "wOS.ALCS.OnLoaded", "wOS.ALCS.LoadServerside", function()
	timer.Create( "wOS.ALCS.Loader", 0.3, 0, function()
		if not cwyptOS.IsReady() then return end
		timer.Destroy( "wOS.ALCS.Loader" )
		if RegistryInt < 0 then return end
		cwyptOS.Initialize( Token, License, RegistryInt ) 
		hook.Call( "wOS.ALCS.PostLoaded" )
	end )
end )

wOS.ALCS:Initialize()

AddCSLuaFile( "wos/advswl/loader/loader.lua" ) 
include( "wos/advswl/loader/loader.lua" )