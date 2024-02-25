function dup_npc_SEM(Entity, Name, StaticData)
	duplicator.StoreEntityModifier(Entity, Name, {
		Entity 		= Entity,
		StaticData 	= StaticData
	}) --[[ Entity, (Duplicator-ID for Entity), Data ]]
end
--
duplicator.RegisterEntityModifier("prophrNPC", function(Player, Entity, Data) --[[ Player, Entity, Data (parameter-transfere here) ]]
	--
	local _Data_prophr 						= nil
	local _Data_prophr_relationship_to_npc 	= nil
	--
	local old_ent_dup 	= Data.StaticData.prophr_ent
	--
	_Data_prophr 			= Data.StaticData
	_Data_prophr.prophr_ent = Entity
	--
	Entity.prophr = _Data_prophr
	Entity.prophr.isDuplicated = true
	--
	if old_ent_dup and old_ent_dup:IsValid() then
		if old_ent_dup.prophr_single_connection_id then
			--
			-- Visst den gamle entity eksisterer, berre kopier over gamle
			-- single-con. data (om det er noko då)
			Entity.prophr_single_connection_id = old_ent_dup.prophr_single_connection_id
			--
			-- **
			-- Ellers, bruker me "prophr_ent_npc_parent_pos_unik_id" og "prophr_ent_npc_parent_ang_unik_id"
			-- for å finne kva entity som hadde førre tilkobling til Entity kopiert (men no ikkje eksisterer lengere)
			--
		else print("PropHr Warning: Could not get the connection ID from previous entity; value was nil.") end
	end
	--
	--
	-- Set network-varibles
	Entity:SetNWBool("prophr_active", true)
	--
	Entity:SetNWBool("prophr_isNPC", true)
	--
	Entity:SetNWInt("prophr_health", _Data_prophr.prophr_health)
	Entity:SetNWInt("prophr_health_left", _Data_prophr.prophr_health)
	--
	Entity:SetNWBool("prophr_health_bar_active", _Data_prophr.prophr_health_bar_active)
	Entity:SetNWBool("prophr_health_left_text_active", _Data_prophr.prophr_health_left_text_active)
	--
	Entity:SetNWInt("prophr_disable_thinking", _Data_prophr.prophr_disable_thinking)
	--
	-- Ellers, legg til nye hatere (mottaker og hater må få oppdater tabell)
	--
	-- NPC-data
	--
	if (_Data_prophr.prophr_hostiles_attacks == 1) then
		-- Make the given NPC-group(s) hate the prop/NPC
		npcRelationshipPropFunc(
			D_HT,
			_Data_prophr.prophr_relationship_amount_npc,
			_Data_prophr.prophr_Combines_attacks,
			_Data_prophr.prophr_HumansResistance_attacks,
			_Data_prophr.prophr_Zombies_attacks,
			_Data_prophr.prophr_EnemyAliens_attacks,
			_Data_prophr.prophr_EveryNPC_attacks,
			true,
			Entity,
			nil,
			old_ent_table,
			false
		)
		--
		if (prophr_print_out_relationships_in_console()) then
			print("+ ++ ++ +")
			print("Spawned duplication entity (NPC) :", Entity)
			print("+ ++ ++ +")
		end
		timer.Simple(0.15, function()
			-- ** Om den eksisterer, vil logikken bli handtert i "prophr_func_logic_addentityrelationship.lua"
			-- Om du spawner ein entity, sjekk om det er ein propHr PROP, og skal hate noko men har ikkje ein tabell på seg enno...
			-- E.g. om det er ein duplikasjon uten originalen eksisterer lengere
			-- (Dette går, sidan funksjonen "lagreForreForhold" forhindrer dobbel-lagring !)
			local _ents 			= ents.FindByClass("npc_*")
			local warningMessage 	= "(PropHr) You spawned a single-connection entity (NPC) which does not have any original hater(s) anymore..."
			--
			local funnetEinSingleConHater 	= false
			local funnetEinKlasse 			= false
			--
			if (Entity.prophr.prophr_single_connection == false) then return end
			for k, v in pairs(_ents) do
				--
				-- Om det er ein NPC som hater...
				--
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
								v:GetClass() == Entity.prophr.prophr_single_connection_with_class_NPC_Class
								and Entity.prophr.prophr_single_connection_with_class == 1
							)
						) then
							funnetEinSingleConHater = true
						end
						--
						--
						if (
							k == #_ents
							and l == #v.prophr_single_connection_id
							and !funnetEinSingleConHater
						) then
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
			end
		end)
	else
		-- Make the given NPC-group(s) netural for the prop/NPC
		npcNeutralRelationshipPropFunc(_Data_prophr.prophr_relationship_amount_npc)
		
		-- This will only be for disabling e.g. thinking
		npcRelationshipPropFunc(
			D_HT,
			_Data_prophr.prophr_Combines_attacks,
			_Data_prophr.prophr_HumansResistance_attacks,
			_Data_prophr.prophr_relationship_amount_npc,
			_Data_prophr.prophr_Zombies_attacks,
			_Data_prophr.prophr_EveryNPC_attacks,
			true,
			_Data_prophr.prophr_EnemyAliens_attacks,
			Entity,
			nil,
			old_ent_table,
			false
		)
	end
end)