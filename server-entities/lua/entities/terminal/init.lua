AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("sv_tasks.lua")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Task Terminal"
ENT.Author = "Tomery"
ENT.Category = "Custom Engineering Entities"
ENT.Spawnable = true
ENT.AdminSpawnable = true

local tasks = {
    "Fix Wiring",
    "Prime Shields",
    "Swipe Card",
    "Clean Filter"
}

local breakChance = 0.1
local breakInterval = 180 -- Break interval in seconds (adjust as needed)
local repairCooldown = 30 -- Cooldown period after repair in seconds (adjust as needed)

if SERVER then
    util.AddNetworkString("TerminalTask")
    util.AddNetworkString("UpdateEngineerCount")
    util.AddNetworkString("RequestTerminalStatus")
    util.AddNetworkString("SendTerminalStatus")

    function ENT:Initialize()

        self:SetModel("models/lordtrilobite/starwars/isd/imp_console_medium01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self.Broken = false
        self.Task = nil

        timer.Create("BreakCheck_" .. self:EntIndex(), breakInterval, 0, function()
            if IsValid(self) and not self.Broken then
                if math.random() < breakChance then
                    self:Break()
                end
            end
        end)
    end
end

function ENT:Use(activator, caller)
    if not IsEngineer(activator) then
        activator:ChatPrint("Only engineers can interact with this terminal.")
        return
    end

    if self.Broken then
        if self.Task then
            print("[TerminalTask] Terminal " .. self:EntIndex() .. " requires: " .. self.Task)
            net.Start("TerminalTask")
            net.WriteEntity(self)
            net.WriteString(self.Task)
            net.Send(activator)
        else
            activator:ChatPrint("This terminal is broken, but no task is assigned.")
        end
    else
        activator:ChatPrint("This terminal is functioning properly.")
    end
end

    function ENT:Break()
        if not self.Broken then
            self.Broken = true
            self.Task = table.Random(tasks)

            if self.Task then
                print("[TerminalSystem] Terminal " .. self:EntIndex() .. " assigned task: " .. self.Task)
            else
                print("[TerminalSystem] This terminal is broken, but no task is assigned.")
            end

        end
    end
end

   function ENT:Repair()
        if self.Broken then
            self.Broken = false
            print("[TerminalSystem] Terminal " .. self:EntIndex() .. " repaired.")
            self.Task = nil

            timer.Simple(repairCooldown, function()
                if IsValid(self) then
                    self.Broken = false
                end
            end)
        end
    end

    function ENT:OnRemove()
        timer.Remove("BreakCheck_" .. self:EntIndex())
    end

end
