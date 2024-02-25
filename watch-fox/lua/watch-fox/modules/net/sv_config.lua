WatchFox = WatchFox or {}
WatchFox.Modules = WatchFox.Modules or {}
WatchFox.Modules.Net = WatchFox.Modules.Net or {}

WatchFox.Modules.Net.Config = WatchFox.Modules.Net.Config or {}

-- Patterns to check for suspicious strings
WatchFox.Modules.Net.Config.SuspiciousStringPatterns = 
{
    "player.GetAll",
    "RunConsoleCommand",
    "BroadcastLua",
    "table.pack",
    "table.load",
    "RunString",
    "lvs_doorhandler_interact",
    "PA_Dash"
}

-- Types of checks to perform
CHECKTYPE = 
{
    MUST = 1024 * 2,
    NONE = 1024 * 8,
}

-- Actions to take on detecting a suspicious message
ONSUSPICIOUSMESSAGE = 
{
    FREEZE = 1,
    NOTIFY_INGAME = 2,
    NOTIFY_DISCORD = 3,
}

-- Default configuration for message checking
WatchFox.Modules.Net.Config.DefaultMessageCheck = 
{
    CheckType = CHECKTYPE.MUST,
    OnSuspiciousMessage = {
        ONSUSPICIOUSMESSAGE.FREEZE, 
        ONSUSPICIOUSMESSAGE.NOTIFY_INGAME, 
        ONSUSPICIOUSMESSAGE.NOTIFY_DISCORD
    }
}

-- Override checks for specific messages and punishments
WatchFox.Modules.Net.Config.MessageOverrideChecks = 
{
    ["FoxNetTest"] = 
    {
        CheckType = CHECKTYPE.NONE,
    },
    ["pac3.onclothrender"] = {
        CheckType = CHECKTYPE.MUST,
    }
}
