AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self:SetModel( "models/releasepackprops/relic.mdl" )
	self:DrawShadow(true)
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup( COLLISION_GROUP_NONE )	
end

function ENT:Use(ply)
    local jedi = {
        [TEAM_JEDIPADAWAN] = true,
        [TEAM_JEDIKNIGHT] = true,
        [TEAM_JEDISENTINEL] = true,
        [TEAM_JEDIGUARDIAN] = true,
        [TEAM_JEDICONSULAR] = true,
        [TEAM_JEDICOUNCIL] = true,
        [TEAM_JEDIGENERALADI] = true,
        [TEAM_JEDIGENERALSHAAK] = true,
        [TEAM_JEDIGENERALKIT] = true,
        [TEAM_JEDIGENERALPLO] = true,
        [TEAM_JEDIGENERALTANO] = true,
        [TEAM_JEDIGENERALWINDU] = true,
        [TEAM_JEDIGENERALOBI] = true,
        [TEAM_JEDIGENERALSKYWALKER] = true,
        [TEAM_JEDIGRANDMASTER] = true,
        [TEAM_JEDIGENERALAAYLA] = true,
        [TEAM_JEDIGENERALLUMINARA] = true,
        [TEAM_JEDIGENERALVOS] = true
	}
    if jedi[ply:Team()] then
		local type = math.random(1,100)
		local chance = math.random(1,100)
		local items = {}

		if type <= 50 then
			if chance <= 50 then
				items = {"Ganodi Hilt", "Pulsating Hilt", "Instigator Hilt", "Byph Hilt", "Dani Hilt", "Petro Hilt", "Gray Hilt", "Royal 2 Hilt", "Royal 3 Hilt",
						"Jedi Knight's Hilt", "Exile Hilt", "Qui-Gon Gin's Hilt", "Obi-Wan Kenobi's Hilt EP1", "Saesee Tiin's Hilt", "Unstable Hilt", "Basic 1 Hilt",
							"Basic 2 Hilt", "Basic 3 Hilt", "Basic 5 Hilt", "Basic 6 Hilt", "Basic 7 Hilt", "Basic 8 Hilt", "Basic 9 Hilt", "Sateleshan's Sparring Hilt"}
			elseif chance <= 70 then
				items = {"Samurai Hilt", "Pulsating Blue Hilt", "Forked Hilt", "Royal 1 Hilt", "Jocastanu Hilt", "Ziost Guardian's Hilt", "Unstable Arbiter's Hilt",
						"Pitiless Raider Hilt", "Mytag Hilt", "Artusian Hilt", "Firenode Hilt", "Fearless Retaliator's Hilt", "Conqueror's Hilt", "Blademaster's Hilt", "Days Hilt"}
			elseif chance <= 85 then
				items = {"Felucia 2 Hilt", "Felucia 1 Hilt", "Adi Galia's Hilt", "Affiliation Hilt", "Zatt Hilt", "Zebra Hilt", "Unknown Hilt", "Talz Hilt", "Gungi Hilt", "Thexan's Hilt",
						"Revanite's Mk2 Hilt", "Praetorian's Hilt", "Unstable Peacemaker's Hilt", "Vindicator's Hilt", "Warden's Hilt", "Kyle Hilt"}
			elseif chance <= 95 then
				items = {"Katooni Hilt", "Sparkling Hilt", "Kashyyyk Hilt", "Spiralling Hilt", "Dauntless Hilt", "Outlander Hilt", "Rishi's Mk1 Hilt", "Tythonian Force Master's Hilt", "Vengeance's Sunsealed Hilt", "Hiridu Hilt"}
			else
				items = {"Executioner's Hilt", "Dragonpearl Hilt", "Seny Atirall's Hilt", "Eternal Commander's Mk 4 Hilt", "Rishi's Mk2 Hilt", "Crossguard Hilt" }
			end
		elseif type <= 85 then
			if chance <= 50 then
				items = {"Vengence Double Hilt", "Pike 2 Hilt",
						"Asascorp Hilt", "Defender's Hilt", "Protector's Hilt", "Attuned Forcelord's Hilt", "Stronghold Defender's Hilt", "Unrelenting Aggressor Hilt", "Derelict Twin Hilt", "Desolator Twin Hilt",
						"Redeemer's Twin Hilt"}
			elseif chance <= 70 then
				items = {"Sateleshan's Hilt", "Pike 1 Hilt", "Vigorous Hilt", "Zakuulan's Mk 2 Hilt", "Zakuulan's Mk 1 Hilt", "Vindicator's Double Hilt", "Despot's Hilt", "Antiques Ocorro Hilt", "Antique Corro Twin Hilt",
						"Defiant Twin Hilt", "Dragon Pearl Twin Hilt", "Senya Tirall's Twin Hilt"}
			elseif chance <= 85 then
				items = {"Trident Hilt", "Elegant Dual Hilt", "Serenity's Sunsealed Hilt", "Warmaster's Double Hilt", "Grantek Hilt", "Artusian Twin Hilt",
						"Inscrutable Twin Hilt", "Prophet's Twin Hilt", "Tempted Twin Hilt", "Unstable Twin Hilt", "Pike 4 Hilt"}
			elseif chance <= 95 then
				items = {"Occultists' Hilt", "Iokath Mk4 Hilt", "Hermit's Hilt", "Lone Wolf's Hilt", "Corusca Twin Hilt", "Reckoning Twin Hilt", "Revanite Twin Hilt", "Peacemaker's Twin Hilt", "Herald's Twin Hilt", "Blade Pommel Hilt"}
			else
				items = {"Rishi's Mk1 Hilt", "Outlander Dual Hilt", "Indomitable Vanquisher's Hilt", "Descendant's Sheirloom Hilt", "Borth Twin Hilt", "Eternal Twin Hilt"}
			end
		else
			if chance <= 80 then
				items = {"Heavish Hum Blueprint", "Heavy Hum Blueprint", "Medium Hum Blueprint", "Heavy Igniter Blueprint", "Heavy Fast Igniter Blueprint", "Jedi Fast Igniter Blueprint", "Jedi Original Igniter Blueprint", "Jedi Original Fast Igniter Blueprint"}
			elseif chance <= 95 then
				local color = string.match(ply.PersonalSaberItems[1], "%( (.+) %)")
				items = {"Unstable Crystal ( " .. color .. " )"}
				--items = {"Unstable Crystal ( Orange )", "Unstable Crystal ( Yellow )", "Unstable Crystal ( Green )", "Unstable Crystal ( Light Green )", "Unstable Crystal ( Cyan )", "Unstable Crystal ( Blue )",
				--		"Unstable Crystal ( Purple )", "Unstable Crystal ( White )"}
			else
				local color = string.match(ply.PersonalSaberItems[1], "%( (.+) %)")
				items = {"Corrupted Crystal ( " .. color .. " )"}
				--items = {"Corrupted Crystal ( Yellow )", "Corrupted Crystal ( Orange )", "Corrupted Crystal ( Green )", "Corrupted Crystal ( Light Green )", "Corrupted Crystal ( Cyan )", "Corrupted Crystal ( Blue )",
				--		"Corrupted Crystal ( Purple )", "Corrupted Crystal ( White )"}
			end
		end
		local randomItem = table.Random(items)
		wOS:HandleItemPickup(ply, randomItem) 
		print(ply:Nick() .. " (" .. ply:SteamID() .. ") picked up a hiltchance and got: " .. randomItem)
		self:Remove()
    	--local randomItems = {69,75,76,77,78,79,80,81,82,84,86,87,96,103,105,106,107,108,110,111,128,129,130,133,134,135,136,137,139,140,141,146,153,158,159}
    	--local randomItemsRare = {181,183}
    	--local randomItemsRare = {69,75,76,77,78,79,80,81,82,84,86,87,96,103,105,106,107,108,110,111,128,129,130,133,134,135,136,137,139,140,141,146,153,158,159}
    	--local randomItemsVeryRare = {45,46,57,58,59,60,61,62,63,64,1}
    	--local rareItemChance = math.random(1,100)
    
    	--if rareItemChance > 90 then
    	--	item1 = wOS:GetItemData(table.Random(randomItemsVeryRare))
    	--elseif rareItemChance > 70 and rareItemChance < 90 then
    	--	item1 = wOS:GetItemData(table.Random(randomItemsRare))
    	--else
    	--	item1 = wOS:GetItemData(table.Random(randomItems))
    	--end
        --wOS:HandleItemPickup( ply, item1.Name )
    	--self:Remove()
    end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS 
end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
    print (SpawnPos)
	return ent

end
