NCS_SHARED.CharSystems = NCS_SHARED.CharSystems or {}

hook.Add("NCS_SHARED_ConfigurationModuleLoaded", "checkLoadedCharacterModule", function()
    if !NCS_SHARED.CharacterSystemEnabled() then return end

    for k, v in pairs(NCS_SHARED.CharSystems) do
        if (NCS_SHARED.GetDataOption("charactersystem_library") != k ) then continue end

        print("---------------------------------------------------------------------------")
        print("[NCS] Shared Library")
        print("We've executed character support integration for ("..k.."), we're adding the following hooks!")
        
        for k, v in pairs(v.hooks) do
            print("Added Hook: ("..k..")")
            hook.Add(k, "NCS_SHARED_CharacterSystem_"..k, function(...)
                v(...)
            end )
        end

        print("---------------------------------------------------------------------------")

    end
end )

function NCS_SHARED.AddCharacterSystem(name, data)
    NCS_SHARED.CharSystems[name] = data
end

function NCS_SHARED.CharacterSystemEnabled()
    return NCS_SHARED.GetDataOption("charactersystemenabled_library")
end

function NCS_SHARED.GetCharacterID(P)
    local dOption = NCS_SHARED.GetDataOption("charactersystem_library")

    if !NCS_SHARED.CharSystems[dOption] then return end
    if !NCS_SHARED.CharSystems[dOption].GetCharacterID then return end

    return NCS_SHARED.CharSystems[dOption].GetCharacterID(P)
end

