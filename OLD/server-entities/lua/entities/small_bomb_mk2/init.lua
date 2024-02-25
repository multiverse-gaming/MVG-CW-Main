AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/slicing/slicing_footlocker_screen.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    self:SetUseType( SIMPLE_USE )
	self:SetHealth(self.BaseHealth)
	timer.Create("Spawncountdown", 300, 1, function()
	local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:SetKeyValue( "spawnflags", 144 )
		explode:SetKeyValue( "iMagnitude", "200" )
		explode:SetKeyValue( "iRadiusOverride", 500 )
		explode:Fire( "Explode", "0", 0 )
		explode:EmitSound( "weapon_AWP.Single", 400, 400 )
		self:Remove()
	end)
end

function ENT:Use( activator, caller )
    if (self:GetNWBool("canuse") == true) then
        self:SetNWBool("canuse", false)
    if (activator:HasWeapon("defuse_kit")) then
        canuse = false
	self:EmitSound(Sound("bomben/countdown.wav"))
    timer.Create("Countdown", 20, 1, function()
    util.BlastDamage(self, activator, self:GetPos(), 500, 200)
    local explode = ents.Create( "env_explosion" ) 
    explode:SetPos( self:GetPos() )
    explode:Spawn()
    explode:SetKeyValue( "spawnflags", 144 )
    explode:SetKeyValue( "iMagnitude", "200" )
    explode:SetKeyValue( "iRadiusOverride", 500 )
    explode:Fire( "Explode", "", 0 )
    explode:EmitSound( "weapon_AWP.Single", 400, 400 )
    self:Remove()
    end)
	umsg.Start( "DrawTheMenuMKIIS", activator )
    umsg.Short( "1" )
    umsg.End()
    util.AddNetworkString( "Damage" )
    util.AddNetworkString( "Print" )
    util.AddNetworkString( "Timer" )
    net.Receive("Damage", function()
local explode = ents.Create( "env_explosion" )
    explode:SetPos( self:GetPos() )
    explode:Spawn()
    explode:SetKeyValue( "spawnflags", 144 )
    explode:SetKeyValue( "iMagnitude", "200" ) 
    explode:SetKeyValue( "iRadiusOverride", 500 )
    explode:Fire( "Explode", "", 0 )
    explode:EmitSound( "weapon_AWP.Single", 400, 400 )
    self:Remove()
    timer.Stop("Countdown")
    end)
    net.Receive("Print", function()
    activator:PrintMessage( HUD_PRINTTALK,"The bomb has been defused!")
	self:EmitSound(Sound("bomben/richtig.wav"))
    self:Remove()
	prop=ents.Create("prop_physics")
	prop:SetModel("models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/slicing/slicing_footlocker_screen.mdl")
	prop:SetPos( self:GetPos() )
	prop:Spawn()
    end)
else
    activator:PrintMessage(HUD_PRINTTALK, "You have no tools!")
end
	if (activator:HasWeapon("weapon_datapad_bomben")) then
		umsg.Start("DrawTheDatapadMenu", activator)
		umsg.Short("1")
		umsg.End()
	end
end
end

function ENT:Think()
    if (self:GetNWBool("canuse") == false) then
        timer.Simple(0.1, function() self:SetNWBool("canuse", true) end)
    end
end

function ENT:OnRemove()
	timer.Remove("Countdown")
	self:StopSound( "bomben/countdown.wav" )
end

function ENT:OnTakeDamage( damage )
	self:SetHealth(self:Health() - damage:GetDamage())
	if (self:Health() <= 0) then
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:SetKeyValue( "spawnflags", 144 )
		explode:SetKeyValue( "iMagnitude", "200" )
		explode:SetKeyValue( "iRadiusOverride", 500 )
		explode:Fire( "Explode", "0", 0 )
		explode:EmitSound( "weapon_AWP.Single", 400, 400 )
		self:Remove()
	end
end