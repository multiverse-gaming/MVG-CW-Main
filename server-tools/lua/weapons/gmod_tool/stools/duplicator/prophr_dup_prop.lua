function dup_prophr_SEM(Entity, Name, StaticData)
	if (GetConVar("prophr_hostiles_attacks"):GetInt() == 0) then
		duplicator.StoreEntityModifier(Entity, Name, {
			Entity 		= Entity,
			StaticData 	= StaticData
		}) --[[ Entity, (Duplicator-ID for Entity), Data ]]
	else
		for k, v in pairs(Entity:GetChildren()) do
			if (
				v:GetName() == "prophr_npc_ent"
			) then
				duplicator.StoreEntityModifier(Entity, Name, {
					Entity 		= v,
					StaticData 	= StaticData
				}) --[[ Entity, (Duplicator-ID for Entity), Data ]]
	
				return
			end
		end
	end
end
--
--
duplicator.RegisterEntityModifier("prophr", function(Player, Entity, Data) --[[ Player, Entity, Data (parameter-transfere here) ]]
	--
	local _Data_prophr 						= nil
	local _Data_prophr_relationship_to_npc 	= nil
	--
	local old_ent_dup = Data.StaticData.prophr_ent
	--
	_Data_prophr 			= Data.StaticData
	_Data_prophr.prophr_ent = Entity
	--
	-- Write new child-entity properties
	if (
		Entity:IsNPC() and
		Entity:GetClass() == prophr_ent_npc_class and
		string.match(Entity:GetName(), "prophr_npc_ent")
	) then
		Entity = Entity:GetParent()
	end
	--
	Entity.prophr = _Data_prophr
	Entity.prophr.isDuplicated = true
	--
	if (old_ent_dup:IsValid()) then
		--
		-- Visst den gamle entity eksisterer, berre kopier over gamle
		-- single-con. data (om det er noko då)
		Entity.prophr_single_connection_id = old_ent_dup.prophr_single_connection_id
		--
		-- **
		-- Ellers, bruker me "prophr_ent_npc_parent_pos_unik_id" og "prophr_ent_npc_parent_ang_unik_id"
		-- for å finne kva entity som hadde førre tilkobling til Entity kopiert (men no ikkje eksisterer lengere)
		--
	end
	--
	--
	Entity.prophr.prophr_health_left = Entity.prophr.prophr_health
	--
	Entity:SetName("prophr_npc_ent")
	--
	-- Set network-varibles
	Entity:SetNWBool("prophr_active", true)
	--
	Entity:SetNWBool("prophr_isNPC", false)
	--
	Entity:SetNWInt("prophr_health", _Data_prophr.prophr_health)
	Entity:SetNWInt("prophr_health_left", _Data_prophr.prophr_health)
	--
	Entity:SetNWBool("prophr_health_bar_active", _Data_prophr.prophr_health_bar_active)
	Entity:SetNWBool("prophr_health_left_text_active", _Data_prophr.prophr_health_left_text_active)
	Entity:SetNWString("prophr_prophr_material", _Data_prophr.prophr_material)
	--
	-- Create NPC-Hit-target
	--
	createNPCforHitTarget(Player, Entity, prophr_ent_npc_class)
	--
	-- PROP-data
	--
	if (_Data_prophr.prophr_hostiles_attacks == 1) then
		--
		-- Make the given NPC-group(s) hate the prop
		npcRelationshipPropFunc(
			D_HT,
			_Data_prophr.prophr_relationship_amount_npc,
			_Data_prophr.prophr_Combines_attacks,
			_Data_prophr.prophr_HumansResistance_attacks,
			_Data_prophr.prophr_Zombies_attacks,
			_Data_prophr.prophr_EnemyAliens_attacks,
			_Data_prophr.prophr_EveryNPC_attacks,
			false,
			nil,
			nil,
			nil,
			false
		)
		--
	end
	--
	--
	if (prophr_print_out_relationships_in_console()) then
		print("+ ++ ++ +")
		print("Spawned duplication entity (PROP) :", Entity)
		print("+ ++ ++ +")
	end
	-- ** Om den eksisterer, vil logikken bli handtert i "prophr_func_logic_addentityrelationship.lua"
	timer.Simple(0.15, function()
		if (!old_ent_dup:IsValid()) then
			-- Om du spawner ein entity, sjekk om det er ein propHr PROP, og skal hate noko men har ikkje ein tabell på seg enno...
			-- E.g. om det er ein duplikasjon uten originalen eksisterer lengere
			-- (Dette går, sidan funksjonen "lagreForreForhold" forhindrer dobbel-lagring !)
			local _ents 			= ents.FindByClass("npc_*")
			local warningMessage 	= "(PropHr) You spawned a single-connection entity (PROP) which does not have any original hater(s) anymore..."
			--
			local funnetEinSingleConHater 	= false
			local funnetEinKlasse 			= false
			--
			if (Entity.prophr.prophr_single_connection == false) then return end
			for k, v in pairs(_ents) do
				--
				-- Om det er ein NPC som hater...
				if (v:GetClass() == Entity.prophr.prophr_single_connection_with_class_NPC_Class) then funnetEinKlasse = true end
				--
				if (v.prophr_single_connection_id != nil) then
					--
					-- Sjekk om denne entitien har entites duplisert (spawna) i seg
					for l, w in pairs(v.prophr_single_connection_id) do
						if (
							(
								w != 0
								and w == Entity.prophr.prophr_single_connection_id
								and Entity.prophr.prophr_single_connection_with_class != 1
							)
							or (
								w != 0
								and w == Entity.prophr.prophr_single_connection_id
								and v:GetClass() == Entity.prophr.prophr_single_connection_with_class_NPC_Class
								and Entity.prophr.prophr_single_connection_with_class == 1
							)
						) then
							funnetEinSingleConHater = true
						end
					end
				end
				--
				--
				if (
					k == #_ents
					and !funnetEinSingleConHater
				) then
					--
					-- Sjekk om det var ein klasse som eksisterte
					if (
						(
							!funnetEinKlasse
							and Entity.prophr.prophr_single_connection_with_class == 1
						)
						 or
						(
							Entity.prophr.prophr_single_connection_with_class == 0
						)
					) then
						-- Vis melding
						PrintMessage(HUD_PRINTTALK, warningMessage)
					end
				end
			end
		end
	end)
end)