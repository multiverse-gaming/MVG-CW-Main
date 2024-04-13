local MODULE = GAS.Logging:MODULE()

MODULE.Category = "WiltOS"
MODULE.Name		= "Kits And Hilts"
MODULE.Colour   = Color(255,90,0)

MODULE:Setup(function()
	MODULE:Hook("WILTOS.ItemUsed", "WILTOS.ItemUsed", function(playerUser, playerSpawner, itemUsed, itemGot)
		MODULE:LogPhrase("command_used", GAS.Logging:FormatPlayer(playerUser), itemUsed, GAS.Logging:FormatPlayer(playerSpawner), itemGot)
	end)
	
	-- How to call this function:
	-- hook.Call("WILTOS.ItemUsed", nil, playerUser, playerSpawner, itemUsed, itemGot)
end)

GAS.Logging:AddModule(MODULE)