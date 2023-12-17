AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize()


	if sirensquadnumber == nil then
	sirensquadnumber = 1
	end

	if sirensquadnumber == 31 then
	sirensquadnumber = 1
	end

	local sirensquadnameslist = ("Alpha Beta Gamma Delta Epsilon Zeta Eta Theta Iota Kappa Lambda Mu Nu Xi Omicron Pi Rho Sigma Tau Upsilon Phi Chi Psi Omega Digamma Stigma San Qoppa Sampi Sho")

	local sirensquadnames = string.Explode(" ", sirensquadnameslist )

	self.Entity:SetNetworkedString( 97, "" .. sirensquadnames[sirensquadnumber] .. "" )

	sirensquadnumber = sirensquadnumber + 1


	for var=1, 15, 1 do
	util.PrecacheSound("ambient/levels/prison/radio_random" .. var .. ".wav")
	end

	util.PrecacheSound("buttons/lever4.wav")
	util.PrecacheSound("buttons/lever5.wav")

	self.Entity:SetModel("models/maxofs2d/motion_sensor.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then	
	phys:Wake()
	end

	self.Useable = 1
	self.Activated = 0

end

function ENT:SpawnFunction( ply, tr )

if ( !tr.Hit ) then return end

local SpawnPos = tr.HitPos + tr.HitNormal * 16
local ent = ents.Create( "dark_deeds" )
ent:SetPos( SpawnPos )
ent:Spawn()
ent:Activate()
return ent

end

function ENT:EnableUse()
self.Useable = 1
end

function ENT:Use( activator, caller )

if self.Activated == 0 && self.Useable == 1 then
timer.Simple(0.42, function() self:Havok() end)
self.Entity:EmitSound( "buttons/lever4.wav", 62, 100 )
timer.Simple(0.32, function() self:EnableUse() end)
self.Activated = 1
self.Useable = 0
return end

if self.Activated == 1 && self.Useable == 1 then
timer.Simple(0.42, function() self:EndHavok() end)
self.Entity:EmitSound( "buttons/lever5.wav", 72, 100 )
timer.Simple(0.32, function() self:EnableUse() end)
self.Activated = 0
self.Useable = 0
return end

end

function ENT:Think()
if self.Activated == 1 then
end
end

function ENT:Havok()

local squad = self:GetNetworkedString( 97 )

self.Entity:EmitSound("Oogway/dark_deeds.mp3",600)

for k,ply in pairs(player.GetAll()) do
ply:ChatPrint( "Dark Deeds activated")
end

end

function ENT:EndHavok()

local squad = self:GetNetworkedString( 97 )

self.Entity:StopSound("Oogway/dark_deeds.mp3")

for k,ply in pairs(player.GetAll()) do
ply:ChatPrint( "Dark Deeds deactivated")
ply:SendLua([[RunConsoleCommand("stopsound")]])
end

end

function ENT:OnRemove()

local squad = self:GetNetworkedString( 97 )

self.Entity:StopSound("Oogway/dark_deeds.mp3")

for k,ply in pairs(player.GetAll()) do
ply:ChatPrint( "Dark Deeds removed")
ply:SendLua([[RunConsoleCommand("stopsound")]])
end

end