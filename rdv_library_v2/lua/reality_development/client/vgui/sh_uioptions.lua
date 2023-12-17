hook.Add("RDV_LIB_Loaded", "RDV_LIB_UIOptions", function()
    local CAT = "Library"

    --[[
    --  Interface Sounds
    --]]

    RDV.LIBRARY.AddConfigOption("LIBRARY_clickSound", { 
        TYPE = RDV.LIBRARY.TYPE.ST, 
        CATEGORY = CAT, 
        DESCRIPTION = "Click", 
        DEFAULT = "rdv/new/activate.mp3",
        SECTION = "Interface Sounds",
    })

    RDV.LIBRARY.AddConfigOption("LIBRARY_hoverSound", { 
        TYPE = RDV.LIBRARY.TYPE.ST, 
        CATEGORY = CAT, 
        DESCRIPTION = "Hover", 
        DEFAULT = "rdv/new/slider.mp3",
        SECTION = "Interface Sounds",
    })

    --[[
    --  Interface Colors
    --]]

    RDV.LIBRARY.AddConfigOption("LIBRARY_outlineTheme", { 
        TYPE = RDV.LIBRARY.TYPE.CO, 
        CATEGORY = CAT, 
        DESCRIPTION = "Default Outline", 
        DEFAULT = Color(122,132,137, 180),
        SECTION = "Interface Theme",
    })

    RDV.LIBRARY.AddConfigOption("LIBRARY_hoverTheme", { 
        TYPE = RDV.LIBRARY.TYPE.CO, 
        CATEGORY = CAT, 
        DESCRIPTION = "Hover Outline", 
        DEFAULT = Color(252,180,9,255),
        SECTION = "Interface Theme",
    })
end)