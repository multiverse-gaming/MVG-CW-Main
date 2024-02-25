hook.Add("PlayerReadyForNetworking", "PLAYER_RETRIEVE_OLD_REQS", function(ply)
    local TAB = RDV.VEHICLE_REQ.SActive
    local COUNT = #TAB

    net.Start("RDV.VEHICLE_REQ.INITIAL")
        net.WriteUInt(COUNT, 8)

        for i = 1, COUNT do
            local REQUESTER = TAB[i].Requester
            local ENTITY = Entity(REQUESTER)

            if !IsValid(ENTITY) then
                continue
            end

            if ( ENTITY == ply ) and !RDV.VEHICLE_REQ.CFG.SGrant then
                continue
            end

            local SHIP = TAB[i].Ship
            local HANGAR = TAB[i].Hangar

            if RDV.VEHICLE_REQ.CanGrant(ply, SHIP, HANGAR) then
                net.WriteUInt(TAB[i].Ship, 8)
                net.WriteUInt(TAB[i].Hangar, 8)
                net.WriteUInt(TAB[i].Requester, 8)
                net.WriteUInt(TAB[i].TIME, 8)
            end
        end
    net.Send(ply)
end)

local DELAY = CurTime()

hook.Add("Tick", "RDV.VehicleRequisition.CheckRequests", function()
    if DELAY > CurTime() then
        return
    end
    
    for k, v in ipairs(RDV.VEHICLE_REQ.SActive) do
        if not v.TIME then
            continue
        end

        local ENT_IND = v.Requester
        local PLAYER = Entity(ENT_IND)
        
        if not IsValid(PLAYER) then
            continue
        end

        if v.TIME <= 0 then
            RDV.VEHICLE_REQ.ACTIVE[ENT_IND] = nil
            RDV.VEHICLE_REQ.SActive[k] = nil

            net.Start("RDV.VEHICLE_REQ.CLEAR")
                net.WriteUInt(k, 8)
            net.Broadcast()

            local LRequestClosed = RDV.LIBRARY.GetLang(nil, "VR_requestAutoClosed", {
                (RDV.VEHICLE_REQ.CFG.Waiting or 60),
            })

            RDV.VEHICLE_REQ.SendNotification(PLAYER, LRequestClosed)
            continue
        end

        RDV.VEHICLE_REQ.SActive[k].TIME = RDV.VEHICLE_REQ.SActive[k].TIME - 1
    end

    DELAY = CurTime() + 1
end)

hook.Add("PlayerDisconnected", "RDV.VehicleRequisition.ClearDisconnected", function(ply)
    local ENT_IND = ply:EntIndex()
    local TAB = RDV.VEHICLE_REQ.ACTIVE[ENT_IND]

    if IsValid(ply.CurrentRequestedVehicle) then
        ply.CurrentRequestedVehicle:Remove()
    end
    
    if TAB then
        local SEQ = TAB.SEQUENTIAL

        net.Start("RDV.VEHICLE_REQ.CLEAR")
            net.WriteUInt(ENT_IND, 8)
        net.Broadcast()

        RDV.VEHICLE_REQ.ACTIVE[ENT_IND] = nil

        if SEQ then
            table.remove(RDV.VEHICLE_REQ.SActive, SEQ)
        end

        local PREFIX = RDV.VEHICLE_REQ.CFG.Prefix.Appension

        local LRequestClosed = RDV.LIBRARY.GetLang(nil, "VR_trashedRequest", {
            ply:Name(),
        })

        print("["..PREFIX.."] "..LRequestClosed)
    end
end)