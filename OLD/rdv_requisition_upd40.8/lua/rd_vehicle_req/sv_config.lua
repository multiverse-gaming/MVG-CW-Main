--[[---------------------------------]]--
--	Saving
--[[---------------------------------]]--

local P_H_I = {}
local P_V_I = {}

local P_H = {}
local P_V = {}

local function SaveHangars()
    file.CreateDir("rdv/vr/spawns")

    -- Spawns
    local JSON = util.TableToJSON(P_H)
    local PATH = "rdv/vr/spawns/"..game.GetMap()..".json"

    file.Write(PATH, JSON)

    -- Vehicles
    local JSON = util.TableToJSON(P_V)
    local PATH = "rdv/vr/vehicles.json"

    file.Write(PATH, JSON)
end
hook.Add("ShutDown", "RDV.VR.SaveHangars", SaveHangars)
timer.Create("rdv_vr_savehangars", 300, 0, SaveHangars)

--[[---------------------------------]]--
--	Hangars Configuration
--[[---------------------------------]]--

util.AddNetworkString("RDV_VR_SendHangar")

local function Delete(UID, TYPE)
    local TAB

    local LOOP = ( TYPE and RDV.VEHICLE_REQ.VEHICLES or RDV.VEHICLE_REQ.SPAWNS )

    for k, v in ipairs(LOOP) do
        if v.UID == UID then
            table.remove(LOOP, k)

            if IsValid(v.TRIGGER) then
                v:Remove()
            end

            TAB = true
        end
    end

    if !TAB then return end

    local NT = (TYPE and P_V or P_H)

    for k, v in ipairs(NT) do
        if v.UID == UID then
            if TYPE then
                table.remove(P_V_I, k)
            else
                table.remove(P_H_I, k)
            end

            table.remove(NT, k)
        end
    end

    if TYPE then -- Vehicle
        net.Start("RDV_VR_DelVehicle")

        P_V = NT
    else
        net.Start("RDV_VR_DelSpawn")

        P_H = NT
    end

    net.WriteString(UID)
    net.Broadcast()
end

local function SendHangars(ply)
    local json = util.TableToJSON(P_H_I)
    local compressed = util.Compress(json)
    local length = compressed:len()

    net.Start("RDV_VR_SendHangar")
        net.WriteUInt(length, 32)
        net.WriteData(compressed, length)
    net.Send(ply)
end

local function SendVehicles(ply)
    local json = util.TableToJSON(P_V_I)
    local compressed = util.Compress(json)
    local length = compressed:len()
    
    net.Start("RDV_VR_SendVehicle")
        net.WriteUInt(length, 32)
        net.WriteData(compressed, length)
    net.Send(ply)
end

--[[---------------------------------]]--
--	Hangar Sent by Admin
--[[---------------------------------]]--

net.Receive("RDV_VR_SendHangar", function(len, ply)
    if !ply:IsAdmin() then return end

    local length = net.ReadUInt(32)
	local data = net.ReadData(length)

	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		return
	end

	local D = util.JSONToTable(uncompressed)

    if D.GT and !table.IsSequential(D.GT) then return end
    if D.RT and !table.IsSequential(D.GT) then return end

    if D.UID then
        Delete(D.UID, false)
    end
    
    local OBJ = RDV.VEHICLE_REQ.AddSpawn(D.NAME)
    OBJ:SetPosition(D.POS)
    OBJ:SetAngles(D.ANG)
    OBJ:AddRequestTeams(D.RT)
    OBJ:AddGrantTeams(D.GT)
    OBJ:SetMap(game.GetMap())

    local UID = ( os.time().."_"..D.NAME )

    OBJ.PERM = true
    OBJ.UID = UID

    D.UID = UID
    D.MAP = game.GetMap()

    local N_GT = {}
    local N_RT = {}

    for k, v in ipairs(D.GT) do
        table.insert(N_GT, team.GetName(v))
    end

    for k, v in ipairs(D.RT) do
        table.insert(N_RT, team.GetName(v))
    end

    table.insert(P_H_I, D)

    local SEND = {[1] = D}

    local json = util.TableToJSON(SEND)
    local compressed = util.Compress(json)
    local length = compressed:len()

    net.Start("RDV_VR_SendHangar")
        net.WriteUInt(length, 32)
        net.WriteData(compressed, length)
    net.Broadcast()

    D.GT = N_GT
    D.RT = N_RT

    table.insert(P_H, D)

    SaveHangars()
end )

hook.Add("PlayerReadyForNetworking", "RDV.REQ.SSS", function(ply)
    SendHangars(ply)
    SendVehicles(ply)
end )

--[[---------------------------------]]--
--	Loading
--[[---------------------------------]]--

local function Read()
    -- Hangars
    local PATH = "rdv/vr/spawns/"..game.GetMap()..".json"

    local JSON = file.Read(PATH, "DATA")

    if !JSON then return end

    P_H = ( util.JSONToTable(JSON) or {} )
    
    local LIST = {}

    for k, v in ipairs(P_H) do
        if LIST[v.NAME] then
            Delete(LIST[v.NAME], false)
        end

        local OBJ = RDV.VEHICLE_REQ.AddSpawn(v.NAME)
        OBJ:SetPosition(v.POS)
        OBJ:SetAngles(v.ANG)
        OBJ:AddRequestTeams(v.RT)
        OBJ:AddGrantTeams(v.GT)
        OBJ:SetMap(v.MAP)

        local UID = ( os.time().."_"..v.NAME )
        
        if !v.UID then
            v.UID = UID
        end

        OBJ.UID = v.UID

        OBJ.PERM = true

        LIST[v.NAME] = v.UID

        local NTAB = table.Copy(v)
        local N_GT = {}
        local N_RT = {}
    
        for k, v in pairs(v.GT) do
            if !isnumber(k) then v.GT[k] = nil continue end

            table.insert(N_GT, RDV.VEHICLE_REQ.GetTeamIndex(v))
        end
    
        for k, v in pairs(v.RT) do
            if !isnumber(k) then v.RT[k] = nil continue end

            table.insert(N_RT, RDV.VEHICLE_REQ.GetTeamIndex(v))
        end
        
        NTAB.GT = N_GT
        NTAB.RT = N_RT

        table.insert(P_H_I, NTAB)
    end

    -- Vehicles

    local PATH = "rdv/vr/vehicles.json"

    local JSON = file.Read(PATH, "DATA")

    if !JSON then return end

    P_V = ( util.JSONToTable(JSON) or {} )
    
    local LIST = {}

    for k, v in ipairs(P_V) do
        if LIST[v.NAME] then
            Delete(LIST[v.NAME], true)
        end

        local OBJ = RDV.VEHICLE_REQ.AddVehicle(v.NAME)
        OBJ:SetCategory( (v.CATEGORY or "Uncategorized") )
        OBJ:SetClass( (v.CLASS or "") )
        OBJ:AddRequestTeams(v.RT)
        OBJ:AddGrantTeams(v.GT)
            
        if v.MODEL and v.MODEL ~= "" then
            OBJ:SetModel(v.MODEL)
        end

        for k, v in ipairs(v.SPAWNS) do
            OBJ:AddHangar(v)
        end

        local UID = ( os.time().."_"..v.NAME )
        
        if !v.UID then
            v.UID = UID
        end

        OBJ.UID = v.UID

        OBJ.PERM = true

        LIST[v.NAME] = v.UID

        local NTAB = table.Copy(v)
        local N_GT = {}
        local N_RT = {}
    
        for k, v in pairs(v.GT) do
            table.insert(N_GT, RDV.VEHICLE_REQ.GetTeamIndex(v))
        end
    
        for k, v in pairs(v.RT) do
            table.insert(N_RT, RDV.VEHICLE_REQ.GetTeamIndex(v))
        end
        
        NTAB.GT = N_GT
        NTAB.RT = N_RT

        table.insert(P_V_I, NTAB)
    end

    hook.Remove("Think", "RDV.VR.LoadHangars")
end

hook.Add("Think", "RDV.VR.LoadHangars", Read)

--[[---------------------------------]]--
--	Hangar Deletion
--[[---------------------------------]]--

util.AddNetworkString("RDV_VR_DelSpawn")

net.Receive("RDV_VR_DelSpawn", function(len, ply)
    if !ply:IsAdmin() then return end

    local UID = net.ReadString()

    Delete(UID, false)
end )

--[[---------------------------------]]--
--	Vehicle Configuration
--[[---------------------------------]]--

util.AddNetworkString("RDV_VR_SendVehicle")

net.Receive("RDV_VR_SendVehicle", function(len, ply)
    if !ply:IsAdmin() then return end

    local length = net.ReadUInt(32)
	local data = net.ReadData(length)
	local uncompressed = util.Decompress(data)

	if (!uncompressed) then
		return
	end

	local D = util.JSONToTable(uncompressed)

    if D.SPAWNS and !table.IsSequential(D.SPAWNS) then return end
    if D.GT and !table.IsSequential(D.GT) then return end
    if D.RT and !table.IsSequential(D.GT) then return end

    if D.UID then
        Delete(D.UID, true)
    else
        D.UID = ( os.time().."_"..D.NAME )
    end

    local OBJ = RDV.VEHICLE_REQ.AddVehicle(D.NAME)
    OBJ:SetCategory( (D.CATEGORY or "Uncategorized") )
    OBJ:SetClass( (D.CLASS or "") )
    OBJ:AddRequestTeams(D.RT)
    OBJ:AddGrantTeams(D.GT)

    if D.MODEL and D.MODEL ~= "" then
        OBJ:SetModel(D.MODEL)
    end

    if D.SPAWNS then
        for k, v in ipairs(D.SPAWNS) do
            OBJ:AddHangar(v)
        end
    end

    OBJ.PERM = true
    OBJ.UID = D.UID

    local N_GT = {}
    local N_RT = {}

    for k, v in ipairs(D.GT) do
        table.insert(N_GT, team.GetName(v))
    end

    for k, v in ipairs(D.RT) do
        table.insert(N_RT, team.GetName(v))
    end

    table.insert(P_V_I, D)

    local SEND = {[1] = D}

    local json = util.TableToJSON(SEND)
    local compressed = util.Compress(json)
    local length = compressed:len()

    net.Start("RDV_VR_SendVehicle")
        net.WriteUInt(length, 32)
        net.WriteData(compressed, length)
    net.Broadcast()

    D.GT = N_GT
    D.RT = N_RT

    table.insert(P_V, D)

    SaveHangars()
end )

--[[---------------------------------]]--
--	Hangar Deletion
--[[---------------------------------]]--

util.AddNetworkString("RDV_VR_DelVehicle")

net.Receive("RDV_VR_DelVehicle", function(len, ply)
    if !ply:IsAdmin() then return end

    local UID = net.ReadString()

    Delete(UID, true)
end )