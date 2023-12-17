-- This function returns current interval.
function LDT_Polls.GetInterval()
    local interval = "0"
    if string.lower(LDT_Polls.Config.StatisticsInterval) == "1m" then
        interval = "1 month"
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "3m" then 
        interval = "3 month"
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "6m" then 
        interval = "6 month"
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "1y" then 
        interval = "1 year"
    elseif string.lower(LDT_Polls.Config.StatisticsInterval) == "all" then 
        interval = "all"
    end

    return interval
end