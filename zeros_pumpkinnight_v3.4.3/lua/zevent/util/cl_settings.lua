/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if not CLIENT then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 7a13433e4132f0bdd7687284099bac6a6eedd6879c87633c7282fdec0ce1b6d0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

hook.Add("AddToolMenuCategories", "zpn_CreateCategories", function()
	spawnmenu.AddToolCategory("Options", "zpn_options", "PumpkinNight")
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

hook.Add("PopulateToolMenu", "zpn_PopulateMenus", function()
	spawnmenu.AddToolMenuOption("Options", "zpn_options", "zpn_Client_Settings", "Client Settings", "", "", function(CPanel)
		zclib.Settings.OptionPanel("VFX", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Show Anti Ghost Sign Radius",
				class = "DCheckBoxLabel",
				cmd = "zpn_cl_draw_antighost"
			},
			[2] = {
				name = "Display Mask Overlay",
				class = "DCheckBoxLabel",
				cmd = "zpn_cl_mask_enabled"
			},
		})
	end)

	spawnmenu.AddToolMenuOption("Options", "zpn_options", "zpn_Admin_Settings", "Admin Settings", "", "", function(CPanel)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

		zclib.Settings.OptionPanel("LootSpawner", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zpn_save_lootspawner"
			},
			[2] = {
				name = "Remove",
				class = "DButton",
				cmd = "zpn_remove_lootspawner"
			}
		})

		zclib.Settings.OptionPanel("Ghost", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Remove All",
				class = "DButton",
				cmd = "zpn_ghost_removeall"
			}
		})

		zclib.Settings.OptionPanel("Boss", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zpn_boss_save"
			},
			[2] = {
				name = "Show Spawns",
				class = "DButton",
				cmd = "zpn_boss_showspawns"
			},
			[3] = {
				name = "Remove",
				class = "DButton",
				cmd = "zpn_boss_remove"
			}
		})

		zclib.Settings.OptionPanel("Minion", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zpn_minion_save"
			},
			[2] = {
				name = "Show Spawns",
				class = "DButton",
				cmd = "zpn_minion_showspawns"
			},
			[3] = {
				name = "Remove",
				class = "DButton",
				cmd = "zpn_minion_remove"
			}
		})

		zclib.Settings.OptionPanel("NPC", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zpn_save_npc"
			},
			[2] = {
				name = "Remove",
				class = "DButton",
				cmd = "zpn_remove_npc"
			}
		})

		zclib.Settings.OptionPanel("Anti Ghost Signs", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zpn_save_Sign"
			},
			[2] = {
				name = "Remove",
				class = "DButton",
				cmd = "zpn_remove_Sign"
			}
		})

		zclib.Settings.OptionPanel("Pumpkin spawns", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zpn_save_pumpkinspawns"
			},
			[2] = {
				name = "Remove",
				class = "DButton",
				cmd = "zpn_remove_pumpkinspawns"
			}
		})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

		zclib.Settings.OptionPanel("Scoreboard", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Save",
				class = "DButton",
				cmd = "zpn_save_scoreboard"
			},
			[2] = {
				name = "Remove",
				class = "DButton",
				cmd = "zpn_remove_scoreboard"
			}
		})

		zclib.Settings.OptionPanel("Other", nil, Color(92, 82, 130, 255), Color(71, 63, 100, 255), CPanel, {
			[1] = {
				name = "Migrate Data from MrEvent",
				class = "DButton",
				cmd = "zpn_data_migrate_from_mrevent"
			}
		})
	end)
end)
