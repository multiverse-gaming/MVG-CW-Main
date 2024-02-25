------------------------------
CustomHUD_Fox = CustomHUD_Fox or {}
CustomHUD_Fox.Loader = CustomHUD_Fox.Loader or {}

CustomHUD_Fox.Loader.UniqueID = CustomHUD_Fox.Loader.UniqueID or nil

CustomHUD_Fox.Loaded = CustomHUD_Fox.Loaded or {}

CustomHUD_Fox.Loader.Temp =  CustomHUD_Fox.Loader.Temp or {} -- Used to test make sure it works.

CustomHUD_Fox.Loader.LastLoadName = CustomHUD_Fox.Loader.LastLoadName or "CLEAN TABLE"
------------------------------
local internal = internal or {} -- DONT WANT TO APPEAR OUTSIDE OF CLASS.

--[[
    
    
]]
function CustomHUD_Fox.Loader:BuildHUD(name, isTest)

    if Debug_Fox then
        print("======================================================================")
        print("[CustomHUD_Fox.Loader][BuildHUD] Starting section: " .. name .. " -> " .. CustomHUD_Fox.Loader.LastLoadName)
    end

    local objToApplyTo = nil

    do
        
        if isTest then
            objToApplyTo = FoxLibs.Table.Copy(CustomHUD_Fox.Loader.Temp, true)
        else
            objToApplyTo = FoxLibs.Table.Copy(CustomHUD_Fox.Loaded, true)
        end

    end



    do -- Check if test table or actual build table is empty.
        if Debug_Fox then
            if not (table.IsEmpty(CustomHUD_Fox.Loaded) or table.IsEmpty(CustomHUD_Fox.Loader.Temp)) and Debug_Fox then
                print("[CustomHUD_Fox.Loader][BuildHUD] Warning, hud has elements in it already.")
            end
        end
    end




    local completedLoadingIntoCurrentSolution = nil
    local newBuild = nil


    do -- Load HUDPart into table.

        -- If there is two Init, then revise method and put them into [1] and [2] etc table.


        if isTest then
            local succ, err = pcall(function()

                completedLoadingIntoCurrentSolution, newBuild = CustomHUD_Fox.Loader:LoadHUDPartIntoBuild(objToApplyTo, name)
            end)

            if not succ then
                if completedLoadingIntoCurrentSolution then
                    LocalPlayer():ChatPrint("[CustomHUD_Fox][BuildHUD] WARNING: Still loaded but issue arrised: " .. err)


                else
                    LocalPlayer():ChatPrint("[CustomHUD_Fox][BuildHUD] FAILED TO LOAD, EXITING BUILD: ")
                    LocalPlayer():ChatPrint(err)

                    return false -- Stop entire solution as failed fully.
                end
            end
        else
            completedLoadingIntoCurrentSolution, newBuild = CustomHUD_Fox.Loader:LoadHUDPartIntoBuild(objToApplyTo, name)
        end


        if newBuild ~= nil then
            if isTest then
                CustomHUD_Fox.Loader.Temp = newBuild
            else
                CustomHUD_Fox.Loaded = newBuild
            end  
        end



    end

    if Debug_Fox then
        if completedLoadingIntoCurrentSolution == true then
            print("[CustomHUD_Fox.Loader][BuildHUD] Built HUD Part Correctly: " .. name .. " into " .. CustomHUD_Fox.Loader.LastLoadName)
            CustomHUD_Fox.Loader.LastLoadName = name
  
            print("======================================================================")


        elseif completedLoadingIntoCurrentSolution == false then
            print("[CustomHUD_Fox.Loader][BuildHUD] Prevented from BuildingNewParent Into Old. Reason above for: " .. name)
        else
            print("[CustomHUD_Fox.Loader][BuildHUD] Unspecified")
        end
    end

    return completedLoadingIntoCurrentSolution
end

--[[
    FIND SOMEWHERE TO PUT THIS:
    Objects should only be CREATED in, PreInit, PostInit, Init. (Any Init Stage, else will break.)
]]
function CustomHUD_Fox.Loader:LoadHUDPartIntoBuild(objToApplyTo, name)
    local uniqueID = CustomHUD_Fox.Loader.UniqueID

    local tempNewHUDPart = FoxLibs.File:Include(name .. ".lua", "customhud/huds/")  -- Load new temp 

    do -- Whitelist elements
        local whitelistTbl = tempNewHUDPart.ElementsOtherHudsCanKnow
        if whitelistTbl ~= nil then
            if istable(whitelistTbl) then
                for i,v in pairs(whitelistTbl) do
                    if isstring(v) then
                        CustomHUD_Fox.Loader:AddWhitelist(v)
                    else
                        print("[CustomHUD][BuildHUD] Elements must be string format.")
                    end
                end
            else
                print("[CustomHUD][BuildHUD] ElementsOtherHudsCanKnow is not table format.")
            end
        end
    end



    do -- Config Load Part.
        local config = CustomHUD_Fox.Loader:GetConfig(name)



        if config.Enabled == false then
            return true, objToApplyTo
        else
            config.Enabled = nil -- No longer needed and removed to avoid issues with verification colission issues.
        end

        if config == {} then
            if Debug_Fox then
                print("[CustomHUD_Fox.Loader] Failed to find any config")
            end
        else
            CustomHUD_Fox.Loader:Merge(config, tempNewHUDPart)
        end

    end

    

    local copy_tempNewHUDPart = FoxLibs.Table.DeepCopy(tempNewHUDPart) 
    local copy_objToApplyTo = FoxLibs.Table.DeepCopy(objToApplyTo)
    
    do -- Init (All Stages) test, main point to double check no components have same name.
            if Debug_Fox then
                print("STARTING INIT TESTING.")
            end

            do -- tempNewHUDPart function test
                local tempNewHUDPart_functionTest = (function(tempNewHUDPart)
                    if (tempNewHUDPart.PreInitI ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(tempNewHUDPart.PreInitI, tempNewHUDPart, ScrW(), ScrH())
                    end

                    if (tempNewHUDPart.PreInit ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(tempNewHUDPart.PreInit, tempNewHUDPart, ScrW(), ScrH())
                    end


                    if (tempNewHUDPart.Init ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(tempNewHUDPart.Init, tempNewHUDPart, ScrW(), ScrH())
                    end


                    if (tempNewHUDPart.PostInitI ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(tempNewHUDPart.PostInitI, tempNewHUDPart, ScrW(), ScrH()) 
                    end

                    if (tempNewHUDPart.PostInit ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(tempNewHUDPart.PostInit, tempNewHUDPart, ScrW(), ScrH()) 
                    end
                end)

                local outcome, extraData = internal.CMV:CompileMissingVariables(tempNewHUDPart_functionTest, tempNewHUDPart)


                if outcome then
                    CustomHUD_Fox.Loader:Merge(extraData, tempNewHUDPart)
                else
                    return false -- Failed to complete. TODO: MAYBE IMPROVE TO SHOW SPECIFIC ERR? DO IN INTERNAL CMV
                end
            end

            do -- objToApplyTo function test
                local objToApplyTo_functionTest = (function(objToApplyTo)

                    if (objToApplyTo.PreInitI ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(objToApplyTo.PreInitI, objToApplyTo, ScrW(), ScrH()) 
                    end

                    if (objToApplyTo.PreInit ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(objToApplyTo.PreInit, objToApplyTo, ScrW(), ScrH()) 
                    end

                    if (objToApplyTo.Init ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(objToApplyTo.Init, objToApplyTo, ScrW(), ScrH())
                    end
                    if (objToApplyTo.PostInitI ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(objToApplyTo.PostInitI, objToApplyTo, ScrW(), ScrH())
                    end
                    if (objToApplyTo.PostInit ~= nil) then
                        CustomHUD_Fox.Loader:RunFunctions(objToApplyTo.PostInit, objToApplyTo, ScrW(), ScrH())
                    end

                end)

                local outcome, extraData = internal.CMV:CompileMissingVariables(objToApplyTo_functionTest, objToApplyTo)



                if outcome then
                    CustomHUD_Fox.Loader:Merge(extraData, objToApplyTo)
                else
                    return false -- Failed to complete. TODO: MAYBE IMPROVE TO SHOW SPECIFIC ERR? DO IN INTERNAL CMV
                end

            end

            do -- Component sharing and Identifier testing.
                if istable(tempNewHUDPart) then 
        
        
                    for i1,v1 in pairs(tempNewHUDPart) do
        
                        local curView = objToApplyTo[i1] 
                        if ( curView ~= nil ) and (not (isfunction(curView) or istable(curView))) then
                            CustomHUD_Fox.Loader:ClearHUDElements(objToApplyTo)
                            CustomHUD_Fox.Loader:ClearHUDElements(tempNewHUDPart)
                            print("[CustomHUD_Fox.Loader][Components] A component is sharing same name in current build of base. Preventing loading part: " .. name .. " IDENTIFIER OF BOTH: " .. i1)
                            return false
                        end
                    end  
        
                    if ((tempNewHUDPart.C) ~= nil) and ((objToApplyTo.C) ~= nil) then
                        for i1, v1 in pairs(tempNewHUDPart.C) do
                            if (objToApplyTo.C[i1] ~= nil) and not CustomHUD_Fox.Loader:IsValidWhitelist(i1) then
                                CustomHUD_Fox.Loader:ClearHUDElements(objToApplyTo)
                                CustomHUD_Fox.Loader:ClearHUDElements(tempNewHUDPart)
                                print("[CustomHUD_Fox.Loader][Components] A part is sharing same identifier that isnt a function in current build of base, name of obj: " .. i1 .. ". Preventing loading part: " .. name)
                                return false
                            end
                        end
                    end
                else
                    Error("[CustomHUD_Fox][BuildHUD] tempNewHUDPart isn't table, which is expected atleast.")
                end
            end





            if Debug_Fox then
                print("COMPLETED INIT TESTING.")
            end
    end

    do -- Start looping through components and merging them.
        CustomHUD_Fox.Loader:Merge(copy_tempNewHUDPart, copy_objToApplyTo)
    end
    

    CustomHUD_Fox.Loader:ClearHUDElements(objToApplyTo)
    CustomHUD_Fox.Loader:ClearHUDElements(tempNewHUDPart)


    return true, copy_objToApplyTo
end

function CustomHUD_Fox.Loader:ClearHUDElements(obj)
    if obj.C ~= nil and istable(obj.C) then
        for i, v in pairs(obj.C) do
            if ispanel(v) then
                v:Remove()
            else
                v = nil
            end
        end
    end

    obj = nil
    
    
end



--[[
    Used to run all functions in table or just function depending on the case.
]]
function CustomHUD_Fox.Loader:RunFunctions(func, selfRef, param1, param2, param3, param4, param5)
    if istable(func) then
        for i,v in pairs(func) do
            v(selfRef, param1, param2, param3, param4, param5)
        end
    elseif isfunction(func) then
        func(selfRef, param1, param2, param3, param4, param5)
    else
        print("[CustomHUD_Fox.Loader][RunFunctions] Isn't function or table [" .. type(func) .. "] " .. ", identifier: " .. tostring(func) .. ", " .. tostring(param1))
    end
end






do -- Internal to CompileMissingVariables
    internal.CMV = internal.CMV or {}


    --[[
        Impossible to make this work and can be much more simpler.
    ]]
    do
        function internal.CMV:CompileMissingVariables(func, classData)
            local currentCopy = FoxLibs.Table.DeepCopy(classData)
            local newDataToAdd = newDataToAdd or {}


            local succ, err = pcall(function()  

                for i,v in pairs(CustomHUD_Fox.Loader.WhiteListIdentifierBypass) do
                    -- Double check I doesn't have. 
                    
                    local code = [[ local curTbl = ]] .. FoxLibs.Table.ToStringFormat(newDataToAdd) .. [[

                        curTbl.]] .. v .. [[ = {}

                        return curTbl
                    ]]


                    newDataToAdd = CompileString(code)()
                end
            end)
            
            if not succ then
                print("[CustomHUD_Fox][Internal][CompileMissingVariables] Failed to create variables:")
                print(err)
                return false

            end
            
        
            local succ, err = pcall(function()  
                
                CustomHUD_Fox.Loader:Merge(newDataToAdd, currentCopy)
                
                func(currentCopy)
            end)
        
            if not succ then
                print("[CustomHUD_Fox][Internal][CompileMissingVariables] Failed to run function still after compiling variables:")
                print(err)
                return false
            else
                return true, newDataToAdd
            end

        end

    end
end



function CustomHUD_Fox.Loader:Merge(newTableToMergeFROM, TableToMergeTO)
    do -- Start looping through components and merging them.
        for i_newPart,v_newPart in pairs(newTableToMergeFROM) do
            if (TableToMergeTO[i_newPart]) ~= nil then -- Check if index exists.
                local v_CurrentBuildPart = TableToMergeTO[i_newPart]
                
                local posI = nil

                if isfunction(v_CurrentBuildPart) then
                    posI = 1 -- As just created.
                    TableToMergeTO[i_newPart] = {}


                    if istable(v_newPart) then
                        TableToMergeTO[i_newPart][posI] = v_CurrentBuildPart -- i_newPart and i2 same in any case in here ofc, due to i_newPart == i2.

                        for i,v in pairs(v_newPart) do
                            TableToMergeTO[i_newPart][posI + 1] = v
                            posI = posI + 1
                        end

                    elseif isfunction(v_newPart) then
    
                        TableToMergeTO[i_newPart][posI] = v_CurrentBuildPart -- i_newPart and i2 same in any case in here ofc, due to i_newPart == i2.
    
                        TableToMergeTO[i_newPart][posI + 1] = v_newPart
                    end
                elseif istable(v_CurrentBuildPart) then
                    
                    posI = #TableToMergeTO[i_newPart] + 1

                    TableToMergeTO[i_newPart][posI] = v_newPart
                else
                    if Debug_Fox then
                        print("[CustomHUD_Fox.Loader] Can only merge functions.")
                    end
                end

            else
                TableToMergeTO[i_newPart] = v_newPart
                
            end
        end
    end 
end


CustomHUD_Fox.Loader.WhiteListIdentifierBypass =  CustomHUD_Fox.Loader.WhiteListIdentifierBypass or {}

--[[
    PREWARNING: CAN ONLY CHECK CERTAIN VALUES.
]]
function CustomHUD_Fox.Loader:IsValidWhitelist(name)
    for i,v in pairs(CustomHUD_Fox.Loader.WhiteListIdentifierBypass) do
        local wow = string.find(v, name)

        if isnumber(wow) then
            return true 
        end
    end

    return false
end
--[[
        PREWARNING: MUST BE ORDERED APPROPIATLY WHEN USING ADD WHITELIST.

]]
function CustomHUD_Fox.Loader:AddWhitelist(name)
    local tbl = CustomHUD_Fox.Loader.WhiteListIdentifierBypass
    tbl[#tbl + 1] = name

end

function CustomHUD_Fox.Loader:RemoveWhiteList(name)
    local tbl = CustomHUD_Fox.Loader.WhiteListIdentifierBypass

    local CollectIndex = {}

    for i,v in pairs(tbl) do
        if v == name then
            table.insert(CollectIndex, i)
        end
    end

    if #CollectIndex == 1 then
        tbl[i] = nil
    else
        -- TODO: FINISH THIS OFF.
        print("[CustomHUD_Fox][RemoveWhitelist] Somehow multiple values.")
    end
end



function CustomHUD_Fox.Loader:OnStart()

    local files, directories = file.Find("customhud/huds/*","LUA")


    do -- Remove .lua part
        for i,v in pairs(files) do
            
            files[i] = string.Left(files[i], #files[i] - 4)
        end

    end
    

    if CustomHUD_Fox.Loader:ComponentExists("base") then
        for i,v in pairs(files) do -- Do cl_base first.
            if v == "cl_base" then
                files[i] = nil
                local bool = CustomHUD_Fox.Loader:BuildHUD(v, false) -- isTest useless.
                break
            end
        end
        
    else
        Error("[CustomHUD_Fox][OnStart] cl_base doesn't exist!")
        return false
    end



    for i,v in pairs(files) do
        local bool = CustomHUD_Fox.Loader:BuildHUD(v, false) -- isTest useless.

    end
    
end


function CustomHUD_Fox.Loader:RequestUniqueID()
    net.Start("CustomHUD_Fox.UniqueID.Request")
    net.SendToServer()

end

function CustomHUD_Fox.Loader:Net_RecieveUniqueID()
    net.Receive("CustomHUD_Fox.UniqueID.SendID", function(len, ply)
        local uniqueID = net.ReadString()

        if uniqueID == "nil" then 
            CustomHUD_Fox.Loader.UniqueID = nil
        else
            CustomHUD_Fox.Loader.UniqueID = uniqueID
        end


        hook.Run("CustomHUD_Fox", "FinishedGettingUniqueID")
    end)
end
