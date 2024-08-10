NCS_SHARED.SavedDataOptions = NCS_SHARED.SavedDataOptions or {}

local didOptionChange = false
local optionCategories = {}
local dataLoaded = false
local lastOptionCreated

function NCS_SHARED.CreateDataOption(name, datatable)
    local UID = string.Replace(string.lower(name.."_"..datatable.dataCategory), " ", "")
    UID = tostring(UID)

    NCS_SHARED.SavedDataOptions[UID] = datatable
    NCS_SHARED.SavedDataOptions[UID].dataName = name
    NCS_SHARED.SavedDataOptions[UID].uniqueid = UID
    NCS_SHARED.SavedDataOptions[UID].setInternalData = function(s, value)
        if NCS_SHARED.SavedDataOptions[UID].verifyData then
            local verifyData = NCS_SHARED.SavedDataOptions[UID]:verifyData(value)

            if ( verifyData == false ) then return end
        end

        net.Start("NCS_SHARED_SetConfigOption")
            net.WriteString(UID, value)
            net.WriteType(value)
        net.SendToServer()
    end

    lastOptionCreated = CurTime() + 2

    table.insert(optionCategories, datatable.dataCategory)
end

function NCS_SHARED.GetDataOption(uniqueid)
    if !NCS_SHARED.SavedDataOptions[tostring(uniqueid)] then ErrorNoHalt("Invalid Data Option Index!") return end
    
    return ( NCS_SHARED.SavedDataOptions[tostring(uniqueid)].currentValue and NCS_SHARED.SavedDataOptions[tostring(uniqueid)].currentValue or false )
end

if SERVER then

    function NCS_SHARED.SetDataOption(uniqueid, value)
        if !NCS_SHARED.SavedDataOptions[tostring(uniqueid)] then ErrorNoHalt("[NCS] Attempted to set an invalid data option!") return end

        if NCS_SHARED.SavedDataOptions[tostring(uniqueid)].verifyData then
            local verifyData = NCS_SHARED.SavedDataOptions[tostring(uniqueid)]:verifyData(value)

            if ( verifyData == false ) then return end
        end

        NCS_SHARED.SavedDataOptions[tostring(uniqueid)].currentValue = value

        didOptionChange = true

        net.Start("NCS_SHARED_SetConfigOption")
            net.WriteString(uniqueid, value)
            net.WriteType(value)
        net.Broadcast()
    end

    local function ReadDataOptions()
        if lastOptionCreated and lastOptionCreated < CurTime() then
            for k, v in pairs(optionCategories) do
                local DATA = file.Read("ncs_configuration_lib_"..v..".json", "DATA")

                if DATA ~= nil then
                    DATA = util.JSONToTable(DATA)
                end

                for k, v in pairs(NCS_SHARED.SavedDataOptions) do
                    if ( DATA == nil ) or ( DATA[k] == nil ) then
                        NCS_SHARED.SavedDataOptions[tostring(k)].currentValue = NCS_SHARED.SavedDataOptions[tostring(k)].defaultValue
                    else
                        NCS_SHARED.SavedDataOptions[k].currentValue = DATA[k]
                    end
                end
                
            end

            lastOptionCreated = false
            dataLoaded = true

            hook.Run("NCS_SHARED_ConfigurationModuleLoaded")
        end
    end

    local nextRun = CurTime() + 10

    hook.Add("Think", "NCS_SharedResources_SaveData", function()
        ReadDataOptions()

        if nextRun > CurTime() then return end
        if !dataLoaded then return end
        if !didOptionChange then return end

        local DATA = {}

        for k, v in pairs(NCS_SHARED.SavedDataOptions) do
            if !v.saveData then continue end

            DATA[v.dataCategory] = DATA[v.dataCategory] or {}
            DATA[v.dataCategory][tostring(v.uniqueid)] = v.currentValue
        end

        for k, v in pairs(DATA) do
            file.Write("ncs_configuration_lib_"..k..".json", util.TableToJSON(v))
        end

        didOptionChange = false
    end )

    util.AddNetworkString("NCS_SHARED_SendConfigOptions")
    util.AddNetworkString("NCS_SHARED_SetConfigOption")

    net.Receive("NCS_SHARED_SetConfigOption", function(_, P)
        local aGroups = NCS_SHARED.GetDataOption("admingroups_library")

        if !aGroups then
            if !P:IsSuperAdmin() then NCS_SHARED.AddText(Color(255,0,0), "[NCS] ", color_white, "No permission, please contact system administrator.") return end
        elseif !aGroups[P:GetUserGroup()] then
            NCS_SHARED.AddText(Color(255,0,0), "[NCS] ", color_white, "No permission, please contact system administrator.")
            return
        end
    
        local UID = net.ReadString()
        local VAL = net.ReadType()
    
        NCS_SHARED.SetDataOption(UID, VAL)
    end )
end

hook.Add("NCS_SHARED_PlayerReadyForNetworking", "NCS_SHARED_ConfigurationOptionNetworking", function(P)
    local DATA = {}

    for k, v in pairs(NCS_SHARED.SavedDataOptions) do
        DATA[v.dataCategory] = DATA[v.dataCategory] or {}
        DATA[v.dataCategory][tostring(v.uniqueid)] = v.currentValue
    end

    for k, v in pairs(DATA) do
        net.Start("NCS_SHARED_SendConfigOptions")
            net.WriteTable(v)
        net.Send(P)
    end
end )