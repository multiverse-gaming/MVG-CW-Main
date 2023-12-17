-----------------------------------------------------
local CONFIG
-----------------------------------------------------

--[[
    NOTE:
        - This is automatically enabled if config is enabled.
]]


--------------------------------------------------------------------------------------------------------------
-- Who can use defcon
--------------------------------------------------------------------------------------------------------------
-- Categories allowed to us OD, e.g. : CONFIG.CategoriesAllowed = {"Navy", "Generals"}
CONFIG.CategoriesAllowed = {}

-- Jobs Allowed to us OD, e.g. : CONFIG.JobsAllowed = {"Shock Commander", "Grand Admiral"}
CONFIG.JobsAllowed = {}

--------------------------------------------------------------------------------------------------------------
-- Who can SEE defcon
-- All jobs and categories can see Defcon by default if you black list it will disable for that category or job.
-- But if its whitelisted it will take priority over the blacklisted meaning you can blacklist categories but
-- Whitelist a job inside it.
--------------------------------------------------------------------------------------------------------------
CONFIG.Blacklist_Categories = {}
CONFIG.Blacklist_Jobs = {}

CONFIG.Whitelist_Categories = {}
CONFIG.Whitelist_Jobs = {}

--------------------------------------------------------------------------------------------------------------


--[[
    This will create a ulx/sam etc command that will allow you to OD someone that isn't in the correct job/category.
]]
CONFIG.CreateODCommand = false


-- If Prefix is left empty or not string, it will go back to "/"" as default.
CONFIG.Prefix = "/"


--------------------------------------------------------------------------------------------------------------
-- Defcons

-- {"NAME OF DEFCON", COLOR}
-- Top values in defcon are the lowest ones, will be the 1st by default.
--------------------------------------------------------------------------------------------------------------
CONFIG.Defcons ={
    {"5", Color(255, 255, 255, 0)},
    {"4",  Color(74,162,74, 100)},
    {"3", Color(232,210,47, 100)},
    {"2", Color(209,136,25, 100)},
    {"1", Color(133,23,23, 100)},
}


return CONFIG