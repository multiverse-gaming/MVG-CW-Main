LDT_Polls = LDT_Polls or {}
LDT_Polls.Config = LDT_Polls.Config or {}

LDT_Polls.Config.MenuCommand = "polls" -- This is the command for opening the Polls menu. This string will be prepended with "!" and "/"

LDT_Polls.Config.Language = "en" -- Currently there is only en, de, fr, es and tr translations available.

LDT_Polls.Config.EnableVoteRewards = false -- This enables the option to give out rewards for voting in polls.
-- The reward amount is set when you create a new poll.

-- Which Reward Framework to use?
-- PS1 = Support of PointShop 1 Points.
-- PS2 = Support of PointShop 2 Points.
-- DarkRP = Support of DarkRP money.
-- NS = Support of NutScript money.
LDT_Polls.Config.RewardFramework = "DarkRP"

LDT_Polls.Config.EnableStatistics = true -- This enables the statistics page.

-- These are the stats intervals
-- 1M = All votes dating back 1 Month
-- 3M = All votes dating back 3 Months
-- 6M = All votes dating back 6 Months
-- 1Y = All votes dating back 1 Year
-- ALL = All votes.
LDT_Polls.Config.StatisticsInterval = "ALL"

LDT_Polls.Config.MaxNumOfPollOptions = 15 -- This is the maximum number of poll options.

LDT_Polls.Config.AdminRanks = { -- These ranks can create new polls.
    ["superadmin"] = true
}

LDT_Polls.Config.CanDeleteOwnPolls = true -- Should the poll creator be able to delete their own polls.

LDT_Polls.Config.WhoCanDeletePolls = { -- These ranks can delete anyones polls.
    ["superadmin"] = true
}

LDT_Polls.Config.UsegroupWeightsEnabled = true -- Should Usergroup weights be enabled? If they are disabled everyone will have only one vote.

LDT_Polls.Config.UsergroupWeights = { -- These are the usergroups with different vote weights.
    ["user"] = 1, -- a normal user will only have 1 vote.
    ["admin"] = 1,
    ["superadmin"] = 1, -- but superadmin will have a vote worth 10 votes.
}

-- These are the colors for every element of the UI. Feel free to change them to your liking.
LDT_Polls.Config.Red = Color(255, 63, 5)
LDT_Polls.Config.RedSecond = Color(255, 63, 5, 200)

LDT_Polls.Config.Green = Color(76, 209, 55)

LDT_Polls.Config.White = Color(255,255,255)
LDT_Polls.Config.WhiteHighlight = Color(200,200,200)
LDT_Polls.Config.WhiteSecond = Color(255,255,255,30)

LDT_Polls.Config.Grey = Color(47, 54, 64)
LDT_Polls.Config.GreySecond = Color(53, 59, 72)
LDT_Polls.Config.BlueThird = Color(38, 117, 175)
LDT_Polls.Config.BlueSecond = Color(0, 168, 255)
LDT_Polls.Config.Blue = Color(0, 151, 230)

LDT_Polls.Config.Gold = Color(251, 197, 49)
LDT_Polls.Config.Silver = Color(127, 143, 166)
LDT_Polls.Config.Bronze = Color(240, 147, 43)