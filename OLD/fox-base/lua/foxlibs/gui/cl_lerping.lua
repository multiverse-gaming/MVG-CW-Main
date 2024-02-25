--------------------------------------------------------------------------------------------------------------------
FoxLibs = FoxLibs or {}
FoxLibs.GUI = FoxLibs.GUI or {}
FoxLibs.GUI.Lerping = FoxLibs.GUI.Lerping or {}

math.max = math.max 
math.abs = math.abs
--------------------------------------------------------------------------------------------------------------------


--[[
    WID: Initalizes on an object the points to use, and creates structure over that.

    Arguments:
    object (Object, PANEL)
    IDType (number) | The type of lerping you want.
        - 1 | Static, changing values doesnt matter between it.
        - 2 | Dynamic, changing any values betweeen it matters.
    Animation_Time (number) | How many seconds you want the animation time to be. Can even be 0, but why you using lerping.
    DelayAmount (number) | Can be 0, how long till you want it to trigger.

    WhatPoints (Array, IDs related to object.Points) | what points matter to lerp. | All or specific, please give in Array of Ids if specific.

    WhatPointsToCheck (Array, IDs related to object.Points) | These will be checked each time to still lerp.


    TO AVOID CONFUSION: Lerping_Points are the points that the normal points are going to!

    What It Creates on object:
        - IDType (Number)
        - Animation_Time (Number)
        - DelayAmount (Number)

        - CurrentTimeSinceLastLerp (Number)


        - Lerping_Points (Array of elements with dimensions 1,2, or 3) | THIS ISNT VALIDATED, just assumed.




]]
function FoxLibs.GUI.Lerping:Init(object, IDType, Animation_Time, DelayAmount, WhatPoints, WhatPointsToCheck) 

    do -- Verifying before starting to initate it.
        local points = object.Points

        do -- Check object is valid and points exist.
            if object == nil then
                Error("[FoxLibs.GUI] Arg #1 No object provided")  
            end
    
            if points == nil then
                Error("[FoxLibs.GUI] No Table containing points exists!")  
            elseif points == {} then
                Error("[FoxLibs.GUI] Table Exists but contains no points")  
            end
        end
    
        local Lerping_Points = object.Lerping_Points
    
        do -- Check object is not already initatied.
            if Lerping_Points ~= nil then
                Error("[FoxLibs.GUI] Table Exists, this object has already been initated")  
            end
        end    
    end

    do -- Set IDType
        if IDType == 1 or IDType == 2 then
            object.IDType = IDType
        else
            Error("[FoxLibs.GUI] Lerping Init, has no valid IDType")
        end
    end

    do -- Set AnimationTime
        if isnumber(Animation_Time) then
            object.Animation_Time = Animation_Time
        else
            Error("[FoxLibs.GUI] Animation Time doesn't exist.")
        end
    end

    do -- Set DelayTime
        if isnumber(DelayAmount) then
            object.DelayAmount = DelayAmount
        else
            Error("[FoxLibs.GUI] Invalid Delay Amount must be number and greater or equal to 0")
        end
    end

    do -- To find what points to use Lerping_Points
        object.Lerping_Points = {}


        if WhatPoints == "All" then
            object.Lerping_Points = table.Copy(object.Points)

        elseif istable(WhatPoints) then

            for i,v in pairs(WhatPoints) do
                object.Lerping_Points[v] = table.Copy(object.Points[v])
            end
        else
            Error("[FoxLibs.GUI] Invalid Format, for WhatPoints")
        end
    end

    do -- CurrentTimeSinceLastLerp
        object.CurrentTimeSinceLastLerp = SysTime()
    end

end

--[[
    WID: Checks size of points. As in the dimension.

    Returns: Dimension Size
]]
function FoxLibs.GUI.Lerping:GetDimensionSize(object, id)
    local currentPoint = object.Points[id or 1]

    do
        local dimensionSize = #currentPoint

        if dimensionSize == 1 or dimensionSize == 2 or dimensionSize == 3 then
            return dimensionSize
        else
            Error("Invalid Dimension Size.")
        end
    end

end



--[[
    WID: Main Lerping Function.

    Arguments: 
    object (Object, Panel)
    formalVerify (bool, optional) | To check if the object IDType is valid. 

]]
function FoxLibs.GUI.Lerping:LerpProcessFunction(object, formalVerify)
    if formalVerify == true then
        if object.IDType ~= 1 or object.IDType ~= 2 then
            Error("[FoxLibs.GUI] Failed to gather IDType, invalid range or not the right input.")
        end
    end


    local currentStage = FoxLibs.GUI.Lerping:WhatStageOfLerping(object)

    if currentStage ~= 2 then return end -- No point carrying on. As no animation is needed.


    FoxLibs.GUI.Lerping:LerpingMainFunction(object)

end

do -- Internal use for LerpProcessFunction

    --[[
            WID: [INTERNAL] For LerpProcessFunction | Used to check what condition it's at.
            
            stageLerpingCondition


            1 | Object is being delayed before animation

            2 | Object is animating.

            3 | object is not moving.

    ]]
    function FoxLibs.GUI.Lerping:WhatStageOfLerping(object)
        local stageLerpingCondition
        
        do -- Check it isnt lerping still for both of them.

            if ((object.CurrentTimeSinceLastLerp + object.DelayAmount) >= SysTime()) and (SysTime() >= object.CurrentTimeSinceLastLerp) then
                -- This is completed now.
                stageLerpingCondition = 1

            elseif object.CurrentTimeSinceLastLerp + object.DelayAmount + object.Animation_Time >= SysTime() and object.IDType == 2 then
                stageLerpingCondition = 2

            else
                stageLerpingCondition = 3
            end
        end

        return stageLerpingCondition
    end

    --[[
        WID: Used to update a point position and verify last point. | IMPORTANT: USE THIS WHEN UPDATING POINTS.
    ]]
    function FoxLibs.GUI.Lerping:UpdatePointPosition(object, id, dimension, value)
        if object.IDType == 2 then
            if object.Lerping_Points[id][dimension] ~= value then
                object.Lerping_Points[id][dimension] = value
                object.CurrentTimeSinceLastLerp = SysTime()


                if Debug_Fox then
                    print("[FoxLibs.GUI.Lerping] Value Changed.")
                end
            else
                -- Already same value
            end
        elseif object.IDType == 1 then
            object.Lerping_Points[id][dimension] = value
        else
            ErrorNoHalt("[FoxLibs.GUI] IDType is invalid format.")
        end
    end

end


--[[
    WID: [INTERAL] Used for LerpProcessFunction, use to update Point to lerping point position.
]]
function FoxLibs.GUI.Lerping:LerpingMainFunction(object)
    
    local animationTime, lerpingCurrentTimeLeft = object.Animation_Time, object.CurrentTimeSinceLastLerp + object.DelayAmount

    for index, value in pairs(object.Lerping_Points) do
        
        for k, t in pairs (value) do

            object.Points[index][k] = Lerp(((SysTime() - (lerpingCurrentTimeLeft))/animationTime), object.Points[index][k], object.Lerping_Points[index][k])

        end

    end


end

