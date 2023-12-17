hook.Add("PlayerReadyForNetworking", "RDV.LIB.WARNING", function(ply)
    timer.Simple(1, function()
        local BL = RDV.LIBRARY.GetConfigOption("LIB_warnEnabled")

        if !BL then return end

        if !PIXEL and ply:IsSuperAdmin() then
            RDV.LIBRARY.AddText(ply, Color(255,0,0), "[RDV] ", Color(255,255,255), "PixelUI is missing and you'll be unable to access the config menu.")
        elseif ply:IsSuperAdmin() then
            local CMD = RDV.LIBRARY.GetConfigOption("RDVL_menuCommand")

            RDV.LIBRARY.AddText(ply, Color(255,0,0), "[RDV] ", Color(255,255,255), "We've started moving configuration into our in-game menu, access it using your bind or rdv_menu in console.")
        end
    end)
end)
