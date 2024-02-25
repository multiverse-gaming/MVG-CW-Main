AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/cire992/props/barrel.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS ) 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
    self:SetUseType( SIMPLE_USE )
	self:SetHealth(self.BaseHealth)
	--[[timer.Create("Spawncountdown", 300, 1, function()
		self.VirusGas = ents.Create("env_smoketrail")
		self.VirusGas:SetPos(self:GetPos())
		self.VirusGas:SetKeyValue("spawnradius","256")
		self.VirusGas:SetKeyValue("minspeed","0.5")
		self.VirusGas:SetKeyValue("maxspeed","2")
		self.VirusGas:SetKeyValue("startsize","16536")
		self.VirusGas:SetKeyValue("endsize","256")
		self.VirusGas:SetKeyValue("endcolor","034 139 034")
		self.VirusGas:SetKeyValue("startcolor","034 139 034")
		self.VirusGas:SetKeyValue("opacity","0.75")
		self.VirusGas:SetKeyValue("spawnrate","20")
		self.VirusGas:SetKeyValue("lifetime","6")
		self.VirusGas:SetParent(self)
		self.VirusGas:Spawn()
		self.VirusGas:Activate()
		self.VirusGas:Fire("turnon", "", 0.1)
		
		local exp = ents.Create("env_explosion")
		exp:SetKeyValue("spawnflags", 461)
		exp:SetPos(self:GetPos())
		exp:Spawn()
		exp:Fire("explode", "", 0)
		self:EmitSound(Sound("BaseSmokeEffect.Sound"))

		timer.Simple(30, function()
			if IsValid(self) then
				self.VirusGas:Remove()
				self:Remove()
				prop=ents.Create("prop_physics")
				prop:SetModel("models/cire992/props/barrel.mdl")
				prop:SetPos( self:GetPos() )
				prop:Spawn()
			end
		end)
	end)]]--
end

function ENT:Use( activator, caller )
    if (self:GetNWBool("canuse") == true) then
        self:SetNWBool("canuse", false)
    if (activator:HasWeapon("defuse_kit")) then
    canuse = false;
	self:EmitSound(Sound("bomben/countdown.wav"))
    timer.Create("Countdown", 20, 1, function()
		timer.Remove("Spawncountdown")
		util.BlastDamage(self, activator, self:GetPos(), 900, 800)
		self.VirusGas = ents.Create("env_smoketrail")
		self.VirusGas:SetPos(self:GetPos())
		self.VirusGas:SetKeyValue("spawnradius","256")
		self.VirusGas:SetKeyValue("minspeed","0.5")
		self.VirusGas:SetKeyValue("maxspeed","2")
		self.VirusGas:SetKeyValue("startsize","16536")
		self.VirusGas:SetKeyValue("endsize","256")
		self.VirusGas:SetKeyValue("endcolor","034 139 034")
		self.VirusGas:SetKeyValue("startcolor","034 139 034")
		self.VirusGas:SetKeyValue("opacity","0.75")
		self.VirusGas:SetKeyValue("spawnrate","20")
		self.VirusGas:SetKeyValue("lifetime","6")
		self.VirusGas:SetParent(self)
		self.VirusGas:Spawn()
		self.VirusGas:Activate()
		self.VirusGas:Fire("turnon", "", 0.1)
		
		local exp = ents.Create("env_explosion")
		exp:SetKeyValue("spawnflags", 461)
		exp:SetPos(self:GetPos())
		exp:Spawn()
		exp:Fire("explode", "", 0)
		self:EmitSound(Sound("BaseSmokeEffect.Sound"))

		timer.Simple(30, function()
			if IsValid(self) then
				self.VirusGas:Remove()
				self:Remove()
				prop=ents.Create("prop_physics")
				prop:SetModel("models/cire992/props/barrel.mdl")
				prop:SetPos( self:GetPos() )
				prop:Spawn()
			end
		end)
    end)
	umsg.Start( "DrawTheMenuMKIIB", activator )
    umsg.Short( "1" )
    umsg.End()
    util.AddNetworkString( "Damage" )
    util.AddNetworkString( "Print" )
    net.Receive("Damage", function()
		timer.Remove("Countdown")
		timer.Remove("Spawncountdown")
		self:StopSound( "bomben/countdown.wav" )
		self.VirusGas = ents.Create("env_smoketrail")
		self.VirusGas:SetPos(self:GetPos())
		self.VirusGas:SetKeyValue("spawnradius","256")
		self.VirusGas:SetKeyValue("minspeed","0.5")
		self.VirusGas:SetKeyValue("maxspeed","2")
		self.VirusGas:SetKeyValue("startsize","16536")
		self.VirusGas:SetKeyValue("endsize","256")
		self.VirusGas:SetKeyValue("endcolor","034 139 034")
		self.VirusGas:SetKeyValue("startcolor","034 139 034")
		self.VirusGas:SetKeyValue("opacity","0.75")
		self.VirusGas:SetKeyValue("spawnrate","20")
		self.VirusGas:SetKeyValue("lifetime","6")
		self.VirusGas:SetParent(self)
		self.VirusGas:Spawn()
		self.VirusGas:Activate()
		self.VirusGas:Fire("turnon", "", 0.1)
			
		local exp = ents.Create("env_explosion")
		exp:SetKeyValue("spawnflags", 461)
		exp:SetPos(self:GetPos())
		exp:Spawn()
		exp:Fire("explode", "", 0)
		self:EmitSound(Sound("BaseSmokeEffect.Sound"))
		timer.Simple(30, function()
			if IsValid(self) then
				self.VirusGas:Remove()
				self:Remove()
				prop=ents.Create("prop_physics")
				prop:SetModel("models/cire992/props/barrel.mdl")
				prop:SetPos( self:GetPos() )
				prop:Spawn()
			end
		end)
   end)
    net.Receive("Print", function()
    activator:PrintMessage(HUD_PRINTTALK, "The bomb has been defused!")
	self:EmitSound(Sound("bomben/richtig.wav"))
    self:Remove()
	prop=ents.Create("prop_physics")
	prop:SetModel("models/cire992/props/barrel.mdl")
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
	
	if !IsValid(self.VirusGas) then return end

	for k, ply in pairs(player.GetAll()) do
		if self:GetPos():Distance(ply:GetPos()) <= 256 then
			ply:TakeDamage(5, self:GetOwner(), self)

			if !ply.IsCoughing then
				ply:EmitSound("ambient/voices/cough"..(math.random(1,4))..".wav", 70)
				ply.IsCoughing = true

				timer.Simple(3, function()
					if IsValid(ply) then
						ply.IsCoughing = false
					end
				end)
			end
		end
	end
	
	
end

function ENT:OnRemove()
	timer.Remove("Countdown")
	timer.Remove("Spawncountdown")
	self:StopSound( "bomben/countdown.wav" )
	
end

function ENT:OnTakeDamage( damage )
	self:SetHealth(self:Health() - damage:GetDamage())
	if (self:Health() <= 0) then
		self.VirusGas = ents.Create("env_smoketrail")
		self.VirusGas:SetPos(self:GetPos())
		self.VirusGas:SetKeyValue("spawnradius","256")
		self.VirusGas:SetKeyValue("minspeed","0.5")
		self.VirusGas:SetKeyValue("maxspeed","2")
		self.VirusGas:SetKeyValue("startsize","16536")
		self.VirusGas:SetKeyValue("endsize","256")
		self.VirusGas:SetKeyValue("endcolor","034 139 034")
		self.VirusGas:SetKeyValue("startcolor","034 139 034")
		self.VirusGas:SetKeyValue("opacity","0.75")
		self.VirusGas:SetKeyValue("spawnrate","20")
		self.VirusGas:SetKeyValue("lifetime","6")
		self.VirusGas:SetParent(self)
		self.VirusGas:Spawn()
		self.VirusGas:Activate()
		self.VirusGas:Fire("turnon", "", 0.1)
		
		local exp = ents.Create("env_explosion")
		exp:SetKeyValue("spawnflags", 461)
		exp:SetPos(self:GetPos())
		exp:Spawn()
		exp:Fire("explode", "", 0)
		self:EmitSound(Sound("BaseSmokeEffect.Sound"))

		timer.Simple(30, function()
			if IsValid(self) then
				self.VirusGas:Remove()
				self:Remove()
				prop=ents.Create("prop_physics")
				prop:SetModel("models/cire992/props/barrel.mdl")
				prop:SetPos( self:GetPos() )
				prop:Spawn()
			end
		end)
	end
end