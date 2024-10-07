local CAT = "Skills"

RDV.LIBRARY.AddConfigOption("SAL_prefix", { 
    TYPE = RDV.LIBRARY.TYPE.ST, 
    CATEGORY = CAT, 
    DESCRIPTION = "Prefix Text", 
    DEFAULT = "SAL",
    SECTION = "Prefix",
})

RDV.LIBRARY.AddConfigOption("SAL_prefixColor", {
    TYPE = RDV.LIBRARY.TYPE.CO,
    CATEGORY = CAT,
    DESCRIPTION = "Prefix Color",
    DEFAULT = Color(255,0,0),
    SECTION = "Prefix",
})

RDV.LIBRARY.AddConfigOption("SAL_homeIcon", {
    TYPE = RDV.LIBRARY.TYPE.ST,
    CATEGORY = CAT,
    DESCRIPTION = "Home Tab Icon",
    DEFAULT = "nmFCQci",
    SECTION = "Icons",
})

RDV.LIBRARY.AddConfigOption("SAL_skillsIcon", {
    TYPE = RDV.LIBRARY.TYPE.ST, 
    CATEGORY = CAT, 
    DESCRIPTION = "Skills Tab Icon", 
    DEFAULT = "mgrQKc0", 
    SECTION = "Icons",
})

RDV.LIBRARY.AddConfigOption("SAL_adminIcon", {
    TYPE = RDV.LIBRARY.TYPE.ST, 
    CATEGORY = CAT, 
    DESCRIPTION = "Admin Tab Icon", 
    DEFAULT = "NqwTCVZ", 
    SECTION = "Icons",
})

RDV.LIBRARY.AddConfigOption("SAL_svDelay", {
    TYPE = RDV.LIBRARY.TYPE.NM, 
    CATEGORY = CAT, 
    DESCRIPTION = "Save Delay", 
    DEFAULT = 300, 
    MIN = 30, 
    MAX = 1000, 
    SECTION = "Customization",
})

RDV.LIBRARY.AddConfigOption("SAL_notifEnabled", {
    TYPE = RDV.LIBRARY.TYPE.BL,
    CATEGORY = CAT,
    DESCRIPTION = "Notifications Enabled",
    DEFAULT = true,
    SECTION = "Customization",
})

RDV.LIBRARY.AddConfigOption("SAL_leaderboardEnabled", { 
    TYPE = RDV.LIBRARY.TYPE.BL, 
    CATEGORY = CAT, 
    DESCRIPTION = "Leaderboard Enabled", 
    DEFAULT = true, 
    SECTION = "Leaderboard", 
})

RDV.LIBRARY.AddConfigOption("SAL_ldbLimit", {
    TYPE = RDV.LIBRARY.TYPE.NM, 
    CATEGORY = CAT, 
    DESCRIPTION = "Leaderboard Limit", 
    DEFAULT = 3, 
    MIN = 1, 
    MAX = 10, 
    SECTION = "Leaderboard",
})

RDV.LIBRARY.AddConfigOption("SAL_hudEnabled", {
    TYPE = RDV.LIBRARY.TYPE.BL,
    CATEGORY = CAT,
    DESCRIPTION = "HUD Enabled",
    DEFAULT = true,
    SECTION = "HUD",
})

RDV.LIBRARY.AddConfigOption("SAL_Adjusth", {
    TYPE = RDV.LIBRARY.TYPE.NM,
    CATEGORY = CAT,
    DESCRIPTION = "HUD Height Adjust",
    DEFAULT = 0,
    MIN = -1, 
    MAX = 1, 
    DECIMALS = 1, 
    SECTION = "HUD",
})

RDV.LIBRARY.AddConfigOption("SAL_Adjustw", {
    TYPE = RDV.LIBRARY.TYPE.NM,
    CATEGORY = CAT,
    DESCRIPTION = "HUD Width Adjust",
    DEFAULT = 0, 
    MIN = -1, 
    MAX = 1,
    DECIMALS = 1, 
    SECTION = "HUD",
})

RDV.LIBRARY.AddConfigOption("SAL_purchaseEnabled", {
    TYPE = RDV.LIBRARY.TYPE.BL, 
    CATEGORY = CAT, 
    DESCRIPTION = "Skillpoint Purchase Enabled",
    DEFAULT = true, 
    SECTION = "Skillpoint Purchase",
})

RDV.LIBRARY.AddConfigOption("SAL_skillPrice", {
    TYPE = RDV.LIBRARY.TYPE.NM, 
    CATEGORY = CAT, 
    DESCRIPTION = "Skill Price", 
    DEFAULT = 0, 
    MIN = 0, 
    MAX = 999999, 
    SECTION = "Skillpoint Purchase",
})

RDV.LIBRARY.AddConfigOption("SAL_spLevelEnabled", { 
    TYPE = RDV.LIBRARY.TYPE.BL, 
    CATEGORY = CAT, 
    DESCRIPTION = "Skillpoint Earning Enabled", 
    DEFAULT = true, 
    SECTION = "Skillpoint Earning",
})

RDV.LIBRARY.AddConfigOption("SAL_spLevel", { 
    TYPE = RDV.LIBRARY.TYPE.NM, 
    CATEGORY = CAT, 
    DESCRIPTION = "Skillpont Every (X) Levels", 
    DEFAULT = 5, 
    MIN = 1, 
    MAX = 999999, 
    SECTION = "Skillpoint Earning",
})

RDV.LIBRARY.AddConfigOption("SAL_mxlvlEnabled", { 
    TYPE = RDV.LIBRARY.TYPE.BL, 
    CATEGORY = CAT, 
    DESCRIPTION = "Max Level Enabled", 
    DEFAULT = false, 
    SECTION = "Max Level", 
})

RDV.LIBRARY.AddConfigOption("SAL_mxlvl", { 
    TYPE = RDV.LIBRARY.TYPE.NM, 
    CATEGORY = CAT, 
    DESCRIPTION = "Max Level", 
    DEFAULT = 50, 
    MIN = 0, 
    MAX = 999999, 
    SECTION = "Max Level",
})


RDV.LIBRARY.AddConfigOption("SAL_resetEnabled", { 
    TYPE = RDV.LIBRARY.TYPE.BL, 
    CATEGORY = CAT, 
    DESCRIPTION = "Skill Reset Enabled", 
    DEFAULT = true, 
    SECTION = "Skill Reset", 
})

RDV.LIBRARY.AddConfigOption("SAL_resetPrice", { 
    TYPE = RDV.LIBRARY.TYPE.NM,
    CATEGORY = CAT, 
    DESCRIPTION = "Skills Reset Price", 
    DEFAULT = 0, 
    MIN = 0, 
    MAX = 999999,
    SECTION = "Skill Reset",
})

RDV.LIBRARY.AddConfigOption("SAL_expScale", { 
    TYPE = RDV.LIBRARY.TYPE.NM,
    CATEGORY = CAT, 
    DESCRIPTION = "Experience Scale", 
    DEFAULT = 1.28, 
    MIN = 0.1, 
    MAX = 5,
    DECIMALS = 2, 
    SECTION = "Leveling",
})

RDV.LIBRARY.AddConfigOption("SAL_startExp", { 
    TYPE = RDV.LIBRARY.TYPE.NM,
    CATEGORY = CAT, 
    DESCRIPTION = "Starting Experience", 
    DEFAULT = 5000, 
    MIN = 1000, 
    MAX = 999999,
    SECTION = "Leveling",
})

RDV.LIBRARY.AddConfigOption("SAL_expPVS", {
    TYPE = RDV.LIBRARY.TYPE.BL,
    CATEGORY = CAT,
    DESCRIPTION = "Experience PVS",
    DEFAULT = false,
    SECTION = "Experimental",
})

local function getSkillTeams()
    local localTeams = {}
    for k, v in ipairs(RPExtraTeams) do
        table.insert(localTeams, v.name)
    end
    return localTeams
end

local applicableCatagories = { "Delta Squad", "Epsilon Squad", "Bad Batch Squad", "Omega Squad", "Republic Commandos" }
local blacklistedTeam = { "RC General Kit Fisto" }
local function getRCTeams()
    local catagories = {}
    for k, v in ipairs(applicableCatagories) do
        catagories[v] = true
    end
    local applicableTeams = {}
    for teamID, teamData in pairs(RPExtraTeams) do
        if (catagories[teamData.category] && !(blacklistedTeam[blacklistedTeam])) then
            applicableTeams[teamData.name] = true
        end
    end
    return applicableTeams
end

RDV.LIBRARY.AddConfigOption("SAL_expTEAMS", {
    TYPE = RDV.LIBRARY.TYPE.SM,
    --TYPE = RDV.LIBRARY.TYPE.SE,
    CATEGORY = CAT,
    DESCRIPTION = "Team Selection",
    SECTION = "Experimental",
    LIST = getSkillTeams()
})

local T = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}

for k, v in ipairs(T) do
    RDV.LIBRARY.AddConfigOption("SAL_xpBonusEnb_"..v, {
        TYPE = RDV.LIBRARY.TYPE.BL,
        CATEGORY = CAT,
        DESCRIPTION = v.." Bonus Experience Enabled",
        DEFAULT = false,
        SECTION = v,
    })

    RDV.LIBRARY.AddConfigOption("SAL_xpBonus_"..v, { 
        TYPE = RDV.LIBRARY.TYPE.NM,
        CATEGORY = CAT, 
        DESCRIPTION = v.." Bonus Experience Gain", 
        DEFAULT = 1.5, 
        DECIMALS = 2,
        MIN = 1, 
        MAX = 5,
        SECTION = v,
    })
end