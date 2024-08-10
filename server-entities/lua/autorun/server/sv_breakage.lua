util.AddNetworkString("TerminalTask")
util.AddNetworkString("UpdateEngineerCount")

include("sv_tasks.lua")

local terminals = {}
local baseChance = 500 -- Base chance in percent

local engineerTeams = {
    TEAM_CEGENERAL,
    TEAM_CEMCOMMANDER,
    TEAM_CECOMMANDER,
    TEAM_CEEXECUTIVEOFFICER,
    TEAM_CECHIEF,
    TEAM_CELIEUTENANT,
    TEAM_CEMECHANIC,
    TEAM_CEFAB,
    TEAM_ARCALPHACE,
    TEAM_CEARC,
    TEAM_CEMEDOFFICER,
    TEAM_CESPECIALIST,
    TEAM_CEMEDTROOPER,
    TEAM_CETROOPER
}

local terminalCooldown = {}
local lastBreakTime = CurTime()

local function RegisterTerminals()
    terminals = ents.FindByClass("task_terminal")
    print("[TerminalSystem] Registered " .. #terminals .. " terminals.")
end

hook.Add("OnEntityCreated", "RegisterTerminalsOnEntityCreated", function(ent)
    if ent:GetClass() == "task_terminal" then
        timer.Simple(0.1, function()
            RegisterTerminals()
        end)
    end
end)

hook.Add("InitPostEntity", "RegisterTerminalsInitPostEntity", function()
    if #terminals == 0 then
        RegisterTerminals()
    end
end)

local function tableContains(table, element)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

local function IsEngineer(ply)
    return IsValid(ply) and tableContains(engineerTeams, ply:Team())
end

local function CanBreakTerminal(terminal)
    if not IsValid(terminal) or terminal.Broken then
        return false
    end

    local lastRepairTime = terminal.lastRepairTime or 0
    local currentTime = CurTime()
    local cooldownDuration = 30

    if currentTime - lastRepairTime >= cooldownDuration then
        return true
    else
        return false
    end
end

local function GetEngineerCount()
    local count = 0
    for _, ply in ipairs(player.GetAll()) do
        if IsEngineer(ply) then
            count = count + 1
        end
    end
    return count
end

local function ShouldBreakTerminal(engineerCount)
    local breakChance = baseChance + (engineerCount * 5) -- Increase chance by 5% per engineer
    return math.random(0, 100) < breakChance
end

hook.Add("Think", "RandomTerminalBreakage", function()
    if CurTime() - lastBreakTime >= 30 then -- Check every 30 seconds
        lastBreakTime = CurTime()

        local engineerCount = GetEngineerCount()
        if engineerCount > 0 and #terminals > 0 then
            if ShouldBreakTerminal(engineerCount) then
                local terminal = table.Random(terminals)
                if CanBreakTerminal(terminal) then
                    if terminal.Break then
                        terminal:Break()
                        terminal.lastRepairTime = CurTime()
                    else
                        print("[TerminalSystem] Error: Terminal does not have a Break method.")
                    end
                end
            end
        else
            -- print("[TerminalSystem] No terminals registered or no engineers online.")
        end
    end
end)

net.Receive("CompleteTask", function(len, ply)
    local terminal = net.ReadEntity()
    if IsValid(terminal) and terminal.Broken then
        terminal:Repair()
        terminal.lastRepairTime = CurTime()
        ply:ChatPrint("You have successfully completed the task and repaired the terminal.")
    end
end)

hook.Add("PlayerUse", "TerminalInteraction", function(ply, ent)
    if ent:IsValid() and ent:GetClass() == "task_terminal" and IsEngineer(ply) then
        net.Start("TerminalTask")
        net.WriteEntity(ent)
        net.Send(ply)
    end
end)
