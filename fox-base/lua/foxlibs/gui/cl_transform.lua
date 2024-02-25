--------------------------------------------------------------------------------------------------------------------
FoxLibs = FoxLibs or {}
FoxLibs.GUI = FoxLibs.GUI or {}
FoxLibs.GUI.Transform = FoxLibs.GUI.Transform or {}

--------------------------------------------------------------------------------------------------------------------

-- Can be used to also reset.
function FoxLibs.GUI.Transform:Init(object, allowTransformations, allowRotations, saveTransformations)
    if allowTransformations then
        object.FlippedVerticle = false
        object.FlippedHorzitonal = false
    end

    if allowRotations then
        object.RotationAngle = 0
    end

    if saveTransformations then
        -- TODO: DO THIS AT SOME POINT!!!
    end
end



--[[
    WHAT IT DOES:
    Resets all transformations produced with it.

    PRECAUTIONS: YOU CAN'T REFLECT -> ROTATE, then use this as that's not how maths works!
]]
function FoxLibs.GUI.Transform:Reset(object, isPanel, type)
    if isPanel == true or isPanel == nil then
        if object.FlippedVerticle == true then
            FoxLibs.GUI.Transform:Reflect(object, true, "V")
        end
    
        if object.FlippedHorzitonal == true then
            FoxLibs.GUI.Transform:Reflect(object, true, "H")
        end
    elseif isPanel == false then
        ErrorNoHalt("Doesn't do anything right now") -- TODO : COMPLETE THIS
    else
        Error("#2 Arg: isPanel not provided. Not sure what to use.")
    end

end



function FoxLibs.GUI.Transform:Reflect(object, isPanel, HoriztonalOrVerticle)
    if isPanel == true or isPanel == nil then
        local width, height = object:GetSize()
        local center_width, center_height = width/2, height/2

        if HoriztonalOrVerticle == "H" then
            do
                for i, v in pairs (object.Points) do
                    local displacement = center_height - v.y
                    v.y = (v.y) + 2 * displacement
                end

                
                if object.FlippedHorzitonal == false then
                    object.FlippedHorzitonal = true
                else
                    object.FlippedHorzitonal = false
                end
            end

        elseif HoriztonalOrVerticle == "V" then
            do
                for i, v in pairs (object.Points) do
                    local displacement = center_width - v.x 
                    v.x = (v.x) + 2 * displacement
                end

                if object.FlippedVerticle == false then
                    object.FlippedVerticle = true
                else
                    object.FlippedVerticle = false
                end
            end

        else
            ErrorNoHalt("#Arg3 HoriztonalOrVerticle not valid, has to be H or V in string form")
        end




    elseif isPanel == false then
        ErrorNoHalt("Doesn't do anything right now") -- TODO : COMPLETE THIS
    else
        Error("#2 Arg: isPanel not provided. Not sure what to use.")
    end
end


--[[
    WHAT IT DOES:
    Reflects horiztonally all of relative object given or if force given a table will use that instead -- TODO ADD THAT?
]]


-- DO I EVEN NEEDS THESE RIGHT NOW?
if true then return end -- TODO: EITHER REMOVE BELOW OR ADD

function FoxLibs.GUI.Transform:Rotate(object, degrees)
    if isPanel == true then
        local width, height = object:GetSize()
        local center_width, center_height = width/2, height/2

        
        object.RotationAngle = degrees 
    elseif isPanel == false then
        ErrorNoHalt("Doesn't do anything right now") -- TODO : COMPLETE THIS
    else
        Error("#2 Arg: isPanel not provided. Not sure what to use.")
    end
end

function FoxLibs.GUI:ResetRotate(object, degrees)
    if isPanel == true then
        local width, height = object:GetSize()
        local center_width, center_height = width/2, height/2

        
        object.RotationAngle = 0 -- Gotta be 0 ofc 
    elseif isPanel == false then
        ErrorNoHalt("Doesn't do anything right now") -- TODO : COMPLETE THIS
    else
        Error("#2 Arg: isPanel not provided. Not sure what to use.")
    end
end