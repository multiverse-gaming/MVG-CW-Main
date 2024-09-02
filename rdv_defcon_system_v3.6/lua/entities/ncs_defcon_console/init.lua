AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local function SendNotification(ply, msg)
    local CFG = NCS_DEFCON.CONFIG
	local PC = CFG.prefixcolor
	local PT = CFG.prefixtext

    NCS_DEFCON.AddText(ply, PC, "["..PT.."] ", color_white, msg)
end

function ENT:Initialize()
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetModel(NCS_DEFCON.CONFIG.consolemodel)
    
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(P)
    local FOUND = false

    NCS_DEFCON.IsStaff(P, function(checkPassed)
        if !checkPassed then
            for k, v in pairs(NCS_DEFCON.CONFIG.defconList) do
                if v.teams and v.teams[team.GetName(P:Team())] or v.allteams then
                    FOUND = true
                    break
                end
            end

            if !FOUND then SendNotification(P, NCS_DEFCON.GetLang(nil, "DEF_noAccessConsole")) return end
        
            net.Start("RD_DEFCON_MENU")
            net.Send(P)
        else
            net.Start("RD_DEFCON_MENU")
            net.Send(P)
        end
    end )
end