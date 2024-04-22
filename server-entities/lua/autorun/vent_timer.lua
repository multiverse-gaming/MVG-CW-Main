local MAX_TIMER = 900
local TIMER_INCREMENT = 300 

local function StartVentTimer(ventEntity)
    if not ventEntity or not IsValid(ventEntity) then return end
    
    if not ventEntity.TimerID then
        ventEntity.TimerID = "VentTimer_" .. ventEntity:EntIndex()
        ventEntity.TimerValue = 300
        timer.Create(ventEntity.TimerID, 1, 0, function()
            ventEntity.TimerValue = ventEntity.TimerValue - 1
            if ventEntity.TimerValue <= 0 then
                timer.Remove(ventEntity.TimerID)
                ventEntity.TimerID = nil
            end
        end)
    end
end

local function AddTimeToVentTimer(ventEntity)
    if not ventEntity or not IsValid(ventEntity) or not ventEntity.TimerID then return end
    
    ventEntity.TimerValue = math.min(ventEntity.TimerValue + TIMER_INCREMENT, MAX_TIMER)
end

hook.Add("MoondustCrateTouchVent", "StartOrAddTimeToVentTimer", function(crateEntity, ventEntity)   
    if not ventEntity.TimerID then
        StartVentTimer(ventEntity)
    else
        AddTimeToVentTimer(ventEntity)
    end
end)