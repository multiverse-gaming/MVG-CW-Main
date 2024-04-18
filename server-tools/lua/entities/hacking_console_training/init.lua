AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')

util.AddNetworkString("openhackingmenu3")
util.AddNetworkString("normalchoice")
util.AddNetworkString("remotechoice")
util.AddNetworkString("playerdead")
function ENT:Initialize()
 
	self:SetModel( "models/lordtrilobite/starwars/isd/imp_console_medium02.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    self:SetVar("usedd", false)
    self:SetVar("isdonee", false)
    self:SetUseType( SIMPLE_USE )
    net.Receive("dowloaddata", function()
        PrintMessage(HUD_PRINTTALK, "[Database] Data Succesfully Dowloaded")
        self:SetVar("usedd", false)
        self:SetVar("isdonee", true)
    end)
end
 
function ENT:Use( activator, caller )
    if (activator:GetNWBool("isableto")) then
        net.Start("openhackingmenu3")
        net.WriteBool( true )
        net.Send(activator)
        CheckAlivestuff(activator)
        self:SetVar("usedd", false)
    else
        activator:PrintMessage(HUD_PRINTTALK, "You Dont have hacking tools")
    end
end