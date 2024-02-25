Fox = Fox or {}
Fox.Defon = Fox.Defcon or {}
local internal = internal or {}

internal.CurGamemode = engine.ActiveGamemode



--[[
    Is the verify of data config exists and runs SH and SV respective to what side the script is running for (Server or Client).
    Avoiding excessive code with verification.
]]
function Fox.Defcon:SH_Init()
    local isValidConfig, cfgData = Fox.Defcon:GetConfig()

    if isValidConfig then
        internal:SetupDefcons(cfgData)
        internal:SetupWhoCanDefcon(cfgData)


        Fox.Defcon:SV_Init(cfgData)
        Fox.Defcon:CL_Init(cfgData)
        
    end

end

--[[
    Checks config for any issues inside it.

    Output: 
        1) Isvalid to use.
        2) configData (if valid to use.)
]]
function Fox.Defcon:GetConfig()
    local newData = FoxLibs.File:Include("defcon.lua", "defcon/config/")

    do -- Defcons check
        if dataConfig.Defcons ~= nil then
            if not istable(dataConfig.Defcons) then
               print("[Fox][Defcon][SetupDefcons] Expecting table of Defcons, value exist's but isnt a table.") 
               return false
            else
                for i,v in pairs(dataConfig.Defcons) do
                    if not isstring(v[1]) then
                        print("[Fox][Defcon][SetupDefcons] Argument one in each defcon should be a string, input for index [" .. i .. "] is value: " .. tostring(v)) 
                        return false
                    end
                    if not IsColor(v[2]) then
                        print("[Fox][Defcon][SetupDefcons] Argument two in each defcon should be a color, input for index [" .. i .. "] is value: " .. tostring(v)) 
                        return false
                    end
                end
            end
        else
            print("[Fox][Defcon][SetupDefcons] Defcons doesn't exist in config at all, was deleted.")
            return false
        end
    end


    
    return true, newData

end

do -- internal
    do -- Setup
        --[[
            Info: 
                WID: Set's up defcon names in a table, instead of config.
                Input: dataconfig (tbl)
                Return: Number of defcons (number), 0 if non exists.
        ]]
        function internal:SetupDefcons(dataConfig)

            Fox.Defcon.TableOfDefcons = {}
        
            if dataConfig.Defcons ~= nil then
                if istable(dataConfig.Defcons) then
                    for i,v in pairs(dataConfig.Defcons) do
                        Fox.Defcon.TableOfDefcons[i] = v[1] -- v[1] as uses first part, the name.
                    end
                else
                   print("[Fox][Defcon][SetupDefcons] Expecting table, value exist's but isnt a table.") 
                end
            else
                print("[Fox][Defcon][SetupDefcons] Defcons doesn't exist in config at all, was deleted.")
            end
        
            return #(Fox.Defcon.TableOfDefcons)
        
        end
        
        
        function internal:SetupWhoCanDefcon(newData)
        
            local curGamemode = internal.CurGamemode
        
            if curGamemode == "darkrp" then
                 
            end
        
        
        end
        
    end

end


--[[
    Input: Player (entity)
    Output: Can set defcon (bool)
    
    INFO:   
        -> If errors, it will return false.
]]
function Fox.Defcon:CanSetDefcon(ply)
    do -- Check ply arg is actually a player.
        if not ply:IsPlayer() then
            ErrorNoHalt("[Fox][Defcon][CanSetDefcon] Ply argument isn't a player entity.")
            return false
        end
    end


    local curGamemode = internal.CurGamemode

    if curGamemode == "darkrp" then
         
    end


end


