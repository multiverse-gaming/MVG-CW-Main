local CAT = "Comms"



RDV.LIBRARY.AddConfigOption("COMMS_conSounds", { 

    TYPE = RDV.LIBRARY.TYPE.BL, 

    CATEGORY = CAT, 

    DESCRIPTION = "Console Sounds Enabled", 

    DEFAULT = true,

    SECTION = "Console",

})



RDV.LIBRARY.AddConfigOption("COMMS_conModel", { 

    TYPE = RDV.LIBRARY.TYPE.ST, 

    CATEGORY = CAT, 

    DESCRIPTION = "Console Model", 

    DEFAULT = "models/lordtrilobite/starwars/isd/imp_console_medium03.mdl",

    SECTION = "Console",

})





RDV.LIBRARY.AddConfigOption("COMMS_conHealthEn", { 

    TYPE = RDV.LIBRARY.TYPE.BL, 

    CATEGORY = CAT, 

    DESCRIPTION = "Console Health Enabled", 

    DEFAULT = false,

    SECTION = "Console",

})



RDV.LIBRARY.AddConfigOption("COMMS_conHealth", {

    TYPE = RDV.LIBRARY.TYPE.NM,

    CATEGORY = CAT,

    DESCRIPTION = "Console Health",

    DEFAULT = 500,

    MIN = 1, 

    MAX = 10000, 

    SECTION = "Console",

})



--[[---------------------------------]]--

--  HUD

--[[---------------------------------]]--



RDV.LIBRARY.AddConfigOption("COMMS_hudLocation", {

    TYPE = RDV.LIBRARY.TYPE.BL, 

    CATEGORY = CAT, 

    DESCRIPTION = "HUD Location (DIS - Left, ENA = Right).", 

    DEFAULT = false, 

    SECTION = "HUD",

})



RDV.LIBRARY.AddConfigOption("COMMS_overheadColor", {

    TYPE = RDV.LIBRARY.TYPE.CO,

    CATEGORY = CAT,

    DESCRIPTION = "Overhead Color",

    DEFAULT = Color(30,150,220),

    SECTION = "HUD",

})



--[[---------------------------------]]--

--  Prefix

--[[---------------------------------]]--



RDV.LIBRARY.AddConfigOption("COMMS_prefix", { 

    TYPE = RDV.LIBRARY.TYPE.ST, 

    CATEGORY = CAT, 

    DESCRIPTION = "Prefix Text", 

    DEFAULT = "COMMS",

    SECTION = "Prefix",

})



RDV.LIBRARY.AddConfigOption("COMMS_prefixColor", {

    TYPE = RDV.LIBRARY.TYPE.CO,

    CATEGORY = CAT,

    DESCRIPTION = "Prefix Color",

    DEFAULT = Color(255,0,0),

    SECTION = "Prefix",

})



--[[---------------------------------]]--

--  Binds

--[[---------------------------------]]--



RDV.LIBRARY.AddConfigOption("COMMS_menuCommand", {

    TYPE = RDV.LIBRARY.TYPE.ST, 

    CATEGORY = CAT, 

    DESCRIPTION = "Config Menu Command.", 

    DEFAULT = "!rconfig", 

    SECTION = "Chat Binds",

})



RDV.LIBRARY.AddConfigOption("COMMS_chatCommand", {

    TYPE = RDV.LIBRARY.TYPE.ST, 

    CATEGORY = CAT, 

    DESCRIPTION = "Group Chat Command.", 

    DEFAULT = "/rcomms", 

    SECTION = "Chat Binds",

})



--[[---------------------------------]]--

--  Speak Bind

--[[---------------------------------]]--



RDV.LIBRARY.AddConfigOption("COMMS_speakBindEnabled", {

    TYPE = RDV.LIBRARY.TYPE.BL, 

    CATEGORY = CAT, 

    DESCRIPTION = "Custom Speak Bind Enabled.", 

    DEFAULT = false, 

    SECTION = "Speak Binds",

})



RDV.LIBRARY.AddConfigOption("COMMS_speakBind", {

    TYPE = RDV.LIBRARY.TYPE.BN, 

    CATEGORY = CAT, 

    DESCRIPTION = "Custom Speak Bind", 

    DEFAULT = KEY_G, 

    SECTION = "Speak Binds",

})



--[[---------------------------------]]--

--  Settings

--[[---------------------------------]]--



RDV.LIBRARY.AddConfigOption("COMMS_haloEnabled", {

    TYPE = RDV.LIBRARY.TYPE.BL, 

    CATEGORY = CAT, 

    DESCRIPTION = "Group Member Halos.", 

    DEFAULT = false, 

    SECTION = "Options",

})



RDV.LIBRARY.AddConfigOption("COMMS_startMuted", {

    TYPE = RDV.LIBRARY.TYPE.BL, 

    CATEGORY = CAT, 

    DESCRIPTION = "Start Muted.", 

    DEFAULT = false, 

    SECTION = "Options",

})



--[[---------------------------------]]--

--  Default Channel

--[[---------------------------------]]--



RDV.LIBRARY.AddConfigOption("COMMS_defaultChannelEn", {

    TYPE = RDV.LIBRARY.TYPE.BL, 

    CATEGORY = CAT, 

    DESCRIPTION = "Default Channel Enabled.", 

    DEFAULT = false, 

    SECTION = "Default Channel",

})



--[[---------------------------------]]--

--  Passive Channels

--[[---------------------------------]]--



RDV.LIBRARY.AddConfigOption("COMMS_passiveChannelCount", { 

    TYPE = RDV.LIBRARY.TYPE.NM, 

    CATEGORY = CAT, 

    DESCRIPTION = "Allowed Passive Channel Count", 

    DEFAULT = 2,

    MIN = 0,

    MAX = 10,

    SECTION = "Passive Channels",

})



local function EditConfig()    

    local TAB = RDV.COMMUNICATIONS.LIST

    local CFG = {}



    local FIRST = false

    for k, v in pairs(TAB) do

        table.insert(CFG, k)



        FIRST = k

    end



    RDV.LIBRARY.AddConfigOption("COMMS_defaultChannel", { 

        TYPE = RDV.LIBRARY.TYPE.SE, 

        CATEGORY = CAT, 

        DESCRIPTION = "Default Channel", 

        LIST = CFG,

        SECTION = "Default Channel",

        DEFAULT = FIRST,

    })

end

hook.Add("RDV_COMMS_ChannelCreated", "RDV_DEFAULTCHANNEL_ADD", EditConfig)

hook.Add("RDV_COMMS_Loaded", "RDV_DEFAULTCHANNEL_ADD", EditConfig)

