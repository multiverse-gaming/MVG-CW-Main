AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/cire992/liq/n7_mi_air_vent.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetSolid(SOLID_VPHYSICS)
        self.Entity:SetNWInt( "venthealth", 500 )

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end
    end
end

function ENT:SetTimer(value)
    self:SetNWInt("VentTimer", math.Clamp(value, 0, MAX_TIMER))
end

function ENT:GetTimer()
    return self:GetNWInt("VentTimer", 0)
end

function ENT:IncrementTimer()
    self:SetTimer(self:GetTimer() + TIMER_INCREMENT)
end

function ENT:Use(activator, caller)
    local HealthonE = self.Entity:GetNWInt( "venthealth", 500 )
	self.Entity:EmitSound("ambient/energy/spark1.wav")
	if HealthonE < 1 then
		HealthonE = 0
	end

    if activator:IsPlayer() then
        if self.TimerValue then
            local remainingTime = math.floor(self.TimerValue / 60)
            local seconds = self.TimerValue % 60
            activator:PrintMessage(HUD_PRINTTALK, "Remaining time on vent timer: " .. remainingTime .. " minutes and " .. seconds .. " seconds")
        else
            activator:PrintMessage(HUD_PRINTTALK, "Vent timer is not active.")
        end
        
        if HealthonE == 0 then
            activator:PrintMessage(HUD_PRINTTALK, "[Vent] Broken, needs repairing!")
        else
            activator:PrintMessage(HUD_PRINTTALK, "[Vent] Energy level: " ..HealthonE.."%" )
        end
    end
end

function ENT:OnTakeDamage(dmginfo)
	local Health = self.Entity:GetNWInt( "venthealth", 500 )
	local TakeDamageInfo = dmginfo
	local damage = TakeDamageInfo:GetDamage()
	local Loss = Health - damage
	if Health > 1 then
		print(Health)
		self.Entity:SetNWInt( "venthealth", Loss )
		self.Entity:EmitSound("ambient/energy/spark1.wav")
	else
		if not self.Entity:IsOnFire() then
			self.Entity:Ignite( 500, 100 )
			if WaitTillAllowedToPlayAgain == false then
				for k, v in pairs( player.GetAll() ) do
					v:PrintMessage( HUD_PRINTTALK, "[AI] The vent was destroyed!" )
				end
			end
			if SERVER and not WaitTillAllowedToPlayAgain then
				WaitTillAllowedToPlayAgain = true
				timer.Simple(5, function() WaitTillAllowedToPlayAgain = false end)
			end
            self.TimerValue = 0
		end
	end




	self.Entity:TakePhysicsDamage(dmginfo)
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end