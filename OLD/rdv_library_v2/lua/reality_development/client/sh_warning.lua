hook.Add("RDV_LIB_RegisterConfigOptions", "RDV.LIBRARY.CHARACTERS", function()
    RDV.LIBRARY.AddConfigOption("LIB_warnEnabled", {
        TYPE = RDV.LIBRARY.TYPE.BL,
        DEFAULT = true,
        CATEGORY = "[RDV] Library", 
        DESCRIPTION = "Should the RDV Library warning be sent to Admins?", 
        SECTION = "Other",
    })
end)