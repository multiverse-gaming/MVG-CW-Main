// Table Definitions
RepublicConquest = RepublicConquest or {}
RepublicConquest.Point = RepublicConquest.Point or {}
RepublicConquest.Entities = RepublicConquest.Entities or {}
RepublicConquest.Inside = RepublicConquest.Inside or {}

if SERVER then
    util.AddNetworkString("RepublicConquest_Menu")
    util.AddNetworkString("republic_conquest_fetch_timers_client")
    util.AddNetworkString("republic_conquest_fetch_timers")
end

local function Sync()
    // Data syncing with client for preview sphere!
    util.AddNetworkString("RepublicConquest_Sync")
    net.Start("RepublicConquest_Sync")
        net.WriteTable(RepublicConquest.Point)
        net.WriteTable(RepublicConquest.Inside)
    net.Broadcast()
end

local function SyncPlayer(ply)
    if SERVER then
        if RepublicConquest.Point == {} then return end
        util.AddNetworkString("RepublicConquest_SyncPly")
        net.Start("RepublicConquest_SyncPly")
            net.WriteTable(RepublicConquest.Point)
            net.WriteTable(RepublicConquest.Inside)
        net.Send(ply)
    end
end

local function FetchTimers(ply)
    // ==============================FETCHING TIME TABLES==============================
    if SERVER then
        if RepublicConquest.Point == {} then return end
        SyncPlayer(ply)
        local tbl = {}
        local tbl_npc = {}
        for k, v in pairs(RepublicConquest.Point) do
            // Fetch time left from all tables.
            local timeleft = timer.TimeLeft("republic_conquest_point_timer"..k)
            local timeleft_npc = timer.TimeLeft("republic_conquest_point_timer_npc"..k)
            tbl[k] = timeleft
            tbl_npc[k] = timeleft_npc
        end

        util.AddNetworkString("republic_conquest_fetch_timers")
        net.Start("republic_conquest_fetch_timers")
            net.WriteTable(tbl)
            net.WriteTable(tbl_npc)
            net.Send(ply)
    end
end

net.Receive("RepublicConquest_SyncPly", function(len, ply)
    RepublicConquest.Point = net.ReadTable()
    RepublicConquest.Inside = net.ReadTable()
end)


function RepublicConquest:AddPoint(pos, radius, square1, square2, user, time, icon, display)
    local index_count = table.Count(RepublicConquest.Point)
    local index_a = index_count + 1

    local ConquestPointTable = {}
    ConquestPointTable["Position"] = pos
    ConquestPointTable["Radius"] = radius
    ConquestPointTable["Square1"] = square1
    ConquestPointTable["Square2"] = square2
    ConquestPointTable["Time"] = time
    ConquestPointTable["Progress"] = "None"
    ConquestPointTable["Active"] = true
    ConquestPointTable["Icon"] = icon
    ConquestPointTable["Captured"] = "None"
    ConquestPointTable["Display"] = display

    table.insert( RepublicConquest.Point, index_a )
    RepublicConquest.Point[index_a] = ConquestPointTable

    table.insert( RepublicConquest.Inside, index_a )

    local temptable = {
        "Player",
        "NPC"
    }

    RepublicConquest.Inside[index_a] = temptable

    RepublicConquest.Inside[index_a]["NPC"] = {}
    RepublicConquest.Inside[index_a]["Player"] = {}

    -- if RepublicConquest.Inside ~= nil then
    --     user.playerinsideconquest = false
    --     table.Empty(RepublicConquest.Inside)
    --     timer.Remove("republic_conquest_point_timer")
    -- end
    
    if SERVER then
        Sync()

        net.Start("RepublicConquest_Menu")
        net.Broadcast()
    end
end

// ============================================================================== //
//                                                                                //
//                            Captured Control Point                              //
//                                                                                //
// ============================================================================== //
local function ConquestCaptured(winner)
    if SERVER then
        // Send a message to the client for capture
        util.AddNetworkString("RepublicConquest_Captured")
        net.Start("RepublicConquest_Captured")
            net.WriteTable(RepublicConquest.Point)
            net.Broadcast()
    end
end

// ============================================================================== //
//                                                                                //
//                  Checks if you have left the point or not.                     //
//                                                                                //
// ============================================================================== //

local function ConquestLeaveThink(activator, index)
    if not RepublicConquest:IsValid() then return end
    if RepublicConquest.Point[index] == nil then return end
    -- if isnumber(RepublicTriggersPos[newindex]) then return end

    // Finding the player..
    local targettable = RepublicConquest.Entities[index]
    
    if targettable == nil then return end
    // Found the player!
    for a, b in ipairs(targettable) do
        local target = b
        if target:IsPlayer() or target:IsNPC() then
            // If the player is inside the trigger, then return true.
            if target == activator then
                return true
            end
        end
    end
end

// ============================================================================== //
//                                                                                //
//                               You've left the point.                           //
//                                                                                //
// ============================================================================== //

local function ConquestLeft(target, index)
    if not RepublicConquest.Inside[index] then return end
    if isnumber(RepublicConquest.Inside[index]) then return end
    if not RepublicConquest.Point[index] then return end

    if IsValid(target) then
        target.playerinsideconquest[index] = false
    end

    // Remove 1 player from the inside table.
    if target:IsPlayer() then
        table.remove(RepublicConquest.Inside[index]["Player"], 1)
    end

    // Remove 1 NPC from the inside table.
    if target:IsNPC() then
        table.remove(RepublicConquest.Inside[index]["NPC"], 1)
    end

    if target:IsPlayer() then
        if timer.Exists("republic_conquest_point_timer"..index) then
            if RepublicConquest.Point[index]["Progress"] ~= "Contesting" then
                local playercount = table.Count(RepublicConquest.Inside[index]["Player"])
                local mult = 0.05
                local timeleft = timer.TimeLeft("republic_conquest_point_timer"..index)
                if timeleft < 0 then return end
                if playercount == 0 then return end
                if playercount > 10 then return end
                local newtime = timer.TimeLeft("republic_conquest_point_timer"..index) + (RepublicConquest.Point[index]["Time"] * mult)
                timer.Adjust("republic_conquest_point_timer"..index, newtime)
            end
        end
    end

    if target:IsNPC() then
        if timer.Exists("republic_conquest_point_timer_npc"..index) then
            if RepublicConquest.Point[index]["Progress"] ~= "Contesting" then
                local npccount = table.Count(RepublicConquest.Inside[index]["NPC"])
                local mult = 0.05
                local timeleft = timer.TimeLeft("republic_conquest_point_timer_npc"..index)
                if timeleft < 0 then return end
                if npccount == 0 then return end
                if npccount > 10 then return end
                local newtime = timeleft + (RepublicConquest.Point[index]["Time"] * mult)
                timer.Adjust("republic_conquest_point_timer_npc"..index, newtime)
            end
        end
    end
    -- // Debug: Entity name left index
    -- if IsValid(target) then
    --     print("Entity left: "..target:GetClass().." Index: "..index)
    -- end
end

// ============================================================================== //
//                                                                                //
//                              Removes a control point                           //
//                                                                                //
// ============================================================================== //

local counts = 0

function RepublicConquest:RemovePoint(index)
    if RepublicConquest.Point[index] == nil then return end
    local last = table.Count(RepublicConquest.Point)
    RepublicConquest.Point[index]["Active"] = false

    // Checks if you removed the last point.
    if last == index then
        for c, d in ipairs( ents.GetAll()) do
            if d:IsPlayer() or d:IsNPC() then
                table.remove(RepublicConquest.Point, index)
                table.remove(RepublicConquest.Entities, index)
                table.remove(RepublicConquest.Inside, index)
                timer.Remove("republic_conquest_refire"..d:EntIndex().."index"..index)
            end
        end
    end

    timer.Remove("republic_conquest_point_timer_npc"..index)
    timer.Remove("republic_conquest_point_timer"..index)
        
    // Removes the trigger refire timer from all players if they're inside a conquest while it's being removed.
    -- for k,v in pairs(player.GetHumans()) do
    --     timer.Remove("republic_conquest_refire"..v:EntIndex().."index"..index)
    --     v.playerinsideconquest[index] = false
    --     ConquestLeft(v, index)
    -- end

    for a, b in ipairs( ents.GetAll()) do
        if b:IsPlayer() or b:IsNPC() then
            timer.Remove("republic_conquest_refire"..b:EntIndex().."index"..index)
            if b.playerinsideconquest ~= nil then
                b.playerinsideconquest[index] = false
                ConquestLeft(b, index)
            end
        end
    end
    
    // Checks if you have removed every single point.
    for k, v in ipairs(RepublicConquest.Point) do
        if isnumber(RepublicConquest.Point[k]) then RepublicConquest:ClearAll() end
        if RepublicConquest.Point[k]["Active"] == true then
            counts = counts + 1
        end
    end

    // If you have removed every conquest, reset tables, so we can get fresh indexes.
    if counts == 0 then
        RepublicConquest:ClearAll()
    end

    // Reset counter.
    counts = 0

    // Sync conquest tables with client.
    if SERVER then
        Sync()

        net.Start("RepublicConquest_Menu")
        net.Broadcast()
    end
end

function RepublicConquest:ClearAll()
    index = 1

    for k,v in ipairs( ents.GetAll()) do
        if v:IsPlayer() or v:IsNPC() then
            v.playerinsideconquest = {}

            for a, b in ipairs(RepublicConquest.Point) do
                timer.Remove("republic_conquest_refire"..v:EntIndex().."index"..a)
                timer.Remove("republic_conquest_point_timer_npc"..a)
                timer.Remove("republic_conquest_point_timer"..a)

                ConquestLeft(v, a)
            end
        end
    end

    table.Empty(RepublicConquest.Point)
    table.Empty(RepublicConquest.Inside)
    table.Empty(RepublicConquest.Entities)
    
    // Data syncing with client for preview sphere!
    if SERVER then
        Sync()

        net.Start("RepublicConquest_Menu")
        net.Broadcast()
    end 
end

function RepublicConquest:IsValid()
    if RepublicConquest.Point[1] == {} then
        return false
    end

    return true
end

net.Receive("RQ_SyncConquestRemoval", function()
    local temp = net.ReadUInt(16)
    RepublicConquest:RemovePoint(temp)

    util.AddNetworkString("RQ_SyncConquestRemoval_CL")
    net.Start("RQ_SyncConquestRemoval_CL")
        net.WriteUInt(temp, 16)
    net.Broadcast()
end)

net.Receive("RQ_SyncConquestRemoval_CL", function()
    local temp = net.ReadUInt(16)
    RepublicConquest:RemovePoint(temp)
end)

if SERVER then
    util.AddNetworkString("RepublicConquest_SyncServerRemovalAll")
    net.Receive("RepublicConquest_SyncServerRemovalAll", function()
        RepublicConquest:ClearAll()
    end)
end


// ============================================================================== //
//                                                                                //
//                               You've entered the point.                        //
//                                                                                //
// ============================================================================== //

local function ConquestAddNPC(target, index)  
    // Check if they're inside already! Team: NPCs!
    if target.playerinsideconquest[index] == false and target:IsNPC() then
        // Effects begin here!
        table.insert(RepublicConquest.Inside[index]["NPC"], "NPC")
        target.playerinsideconquest[index] = true
        // Timer is never activated before..
        if not timer.Exists("republic_conquest_point_timer_npc"..index) and not timer.Exists("republic_conquest_point_timer"..index) then
            if CLIENT then
                FetchTimers(LocalPlayer())
            else
                Sync()
            end
            // If the point is not owned by an NPC, start the timer.
            if RepublicConquest.Point[index]["Captured"] ~= "NPC" then
                timer.Create("republic_conquest_point_timer_npc"..index, RepublicConquest.Point[index]["Time"], 1, function()
                    timer.Remove("republic_conquest_point_timer_npc"..index)
                    RepublicConquest.Point[index]["Captured"] = "NPC"
                    ConquestCaptured(1)
                end)
                timer.Create("republic_conquest_point_timer"..index, RepublicConquest.Point[index]["Time"], 1, function()
                    timer.Remove("republic_conquest_point_timer"..index)
                    RepublicConquest.Point[index]["Captured"] = "Player"
                    ConquestCaptured(2)
                end)
            end
        else
            // If the point is not being contested, then we can come in to increase capture rate!
            if RepublicConquest.Point[index]["Progress"] ~= "Contesting" then
                // Timer is active, so we increase capture rate.
                if timer.Exists("republic_conquest_point_timer_npc"..index) then
                    local npccount = table.Count(RepublicConquest.Inside[index]["NPC"])
                    local mult = 0.05
                    local timeleft = timer.TimeLeft("republic_conquest_point_timer_npc"..index)
                    if timeleft < 0 then return end
                    if npccount < 2 then return end
                    if npccount > 10 then return end
                    local multtime = RepublicConquest.Point[index]["Time"] * mult
                    local time = timeleft - multtime
                    timer.Adjust("republic_conquest_point_timer_npc"..index, time)
                end
            end
        end
    end
    // Check if you've left.
    timer.Create("republic_conquest_refire_npc"..target:EntIndex().."index"..index, 0.5, 1, function()
        local result = ConquestLeaveThink(target, index)
        if result == nil then
            timer.Remove("republic_conquest_refire_npc"..target:EntIndex().."index"..index)
            if not RepublicConquest.Point[index] then return end
            ConquestLeft(target, index)
        end
    end)
end

local function ConquestAddPlayer(target, index)
    // Check if they're inside already! Team: Players!
    if target.playerinsideconquest[index] == false and target:IsPlayer() then
        // Effects begin here!
        table.insert(RepublicConquest.Inside[index]["Player"], "Player")
        target.playerinsideconquest[index] = true
        
        SyncPlayer(target)
        // Timer is never activated before..
        if not timer.Exists("republic_conquest_point_timer_npc"..index) and not timer.Exists("republic_conquest_point_timer"..index) then
            if CLIENT then
                FetchTimers(target)
            end
            // If the point is not owned by a player, then start the timer.
            if RepublicConquest.Point[index]["Captured"] ~= "Player" then
                timer.Create("republic_conquest_point_timer"..index, RepublicConquest.Point[index]["Time"], 1, function()
                    timer.Remove("republic_conquest_point_timer"..index)
                    RepublicConquest.Point[index]["Captured"] = "Player"
                    ConquestCaptured(2)
                end)
                timer.Create("republic_conquest_point_timer_npc"..index, RepublicConquest.Point[index]["Time"], 1, function()
                    timer.Remove("republic_conquest_point_timer_npc"..index)
                    RepublicConquest.Point[index]["Captured"] = "NPC"
                    ConquestCaptured(1)
                end)
            end
        else
            if timer.Exists("republic_conquest_point_timer"..index) then
                // If the point is not being contested, then we can come in to increase capture rate!
                if RepublicConquest.Point[index]["Progress"] ~= "Contesting" then
                    // Timer is active, so we increase capture rate.
                    local playercount = table.Count(RepublicConquest.Inside[index]["Player"])
                    local mult = 0.05
                    local timeleft = timer.TimeLeft("republic_conquest_point_timer"..index)
                    if timeleft < 0 then return end
                    if playercount < 2 then return end
                    if playercount > 10 then return end
                    local multtime = RepublicConquest.Point[index]["Time"] * mult
                    local time = timeleft - multtime
                    timer.Adjust("republic_conquest_point_timer"..index, time)
                end
            end
        end
    end

    // Check if you've left.
    timer.Create("republic_conquest_refire_"..target:EntIndex().."index"..index, 0.5, 1, function()
        local result = ConquestLeaveThink(target, index)
        if result == true then
            -- timer.Remove("republic_conquest_refire_"..target:EntIndex().."index"..index)
            -- ConquestLeft(target, index)
        end

        if result == nil then
            timer.Remove("republic_conquest_refire_"..target:EntIndex().."index"..index)
            ConquestLeft(target, index)
        end
    end)
end

// ============================================================================== //
//                                                                                //
//           Checks every tick if a player is inside a control point.             //
//                                                                                //
// ============================================================================== //

local function ConquestThink()
    if not RepublicConquest:IsValid() then return end

    // Timer Functions!
    for k, v in pairs(RepublicConquest.Point) do
        local index = k

        // Lua Error avoidance hack
        if isnumber(RepublicConquest.Point[index]) then return end
        if RepublicConquest.Point == nil then return end
        if RepublicConquest.Inside[index] == nil then return end
        

        ///////////////// BIG BOY GAME RULES!! ////////////////////////

        // If Progress is set to NPC or Player, their respective timers will resume!
        if not table.IsEmpty(RepublicConquest.Inside[index]) and RepublicConquest.Point[index]["Progress"] == "Player" then
            timer.Pause("republic_conquest_point_timer_npc"..index)
            timer.UnPause("republic_conquest_point_timer"..index)
        end

        if not table.IsEmpty(RepublicConquest.Inside[index]) and RepublicConquest.Point[index]["Progress"] == "NPC" then
            timer.Pause("republic_conquest_point_timer"..index)
            timer.UnPause("republic_conquest_point_timer_npc"..index)
        end

        // If an each side captured the point, then the timer will be removed.
        if RepublicConquest.Point[index]["Captured"] == "NPC" then
            timer.Remove("republic_conquest_point_timer_npc"..index)
        end

        if RepublicConquest.Point[index]["Captured"] == "Player" then
            timer.Remove("republic_conquest_point_timer"..index)
        end

        // If there is a player inside the point, and is not contested, the progress is player.
        if not table.IsEmpty(RepublicConquest.Inside[index]["Player"]) and RepublicConquest.Point[index]["Progress"] ~= "Contesting" then
            RepublicConquest.Point[index]["Progress"] = "Player"
        end

        // If there is a NPC inside the point, and is not contested, the progress is NPC.
        if not table.IsEmpty(RepublicConquest.Inside[index]["NPC"]) and RepublicConquest.Point[index]["Progress"] ~= "Contesting" then
            RepublicConquest.Point[index]["Progress"] = "NPC"
        end

        // If the point is completely empty, timer will stop.
        if table.IsEmpty(RepublicConquest.Inside[index]) then
            timer.Remove("republic_conquest_point_timer"..index)
            timer.Remove("republic_conquest_point_timer_npc"..index)
        end

        // If Progress is set to Contesting or None, both timers will pause!
        if RepublicConquest.Point[index]["Progress"] == "Contesting" or RepublicConquest.Point[index]["Progress"] == "None" then
            local msg1 = RepublicConquest.Point[index]["Progress"]
            timer.Pause("republic_conquest_point_timer"..index)
            timer.Pause("republic_conquest_point_timer_npc"..index)
        end

        // If the point has an NPC on it but not contested and is not owned by NPC, it the progress is NPC.
        if not table.IsEmpty(RepublicConquest.Inside[index]["NPC"]) and RepublicConquest.Point[index]["Progress"] ~= "Contesting" and RepublicConquest.Point[index]["Captured"] ~= "NPC" then
            RepublicConquest.Point[index]["Progress"] = "NPC"
        end

        // If the point has a player on it but not contested, it the progress is Player.
        if not table.IsEmpty(RepublicConquest.Inside[index]["Player"]) and RepublicConquest.Point[index]["Progress"] ~= "Contesting" and RepublicConquest.Point[index]["Captured"] ~= "Player" then
            RepublicConquest.Point[index]["Progress"] = "Player"
        end

        // If no one is on the point, and it is not owned by anyone, progress is none.
        if table.IsEmpty(RepublicConquest.Inside[index]) and RepublicConquest.Point[index]["Captured"] == "None" then
            RepublicConquest.Point[index]["Progress"] = "None"
        end

        // If there is both NPC and Players on the point, then it is contested.
        if not table.IsEmpty(RepublicConquest.Inside[index]["NPC"]) and not table.IsEmpty(RepublicConquest.Inside[index]["Player"]) then
            RepublicConquest.Point[index]["Progress"] = "Contesting"
        end

        // Recount the players inside the point.
        local playercount = table.Count(RepublicConquest.Inside[index]["Player"])

        // Recount the NPCs inside the point.
        local npcscount = table.Count(RepublicConquest.Inside[index]["NPC"])

        // If they're contesting..
        if RepublicConquest.Point[index]["Progress"] == "Contesting" then
            // If the NPC count is 0, then set the progress to player.
            if npcscount == 0 then
                RepublicConquest.Point[index]["Progress"] = "Player"
            end

            // If the player count is 0, then set the progress to NPC.
            if playercount == 0 then
                RepublicConquest.Point[index]["Progress"] = "NPC"
            end
        end

        // If the player count is 0 and the NPC count is 0, then set the progress to None.
        if playercount == 0 and npcscount == 0 then
            RepublicConquest.Point[index]["Progress"] = "None"
        end

        /////////////////////////////
        
        // Finding all entities inside the point.
        RepublicConquest.Entities[index] = ents.FindInSphere(RepublicConquest.Point[index]["Position"], RepublicConquest.Point[index]["Radius"])

        // Still finding that entity..
        local targettable = RepublicConquest.Entities[index]
        // A player has entered a trigger, and the game has found them!
        for a, b in ipairs(targettable) do
            local target = b
            // Checks if it is a player here, so we can access player tables.
            if target:IsPlayer() or target:IsNPC() then
                // If the player is dead, you can't capture it.
                if target:IsPlayer() and target:Alive() == false then
                    continue
                end
                // Leave Check
                local result = ConquestLeaveThink(target, index)
                // Player is inside the trigger
                if result == true then
                    // Checks if the player tables are nil, if they are, fix it up.
                    if target.playerinsideconquest == nil then
                        target.playerinsideconquest = {}
                    end

                    if target.playerinsideconquest[index] == nil then
                        target.playerinsideconquest[index] = false
                    end

                    if target:IsNPC() then
                        // Consistently check if the NPC is actually inside or not..
                        ConquestAddNPC(target, index)
                    else
                        ConquestAddPlayer(target, index)
                    end
                end
            end
        end  
    end
end

// Runs every frame to check if we're in a trigger.
hook.Add("Think", "RepublicConquest_Thinker", function()
    ConquestThink()
end)

// Runs when you spawn.
hook.Add("PlayerLoadout", "RQ_FirstSpawnTrigger", function(ply)
    ply.playerinsideconquest = {}
    SyncPlayer(ply)
end)

hook.Add("InitPostEntity", "RQ_FetchPointTimers", function(ply)
    // Client makes a request to the server to fetch the timers.
    if CLIENT then
        net.Start("republic_conquest_fetch_timers_client")
        net.SendToServer()
    end
end)

// Server receives client's request.
net.Receive("republic_conquest_fetch_timers_client", function(len, ply)
    if RepublicConquest.Point == {} then return end
    FetchTimers(ply)
end)

net.Receive("republic_conquest_fetch_timers", function(len, ply)
    // Get the table from the server.
    local tbl = net.ReadTable()
    local tbl_npc = net.ReadTable()
    // Loop through the player table and set the timers.
    for a, b in pairs(tbl) do
        // Do not set the timer if it is nil.
        if b ~= nil then
            if b < 0 then b = b * -1 end
            timer.Create("republic_conquest_point_timer"..a, b, 1, function()
                timer.Remove("republic_conquest_point_timer"..a)
                RepublicConquest.Point[b]["Captured"] = "Player"
                ConquestCaptured(2)
            end)
        end
    end

    for k, v in pairs(tbl_npc) do
        if v ~= nil then
            if v < 0 then v = v * -1 end
            timer.Create("republic_conquest_point_timer_npc"..k, v, 1, function()
                timer.Remove("republic_conquest_point_timer_npc"..k)
                RepublicConquest.Point[k]["Captured"] = "NPC"
                ConquestCaptured(1)
            end)
        end
    end
end)