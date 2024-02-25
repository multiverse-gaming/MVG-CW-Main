CustomHUD_Fox.Loader = CustomHUD_Fox.Loader or {}
CustomHUD_Fox.Loader.OnlineDataLoad = CustomHUD_Fox.Loader.OnlineDataLoad or {}
local internal = internal or {}






internal.Messages = internal.Messages or {}
--[[
    errorCode:
            -3 Notification
            -2 Issue
            -1 Critical Error

    Messages (tbl) {
        [index] = {message, errorLvl}
    }
]]
function CustomHUD_Fox.Loader:AddMessage(msg, errorCode)
    do -- Preliminary checks
        do
            if not isstring(msg) then
                ErrorNoHalt("[CustomHUD_Fox][Loader] msg argument isn't a string.")
                return false
            end

            if not isnumber(errorCode) then
                ErrorNoHalt("[CustomHUD_Fox][Loader] erroreCode argument isn't a number.")
                return false
            else
                if not (errorCode == 1 or errorCode == 2 or errorCode == 3) then
                    ErrorNoHalt("[CustomHUD_Fox][Loader] erroreCode argument isn't a valid input, only 1 to 3.")
                    return false
                end 
            end

            for i,v in pairs(internal.Messages) do
                if isstring(msg) and v[1] == msg then
                    ErrorNoHalt("[CustomHUD_Fox][Loader] Message already exists in the compile report.")
                    return false
                end
            end
        end
    end

    table.insert(internal.Messages, {msg, errorCode})

    return true


end


if true then return end

--[[
    What it does:
    - Grabs Data from online.
        - Checks if modules are compatible for versions.
        - Looks out for new versions.

    - This determains if modules also should be ran on the client etc.
]]
function CustomHUD_Fox.Loader.StartProcessing()



    hook.Add("CustomHUD_Fox", "CustomHUD_Fox.Loader.FinishedHTTPFetch", function()
        print("================================================================================")
        print("                                   HUD BASE                                     ")
        print("                           MODULES STATE INFORMATION                            ")
        print("================================================================================")

        internal.ConfigTbl = FoxLibs.File:Include("sv_verifycheck.lua", "customhud/config/")  -- Load new temp 

        do -- Config Related Part.
            if internal.ConfigTbl ~= false and internal.ConfigTbl.Enabled == true then -- Is Config enabled

                                    
                do -- Should refresh is server files update live.
                    if isnumber(internal.ConfigTbl.UpdatingMode) and internal.ConfigTbl.UpdatingMode == 2 then

                        hook.Add("Tick", "CustomHUD_Fox.Loader.CheckIfFileUpdated", internal.compareFileTime)
                    else
                        if FoxLibs.Hook:HookExists("Tick", "CustomHUD_Fox.Loader.CheckIfFileUpdated") then
                            hook.Remove("Tick", "CustomHUD_Fox.Loader.CheckIfFileUpdated")
                        end
                    end
                end


                do -- Bug Avoider Part and Compatiblity warning/report

                    do -- New internal variables.
                        internal.CompatibilityWarnings = nil -- Message

                        internal.CompatbilityMessage = nil -- Message
    
                        internal.AddModulesToRun = {}
                    end

                    do -- Loop part
                        local files, directories = file.Find("customhud/huds/*","LUA")

                        for i,v in pairs(files) do
                            local bool, warningMessage, compMessageReport = internal:CheckCompatibility(v)

                            if bool then
                                internal.AddModulesToRun[i] = v
                            end

                            if isstring(warningMessage) then
                                if internal.CompatibilityWarnings == nil then
                                    internal.CompatibilityWarnings = ""
                                end
                                internal.CompatibilityWarnings = internal.CompatibilityWarnings .. warningMessage .. "\n"
                            end

                            if isstring(compMessageReport) then
                                if internal.CompatbilityMessage == nil then
                                    internal.CompatbilityMessage = ""
                                end
                                internal.CompatbilityMessage = internal.CompatbilityMessage .. compMessageReport .. "\n"
                            end

                        end
                    end

                    --[[
                        This part only prints the output in tho the server console from bug report/compatbility.
                    ]]
                    do
                        
                        if internal.CompatibilityWarnings ~= nil then
                            print("                               ISSUES THAT ARRISED                              ")
                            print("================================================================================")

                            print(internal.CompatibilityWarnings)

                            print("================================================================================")

                        end

                        if internal.CompatbilityMessage ~= nil then
                            print("                             COMPATIBILITY REPORT                               ")
                            print("================================================================================")

                            print(internal.CompatbilityMessage)

                            print("================================================================================")

                        end

                        do
                            print("\n")
                            print("\n")
                        end
                    end

                    
                end



                
                


            elseif internal.ConfigTbl ~= false and internal.ConfigTbl.Enabled == false then
                -- Disabled speifically
            end



        end
        


    
    end)

    internal:LoadOnlineData()

end


hook.Add("OnGamemodeLoaded", "CustomHUD_Fox.Loader.StartProcessing", CustomHUD_Fox.Loader.StartProcessing)



do -- internal

    --[[
        Loads into CustomHUD_Fox.Loader.OnlineDataLoad
    ]]
    function internal:LoadOnlineData()
        http.Fetch("https://raw.githubusercontent.com/The-Fox-Dev/MyUpdates/main/foxLibs.txt", function(body, str, headers, code)
            -- Success
            local code = "return " .. body
            CustomHUD_Fox.Loader.OnlineDataLoad = CompileString(code)()

            hook.Run("CustomHUD_Fox", "CustomHUD_Fox.Loader.FinishedHTTPFetch")
        end,
        function(err)
            -- Failure
            print("[Loader][LoadOnlineData] Failed to get online data: Will not carry on Fox Base ")
            print(err)
        end,
        {
            ["cache-control"] = "no-cache",
            ["expires"] = "0",
            ["pragma"] = "no-cache",

        })
    end

    --[[
        OUTPUT:
            1) returns if can run.
    ]]
    function internal:CheckCompatibility(curModule)

        local curModule_RemoveLuaPart = string.Left(curModule, #curModule - 4)
        local tempDataInfo = FoxLibs.File:Include(curModule, "customhud/huds/")  -- Load new temp 
        local curVersionOfModule = nil 

        local output_LoA = nil
        local avgVersionWarningLevel = nil


        do -- Check manual preliminary.
            if istable(tempDataInfo) and tempDataInfo.PreliminaryCheck ~= nil and isfunction(tempDataInfo.PreliminaryCheck) then
                local bool = tempDataInfo.PreliminaryCheck(tempNewHUDPart)
    
                if not (bool == true or bool == nil) then
                    
                    if Debug_Fox then
                        print("[CustomHUD_Fox.Loader][CheckCompatibility] HUD has failed preliminary check, no longer enabling this element.")
                    end
    
                    return false
                end
            end
        end


        do
            curVersionOfModule = internal:getVersionOfCurrentModuleOnServer(curModule)

            if curVersionOfModule ~= false then
                curVersionOfModule = internal:ConvertToNumber(curVersionOfModule)
            else
                return true, "[UNKNOWN]" .. "[" .. curModule_RemoveLuaPart .. "]" .. " Module on server doesn't have version tag, assumning its fine to run", "[UNKNOWN][" .. curModule_RemoveLuaPart .. "] Assuming it's fine."
            end
        end
        



        do -- LevelOAcceptance config function.

            if internal.ConfigTbl.LevelOAcceptance ~= nil then -- This shouldn't be missing but just incase they deleted it...
                output_LoA = internal.ConfigTbl.LevelOAcceptance(table.Copy(tempDataInfo), curModule_RemoveLuaPart) -- TODO: CHange to foxlibs from table.Copy |  we dont want them to modify table, so we use table.Copy.
    
                if output ~= 1 or output ~= 2 then
                    output_LoA = 1 -- if value returns nothing or still returns nil it goes to 1 by default.
                end

    
            else
                if Debug_Fox then
                    print("[CustomHUD_Fox][CheckCompatbility] Function LevelOAcceptance has been deleted in config. Please avoid doing this.")
                end
            end
        end

        do -- Get Compatiblity.

            local curTableScope = table.Copy(CustomHUD_Fox.Loader.OnlineDataLoad[curModule_RemoveLuaPart])


            --[[
                We seperate the tables for the depedent modules related to it and the module itself.
            ]]
            local depModules_onCurrent = {}
            local currentVersions_onCurrent = {}

            do -- This is the part it seperates into the two variables above.
                if curTableScope ~= nil then
                    for i,v in pairs(curTableScope) do
                        if istable(v) then
                            depModules_onCurrent[i] = v
                        else
                            currentVersions_onCurrent[i] = v
                        end
                    end
                else
                    return true, "[UNKNOWN]" .. "[" .. curModule_RemoveLuaPart .. "]" .. " Couldn't find any data from online database, about this module at all. ", "[UNKNOWN][" .. curModule_RemoveLuaPart .. "] Assuming it's fine." -- Assuming it can run.
                end
            end
            
            local currentHighestWarning_onModule = nil
            do
                for i,v in pairs(currentVersions_onCurrent) do
                    if i == curVersionOfModule then
                        currentHighestWarning_onModule = v 
                    end
                end
    
                if foundVersion_ofModuleItself == false then
                    return true, "[UNKNOWN]" .. "[" .. curModule_RemoveLuaPart .. "]" .. " Module itself on server doesn't have version tag, not in the online database, assuming its fine to run.", "[UNKNOWN][" .. curModule_RemoveLuaPart .. "] Assuming it's fine."
                end
            end


            local currentHighestWarning_onDepdent = nil
            do
                for i,v in pairs(depModules_onCurrent) do
                    getVersionOfSubModule = internal:getVersionOfCurrentModuleOnServer(i)

                    if getVersionOfSubModule ~= false then
                        getVersionOfSubModule = internal:ConvertToNumber(getVersionOfSubModule)

                        for key, value in pairs(v) do
                            if key == curVersionOfModule then
                                currentHighestWarning_onDepdent = FoxLibs.Math:LowestValue(value, currentHighestWarning_onDepdent)
                            end
                        end

                    else
                        -- TODO FIX ERROR MESSAG BELOW.
                        return true, "[UNKNOWN]" .. "[" .. curModule_RemoveLuaPart .. "]" .. " Module on server doesn't have version tag, didn't find version in online database, assuming true", "[UNKNOWN][" .. curModule_RemoveLuaPart .. "] Assuming it's fine."
                    end
                end
            end

            avgVersionWarningLevel = FoxLibs.Math:LowestValue(currentHighestWarning_onDepdent, currentHighestWarning_onModule)

        end
        

        local avgVersionWarningLevel_ToText

        do
            if avgVersionWarningLevel == 1 then
                avgVersionWarningLevel_ToText = "[FINE]"
            elseif avgVersionWarningLevel == 2 then
                avgVersionWarningLevel_ToText = "[WARNING]"
            else
                avgVersionWarningLevel_ToText = "[INCOMPATIBLE]"
            end
        end



        local warningMessage = "[" .. curModule_RemoveLuaPart .. "]"





        if output_LoA <= avgVersionWarningLevel then
            return true, nil, avgVersionWarningLevel_ToText .. warningMessage .. " Level of Acceptance let this pass"
        else
            return false, nil, avgVersionWarningLevel_ToText .. warningMessage .. " Level of acceptance didn't let this pass"
        end
    end


    function internal:ConvertToNumber(v)
        local curVal = ""
        if v == math.abs(v) then -- Check if integer is whole.
            curVal = tostring(v) .. ".0"
        else
            curVal = tostring(v)
        end

        return curVal
    end


    --[[
        Input: CurModule Name
        Output: (float) module number, returns false if non existing.
    ]]
    function internal:getVersionOfCurrentModuleOnServer(curModule)
        local tempDataInfo = FoxLibs.File:Include(curModule, "customhud/huds/")  -- Load new temp 


        if (tempDataInfo.Version) ~= nil and isnumber(tempDataInfo.Version) then

            return tempDataInfo.Version
        end

        return false
    end




    local lastTimeForCheck = SysTime()

    function internal.compareFileTime()
        if lastTimeForCheck + 5 < SysTime() then
            lastTimeForCheck = SysTime()

            local hasUpdated = FoxLibs.File:FileHasBeenUpdated("sv_verifycheck", "customhud/config/sv_verifycheck.lua", "LUA")

            if hasUpdated then
                CustomHUD_Fox.Loader.StartProcessing() -- Need to start repossessing data.
            end

        end 
    end
end

