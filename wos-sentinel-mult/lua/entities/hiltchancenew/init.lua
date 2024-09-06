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
        [TEAM_WPJEDI] = true,
        [TEAM_GMJEDI] = true,
        [TEAM_327THJEDI] = true,
        [TEAM_501STJEDI] = true,
        [TEAM_212THJEDI] = true,
        [TEAM_JEDIKNIGHT] = true,
        [TEAM_JEDISENTINEL] = true,
        [TEAM_JEDIGUARDIAN] = true,
        [TEAM_JEDICONSULAR] = true,
        [TEAM_JEDICOUNCIL] = true,
        [TEAM_JEDIGENERALADI] = true,
        [TEAM_GMGENERALADI] = true,
        [TEAM_JEDIGENERALSHAAK] = true,
        [TEAM_CGGENERALSHAAK] = true,
        [TEAM_JEDIGENERALKIT] = true,
        [TEAM_RCGENERALKIT] = true,
        [TEAM_JEDIGENERALPLO] = true,
        [TEAM_WPGENERALPLO] = true,
        [TEAM_JEDIGENERALTANO] = true,
        [TEAM_501STGENERALTANO] = true,
        [TEAM_JEDIGENERALWINDU] = true,
        [TEAM_JEDIGENERALOBI] = true,
        [TEAM_212THGENERALOBI] = true,
        [TEAM_JEDIGENERALSKYWALKER] = true,
        [TEAM_501STGENERALSKYWALKER] = true,
        [TEAM_JEDIGRANDMASTER] = true,
        [TEAM_GCGRANDMASTER] = true,
        [TEAM_JEDIGENERALAAYLA] = true,
        [TEAM_327THGENERALAAYLA] = true,
        [TEAM_JEDIGENERALLUMINARA] = true,
        [TEAM_CGJEDI] = true,
        [TEAM_CGJEDICHIEF] = true,
        [TEAM_JEDIGENCINDRALLIG] = true,
        [TEAM_JEDITGCHIEF] = true,
        [TEAM_TGJEDI] = true,
        [TEAM_GCGENERALLUMINARA] = true,
        [TEAM_JEDIGENERALVOS] = true,
        [TEAM_SHADOWGENERALVOS] = true,
        [TEAM_JEDITOURNAMENT] = true,
        }
    if jedi[ply:Team()] then
		local type = math.random(1,100)
		local chance = math.random(1,100)
		local items = {}

		if type <= 65 then
			-- Single Hilts
			if chance <= 50 then
				items = { "Basic 1 Hilt", "Basic 2 Hilt", "Basic 3 Hilt", "Byph Hilt", "Dani Hilt", "Exile Hilt",
					"Ganodi Hilt", "Gray Hilt", "Instigator Hilt", "Jedi Knight's Hilt", "Petro Hilt", "Pulsating Hilt",
					"Royal 3 Hilt", "Saesee Tiin's Hilt", "Unstable Hilt", "Ashara Hilt", "Challengers Hilt", "Chrysopaz Hilt",
					"Chrysopaz Shoto" }
			elseif chance <= 70 then
				items = { "Artusian Hilt", "Blademaster's Hilt", "Conqueror's Hilt", "Fearless Retaliator's Hilt", "Firenode Hilt", "Mytag Hilt",
					"Pitiless Raider Hilt", "Unstable Arbiter's Hilt", "Ziost Guardian's Hilt", "Forked Hilt", "Talz Hilt", "Pulsating Blue Hilt",
					"Royal 1 Hilt", "Samurai Hilt", "Days Hilt", "Followers Hilt", "Followers Shoto" }
			elseif chance <= 85 then
				items = { "Elegant Dual Hilt", "Praetorian's Hilt", "Revanite's Mk2 Hilt", "Thexan's Hilt", "Unstable Peacemaker's Hilt", "Vindicator's Hilt",
					"Warden's Hilt", "Kyle Hilt", "Gungi Hilt", "Affiliation Hilt", "Zebra Hilt", "Zatt Hilt",
					"Felucia 2 Hilt", "Felucia 1 Hilt", "Blade Masters Attenuated Hilt", "Exarch Hilt", "Exarch Shoto" }
			elseif chance <= 96 then
				items = { "Dauntless Hilt", "Outlander Hilt", "Rishi's Mk1 Hilt", "Tythonian Force Master's Hilt", "Vengeance's Sunsealed Hilt", "Hiridu Hilt",
					"Katooni Hilt", "Kashyyyk Hilt", "Spiralling Hilt", "Sparkling Hilt", "Coruscal Hilt", "Coruscal Shoto" }
			else
				items = { "Crossguard Hilt", "Dragonpearl Hilt", "Eternal Commander's Mk 4 Hilt", "Executioner's Hilt", "Rishi's Mk2 Hilt", "Seny Atirall's Hilt",
					"Royal 2 Hilt", "Unknown Hilt", "Blade Pommel Hilt", "Kyle Katarn's Hilt", "Tythian Hilt",
					"Dragonpearl Shoto", "Claw's Hilt" }
			end
		elseif type <= 90 then
			-- Double Hilts
			if chance <= 50 then
				items = { "Asascorp Hilt", "Attuned Forcelord's Hilt", "Defender's Hilt", "Protector's Hilt", "Stronghold Defender's Hilt", "Unrelenting Aggressor Hilt",
					"Vengence Double Hilt", "Redeemer's Twin Hilt", "Derelict Twin Hilt", "Desolator Twin Hilt", "Pike 2 Hilt" }
			elseif chance <= 70 then
				items = { "Antique Corro Twin Hilt", "Defiant Twin Hilt", "Dragon Pearl Twin Hilt", "Antiques Ocorro Hilt", "Despot's Hilt", "Pike 1 Hilt",
					"Sateleshan's Hilt", "Vigorous Hilt", "Vindicator's Double Hilt", "Zakuulan's Mk 1 Hilt", "Zakuulan's Mk 2 Hilt", "Senya Tirall's Twin Hilt",
					"Ardent Dual Hilt", "Frontier Hunter Hilt" }
			elseif chance <= 85 then
				items = { "Artusian Twin Hilt", "Grantek Hilt", "Pike 4 Hilt", "Serenity's Sunsealed Hilt", "Warmaster's Double Hilt", "Inscrutable Twin Hilt",
					"Prophet's Twin Hilt", "Tempted Twin Hilt", "Unstable Twin Hilt", "Trident's Hilt", "Blade Masters Staff Hilt", "Champions Hilt" }
			elseif chance <= 96 then
				items = { "Corusca Twin Hilt", "Herald's Twin Hilt", "Hermit's Hilt", "Iokath Mk4 Hilt", "Lone Wolf's Hilt", "Occultists' Hilt",
					"Peacemaker's Twin Hilt", "Reckoning Twin Hilt", "Revanite Twin Hilt", "Chrysopaz Staff Hilt", "Dual Blade 5 Hilt", "Reverie Staff Hilt" }
			else
				items = { "Eternal Twin Hilt", "Borth Twin Hilt", "Descendant's Sheirloom Hilt", "Indomitable Vanquisher's Hilt", "Outlander Dual Hilt", "The Knowledge Seeker Hilt",
					"Devastating Staff Hilt", "Vengeance's Sunsealed Double Hilt" }
			end
		else
			local color = { "Orange", "Yellow", "Green", "Light Green", "Cyan", "Blue", "Purple", "White", "Pink" }
			-- Unique items
			if chance <= 50 then
				items = {"Heavish Hum Blueprint", "Heavy Hum Blueprint", "Medium Hum Blueprint", "Heavy Igniter Blueprint", 
					"Heavy Fast Igniter Blueprint", "Jedi Fast Igniter Blueprint", "Jedi Original Igniter Blueprint", 
					"Jedi Original Fast Igniter Blueprint"}
			elseif chance <= 70 then
				items = {"Unstable Crystal ( " .. table.Random( color ) .. " )"}
			elseif chance <= 85 then
				items = {"Corrupted Crystal ( " .. table.Random( color ) .. " )"}
			elseif chance <= 95 then
				items = {"Purified Crystal ( " .. table.Random( color ) .. " )"}
			elseif chance <= 99 then
				items = {"Focused Crystal ( " .. table.Random( color ) .. " )"}
			else
				items = {"Perfected Crystal ( " .. table.Random( color ) .. " )"}
			end
		end
		
		local randomItem = table.Random(items)
		wOS:HandleItemPickup(ply, randomItem) 
		hook.Call("WILTOS.ItemUsed", nil, ply, "New Hilt Chance", randomItem)
		self:Remove()
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
