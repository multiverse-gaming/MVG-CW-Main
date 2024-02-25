--[[
	1 = relationship (INT),
	2 = prophr_relationship_amount (INT)

	3 = Combine (INT)
	4 = (Humans + Resitance) (INT)
	5 = Zombies (INT)
	6 = Enemy Aliens (INT)
	7 = Every NPC (INT)
	
	8 = Entity is NPC (BOOLEAN)
	9 = NPC Entity (ENT or NIL)
	10 = NPC Entity 2 (ENT or NIL)
]]
-- Denne blir kjøyrt på når PropHr blir lagt til for NPC og Prop
--
--
function npcRelationshipPropFunc(
		relationship,
		prophr_relationship_amount,
		Combine,
		HumansResistance,
		Zombies,
		EnemyAliens,
		EveryNPC,
		ent_isNPC,
		ent_NPC,
		ent_NPC2,
		old_ent_table,
		from_entity_created
	)
	-- Interne funksjoner
	--
	-- Disable thinking
	local function disableThinking()
		if (ent_NPC != nil and ent_NPC:GetNWInt("prophr_disable_thinking", nil) == 1) then ent_NPC:AddEFlags(EFL_NO_THINK_FUNCTION) end
		if (ent_NPC2 != nil and ent_NPC2:GetNWInt("prophr_disable_thinking", nil) == 1) then ent_NPC2:AddEFlags(EFL_NO_THINK_FUNCTION) end
	end
	--
	--
	-- Legg til hat for eksisterende PropHr-prop/NPC, når ein ny NPC blir spawna
	local function leggTilHatForEksisterendeProphr()
		--
		-- Funksjoner
		local function leggtilhatProp(ent_skal_hate, ent_skal_motta)
			--
			if (ent_skal_motta.prophr_prophr_relationship_to_npc != nil) then
				for l, w in pairs(ent_skal_motta.prophr_prophr_relationship_to_npc) do
					--
					if (#ent_skal_motta.prophr_prophr_relationship_to_npc == l) then
						--
						-- Legg til hat om NPC allerie ikkje har det mot PropHr-propen
						for m, x in pairs(ent_skal_motta.prophr_prophr_relationship_to_npc) do
							if (
								x.hostile_npc_ent:IsValid() and
								x.hostile_npc_ent:Disposition(ent_skal_motta) != D_HT
							) then
								local prophr_data = ent_skal_motta.prophr
								if (prophr_data == nil) then
									-- Om prop
									prophr_data = ent_skal_motta:GetParent().prophr
								end
								local pd = ent_skal_motta.prophr
								if (pd == nil) then pd = ent_skal_motta:GetParent() else pd = ent_skal_motta end
								local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, pd, "prop", "#give_access_control9")
				--
								if (fikk_tilgang) then
									--
									lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold3")
									addentityrelationship(x.hostile_npc_ent,
										ent_skal_motta,
										D_HT,
										prophr_data.prophr_relationship_amount_npc,
										"#add_ent_rel12"
									)
								end
							else
								if (m == #ent_skal_motta.prophr_prophr_relationship_to_npc) then
									--
									-- Om det er ein entity som ikkje har noko forhold frå før av
									if (ent_skal_hate:Disposition(ent_skal_motta) != D_HT) then
										local prophr_data = ent_skal_motta.prophr
										if (prophr_data == nil) then
											-- Om prop
											prophr_data = ent_skal_motta:GetParent().prophr
										end
										local pd = ent_skal_motta.prophr
										if (pd == nil) then pd = ent_skal_motta:GetParent() else pd = ent_skal_motta end
										local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, pd, "prop", "#give_access_control7")
						--
										if (fikk_tilgang) then
											--
											lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold72")
											addentityrelationship(ent_skal_hate,
												ent_skal_motta,
												D_HT,
												prophr_data.prophr_relationship_amount_npc,
												"#add_ent_rel72"
											)
										end
									end
								end
							end
						end
					end
				end
			else
				--
				-- Visst PropHr entity ikkje har nokon forhold frå før av, og ein NPC blir spawna
				--
				-- Om det er ein entity som ikkje har noko forhold frå før av
				if (ent_skal_hate:Disposition(ent_skal_motta) != D_HT) then
					local prophr_data = ent_skal_motta.prophr
					if (prophr_data == nil) then
						-- Om prop
						prophr_data = ent_skal_motta:GetParent().prophr
					end
					local pd = ent_skal_motta.prophr
					if (pd == nil) then pd = ent_skal_motta:GetParent() else pd = ent_skal_motta end
					local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, pd, "prop", "#give_access_control8")
	--
					if (fikk_tilgang) then
						--
						lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold70")
						addentityrelationship(ent_skal_hate,
							ent_skal_motta,
							D_HT,
							prophr_data.prophr_relationship_amount_npc,
							"#add_ent_rel70"
						)
					end
				end
			end
		end
		local function leggtilhatNPC(ent_skal_hate, ent_skal_motta)
			-- E.g. single connection tabell kan ikkje vere like (ellers byrjer dei å skyte på kvarandre)
			-- Men utenom det, blir forhold lagt til
			--
			local prophr_data = ent_skal_motta.prophr
			if (prophr_data == nil) then
				-- Om prop
				prophr_data = ent_skal_motta:GetParent().prophr
			end
			--
			if (prophr_data != nil) then
				--
				-- Legg til hat om NPC allerie ikkje har det mot PropHr-propen
				if (
					ent_skal_motta.prophr_prophr_relationship_to_npc != nil and
					ent_skal_hate.prophr != nil
				) then
					for l, w in pairs(ent_skal_motta.prophr_prophr_relationship_to_npc) do
						--
						-- Visst det er ein duplikasjon, 
						local _ent_skal_hate = w.hostile_npc_ent
						--
						if (_ent_skal_hate:IsValid()) then
							--
							if (_ent_skal_hate:Disposition(ent_skal_motta) != D_HT) then
								--
								local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(_ent_skal_hate, ent_skal_motta, "npc", "#give_access_control1")
								--
								if (fikk_tilgang) then
									lagreForreForhold(_ent_skal_hate, ent_skal_motta, "#lagreførreforhold4")
									addentityrelationship(_ent_skal_hate,
										ent_skal_motta,
										D_HT,
										prophr_data.prophr_relationship_amount_npc,
										"#add_ent_rel13"
									)
								end
							end
						else
							--[[ PrintMessage(HUD_PRINTTALK, "PropHr ERROR (NPC) : (1) Could not update relationship between entities. One or more entity is invalid.")
							print(_ent_skal_hate, ent_skal_motta) ]]
		
							return
						end
					end
				else
					--
					-- Om det er ein entity som ikkje har noko forhold frå før av
					if (ent_skal_hate:Disposition(ent_skal_motta) != D_HT) then
						local prophr_data = ent_skal_motta.prophr
						if (prophr_data == nil) then
							-- Om prop
							prophr_data = ent_skal_motta:GetParent().prophr
						end
						local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, ent_skal_motta, "npc", "#give_access_control7")
						--
						if (fikk_tilgang) then
							--
							lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold71")
							addentityrelationship(ent_skal_hate,
								ent_skal_motta,
								D_HT,
								prophr_data.prophr_relationship_amount_npc,
								"#add_ent_rel71"
							)
						end
					end
				end
			end
		end
		--
		local function leggtilhatNPCSpesifikkKlasseNPC(ent_skal_hate, ent_skal_motta)
			--
			-- Desse blir brukt når ein ny entity blir spawna; ellers blir det registrert hos "Left-Click"
			local spesifikk_npc_klasse = ent_skal_hate:GetClass()
			--
			for k, v in pairs(ents.FindByClass(spesifikk_npc_klasse)) do
				--
				if (ent_skal_hate:Disposition(ent_skal_hate) != D_HT) then
					local ent_skal_hate	= v
					--
					local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, ent_skal_motta, "npc", "#give_access_control6")
					--
					if (fikk_tilgang) then
						lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold66")
						addentityrelationship(ent_skal_hate,
							ent_skal_motta,
							D_HT,
							ent_skal_motta.prophr.prophr_relationship_amount_npc,
							"#add_ent_rel66"
						)
					end
				end
			end
		end
		local function leggtilhatNPCSpesifikkKlassePROP(ent_skal_hate, ent_skal_motta)
			--
			-- Desse blir brukt når ein ny entity blir spawna; ellers blir det registrert hos "Left-Click"
			--
			if (ent_skal_hate:Disposition(ent_skal_hate) != D_HT) then
				local spesifikk_npc_klasse = ent_skal_hate:GetClass()
				--
				local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, ent_skal_motta:GetParent(), "prop", "#give_access_control7")
				--
				if (fikk_tilgang) then
					lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold64")
					addentityrelationship(ent_skal_hate,
						ent_skal_motta,
						D_HT,
						ent_skal_motta:GetParent().prophr.prophr_relationship_amount_npc,
						"#add_ent_rel64"
					)
				end
			end
		end
		--
		local function finnTilhoyrandeKlasse(
			ent_spawned,
			prophr_ent,
			ent_spawned_class,
			prophr_Combines_attacks,
			prophr_HumansResistance_attacks,
			prophr_Zombies_attacks,
			prophr_EnemyAliens_attacks,
			prophr_EveryNPC_attacks,
			forProphrNPC,
			forSpesifikkNPCKlasse
		)
			-- COMBINE
			if (
				ent_spawned_class == "npc_turret_ceiling" or
				ent_spawned_class == "npc_combinedropship" or
				ent_spawned_class == "npc_combinegunship" or
				ent_spawned_class == "npc_helicopter" or
				ent_spawned_class == "npc_manhack" or
				ent_spawned_class == "npc_metropolice" or
				ent_spawned_class == "npc_combine_s" or
				ent_spawned_class == "npc_rollermine" or
				ent_spawned_class == "npc_strider" or
				ent_spawned_class == "npc_turret_floor"
			) then
				--
				if (
					prophr_Combines_attacks == 1 or
					prophr_EveryNPC_attacks == 1
				) then
					if (forProphrNPC) then
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlasseNPC(ent_spawned, prophr_ent)
						else
							leggtilhatNPC(ent_spawned, prophr_ent)
						end
					else
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlassePROP(ent_spawned, prophr_ent)
						else
							leggtilhatProp(ent_spawned, prophr_ent)
						end
					end
				end
			end
			-- HUMAN + RESISTANCE
			if (
				ent_spawned_class == "npc_alyx" or
				ent_spawned_class == "npc_barney" or
				ent_spawned_class == "npc_dog" or
				ent_spawned_class == "npc_kleiner" or
				ent_spawned_class == "npc_mossman" or
				ent_spawned_class == "npc_eli" or
				ent_spawned_class == "npc_gman" or
				ent_spawned_class == "npc_citizen" or
				ent_spawned_class == "npc_vortigaunt" or
				ent_spawned_class == "npc_breen"
			) then
				--
				if (
					prophr_HumansResistance_attacks == 1 or
					prophr_EveryNPC_attacks == 1
				) then
					if (forProphrNPC) then
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlasseNPC(ent_spawned, prophr_ent)
						else
							leggtilhatNPC(ent_spawned, prophr_ent)
						end
					else
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlassePROP(ent_spawned, prophr_ent)
						else
							leggtilhatProp(ent_spawned, prophr_ent)
						end
					end
				end
			end
			-- ZOMBIE
			if (
				ent_spawned_class == "npc_headcrab_fast" or
				ent_spawned_class == "npc_fastzombie" or
				ent_spawned_class == "npc_fastzombie_torso" or
				ent_spawned_class == "npc_headcrab" or
				ent_spawned_class == "npc_headcrab_black" or
				ent_spawned_class == "npc_poisonzombie" or
				ent_spawned_class == "npc_zombie" or
				ent_spawned_class == "npc_zombie_torso"
			) then
				--
				if (
					prophr_Zombies_attacks == 1 or
					prophr_EveryNPC_attacks == 1
				) then
					if (forProphrNPC) then
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlasseNPC(ent_spawned, prophr_ent)
						else
							leggtilhatNPC(ent_spawned, prophr_ent)
						end
					else
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlassePROP(ent_spawned, prophr_ent)
						else
							leggtilhatProp(ent_spawned, prophr_ent)
						end
					end
				end
			end
			-- ALIEN
			if (
				ent_spawned_class == "npc_antlion" or
				ent_spawned_class == "npc_antlionguard" or
				ent_spawned_class == "npc_barnacle"
			) then
				--
				if (
					prophr_EnemyAliens_attacks == 1 or
					prophr_EveryNPC_attacks == 1
				) then
					if (forProphrNPC) then
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlasseNPC(ent_spawned, prophr_ent)
						else
							leggtilhatNPC(ent_spawned, prophr_ent)
						end
					else
						if (forSpesifikkNPCKlasse) then
							leggtilhatNPCSpesifikkKlassePROP(ent_spawned, prophr_ent)
						else
							leggtilhatProp(ent_spawned, prophr_ent)
						end
					end
				end
			end
			--
		end
		--
		local ent_spawned = ent_NPC2
		if (
			ent_spawned == nil or
			!ent_spawned:IsValid()
		) then
			--
			ent_spawned = ent_NPC
			if (
				ent_spawned == nil or
				!ent_spawned:IsValid()
			) then return end
		end
		local ent_spawned_class = ent_spawned:GetClass() -- Finn kva type ent_spawned tilhøyrer for så og vite om den skal hate denne prop-en/NPCen
		--
		-- Legg til at NPC spawna, skal hate den/dei PropHr-prop/NPC for respektive NPC-klasse
		for k, v in pairs(ents.FindByClass("npc_*")) do
			-- Finn alle PropHr-props
			if (!v:IsValid()) then
				--
				-- Sjekk at entitien ikkje har nokon null Entity under ".hostile_npc_ent" => ellers slett det
				print("PropHr ERROR : (1) (NPC Relationship) Invalid entity...")
			else
				if (v:GetName() == 'prophr_npc_ent') then
					-- Legg til att "NPC i løkke" skal hate PropHr-prop
					-- om PropHr-prop har den klassen lagret i seg
					local prophr_ent 		= v
					local prophr_ent_parent = prophr_ent:GetParent()

					local prophr_Combines_attacks 			= prophr_ent_parent.prophr.prophr_Combines_attacks
					local prophr_HumansResistance_attacks 	= prophr_ent_parent.prophr.prophr_HumansResistance_attacks
					local prophr_Zombies_attacks 			= prophr_ent_parent.prophr.prophr_Zombies_attacks
					local prophr_EnemyAliens_attacks 		= prophr_ent_parent.prophr.prophr_EnemyAliens_attacks
					local prophr_EveryNPC_attacks 			= prophr_ent_parent.prophr.prophr_EveryNPC_attacks
					--
					--
					if (
						prophr_ent_parent.prophr != nil and
						prophr_ent_parent.prophr.prophr_single_connection_with_class != nil and
						prophr_ent_parent.prophr.prophr_single_connection_with_class == 1
					) then
						--
						-- PROP (single-con. med klasse)
						finnTilhoyrandeKlasse(
							ent_spawned,
							prophr_ent,
							ent_spawned_class,
							prophr_Combines_attacks,
							prophr_HumansResistance_attacks,
							prophr_Zombies_attacks,
							prophr_EnemyAliens_attacks,
							prophr_EveryNPC_attacks,
							false,
							true
						)
					else
						--
						-- PROP
						finnTilhoyrandeKlasse(
							ent_spawned,
							prophr_ent,
							ent_spawned_class,
							prophr_Combines_attacks,
							prophr_HumansResistance_attacks,
							prophr_Zombies_attacks,
							prophr_EnemyAliens_attacks,
							prophr_EveryNPC_attacks,
							false,
							false
						)
					end
				else
					-- Legg til att "NPC i løkke" skal hate PropHr-NPC
					-- om PropHr-prop har den klassen lagret i seg
					if (v.prophr != nil) then
						local prophr_npc_ent = v

						local prophr_Combines_attacks 			= prophr_npc_ent.prophr.prophr_Combines_attacks
						local prophr_HumansResistance_attacks 	= prophr_npc_ent.prophr.prophr_HumansResistance_attacks
						local prophr_Zombies_attacks 			= prophr_npc_ent.prophr.prophr_Zombies_attacks
						local prophr_EnemyAliens_attacks 		= prophr_npc_ent.prophr.prophr_EnemyAliens_attacks
						local prophr_EveryNPC_attacks 			= prophr_npc_ent.prophr.prophr_EveryNPC_attacks
						--
						--
						if (
							prophr_npc_ent.prophr != nil and
							prophr_npc_ent.prophr.prophr_single_connection_with_class != nil and
							prophr_npc_ent.prophr.prophr_single_connection_with_class == 1
						) then
							--
							-- NPC (single-con. med klasse)
							finnTilhoyrandeKlasse(
								ent_spawned,
								prophr_npc_ent,
								ent_spawned_class,
								prophr_Combines_attacks,
								prophr_HumansResistance_attacks,
								prophr_Zombies_attacks,
								prophr_EnemyAliens_attacks,
								prophr_EveryNPC_attacks,
								true,
								true
							)
						else
							--
							-- NPC
							finnTilhoyrandeKlasse(
								ent_spawned,
								prophr_npc_ent,
								ent_spawned_class,
								prophr_Combines_attacks,
								prophr_HumansResistance_attacks,
								prophr_Zombies_attacks,
								prophr_EnemyAliens_attacks,
								prophr_EveryNPC_attacks,
								true,
								false
							)
						end
					end
				end
			end
		end
	end
	--
	-- Legg til hat
	local function addHateFunc(npc_class, should_have_no_enemy)
		if (GetConVar("prophr_hostiles_attacks"):GetInt() == 1) then
			if (ent_isNPC) then
				if (!should_have_no_enemy) then
					if (ent_NPC != nil) then
						--
						for k, v in pairs(ents.FindByClass(npc_class)) do
							for l, q in pairs(ents.FindByClass(ent_NPC:GetClass())) do
								local ent_skal_hate 	= v
								local ent_skal_motta 	= q
								--
								if (
									ent_skal_hate:IsValid() and
									ent_skal_motta:IsValid() and
									ent_skal_hate:IsNPC() and
									ent_skal_motta:IsNPC() and
									ent_skal_hate != ent_skal_motta and
									ent_skal_hate:GetClass() != prophr_ent_npc_class and
									ent_skal_motta.prophr != nil and
									ent_skal_motta.prophr.prophr_hostiles_attacks == 1
								) then
									-- Disabled for Enemy Alien Guard
									if (
										ent_skal_hate:GetClass() == ent_skal_motta:GetClass() and
										(
											ent_skal_hate:GetClass() == "npc_antlionguard" or
											ent_skal_hate:GetClass() == "npc_antlion" or
											ent_skal_hate:GetClass() == "npc_barnacle"
										)
									) then
										return
									end
									--
									--
									if (ent_skal_motta.prophr != nil) then
										--
										-- Legg til hat for NPC (DETTE BLIR KJØYRT TIL VANLIG... E.G. PÅ ENTITY SPAWN)
										--
										
										local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, ent_skal_motta, "npc", "#give_access_control2")
										--
										--
										if (fikk_tilgang) then
											--
											-- OK forsett med og legge til kobling
											if (ent_skal_hate:Disposition(ent_skal_motta) != relationship) then
												lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold10")
												addentityrelationship(ent_skal_hate,
													ent_skal_motta,
													relationship,
													GetConVar("prophr_relationship_amount_npc"):GetInt(),
													"#add_ent_rel15"
												)
											end
										end
										--
										--
										-- Gjer sånn at NPCen som har på seg PropHr frykter den NPCen som hater den
										if (GetConVar("prophr_fear_the_hostile_npc"):GetInt() == 1) then
											if (ent_skal_hate:Disposition(ent_skal_motta) != D_FR) then
												lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold11")
												addentityrelationship(ent_skal_motta,
													ent_skal_hate,
													D_FR,
													GetConVar("prophr_relationship_amount_npc"):GetInt(),
													"#add_ent_rel16"
												)
											end
										else
											if (GetConVar("prophr_hate_the_hostile_npc"):GetInt() == 1) then
												-- Gjer sånn at NPCen som har på seg PropHr hater den NPCen som hater den
												if (ent_skal_hate:Disposition(ent_skal_motta) != D_HT) then
													lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold12")
													addentityrelationship(ent_skal_motta,
														ent_skal_hate,
														D_HT,
														GetConVar("prophr_relationship_amount_npc"):GetInt(),
														"#add_ent_rel17"
													)
												end
											else
												-- "Normal"; i.e. the relationship will be an Error
												--[[ if (ent_skal_motta:Disposition(ent_skal_hate) != D_ER) then
													ent_skal_motta:AddEntityRelationship(
														ent_skal_hate,
														D_ER,
														GetConVar("prophr_relationship_amount_npc"):GetInt()
													)
												end ]]
											end
										end
									end
								end
							end
						end
					else
						-- På e.g. spawn
						-- Gjelder PropHr-prop/NPC
						leggTilHatForEksisterendeProphr()
					end
					--
					disableThinking()
				else
					-- Ingen fiender
					disableThinking()
				end
			else
				--
				-- Legg til hat for ein PROP
				--
				for k, v in pairs(ents.FindByClass(npc_class)) do
					for l, q in pairs(ents.FindByClass(prophr_ent_npc_class)) do
						if (
							v:IsValid() and
							q:IsValid() and
							v:IsNPC() and
							q:IsNPC() and
							v:GetClass() != prophr_ent_npc_class and
							q:GetParent().prophr != nil and
							q:GetParent().prophr.prophr_hostiles_attacks == 1
						) then
							-- Disabled for Enemy Alien Guard
							if (
								v:GetClass() == q:GetClass() and
								(
									v:GetClass() == "npc_antlionguard" or
									v:GetClass() == "npc_antlion" or
									v:GetClass() == "npc_barnacle"
								)
							) then
								return
							end
							--
							-- Lagre førre forhold
							local ent_skal_hate 	= v
							local ent_skal_motta 	= q
							--
							local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, ent_skal_motta:GetParent(), "prop", "#give_access_control3")
							--
							--
							if (fikk_tilgang) then
								lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold13")
								addentityrelationship(ent_skal_hate,
									ent_skal_motta,
									relationship,
									GetConVar("prophr_relationship_amount_npc"):GetInt(),
									"#add_ent_rel18"
								)
							end
						end
					end
				end
			end
		else
			-- * I might have added more situations than possible, but do not have more time to spend on this *
			--
			disableThinking()
		end
	end
	--
	 -- Grunnlogikk
	--
	if (GetConVar("prophr_hostiles_attacks"):GetInt() == 1) then
		--npcNeutralRelationshipPropFunc(prophr_relationship_amount)
	end
	--
	--
	if (EveryNPC == 0) then
		if (
			(
				ent_isNPC and
				Combine == 0 and
				HumansResistance == 0 and
				Zombies == 0 and
				EnemyAliens == 0
			) or
			GetConVar("prophr_hostiles_attacks"):GetInt() == 0
		) then
			addHateFunc("", true)
		else
			-- Combine
			if (Combine == 1) then
				-- npc_turret_ceiling
				-- npc_combinedropship
				-- npc_combinegunship
				-- npc_helicopter
				-- npc_manhack
				-- npc_metropolice
				-- npc_combine_s
				-- npc_rollermine
				-- npc_strider
				-- npc_turret_floor
				--
				addHateFunc("npc_turret_ceiling", false)
				addHateFunc("npc_combinedropship", false)
				addHateFunc("npc_combinegunship", false)
				addHateFunc("npc_helicopter", false)
				addHateFunc("npc_manhack", false)
				addHateFunc("npc_metropolice", false)
				addHateFunc("npc_combine_s", false)
				addHateFunc("npc_rollermine", false)
				addHateFunc("npc_strider", false)
				addHateFunc("npc_turret_floor", false)
			else
				addHateFunc("", false)
			end
			-- Humans + Resitance
			if (HumansResistance == 1) then
				-- npc_alyx
				-- npc_barney
				-- npc_dog
				-- npc_kleiner
				-- npc_mossman
				-- npc_eli
				-- npc_gman
				-- npc_citizen
				-- npc_vortigaunt
				-- npc_breen
				--
				addHateFunc("npc_alyx", false)
				addHateFunc("npc_barney", false)
				addHateFunc("npc_dog", false)
				addHateFunc("npc_kleiner", false)
				addHateFunc("npc_mossman", false)
				addHateFunc("npc_eli", false)
				addHateFunc("npc_gman", false)
				addHateFunc("npc_citizen", false)
				addHateFunc("npc_vortigaunt", false)
				addHateFunc("npc_breen", false)
			else
				addHateFunc("", false)
			end
			-- Zombies
			if (Zombies == 1) then
				-- npc_headcrab_fast
				-- npc_fastzombie
				-- npc_fastzombie_torso
				-- npc_headcrab
				-- npc_headcrab_black
				-- npc_poisonzombie
				-- npc_zombie
				-- npc_zombie_torso
				--
				addHateFunc("npc_headcrab_fast", false)
				addHateFunc("npc_fastzombie", false)
				addHateFunc("npc_fastzombie_torso", false)
				addHateFunc("npc_headcrab", false)
				addHateFunc("npc_headcrab_black", false)
				addHateFunc("npc_poisonzombie", false)
				addHateFunc("npc_zombie", false)
				addHateFunc("npc_zombie_torso", false)
			else
				addHateFunc("", false)
			end
			if (EnemyAliens == 1) then
				-- npc_antlion
				-- npc_antlionguard
				-- npc_barnacle
				--
				addHateFunc("npc_antlion", false)
				addHateFunc("npc_antlionguard", false)
				addHateFunc("npc_barnacle", false)
			else
				addHateFunc("", false)
			end
		end
		--
		if (GetConVar("prophr_hostiles_attacks"):GetInt() == 1) then
			-- No enemy, but is NPC
			addHateFunc("", false)
		end
	else
		if (EveryNPC == 1) then
			-- Every NPC
			addHateFunc("npc_*", false)
		else
			-- NPC-button disabled
			addHateFunc("", true)
		end
	end
	--
end