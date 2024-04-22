AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/cire992/liq/n7_mi_air_vent.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetSolid(SOLID_VPHYSICS)

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
    if IsValid(activator) and activator:IsPlayer() then
        if self.TimerValue then
            local remainingTime = math.floor(self.TimerValue / 60)
            local seconds = self.TimerValue % 60
            activator:ChatPrint("Remaining time on vent timer: " .. remainingTime .. " minutes and " .. seconds .. " seconds")
        else
            activator:ChatPrint("Vent timer is not active.")
        end
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end