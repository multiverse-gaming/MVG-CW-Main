xLogs.DarkRP = xLogs.DarkRP or {}

--[[

	Police

]]--

function xLogs.DarkRP.LogArrest(target, tim, ply)
	xLogs.RunLog("Police", xLogs.GetLanguageString("arrested"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(target), tim)
end

function xLogs.DarkRP.LogRelease(target, ply)
	xLogs.RunLog("Police", xLogs.GetLanguageString("unarrested"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(target))
end

function xLogs.DarkRP.LogBatteringRam(success, ply, trace)
	if success then xLogs.RunLog("Police", xLogs.GetLanguageString("batteringram"), xLogs.DoPlayerFormatting(ply)) end
end

function xLogs.DarkRP.LogWanted(target, ply, reason)
	xLogs.RunLog("Police", xLogs.GetLanguageString("wanted"), xLogs.DoPlayerFormatting(target), xLogs.DoPlayerFormatting(ply), reason)
end

function xLogs.DarkRP.LogUnWanted(target, ply)
	xLogs.RunLog("Police", xLogs.GetLanguageString("unwanted"), xLogs.DoPlayerFormatting(target), xLogs.DoPlayerFormatting(ply))
end

function xLogs.DarkRP.LogWarrant(target, ply, reason)
	xLogs.RunLog("Police", xLogs.GetLanguageString("warranted"), xLogs.DoPlayerFormatting(target), xLogs.DoPlayerFormatting(ply), reason)
end

function xLogs.DarkRP.LogWeaponCheck(ply, target, weapons)
	xLogs.RunLog("Police", xLogs.GetLanguageString("weaponcheck"), xLogs.DoPlayerFormatting(target), xLogs.DoPlayerFormatting(ply))
end


--[[

	Jobs

]]--

function xLogs.DarkRP.LogJobChange(ply, old, new)
	xLogs.RunLog("Jobs", xLogs.GetLanguageString("changedjob"), xLogs.DoPlayerFormatting(ply), ply:getJobTable().name)
end

function xLogs.DarkRP.LogDemote(ply, target, reason)
	xLogs.RunLog("Jobs", xLogs.GetLanguageString("demoted"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(target), reason)
end


--[[

	Adverts

]]--

function xLogs.DarkRP.LogAdvert(ply, args, ent)
	xLogs.RunLog("Adverts", xLogs.GetLanguageString("advert"), xLogs.DoPlayerFormatting(ply), args)
end


--[[

	Cheques

]]--

function xLogs.DarkRP.LogDropCheque(ply, recipient, amount, ent)
	xLogs.RunLog("Cheque", xLogs.GetLanguageString("dropcheque"), xLogs.DoPlayerFormatting(ply), DarkRP.formatMoney(amount), xLogs.DoPlayerFormatting(recipient))
end

function xLogs.DarkRP.LogPickupCheque(ply, recipient, amount, success, ent)
	if success then xLogs.RunLog("Cheque", xLogs.GetLanguageString("pickupcheque"), xLogs.DoPlayerFormatting(ply), DarkRP.formatMoney(amount), xLogs.DoPlayerFormatting(recipient)) end
end

function xLogs.DarkRP.LogToreCheque(ply, recipient, amount, ent)
	xLogs.RunLog("Cheque", xLogs.GetLanguageString("torecheque"), xLogs.DoPlayerFormatting(ply), DarkRP.formatMoney(amount), xLogs.DoPlayerFormatting(recipient))
end


--[[

	Doors

]]--

function xLogs.DarkRP.LogBuyDoor(ply, ent, amount)
	xLogs.RunLog("Doors", xLogs.GetLanguageString("buydoor"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogSellDoor(ply, ent, amount)
	xLogs.RunLog("Doors", xLogs.GetLanguageString("selldoor"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end


--[[

	Money

]]--

function xLogs.DarkRP.LogDropMoney(ply, amount, ent)
	xLogs.RunLog("Money", xLogs.GetLanguageString("dropmoney"), xLogs.DoPlayerFormatting(ply), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogGiveMoney(ply, recipient, amount)
	xLogs.RunLog("Money", xLogs.GetLanguageString("givemoney"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(recipient), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogPickupMoney(ply, amount, ent)
	xLogs.RunLog("Money", xLogs.GetLanguageString("pickupmoney"), xLogs.DoPlayerFormatting(ply), DarkRP.formatMoney(amount))
end


--[[

	Hits

]]--

function xLogs.DarkRP.LogHitAccepted(ply, target, customer)
	xLogs.RunLog("Hit", xLogs.GetLanguageString("acceptedhit"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(target), xLogs.DoPlayerFormatting(customer))
end

function xLogs.DarkRP.LogHitCompleted(ply, target, customer)
	xLogs.RunLog("Hit", xLogs.GetLanguageString("completedhit"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(target), xLogs.DoPlayerFormatting(customer))
end

function xLogs.DarkRP.LogHitFailed(ply, target, reason)
	xLogs.RunLog("Hit", xLogs.GetLanguageString("failedhit"), xLogs.DoPlayerFormatting(ply), xLogs.DoPlayerFormatting(target), reason)
end


--[[

	Lockpicking

]]--

function xLogs.DarkRP.LogStartLockpick(ply, ent, trace)
	xLogs.RunLog("Lockpicking", xLogs.GetLanguageString("lockpickstart"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent))
end

function xLogs.DarkRP.LogCompleteLockpick(ply, success, ent)
	if success then xLogs.RunLog("Lockpicking", xLogs.GetLanguageString("lockpickcomplete"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent)) end
end


--[[

	Pocket

]]--

function xLogs.DarkRP.LogPocketAdd(ply, ent, serialised)
	xLogs.RunLog("Pocket", xLogs.GetLanguageString("pocketadd"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent))
end

function xLogs.DarkRP.LogPocketDrop(ply, ent, item, id)
	xLogs.RunLog("Pocket", xLogs.GetLanguageString("pocketdrop"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent))
end


--[[

	Names

]]--

function xLogs.DarkRP.LogNameChange(ply, old, new)
	xLogs.RunLog("Name", xLogs.GetLanguageString("namechanged"), xLogs.DoPlayerFormatting(ply), old, new)
end


--[[
	
	Purchases

]]--

function xLogs.DarkRP.LogVehiclePurchase(ply, ent, amount)
	xLogs.RunLog("Purchase", xLogs.GetLanguageString("purchased"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogAmmoPurchase(ply, ammo, ent, amount)
	xLogs.RunLog("Purchase", xLogs.GetLanguageString("purchased"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogCustomEntPurchase(ply, entTb, ent, amount)
	xLogs.RunLog("Purchase", xLogs.GetLanguageString("purchased"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogCustomVehiclePurchase(ply, entTb, ent, amount)
	xLogs.RunLog("Purchase", xLogs.GetLanguageString("purchased"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogFoodPurchase(ply, food, ent, amount)
	xLogs.RunLog("Purchase", xLogs.GetLanguageString("purchased"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogPistolPurchase(ply, wepTb, ent, amount)
	xLogs.RunLog("Purchase", xLogs.GetLanguageString("purchased"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end

function xLogs.DarkRP.LogShipmentPurchase(ply, shipTb, ent, amount)
	xLogs.RunLog("Purchase", xLogs.GetLanguageString("purchased"), xLogs.DoPlayerFormatting(ply), xLogs.DoEntityFormatting(ent), DarkRP.formatMoney(amount))
end


--[[

	Log Registration

]]--

hook.Add("PostGamemodeLoaded", "xLogsDarkRPRegisterCat", function()
	xLogs.RegisterLoggingCategory("DarkRP", Color(177, 0, 0, 255), true, function()
		return DarkRP or false
	end)

	xLogs.RegisterLoggingType("Police", "DarkRP", Color(125, 60, 60, 255), true, {
		{"playerArrested", xLogs.DarkRP.LogArrest},
		{"playerUnArrested", xLogs.DarkRP.LogRelease},
		{"onDoorRamUsed", xLogs.DarkRP.LogBatteringRam},
		{"playerWanted", xLogs.DarkRP.LogWanted},
		{"playerUnWanted", xLogs.DarkRP.LogUnWanted},
		{"playerWeaponsChecked", xLogs.DarkRP.LogWeaponCheck},
	})

	xLogs.RegisterLoggingType("Jobs", "DarkRP", Color(60, 175, 60, 255), false, {
		{"OnPlayerChangedTeam", xLogs.DarkRP.LogJobChange},
		{"onPlayerDemoted", xLogs.DarkRP.LogDemote},
	})

	xLogs.RegisterLoggingType("Adverts", "DarkRP", Color(175, 145, 60, 255), false, {
		{"playerAdverted", xLogs.DarkRP.LogAdvert},
	})

	xLogs.RegisterLoggingType("Cheque", "DarkRP", Color(20, 200, 20, 255), true, {
		{"playerDroppedCheque", xLogs.DarkRP.LogDropCheque},
		{"playerPickedUpCheque", xLogs.DarkRP.LogPickupCheque},
		{"playerToreUpCheque", xLogs.DarkRP.LogToreCheque},
	})

	xLogs.RegisterLoggingType("Doors", "DarkRP", Color(65, 65, 200, 255), false, {
		{"playerBoughtDoor", xLogs.DarkRP.LogBuyDoor},
		{"playerKeysSold", xLogs.DarkRP.LogSellDoor},
	})

	xLogs.RegisterLoggingType("Money", "DarkRP", Color(50, 255, 50, 255), true, {
		{"playerDroppedMoney", xLogs.DarkRP.LogDropMoney},
		{"playerGaveMoney", xLogs.DarkRP.LogGiveMoney},
		{"playerPickedUpMoney", xLogs.DarkRP.LogPickupMoney},
	})

	xLogs.RegisterLoggingType("Hit", "DarkRP", Color(145, 70, 255, 255), false, {
		{"onHitAccepted", xLogs.DarkRP.LogHitAccepted},
		{"onHitCompleted", xLogs.DarkRP.LogHitCompleted},
		{"onHitFailed", xLogs.DarkRP.LogHitFailed},
	})

	xLogs.RegisterLoggingType("Lockpicking", "DarkRP", Color(125, 20, 100, 255), false, {
		{"lockpickStarted", xLogs.DarkRP.LogStartLockpick},
		{"onLockpickCompleted", xLogs.DarkRP.LogCompleteLockpick},
	})

	xLogs.RegisterLoggingType("Pocket", "DarkRP", Color(58, 181, 230, 255), false, {
		{"onPocketItemAdded", xLogs.DarkRP.LogPocketAdd},
		{"onPocketItemDropped", xLogs.DarkRP.LogPocketDrop},
	})

	xLogs.RegisterLoggingType("Name", "DarkRP", Color(240, 110, 17, 255), false, {
		{"onPlayerChangedName", xLogs.DarkRP.LogNameChange},
	})

	xLogs.RegisterLoggingType("Purchase", "DarkRP", Color(50, 200, 50, 255), true, {
		{"playerBoughtVehicle", xLogs.DarkRP.LogVehiclePurchase},
		{"playerBoughtAmmo", xLogs.DarkRP.LogAmmoPurchase},
		{"playerBoughtCustomEntity", xLogs.DarkRP.LogCustomEntPurchase},
		{"playerBoughtCustomVehicle", xLogs.DarkRP.LogCustomVehiclePurchase},
		{"playerBoughtFood", xLogs.DarkRP.LogFoodPurchase},
		{"playerBoughtPistol", xLogs.DarkRP.LogPistolPurchase},
		{"playerBoughtShipment", xLogs.DarkRP.LogShipmentPurchase},
	})
end)