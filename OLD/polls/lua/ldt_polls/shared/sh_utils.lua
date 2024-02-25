-- Create maximum number of chars for the title and description
LDT_Polls.Config.MaxNumOfCharsTitle = 50
LDT_Polls.Config.MaxNumOfCharsDesc = 200

LDT_Polls.PollTypes = {"Running","Finished","Your"}

-- Returns the correct User Group
function LDT_Polls.GetPlayerGroup(ply)
    if SG then
        return ply:GetSecondaryUserGroup() or ply:GetUserGroup()
    else
        return ply:GetUserGroup()
    end
end

-- Formats the reward value to the appropriate RewardFramework
function LDT_Polls.PollsRewardFormater(value)
    if LDT_Polls.Config.RewardFramework == "DarkRP" then
        return DarkRP.formatMoney(value)
    elseif LDT_Polls.Config.RewardFramework == "NS" then
        return "$"..value
    elseif LDT_Polls.Config.RewardFramework == "PS1" or LDT_Polls.Config.RewardFramework == "PS2" then
        return value.." Points"
    end
end

function LDT_Polls.GetLanguange(id)
    return LDT_Polls.Language[LDT_Polls.Config.Language][id]
end