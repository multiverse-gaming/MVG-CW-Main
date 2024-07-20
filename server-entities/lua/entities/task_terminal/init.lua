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
    util.AddNetworkString("ClaimTerminal")
    util.AddNetworkString("UnclaimTerminal")
    util.AddNetworkString("ESPAdd")
    util.AddNetworkString("ESPRemove")

    -- List to keep track of all terminals and their statuses
    local terminalList = {}

    local function UpdateTerminalList()
        local terminals = {}
        for _, terminal in ipairs(terminalList) do
            if IsValid(terminal) then
                table.insert(terminals, {entity = terminal, broken = terminal.Broken, claimedBy = terminal.ClaimedBy})
            end
        end
        return terminals
    end

    function ENT:Initialize()
        self:SetModel("models/lordtrilobite/starwars/isd/imp_console_medium01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self.Broken = false
        self.Task = nil
        self.ClaimedBy = nil

        print("[TerminalSystem] Initialized terminal " .. self:EntIndex())

        table.insert(terminalList, self)

        timer.Create("BreakCheck_" .. self:EntIndex(), breakInterval, 0, function()
            if IsValid(self) and not self.Broken then
                if math.random() < breakChance then
                    self:Break()
                end
            end
        end)
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
            self.ClaimedBy = nil

            if self.Task then
                print("[TerminalSystem] Terminal " .. self:EntIndex() .. " assigned task: " .. self.Task)
            else
                print("[TerminalSystem] This terminal is broken, but no task is assigned.")
            end

            net.Start("SendTerminalStatus")
            net.WriteTable(UpdateTerminalList())
            net.Broadcast()
        end
    end

    function ENT:Repair()
        if self.Broken then
            self.Broken = false
            self.ClaimedBy = nil
            print("[TerminalSystem] Terminal " .. self:EntIndex() .. " repaired.")
            self.Task = nil

            timer.Simple(repairCooldown, function()
                if IsValid(self) then
                    self.Broken = false
                end
            end)

            net.Start("SendTerminalStatus")
            net.WriteTable(UpdateTerminalList())
            net.Broadcast()
        end
    end

    function ENT:OnRemove()
        timer.Remove("BreakCheck_" .. self:EntIndex())
        table.RemoveByValue(terminalList, self)

        net.Start("SendTerminalStatus")
        net.WriteTable(UpdateTerminalList())
        net.Broadcast()
    end

    net.Receive("RequestTerminalStatus", function(len, ply)
        net.Start("SendTerminalStatus")
        net.WriteTable(UpdateTerminalList())
        net.Send(ply)
    end)

    net.Receive("ClaimTerminal", function(len, ply)
        local ent = net.ReadEntity()
        if IsValid(ent) and ent.Broken and IsEngineer(ply) then
            ent.ClaimedBy = ply:Nick()
            net.Start("ESPAdd")
            net.WriteEntity(ent)
            net.Send(ply)
            net.Start("SendTerminalStatus")
            net.WriteTable(UpdateTerminalList())
            net.Broadcast()
        end
    end)

    net.Receive("UnclaimTerminal", function(len, ply)
        local ent = net.ReadEntity()
        if IsValid(ent) and ent.Broken and ent.ClaimedBy == ply:Nick() then
            ent.ClaimedBy = nil
            net.Start("ESPRemove")
            net.WriteEntity(ent)
            net.Send(ply)
            net.Start("SendTerminalStatus")
            net.WriteTable(UpdateTerminalList())
            net.Broadcast()
        end
    end)
end
