--------------------------------------------------------------------------------------------------------------------
FoxLibs = FoxLibs or {}
FoxLibs.Table = FoxLibs.Table or {}
--------------------------------------------------------------------------------------------------------------------

local internal = internal or {}
--[[
    Don't use on userdata.
]]
function FoxLibs.Table.Copy(obj, byRef)
    if byRef == true then
        return obj
    else
        return table.Copy(obj)
        -- Save copied tables in `copies`, indexed by original table.
         
    end
end


function FoxLibs.Table.DeepCopy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[FoxLibs.Table.DeepCopy(k, s)] = FoxLibs.Table.DeepCopy(v, s) end
    return res

end

--[[
    Converts Table into string format.


    -- Useful for debugging info, into console form to see table. But just printtable?
]]
function FoxLibs.Table.ToStringFormat(tbl)
    if type(tbl) == 'table' then
       local s = '{ '
       for k,v in pairs(tbl) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' ..  FoxLibs.Table.ToStringFormat(v) .. ','
       end
       return s .. '} '
    else
       return tostring(tbl)
    end
 end





if true then return end -- The functions below are too excessive.

FoxLibs.Table.InteractTableWithString = FoxLibs.Table.InteractTableWithString or {}


--[[
    Input:
        tbl to look through
        strPath | The path to go through

    Output
        1) Did issues happen (bool)
        2) Is "KEY" or "VALUE" for path

]]
function FoxLibs.Table.InteractTableWithString:IsValidPath(tbl, strPath)

        local code = [[
            local succ, err = pcall(function()
            
                local tbl = ]] ..  FoxLibs.Table.ToStringFormat(tbl) .. [[

                local test = tbl.]].. strPath ..[[

            end)
            

            if succ then
                return true
            else
                return false
            end
            ]]
        
            
        local output = CompileString(code, nil, false)


        if isfunction(output) then
            return output()

            

        elseif isstring(output) then -- It's an error.
            return false
        end

        print("[INTERNAL][VFS][ISVALID] Not sure how go to here.") -- TODO: IF ACCOURS REPORT.

end





    --[[
        PURPOSE:

        INPUT:
        tbl (Table) | This is the table to manipulate to set a value in it. 
        strPath (string) | The path to go to.


        OUTPUT:
        (bool) Issues happened
          
    ]]
function FoxLibs.Table.InteractTableWithString:SetValue(tbl, strPath, value)
    
    do -- Checking IsValidPath is fine.
        local strPathForIsValid = "" -- Used to double check is valid location to place value.

        local seperate = string.Split(strPath, ".")

        if istable(seperate) and #seperate > 0 then
            seperate[#seperate + 1] = nil -- Remove last value.

            for i,v in pairs(seperate) do
                strPathForIsValid = strPathForIsValid .. v .. "." 
            end

            strPathForIsValid = string.Left(strPathForIsValid, (#strPathForIsValid - 1))

        end


        if not FoxLibs.Table.InteractTableWithString:IsValidPath(tbl, strPath) then -- Double Checks valid location
            print("[FoxLibs][Table][InteractTableWithString][SetValue] Invalid Location to set value")
    
            return true -- TODO: 
        end

    end


    local code = [[
            local value = ]] .. value .. [[ or ""
            
            
            local tbl = ]] ..  FoxLibs.Table.ToStringFormat(tbl) .. [[

            tbl.]] .. strPath .. [[ = ]] .. [[value
            return tbl
            ]]

    local output = CompileString(code, nil, false)

    

    if isfunction(output) then
        local value = output()
        
        if value ~= nil then
            tbl = value
            

            return false
        else
            return true
        end

    else -- it's an error, most likely string format.

        return true
    end

end


