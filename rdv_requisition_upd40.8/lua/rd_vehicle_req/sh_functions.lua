--[[---------------------------------]]--
--  Granting a Vehicle
--[[---------------------------------]]--

function RDV.VEHICLE_REQ.CanGrant(ply, ship, hangar)
    local HANG = RDV.VEHICLE_REQ.SPAWNS[hangar]
    local VEH = RDV.VEHICLE_REQ.VEHICLES[ship]

    --[[
    --  Vehicles
    --]]

    local SUCCESS = hook.Run("RDV_VR_CanGrant", ply, ship, hangar)

    if (SUCCESS ~= nil) then
        return SUCCESS
    end

    local TEAMS = VEH.GTEAMS

    if not table.IsEmpty(TEAMS) then
        if not TEAMS[team.GetName(ply:Team())] then

            return false
        end
    end


    if VEH.CanGrant and VEH:CanGrant(ply) == false then
        return false
    end


    --[[
    --  Hangars
    --]]

    local TEAMS = HANG.GTEAMS

    if not table.IsEmpty(TEAMS) then

        if not TEAMS[team.GetName(ply:Team())] then

            return false
        end
    end

    if HANG.CanGrant and HANG:CanGrant(ply) == false then

        return false
    end

    return true
end

--[[---------------------------------]]--
--  Requesting a Vehicle
--[[---------------------------------]]--

function RDV.VEHICLE_REQ.CanRequest(ply, ship, hangar)
    local HANG = RDV.VEHICLE_REQ.SPAWNS[hangar]
    local VEH = RDV.VEHICLE_REQ.VEHICLES[ship]

    --[[
    --  Vehicles
    --]]
    
    local SUCCESS = hook.Run("RDV_VR_CanRequest", ply, ship, hangar)

    if (SUCCESS ~= nil) then
        return SUCCESS
    end

    local TEAMS = VEH.TEAMS

    if not table.IsEmpty(TEAMS) then
        if not TEAMS[team.GetName(ply:Team())] then
            return false
        end
    end

    if VEH.CanRequest and VEH:CanRequest(ply) == false then
        return false
    end

    --[[
    --  Hangars
    --]]

    if VEH.SPAWNS and not table.IsEmpty(VEH.SPAWNS) then
        if not VEH.SPAWNS[HANG.NAME] then
            return false
        end
    end

    local TEAMS = HANG.TEAMS

    if not table.IsEmpty(TEAMS) then
        if not TEAMS[team.GetName(ply:Team())] then
            return false
        end
    end
    
    if HANG.CanRequest and HANG:CanRequest(ply) == false then
        return false
    end

    if VEH.PRICE then
        if not RDV.LIBRARY.CanAfford(ply, nil, VEH.PRICE) then
            return false
        end
    end
        
    return true
end

--[[---------------------------------]]--
--  Checking if a Hangar is clear.
--[[---------------------------------]]--

function RDV.VEHICLE_REQ.IsHangarInUse(hangar)
    local LOC = RDV.VEHICLE_REQ.SPAWNS[hangar]

    if !LOC then 
        return 
    end

    local FOUND = false

    for k, v in ipairs(ents.GetAll()) do
        if v:GetPos():DistToSqr(LOC.Position) <= (RDV.VEHICLE_REQ.CFG.Size ^ 2) then
            if v:IsVehicle() or v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
                FOUND = true
            end
        end
    end

    return FOUND
end

--[[---------------------------------]]--
--  Notification
--[[---------------------------------]]--

local COL_1 = Color(255,255,255)

function RDV.VEHICLE_REQ.SendNotification(PLAYER, MSG)
    local PREFIX = RDV.VEHICLE_REQ.CFG.Prefix.Appension
    local COL = RDV.VEHICLE_REQ.CFG.Prefix.Color

    RDV.LIBRARY.AddText(PLAYER, COL, "["..PREFIX.."] ", COL_1, MSG)
end