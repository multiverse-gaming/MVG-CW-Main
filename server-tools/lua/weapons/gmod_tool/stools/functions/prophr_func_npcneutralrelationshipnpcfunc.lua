function npcNeutralRelationshipNPCFunc(relationship_amount, ent)
	-- LAG PÅ NYTT...
	-- START
	-- Løkk igjennom 'ent' (skal alltid vere mottakar..) sine fiender
	-- Nøytraliser ein og ein, + slett 'ent' frå deira tabell
	-- Når alle er kjøyrt igjennom, nøytralisert forholdet (mottakar og hater)
	-- og sletta frå deira tabell, slett 'ent' sin tabell
	-- FERDIG
	if (ent.prophr_prophr_relationship_to_npc != nil) then
		--
		function _ja(original_rel, ent_skal_hate, ent_skal_motta)
			if (ent_skal_motta.prophr == nil) then return end
			--
			if (prophr_print_out_relationships_in_console()) then
				print("Original relationship (D_ Enums): "..original_rel)
			end
			-- Nøytraliser forhold
			--
			prophr_print_out_NPC_relationship(ent_skal_hate, ent_skal_motta, true, "#netural_relationship1")
			--
			addentityrelationship(ent_skal_hate,
				ent_skal_motta,
				original_rel,
				ent_skal_motta.prophr.prophr_relationship_amount_npc,
				"#add_ent_rel5"
			)
			--
			-- Slett mottakar frå hatar sin tabell
			if (ent_skal_hate.prophr_npc_relationship_to_prophr != nil) then
				for l, w in pairs(ent_skal_hate.prophr_npc_relationship_to_prophr) do
					if (w.prophr_npc_ent == ent_skal_motta) then
						-- Slett
						table.remove(ent_skal_hate.prophr_npc_relationship_to_prophr, l)
						if (next(ent_skal_hate.prophr_npc_relationship_to_prophr) == nil) then
							ent_skal_hate.prophr_npc_relationship_to_prophr = nil
						end
					end
				end
			end
			--
			--
			if (k == #ent.prophr_prophr_relationship_to_npc) then
				-- Slett mottakar sin table
				ent.prophr_prophr_relationship_to_npc = nil
			end
		end
		--
		-- Løkk igjennom
		for k, v in pairs(ent.prophr_prophr_relationship_to_npc) do
			--
			local ent_skal_hate		= v.hostile_npc_ent
			local ent_skal_motta	= ent
			local original_rel1		= v.original_rel_to_prophr_npc
			local original_rel2		= nil
			--
			-- For å finne riktig originalt forhold, må det gjerest slik
			if (ent_skal_hate.prophr_npc_relationship_to_prophr != nil) then
				for l, w in pairs(ent_skal_hate.prophr_npc_relationship_to_prophr) do
					if (w.prophr_npc_ent == ent_skal_motta) then
						--
						-- Funnet mottakar i hatar sin tabell
						original_rel2	= w.original_rel_to_hostile_npc
					end
				end
			end
			--
			-- Høgare  == liker betre.. Det kan skje
			-- at forholdene mixes opp når ein hater ein anna
			-- før det legges til originalt forhold.. og då
			-- vil det vere ugyldig, og få feil originalt forhold
			-- "frå spelet". Vil ha det høgaste forholdet,
			-- sidan det mest sannsynlig er det gyldige orignal-forholdet
			if (original_rel1 == nil) then
				_ja(original_rel2, ent_skal_hate, ent_skal_motta)
			else
				if (original_rel2 == nil) then
					_ja(original_rel1, ent_skal_hate, ent_skal_motta)
				else
					if (original_rel1 > original_rel2) then
						_ja(original_rel1, ent_skal_hate, ent_skal_motta)
					else
						_ja(original_rel2, ent_skal_hate, ent_skal_motta)
					end
				end
			end
		end
	end
end