AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

include("eps_claimboard/config.lua")

function ENT:Initialize()
    self:SetModel("models/lt_c/holo_wall_unit.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetBodygroup(1, 1)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if self:GetClaimBoardClaimer() == activator or not self:GetClaimBoardClaimed() then
        net.Start("OpenClaimPanel")
            net.WriteEntity(self)
        net.Send(activator)
    else
        net.Start("EPS_ClaimBoard_Inspect")
            net.WriteEntity(self)
        net.Send(activator)
    end
end