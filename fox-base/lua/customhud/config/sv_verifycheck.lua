------------------------------------------------------------------------
local CONFIG = {}
------------------------------------------------------------------------

-- Do you want verify check to ensure any packages added are compatiable.
CONFIG.Enabled = true

--[[
    UpdateMode:
        1) Changing the file will re-process the data on server live for verfying all the related confing in here.
        2) Nothing.

    NOTE: If you change this to 1, you will require server restart to work if it was changed to 2 during it.
]]
CONFIG.UpdatingMode = 2


------------------------------------------------------------------------
---------------------------- BUG AVOIDER -------------------------------
------------------------------------------------------------------------

--[[
    return (number value)
    1) Enable if ONLY fully working.
    2) Enable if ONLY WARNING of potential issues.

    Not returning a valid input above will put it as 1 by default.
    
    If you want enable in all cases just disable this feature.

    -- This feature only works from data collection on past results from online, it doesn't test. It will do that regardless, 
    The point of this is for more stopping warnings and suggest what to update to.

    -- self in this context is curModuleName table of data.

]]
function CONFIG:LevelOAcceptance(curModuleName)
    
end



------------------------------------------------------------------------
---------------------------- NEW UPDATES -------------------------------
------------------------------------------------------------------------

CONFIG.NotifyOfNewUpdates = true 


--[[
    1) Server console only
    2) When a superadmin joins
    3) Specific conditions when a player joins and puts in their chat when loaded. (WILL USE FUNCTION IN CONFIG function LevelOfNotifyFunc())
]]
CONFIG.LevelOfNotifying = 1



--[[
    If LevelOfNotifying == 3 then uses this.

    If function doesn't return anything or return's nil, it will notify no one. 

    return 2 -- returns notifications for new updates and packages that uses others for more features.

    return 1 -- only returns notifications for new updates.

    return 0 -- Nothing.
]]
function CONFIG:LevelOfNotifyFunc(ply)
    if ply:GetUserGroup("superadmin") then
        return 2
    elseif ply:GetUserGroup("admin") then
        return 1
    else
        return 0
    end

end

--[[
    SERVER ONLY 

    if return nil it returns false.

    Output:
        1) Should it run the code without GUI loading.

    Note: self in this context will be data table of the curModuleName (arg).
]]
function CONFIG:ShouldModuleLoadWithoutGUI(curModuleName)
    return false
end



------------------------------------------------------------------------
return CONFIG
------------------------------------------------------------------------
