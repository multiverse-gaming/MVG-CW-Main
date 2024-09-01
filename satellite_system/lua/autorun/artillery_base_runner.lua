

if (SERVER) then
    game.AddParticles("particles/doi_explosions_smoke.pcf")
    game.AddParticles("particles/doi_explosion_fx_new.pcf")
    PrecacheParticleSystem("doi_artillery_explosion")
    PrecacheParticleSystem("doi_smoke_artillery")
    resource.AddFile("resource/fonts/UbuntuMono-Regular.ttf")
    util.AddNetworkString("kaito_net_sound_new_art_he")
    util.AddNetworkString("kaito_net_sound_new_art_se")
    util.AddNetworkString("kaito_net_sound_new_art_uhe")
    util.AddNetworkString("kaito_net_sound_new_art_basefire")
    util.AddNetworkString("kaito_net_sound_new_mortar_basefire")
    util.AddNetworkString("kaito_net_art_sendfiremission")
    
    if not ConVarExists("kshellwaitingtime") then
        CreateConVar("kshellwaitingtime", 10, 0, "Waiting time before shells strike")
    end

    if not ConVarExists("kplayartdistantsound") then
        CreateConVar("kplayartdistantsound", 1, 0, "Play or not the art distant firing sound")
    end

    if not ConVarExists("k_art_he_damage") then
        CreateConVar("k_art_he_damage", 400, 0, "Sets the artillery HE damage")
    end

    if not ConVarExists("k_art_he_splash_radius") then
        CreateConVar("k_art_he_splash_radius", 1100, 0, "Sets the artillery HE Splash Radius")
    end

    if not ConVarExists("k_art_radialstrike_value") then
        CreateConVar("k_art_radialstrike_value", "10", 0, "Number of strikes in radial strike")
    end

    if not ConVarExists("k_art_volleystrike_value") then
        CreateConVar("k_art_volleystrike_value", "5", 0, "Number of strikes in volley strike")
    end

end 

hook.Add( "AddToolMenuCategories", "KaitoCustomArtCategory", function()
	spawnmenu.AddToolCategory( "Options", "KaitoArtyOptions", "#Artillery Addon Options" )
end )

hook.Add( "PopulateToolMenu", "KaitoCustomMenu", function()
	spawnmenu.AddToolMenuOption( "Options", "KaitoArtyOptions", "KSArty_Menu", "#Server Options", "", "", function( panel )
		panel:ClearControls()
        panel:NumSlider("Time before impact", "kshellwaitingtime", 5, 60, 0)
        panel:CheckBox("Play distant firing sound", "kplayartdistantsound")
        panel:NumSlider("HE Shell Damage", "k_art_he_damage", 300, 1500, 0)
        panel:NumSlider("HE Splash Radius", "k_art_he_splash_radius", 750, 2100, 0)
        panel:NumSlider("Shells in Radial Strike", "k_art_radialstrike_value", 10, 30, 0)    
        panel:NumSlider("Shells in Volley Strike", "k_art_volleystrike_value", 5, 10, 0)    
	end )

    spawnmenu.AddToolMenuOption( "Options", "KaitoArtyOptions", "KCArty_Menu", "#Client Settings", "", "", function( panel )
		panel:ClearControls()
        panel:CheckBox("Enable Shellshock (recommended)", "k_artcl_enable_shelllshock")
        panel:CheckBox("Enable Bino's Base HUD", "k_artcl_enable_binobasehud")
        panel:CheckBox("Enable Bino's Sci-Fi HUD", "k_artcl_enable_binoscifihud")
        panel:CheckBox("Enable Artillery Tool Sounds", "k_artcl_enable_sounds")
    end )
end )
    
if (CLIENT) then
    if not ConVarExists("k_artcl_enable_shelllshock") then
        CreateClientConVar("k_artcl_enable_shelllshock", 1, true, false, "Enable or not Shellshock")
    end

    if not ConVarExists("k_artcl_enable_binobasehud") then
        CreateClientConVar("k_artcl_enable_binobasehud", 1, true, false, "Enable Bino's Base HUD")
    end

    if not ConVarExists("k_artcl_enable_binoscifihud") then
        CreateClientConVar("k_artcl_enable_binoscifihud", 1, true, false, "Enable Bino's Sci-Fi HUD")
    end

    if not ConVarExists("k_artcl_enable_sounds") then
        CreateClientConVar("k_artcl_enable_sounds", 1, true, false, "Enable Bino's Sci-Fi HUD")
    end

    game.AddParticles("particles/doi_explosions_smoke.pcf")
    game.AddParticles("particles/doi_explosion_fx_new.pcf") 
end