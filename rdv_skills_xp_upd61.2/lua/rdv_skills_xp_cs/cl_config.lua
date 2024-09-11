local CAT = "Skills"

RDV.LIBRARY.AddConfigOption("SAL_menuBind", {
    TYPE = RDV.LIBRARY.TYPE.BN, 
    CATEGORY = CAT, 
    DESCRIPTION = "Menu Bind", 
    DEFAULT = KEY_F5, 
    SECTION = "Binds (Client)",
    noNetwork = true,
})

RDV.LIBRARY.AddConfigOption("SAL_menuCommand", {
    TYPE = RDV.LIBRARY.TYPE.ST, 
    CATEGORY = CAT, 
    DESCRIPTION = "Menu Command.", 
    DEFAULT = "!skills", 
    SECTION = "Binds (Client)",
    noNetwork = true,
})