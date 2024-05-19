local MODULE = GAS.Logging:MODULE()

MODULE.Category = "WiltOS"
MODULE.Name		= "Kits And Hilts"
MODULE.Colour   = Color(255,90,0)

MODULE:Setup(function()
	MODULE:Hook("WILTOS.ItemUsed", "WILTOS.ItemUsed", function(playerUser, itemUsed, itemGot)
		MODULE:LogPhrase("wiltosLog",
		GAS.Logging:FormatPlayer(playerUser),
		GAS.Logging:Highlight(itemUsed),
		GAS.Logging:Highlight(itemGot))
	end)
end)

GAS.Logging:AddModule(MODULE)