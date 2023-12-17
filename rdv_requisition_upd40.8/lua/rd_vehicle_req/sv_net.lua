util.AddNetworkString("RDV.VEHICLE_REQ.GRANT")
util.AddNetworkString("RDV.VEHICLE_REQ.CLEAR")
util.AddNetworkString("RDV.VEHICLE_REQ.DENY")
util.AddNetworkString("RDV.VEHICLE_REQ.MENU")
util.AddNetworkString("RDV.VEHICLE_REQ.START")
util.AddNetworkString("RDV.VEHICLE_REQ.ASK")
util.AddNetworkString("RDV.VEHICLE_REQ.RETURN")
util.AddNetworkString("RDV.VEHICLE_REQ.INITIAL")

RDV.VEHICLE_REQ.ACTIVE = {}

local vehCount = 0
local vehTable = {}

--[[---------------------------------]]--
--  Requsition Request Received
--[[---------------------------------]]--

hook.Add("EntityRemoved", "RDV.REQUISITION.REMOVED", function(ent)
    if vehTable[ent] then
        vehTable[ent] = nil
        vehCount = (vehCount - 1)
    end
end )

local function SpawnVehicle(ply, SHIP, HANGAR_TAB, VEHICLE_TAB)
    if IsValid(ply.CurrentRequestedVehicle) then
        ply.CurrentRequestedVehicle:Remove()
    end

    local TAB = RDV.VEHICLE_REQ.ACTIVE[ply:EntIndex()]
    
    local VAL = hook.Run("RDV_VR_PreVehicleSpawned", ply, TAB)

    if (VAL == false) then
        return
    end

    if RDV.VEHICLE_REQ.CFG.MaxVehicles and ( ( vehCount + 1 ) > RDV.VEHICLE_REQ.CFG.MaxVehicles ) then
        local LtooManyVehicles = RDV.LIBRARY.GetLang(nil, "VR_tooManyVehicles")

        RDV.VEHICLE_REQ.SendNotification(ply, LtooManyVehicles)
        return
    end

    local veh

    if simfphys and list.Get( "simfphys_vehicles" )[VEHICLE_TAB.CLASS] then
        veh = simfphys.SpawnVehicleSimple( VEHICLE_TAB.CLASS, HANGAR_TAB.Position, HANGAR_TAB.Angles )
    else
        veh = ents.Create(VEHICLE_TAB.CLASS)
        veh:SetPos(HANGAR_TAB.Position)
        veh:Spawn()
        veh:SetAngles(HANGAR_TAB.Angles)
        veh:SetSkin(TAB.SKIN)
    end

    vehTable[veh] = true
    vehCount = vehCount + 1

    ::skipsim::

    if !IsValid(veh) then return end

    if veh.CPPISetOwner then
        veh:CPPISetOwner(ply)
    end

    local BGS = VEHICLE_TAB.BODYGROUPS

    if istable(BGS) then
        for k, v in pairs(BGS) do
            veh:SetBodygroup(k, v)
        end
    end

    ply.CurrentRequestedVehicle = veh

    hook.Run("RDV_VR_VehicleSpawned", ply, veh, TAB)
end

local function AutoGrant(ply, SHIP, HANGAR_TAB, VEHICLE_TAB)
    local ACTIVE = RDV.VEHICLE_REQ.ACTIVE[ply:EntIndex()]
    local SEQ = ACTIVE.SEQUENTIAL

    if VEHICLE_TAB.PRICE then
        local canAfford = RDV.LIBRARY.CanAfford(ply, nil, VEHICLE_TAB.PRICE)

        if ( !canAfford ) then
            local LcannotAfford = RDV.LIBRARY.GetLang(nil, "VR_cannotAfford")

            RDV.VEHICLE_REQ.SendNotification(ply, LcannotAfford)

            RDV.VEHICLE_REQ.ACTIVE[ply:EntIndex()] = nil

            if SEQ then
                table.remove(RDV.VEHICLE_REQ.SActive, SEQ)
            end

            return false
        end

        RDV.LIBRARY.AddMoney(ply, nil, -VEHICLE_TAB.PRICE)
    end
    
    SpawnVehicle(ply, SHIP, HANGAR_TAB, VEHICLE_TAB)

    local LautoGranted = RDV.LIBRARY.GetLang(nil, "VR_autoGranted")

    RDV.VEHICLE_REQ.SendNotification(ply, LautoGranted)

    ply:EPS_PlaySound("reality_development/ui/ui_accept.ogg")

    -- Remove

    RDV.VEHICLE_REQ.ACTIVE[ply:EntIndex()] = nil

    if SEQ then
        table.remove(RDV.VEHICLE_REQ.SActive, SEQ)
    end
end

net.Receive("RDV.VEHICLE_REQ.START", function(len, ply)
    local SHIP = net.ReadUInt(8)
    local HANGAR = net.ReadUInt(8)

    local H_TAB = RDV.VEHICLE_REQ.SPAWNS[HANGAR]
    local V_TAB = RDV.VEHICLE_REQ.VEHICLES[SHIP]

    if H_TAB and V_TAB then
        if RDV.VEHICLE_REQ.CFG.MaxVehicles and ( ( vehCount + 1 ) > RDV.VEHICLE_REQ.CFG.MaxVehicles ) then
            local LtooManyVehicles = RDV.LIBRARY.GetLang(nil, "VR_tooManyVehicles")

            RDV.VEHICLE_REQ.SendNotification(ply, LtooManyVehicles)
            return
        end

        --
        --  Handle Map Check
        --

        if H_TAB.MAP ~= game.GetMap() then
            return
        end

        --
        --  Handle Distance Check
        --

        local POS = H_TAB.Position

        if RDV.VEHICLE_REQ.CFG.Distance then
            local DISTANCE = (string.Explode(".", POS:Distance(ply:GetPos()) / 52.49))[1]

            if tonumber(DISTANCE) >= (RDV.VEHICLE_REQ.CFG.Distance or 500) then
                return
            end
        end

        --
        --  Handle Blacklists
        --
        if !V_TAB.WL_EMPTY and !V_TAB.SPAWNS[H_TAB.NAME] then return end


        if !V_TAB.BL_EMPTY and V_TAB.BLACKLIST[H_TAB.NAME] then return end
        
        --
        --  Handle Skins
        --

        local SKIN = 0

        if V_TAB.CUSTOMIZABLE then
            SKIN = net.ReadUInt(8)
    
            if !SKIN then
                SKIN = ( V_TAB.SKIN or 0 )
            end
        elseif V_TAB.SKIN then
            SKIN = V_TAB.SKIN
        end 
        
        --
        --  Handle Active Requests
        --

        if RDV.VEHICLE_REQ.ACTIVE and RDV.VEHICLE_REQ.ACTIVE[ply:EntIndex()] then
            local LrequestOpen = RDV.LIBRARY.GetLang(nil, "VR_requestOpen")

            RDV.VEHICLE_REQ.SendNotification(ply, LrequestOpen)

            return
        end

        --
        --  Handle Checking Availability
        --

        local CAN_REQUEST, REASON = RDV.VEHICLE_REQ.CanRequest(ply, SHIP, HANGAR)

        if (CAN_REQUEST == false) then
            local cannotRequest = RDV.LIBRARY.GetLang(nil, "VR_cannotRequest")

            RDV.VEHICLE_REQ.SendNotification(ply, (REASON or cannotRequest))
            return
        end
        
        --
        --  Handle Hangar in use
        --

        if RDV.VEHICLE_REQ.IsHangarInUse(HANGAR) then
            local hangarOccupied = RDV.LIBRARY.GetLang(nil, "VR_hangarOccupied")

            RDV.VEHICLE_REQ.SendNotification(ply, hangarOccupied)
            return 
        end

        --
        --  Create Request
        --

        local KEY = table.insert(RDV.VEHICLE_REQ.SActive, {
            Requester = ply:EntIndex(),
            Ship = SHIP,
            Hangar = HANGAR,
            TIME = (RDV.VEHICLE_REQ.CFG.Waiting or 60),
        })

        RDV.VEHICLE_REQ.ACTIVE[ply:EntIndex()] = {
            Ship = SHIP,
            Hangar = HANGAR,
            Player = ply,
            SKIN = (SKIN or 0),
            SEQUENTIAL = KEY,
        }
        
        --
        --  Request or Auto Grant
        --

        if V_TAB.REQUEST then
            --
            --  Create Filter and Network
            --

            local COUNT = 0
            local FILTER = {}

            for k, v in ipairs(player.GetAll()) do
                if ( v == ply ) and !RDV.VEHICLE_REQ.CFG.SGrant then
                    continue
                end

                if RDV.VEHICLE_REQ.CanGrant(v, SHIP, HANGAR) then
                    COUNT = COUNT + 1

                    table.insert(FILTER, v)
                end
            end

            if COUNT <= 0 and ( V_TAB.SpawnAlone == true ) then
                AutoGrant(ply, SHIP, H_TAB, V_TAB)
            elseif COUNT >= 1 then
                net.Start("RDV.VEHICLE_REQ.ASK")
                    net.WriteUInt(SHIP, 8)
                    net.WriteUInt(HANGAR, 8)
                    net.WriteUInt(ply:EntIndex(), 8)
                net.Send(FILTER)
            end

            local NAME = ( V_TAB.NAME or SHIP )
            
            local startedRequest = RDV.LIBRARY.GetLang(nil, "VR_startedRequest", {
                NAME,
            })

            RDV.VEHICLE_REQ.SendNotification(ply, startedRequest)
        else

            --
            --  Auto Grant
            --

            AutoGrant(ply, SHIP, H_TAB, V_TAB)
        end
    end
end)

--[[---------------------------------]]--
--  Requisition Request Granted
--[[---------------------------------]]--

net.Receive("RDV.VEHICLE_REQ.GRANT", function(len, ply)
    local PLAYER = net.ReadUInt(8)
    local E_INDEX = PLAYER

    local NPLAYER = Entity(PLAYER)

    if !IsValid(NPLAYER) then
        return
    else
        PLAYER = NPLAYER
    end
    
    if ( NPLAYER == ply ) and !RDV.VEHICLE_REQ.CFG.SGrant then
        return
    end

    local tab = RDV.VEHICLE_REQ.ACTIVE[E_INDEX]
    local SEQ = tab.SEQUENTIAL

    local VEHICLE_TAB = RDV.VEHICLE_REQ.VEHICLES[tab.Ship]
    local HANGAR_TAB = RDV.VEHICLE_REQ.SPAWNS[tab.Hangar]

    if not VEHICLE_TAB then
        return
    end

    if tab and RDV.VEHICLE_REQ.CanGrant(ply, tab.Ship, tab.Hangar) then
        local spawn_pos = HANGAR_TAB.Position
        local SHIP_NAME = RDV.VEHICLE_REQ.VEHICLES[tab.Ship].NAME

        net.Start("RDV.VEHICLE_REQ.CLEAR")
            net.WriteUInt(E_INDEX, 8)
        net.Broadcast()

        if VEHICLE_TAB.PRICE then
            if not RDV.LIBRARY.CanAfford(PLAYER, nil, VEHICLE_TAB.PRICE) then
                local LcannotAfford = RDV.LIBRARY.GetLang(nil, "VR_cannotAfford")

                RDV.VEHICLE_REQ.SendNotification(PLAYER, LcannotAfford)

                RDV.VEHICLE_REQ.ACTIVE[E_INDEX] = nil

                if SEQ then
                    table.remove(RDV.VEHICLE_REQ.SActive, SEQ)
                end

                return false
            end
                
            RDV.LIBRARY.AddMoney(PLAYER, nil, -VEHICLE_TAB.PRICE)
        end

        SpawnVehicle(PLAYER, tab.Ship, HANGAR_TAB, VEHICLE_TAB)

        RDV.VEHICLE_REQ.ACTIVE[E_INDEX] = nil

        if SEQ then
            table.remove(RDV.VEHICLE_REQ.SActive, SEQ)
        end

        if PLAYER ~= ply then
            local spawnAccRequester = RDV.LIBRARY.GetLang(nil, "VR_spawnAccRequester", {
                SHIP_NAME,
                ply:Name(),
            })

            RDV.VEHICLE_REQ.SendNotification(PLAYER, spawnAccRequester)

            local spawnAccRequester = RDV.LIBRARY.GetLang(nil, "VR_spawnAccAccepter", {
                SHIP_NAME,
                PLAYER:Name(),
            })

            RDV.VEHICLE_REQ.SendNotification(ply, spawnAccAccepter)
        else
            local spawnAccSelf = RDV.LIBRARY.GetLang(nil, "VR_spawnAccSelf", {
                SHIP_NAME,
            })

            RDV.VEHICLE_REQ.SendNotification(ply, spawnAccSelf)
        end

        PLAYER:EPS_PlaySound("reality_development/ui/ui_accept.ogg")

        hook.Run("RDV_VR_RequestGranted", PLAYER, ply, tab)
    end
end)

--[[---------------------------------]]--
--  Requsition Request Denied
--[[---------------------------------]]--

net.Receive("RDV.VEHICLE_REQ.DENY", function(len, ply)
    local PLAYER = net.ReadUInt(8)
    local E_INDEX = PLAYER

    local NPLAYER = Entity(PLAYER)

    if !IsValid(NPLAYER) then
        return
    else
        PLAYER = NPLAYER
    end

    if ( NPLAYER == ply ) and !RDV.VEHICLE_REQ.CFG.SGrant then
        return
    end
    
    local tab = RDV.VEHICLE_REQ.ACTIVE[E_INDEX]
    local SEQ = tab.SEQUENTIAL

    if tab and RDV.VEHICLE_REQ.CanGrant(ply, tab.Ship, tab.Hangar) ~= false then
        local SHIP_NAME = RDV.VEHICLE_REQ.VEHICLES[tab.Ship].NAME

        net.Start("RDV.VEHICLE_REQ.CLEAR")
            net.WriteUInt(E_INDEX, 8)
        net.Broadcast()

        RDV.VEHICLE_REQ.ACTIVE[E_INDEX] = nil

        if SEQ then
            table.remove(RDV.VEHICLE_REQ.SActive, SEQ)
        end

        if PLAYER ~= ply then
            local spawnDenRequester = RDV.LIBRARY.GetLang(nil, "VR_spawnDenRequester", {
                SHIP_NAME,
                ply:Name(),
            })

            RDV.VEHICLE_REQ.SendNotification(PLAYER, spawnDenRequester)

            local spawnDenDenier = RDV.LIBRARY.GetLang(nil, "VR_spawnDenDenier", {
                SHIP_NAME,
                PLAYER:Name(),
            })

            RDV.VEHICLE_REQ.SendNotification(ply, spawnDenDenier)
        else   
            local spawnDenSelf = RDV.LIBRARY.GetLang(nil, "VR_spawnDenSelf", {
                SHIP_NAME,
            })

            RDV.VEHICLE_REQ.SendNotification(ply, spawnDenSelf)
        end

        PLAYER:EPS_PlaySound("reality_development/ui/ui_denied.ogg")

        hook.Run("RDV_VR_RequestDenied", PLAYER, ply, tab)
    end
end)

net.Receive("RDV.VEHICLE_REQ.RETURN", function(len, ply)
    local VEHICLE = ply.CurrentRequestedVehicle

    if VEHICLE and IsValid(VEHICLE) then
        local CLASS = VEHICLE:GetClass()

        hook.Run("RDV_VR_PreVehicleReturn", ply, VEHICLE)

        VEHICLE:Remove()

        local returnedVehicle = RDV.LIBRARY.GetLang(nil, "VR_returnedVehicle")

        RDV.VEHICLE_REQ.SendNotification(ply, returnedVehicle)

        hook.Run("RDV_VR_PostVehicleReturn", ply, CLASS)
    else
        local noCurrentVehicle = RDV.LIBRARY.GetLang(nil, "VR_noCurrentVehicle")

        RDV.VEHICLE_REQ.SendNotification(ply, noCurrentVehicle)
    end
end)