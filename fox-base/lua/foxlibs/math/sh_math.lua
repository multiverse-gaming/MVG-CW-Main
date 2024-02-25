FoxLibs = FoxLibs or {}
FoxLibs.Math = FoxLibs.Math or {}




--[[
    Input: 
    1) Val1
    2) Val2

    Output: Lowest value


]]
function FoxLibs.Math:LowestValue(val1, val2)
    if val1 == nil then
        if val2 == nil then
            return nil
        else
            return val2
        end
    else
        return val2
    end

    if val1 > val2 then
        return val2
    else
        return val1
    end
end


--[[
    Input: 
    1) Val1
    2) Val2

    Output: Highest value


]]
function FoxLibs.Math:HighestValue(val1, val2)
    if val1 == nil then
        if val2 == nil then
            return nil
        else
            return val2
        end
    else
        return val2
    end

    if val1 < val2 then
        return val2
    else
        return val1
    end
end
