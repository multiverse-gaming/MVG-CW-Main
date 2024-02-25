function TOOL:LeftClick(tr)
	if CLIENT then return true end
	--
	local ent = tr.Entity
	local eiger = self.SWEP:GetOwner()
	if (ent:GetCollisionGroup() == COLLISION_GROUP_DEBRIS) then return false end
	local isNPCAttackable = false
	local isNPC = false
	local e_knapp_nede = eiger:KeyDown(IN_USE)
	if (prophr_print_out_relationships_in_console() and e_knapp_nede) then
		print("(PropHr) LEFT-CLICK + 'E'-KEY activated on:", ent)
	else
		if (prophr_print_out_relationships_in_console()) then
			print("(PropHr) LEFT-CLICK activated on:", ent)
		end
	end
	--
	--
	--
	-- Settings from VGUI-panel
	local health                  = eiger:GetNWInt("prophr_health", 100)
	local health_left             = eiger:GetNWInt("prophr_health", 100)
	--
	--
	local health_bar_active       = eiger:GetNWInt("prophr_health_bar_active", 1)
	local health_left_text_active = eiger:GetNWInt("prophr_health_left_text_active", 0)
	--
	local prophr_hostiles_attacks         = eiger:GetNWInt("prophr_hostiles_attacks", 0)
	local prophr_Combines_attacks         = eiger:GetNWInt("prophr_Combines_attacks", 0)
	local prophr_HumansResistance_attacks = eiger:GetNWInt("prophr_HumansResistance_attacks", 0)
	local prophr_Zombies_attacks          = eiger:GetNWInt("prophr_Zombies_attacks", 0)
	local prophr_EnemyAliens_attacks      = eiger:GetNWInt("prophr_EnemyAliens_attacks", 0)
	local prophr_EveryNPC_attacks         = eiger:GetNWInt("prophr_EveryNPC_attacks", 1)
	--
	local prophr_new_health_onchange     = eiger:GetNWInt("prophr_new_health_onchange", 1)
	local prophr_new_healthLeft_onchange = eiger:GetNWInt("prophr_new_healthLeft_onchange", 1)
	--
	local prophr_disable_thinking = eiger:GetNWInt("prophr_disable_thinking", 0)
	--
	local prophr_fear_the_hostile_npc = eiger:GetNWInt("prophr_fear_the_hostile_npc", 0)
	local prophr_hate_the_hostile_npc = eiger:GetNWInt("prophr_hate_the_hostile_npc", 0)
	--
	local prophr_single_connection_with_class = eiger:GetNWInt("prophr_single_connection_with_class", 0)
	--
	local prophr_optimized_hitbox_system = eiger:GetNWInt("prophr_optimized_hitbox_system", 0)
	--
	local prophr_relationship_amount_npc = eiger:GetNWInt("prophr_relationship_amount_npc", 99)
	--
	local prophr_health_reset_timer_checkbox 		= eiger:GetNWInt("prophr_health_reset_timer_checkbox", 0)
	local prophr_health_reset_timer_value 			= eiger:GetNWFloat("prophr_health_reset_timer_value", 1)
	local prophr_health_reset_timer_interval_value 	= eiger:GetNWInt("prophr_health_reset_timer_interval_value", 0)
	--
	local prophr_print_out_relationships_in_console = eiger:GetNWInt("prophr_print_out_relationships_in_console", 0)
	--
	--
	-- Health : =1 = unbreakable (metal, concret), >1 = breakable
	local ent_health   = ent:GetMaxHealth()
	local ent_material = ent:GetMaterialType()
	--
	local ent_original_blood_color = nil
	--
	-- Reset health
	local check_prophr = ent.prophr
	if (check_prophr == nil) then
		if (ent:GetParent().prophr != nil) then
			-- Om du treffer ein hitbox
			--
			check_prophr = ent:GetParent().prophr
		end
	end
	if (prophr_new_health_onchange == 0) then
		if (check_prophr != nil) then
			--
			--
			if (health <= check_prophr.prophr_health) then
				health = check_prophr.prophr_health
			else
				if (prophr_new_healthLeft_onchange == 1) then
					PrintMessage(HUD_PRINTTALK, "(PropHr Settings) Updated the health, since the new 'health left' is higher than the previous health.")
				end
			end
		end
	end
	if (prophr_new_healthLeft_onchange == 0) then
		if (check_prophr != nil) then
			--
			--
			if (health >= check_prophr.prophr_health) then
				health_left = check_prophr.prophr_health_left
			else
				PrintMessage(HUD_PRINTTALK, "(PropHr Settings) Updated the 'health left', since the new health is lower than the previous health.")
			end
		end
	end
	--
	--
	--
	-- For om brukar vil at ein prop/NPC og ein NPC (eller NPC-klasse) skal angripe ein prop
	if (
		e_knapp_nede and
		ent:IsValid()
	) then
		if (#prophr_spesific_relationship > 0) then
			if (
				(
					prophr_spesific_relationship[1] != nil and
					!prophr_spesific_relationship[1]:IsValid()
				)
					or
				(
					prophr_spesific_relationship[2] != nil and
					!prophr_spesific_relationship[2]:IsValid()
				)
			) then
				-- Reset
				resetSpesificRel()

				-- Legg til fyrste (nr. 1/2) Entity
				table.insert(prophr_spesific_relationship, ent)

				return true
			end
		end

		if (#prophr_spesific_relationship == 0) then
			-- Legg til fyrste (nr. 1/2) Entity
			table.insert(prophr_spesific_relationship, ent)

			return true
		else
			if (#prophr_spesific_relationship == 1) then
				-- Legg til fyrste (nr. 2/2) Entity
				table.insert(prophr_spesific_relationship, ent)

				if (prophr_spesific_relationship[1] == prophr_spesific_relationship[2]) then
					-- Visst det er same entity =>
					-- Reset
					resetSpesificRel()

					return true
				end
			else
				if (#prophr_spesific_relationship > 2) then
					-- Reset
					resetSpesificRel(true)

					return true
				end
			end
		end
	else
		-- Reset
		resetSpesificRel()
	end
	local prophr_single_connection 						= false
	local prophr_single_connection_with_class_NPC_Class = nil
	 --
	-- Bytt om, om nødvendig... [1] skal vere NPC-hater, [2] skal vere NPC eller Parent Prop (ikkje npc_bullseye !)
	if (
		e_knapp_nede and
		prophr_spesific_relationship[1] != nil and
		prophr_spesific_relationship[2] != nil and
		!string.match(prophr_spesific_relationship[1]:GetClass(), "npc_")
	) then
		local nr1 = prophr_spesific_relationship[1]
		local nr2 = prophr_spesific_relationship[2]

		prophr_spesific_relationship[1] = nr2
		prophr_spesific_relationship[2] = nr1
		--
		ent 	= prophr_spesific_relationship[2]
		isNPC 	= false
	end
	--
	if (
		prophr_spesific_relationship[1] != nil and
		prophr_spesific_relationship[1]:IsValid()
	) then
		prophr_single_connection_with_class_NPC_Class = prophr_spesific_relationship[1]:GetClass()
	end
	if (prophr_single_connection_with_class_NPC_Class == nil) then
		prophr_single_connection_with_class = 0
	end
	--
	if (
		prophr_spesific_relationship[1] != nil and
		prophr_spesific_relationship[2] != nil and
		prophr_spesific_relationship[1]:IsValid() and
		prophr_spesific_relationship[2]:IsValid()
	) then
		prophr_single_connection = true
	end
	--
	-- Nøytraliser forhold for alle NPC fyrst for så å legge til evt. nye...
	if (!prophr_single_connection) then
		-- Lagre original blod-farge
		if (ent.prophr == nil) then
			ent_original_blood_color = ent:GetBloodColor()
		else
			ent_original_blood_color = ent.prophr.original_blood_color
		end
		--
		reset_reload(prophr_relationship_amount_npc, ent, false)
	end
	--
	--
	-- Get the Prop-Entity
	if (
		ent:IsNPC() and
		ent:GetClass() == prophr_ent_npc_class and
		string.match(ent:GetName(), "prophr_npc_ent")
	) then
		ent = ent:GetParent()
	else
		-- It is a NPC and not a prop
		if (
			ent:IsNPC() and
			string.match(ent:GetClass(), "npc_") and
			ent:GetClass() != prophr_ent_npc_class
		) then
			isNPC = true
		else
			-- Is Prop or Ragdoll
			local ent_npc_hitbox = nil
			if (!ent:IsValid()) then return false end
			if (
				ent:GetClass() != "prop_physics" and
				ent:GetClass() != "prop_ragdoll"
			) then
				ent_npc_hitbox = ent
				ent = ent:GetParent()
			end
			if (!ent:IsValid()) then return false end

			local ent_aabb_min, ent_aabb_max = ent:GetPhysicsObject():GetAABB()
			if ((ent:WorldToLocal(tr.HitPos).z - 10) > ent_aabb_max.z) then
				return false
			end
		end
	end
	--
	-- Everything OK =>
	--
	local data_object_prophr = nil
	--
	-- UNIK ID for single-connection (mellom to entity) Brukes for validering om det er ein normal entitiy spawna/kobla.. eller ikkje
	local single_connection_unik_id = 0
	--
	if (e_knapp_nede) then
		single_connection_unik_id = (
			(ent:GetPos().x +
			ent:GetPos().y +
			ent:GetPos().z +
			ent:GetAngles().x +
			ent:GetAngles().y +
			ent:GetAngles().z)
			*
			os.time()
			/
			math.random(-1000, 1000)
		)
		--
		local ent_skal_hate 	= prophr_spesific_relationship[1]
		local ent_skal_motta 	= prophr_spesific_relationship[2]

		-- Avbryt
		if (!ent_skal_hate:IsNPC()) then return true end
		
		--
		if (ent_skal_hate.prophr_single_connection_id == nil) then ent_skal_hate.prophr_single_connection_id = {} end
		if (ent_skal_motta.prophr_single_connection_id == nil) then ent_skal_motta.prophr_single_connection_id = {} end
		--
		--
		table.insert(ent_skal_hate.prophr_single_connection_id, single_connection_unik_id)
		table.insert(ent_skal_motta.prophr_single_connection_id, single_connection_unik_id)
	else
		if (ent.prophr_single_connection_id == nil) then ent.prophr_single_connection_id = {} end
		table.insert(ent.prophr_single_connection_id, single_connection_unik_id)
	end
	--
	--
	if (isNPC) then
		-- If PropHr is used on a NPC for custom health + NPC-attack
		data_object_prophr = {
			prophr_ent                      = ent,
			--
			prophr_ent_npc_parent_pos_unik_id	= duplicator.CopyEntTable(ent).Pos,
			prophr_ent_npc_parent_ang_unik_id  	= duplicator.CopyEntTable(ent).Angle,
			--
			original_blood_color				= ent_original_blood_color,
			--
			prophr_ent_class				= ent:GetClass(),
			isNPC							= true,
			prophr_disable_thinking			= prophr_disable_thinking,
			prophr_fear_the_hostile_npc 	= prophr_fear_the_hostile_npc,
			prophr_hate_the_hostile_npc 	= prophr_hate_the_hostile_npc,
			-- Bruker dette som id til å finne ut om det er ein samankobling mellom to ents..
			-- Aka. ein duplikasjon ved bruk av "E" holdt inn for å legge til forhold fyrst
			--
			prophr_single_connection_id						= single_connection_unik_id, -- Brukes berre til å kopiere verdi når Entitty blir duplisert. Ellers ligger den rett under "prophr_single_connection_id"
			prophr_single_connection						= prophr_single_connection,
			prophr_single_connection_with_class 			= prophr_single_connection_with_class,
			prophr_single_connection_with_class_NPC_Class 	= prophr_single_connection_with_class_NPC_Class,
			--
			isDuplicated = false,
			--
			prophr_healt_type              	= ent_health,
			prophr_health                   = health,
			prophr_health_left              = health_left,
			prophr_health_bar_active        = health_bar_active,
			prophr_health_left_text_active  = health_left_text_active,
			--
			prophr_new_health_onchange      = prophr_new_health_onchange,
			prophr_new_healthLeft_onchange  = prophr_new_healthLeft_onchange,
			--
			prophr_hostiles_attacks         = prophr_hostiles_attacks,
			prophr_Combines_attacks         = prophr_Combines_attacks,
			prophr_HumansResistance_attacks = prophr_HumansResistance_attacks,
			prophr_Zombies_attacks    		= prophr_Zombies_attacks,
			prophr_EnemyAliens_attacks    	= prophr_EnemyAliens_attacks,
			prophr_EveryNPC_attacks         = prophr_EveryNPC_attacks,
			--
			prophr_relationship_amount_npc 	= prophr_relationship_amount_npc
		}
		--
		if (
			prophr_new_health_onchange == 0 and
			prophr_new_healthLeft_onchange == 0
		) then
			if (ent.prophr != nil) then
				--
				data_object_prophr.prophr_health 		= ent.prophr.prophr_health
				data_object_prophr.prophr_health_left 	= ent.prophr.prophr_health_left
			end
		end
		if (
			prophr_new_health_onchange == 1 and
			prophr_new_healthLeft_onchange == 0
		) then
			if (ent.prophr != nil) then
				if (ent.prophr.prophr_health_left > health) then
					--
					data_object_prophr = data_object_prophr
				end
				if (ent.prophr.prophr_health_left < health) then
					--
					data_object_prophr.prophr_health_left = ent.prophr.prophr_health_left
				end
			end
		end
		ent.prophr = data_object_prophr
		--
		if (ent.prophr.prophr_disable_thinking == 0) then
			-- Remove all possible flags
			ent:RemoveEFlags(EFL_NO_THINK_FUNCTION)
		end	
	else
		-- If PropHr is used on a prop for custom health + NPC-attack
		local prophr_prophr_material = ""
		local prophr_killmodel_a     = ""
		local prophr_killmodel_b     = ""
		local prophr_killmodel_c     = ""
		-- Metal
		if (ent_material == MAT_METAL) then
			prophr_material = "METAL"
			killmodel_a     = "models/mechanics/solid_steel/i_beam_4.mdl"
			killmodel_b     = "models/props_phx/gears/bevel9.mdl"
			killmodel_c     = "models/props_c17/oildrumchunk01c.mdl"
		end
		-- Concrete
		if (ent_material == MAT_CONCRETE) then
			prophr_material = "CONCRETE"
			killmodel_a     = "models/props_junk/cinderblock01a.mdl"
			killmodel_b     = "models/props_junk/cinderblock01a.mdl"
			killmodel_c     = "models/props_junk/cinderblock01a.mdl"
		end
		-- Plastic
		if (ent_material == MAT_PLASTIC) then
			prophr_material = "PLASTIC"
			killmodel_a     = "models/props_c17/doll01.mdl"
			killmodel_b     = "models/props_lab/huladoll.mdl"
			killmodel_c     = "models/props_junk/garbage_plasticbottle003a.mdl"
		end
		-- Dirt (e.g. a couch uses dirt-material)
		if (ent_material == MAT_DIRT) then
			prophr_material = "DIRT"
			killmodel_a     = "models/gibs/wood_gib01b.mdl"
			killmodel_b     = "models/gibs/wood_gib01c.mdl"
			killmodel_c     = "models/props_phx/construct/wood/wood_panel1x1.mdl"
		end
		if (
			ent_material == MAT_FLESH
			or ent_material == MAT_BLOODYFLESH
		) then -- RAGDOLLS
			prophr_material = "FLESH"
			killmodel_a     = "models/Gibs/HGIBS.mdl"
			killmodel_b     = "models/Gibs/HGIBS_spine.mdl"
			killmodel_c     = "models/Gibs/HGIBS_rib.mdl"
		end
		-- Breakables (e.g. wood or glass)
		if (
			ent:GetClass() == "func_breakable" or
			ent_health != 1
			and ent:GetClass() != "prop_ragdoll"
		) then
			prophr_material = "BREAKABLE"
		else
			--
			-- Visst ingen av dei andre
			if (
				ent_material != MAT_METAL
				and ent_material != MAT_CONCRETE
				and ent_material != MAT_PLASTIC
				and ent_material != MAT_DIRT
				and ent_material != MAT_FLESH
				and ent_material != MAT_BLOODYFLESH
			) then
				--
				prophr_material = "UNKNOWN"
				killmodel_a     = "models/hunter/blocks/cube025x025x025.mdl"
				killmodel_b     = "models/hunter/blocks/cube025x025x025.mdl"
				killmodel_c     = "models/hunter/blocks/cube025x025x025.mdl"
			end
		end
		--
		-- Write new child-entity properties
		data_object_prophr = {
			prophr_ent                      = ent,
			-- Bruker dette som id til å finne ut om det er ein samankobling mellom to ents..
			-- Aka. ein duplikasjon ved bruk av "E" holdt inn for å legge til forhold fyrst
			prophr_ent_npc_parent_pos_unik_id	= duplicator.CopyEntTable(ent).Pos,
			prophr_ent_npc_parent_ang_unik_id	= duplicator.CopyEntTable(ent).Angle,
			--
			original_blood_color				= ent_original_blood_color,
			--
			prophr_ent_class				= ent:GetClass(),
			isNPC							= false,
			--
			prophr_single_connection_id						= single_connection_unik_id, -- Brukes berre til å kopiere verdi når Entitty blir duplisert. Ellers ligger den rett under "prophr_single_connection_id"
			prophr_single_connection						= prophr_single_connection,
			prophr_single_connection_with_class 			= prophr_single_connection_with_class,
			prophr_single_connection_with_class_NPC_Class 	= prophr_single_connection_with_class_NPC_Class,
			--
			isDuplicated = false,
			--
			prophr_optimized_hitbox_system	= prophr_optimized_hitbox_system,
			--
			prophr_healt_type               = ent_health,
			prophr_health                   = health,
			prophr_health_left              = health_left,
			prophr_health_bar_active        = health_bar_active,
			prophr_health_left_text_active  = health_left_text_active,
			--
			prophr_new_health_onchange      = prophr_new_health_onchange,
			prophr_new_healthLeft_onchange  = prophr_new_healthLeft_onchange,
			--
			prophr_hostiles_attacks         = prophr_hostiles_attacks,
			prophr_Combines_attacks         = prophr_Combines_attacks,
			prophr_HumansResistance_attacks = prophr_HumansResistance_attacks,
			prophr_Zombies_attacks    		= prophr_Zombies_attacks,
			prophr_EnemyAliens_attacks    	= prophr_EnemyAliens_attacks,
			prophr_EveryNPC_attacks         = prophr_EveryNPC_attacks,
			--
			prophr_relationship_amount_npc 	= prophr_relationship_amount_npc,
			--
			prophr_material                 = prophr_material,
			--
			prophr_killmodel_a              = killmodel_a,
			prophr_killmodel_b              = killmodel_b,
			prophr_killmodel_c              = killmodel_c
		}
		--
		if (
			prophr_new_health_onchange == 0 and
			prophr_new_healthLeft_onchange == 0
		) then
			if (ent.prophr != nil) then
				--
				data_object_prophr.prophr_health 		= ent.prophr.prophr_health
				data_object_prophr.prophr_health_left 	= ent.prophr.prophr_health_left
			end
		end
		if (
			prophr_new_health_onchange == 1 and
			prophr_new_healthLeft_onchange == 0
		) then
			if (ent.prophr != nil) then
				if (ent.prophr.prophr_health_left > health) then
					--
					data_object_prophr = data_object_prophr
				end
				if (ent.prophr.prophr_health_left < health) then
					--
					data_object_prophr.prophr_health_left = ent.prophr.prophr_health_left
				end
			end
		end
		--
		--
		ent.prophr = data_object_prophr
		--
		-- Remove all children of entity with the respective class (the old one)
		if (!e_knapp_nede) then
			for k, v in pairs(ent:GetChildren()) do
				if (
					v:IsNPC() and
					v:GetClass() == prophr_ent_npc_class and
					string.match(v:GetName(), "prophr_npc_ent")
				) then
					--
					-- Slett frå hater sin "hate-data"
					if (v.prophr_prophr_relationship_to_npc != nil) then
						for l, x in pairs(v.prophr_prophr_relationship_to_npc) do
							-- Finn mottaker NPC
							if (x.hostile_npc_ent == v) then
								table.remove(v.prophr_prophr_relationship_to_npc, l)
								-- Om tabel er tom => sett den til nil
								if (next(v.prophr_prophr_relationship_to_npc) == nil) then
									v.prophr_prophr_relationship_to_npc = nil
								end
							end
						end
					end
					--
					prophr_slett_entity(v, "#slett_ent4")
				end
			end
		end
	end
	--
	-- Set network-varibles
	-- for the PropHr-prop
	ent:SetNWBool("prophr_active", true)
	--
	ent:SetNWInt("prophr_health", ent.prophr.prophr_health)
	ent:SetNWInt("prophr_health_left", ent.prophr.prophr_health_left)
	--
	ent:SetNWBool("prophr_health_bar_active", ent.prophr.prophr_health_bar_active)
	ent:SetNWBool("prophr_health_left_text_active", ent.prophr.prophr_health_left_text_active)
	--
	ent:SetNWBool("prophr_Combines_attacks", ent.prophr.prophr_Combines_attacks)
	ent:SetNWBool("prophr_HumansResistance_attacks", ent.prophr.prophr_HumansResistance_attacks)
	ent:SetNWBool("prophr_Zombies_attacks", ent.prophr.prophr_Zombies_attacks)
	ent:SetNWBool("prophr_EnemyAliens_attacks", ent.prophr.prophr_EnemyAliens_attacks)
	ent:SetNWBool("prophr_EveryNPC_attacks", ent.prophr.prophr_EveryNPC_attacks)
	--
	ent:SetNWBool("prophr_relationship_amount_npc", ent.prophr.prophr_relationship_amount_npc)
	--
	ent:SetNWBool("prophr_isNPC", ent.prophr.isNPC)
	--
	--
	-- Set blood color (kan berre ha den her... Sjølv om props ikkje vil ha blodfarge til vanlig)
	if (prophr_npc_blood_color != -2) then
		ent:SetBloodColor(prophr_npc_blood_color)
	else
		if (ent.prophr != nil) then
			ent:SetBloodColor(ent.prophr.original_blood_color)
		end
	end
	--
	if (isNPC) then
		-- NPC-data
		--
		-- Set network-varibles
		--
		ent:SetNWInt("prophr_disable_thinking", ent.prophr.prophr_disable_thinking)
		--
		--
		if (e_knapp_nede) then
			--
			-- Legg til single-connection
			if (
				prophr_single_connection and
				prophr_single_connection_with_class == 0
			) then
				local ent_skal_hate 	= prophr_spesific_relationship[1]
				local ent_skal_motta 	= prophr_spesific_relationship[2]
				--
				-- Vanlig
				lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold97")
				addentityrelationship(ent_skal_hate,
					ent_skal_motta,
					D_HT,
					ent_skal_motta.prophr.prophr_relationship_amount_npc,
					"#add_ent_rel97"
				)
			else
				-- Legg til single-connection for klasse
				--
				local ent_skal_motta	= prophr_spesific_relationship[2]
				--
				for k, v in pairs(ents.FindByClass(prophr_spesific_relationship[1]:GetClass())) do
					if (
						v:IsValid() and
						v != ent_skal_motta
					) then
						local ent_skal_hate	= v
						--
						local fikk_tilgang = gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, ent_skal_motta, "npc", "#give_access_control5")
						--
						if (fikk_tilgang) then
							lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold68")
							addentityrelationship(ent_skal_hate,
								ent_skal_motta,
								D_HT,
								ent_skal_motta.prophr.prophr_relationship_amount_npc,
								"#add_ent_rel68"
							)
						end
					end
				end
			end
		else
			--
			if (prophr_hostiles_attacks == 1) then
				-- Mellom to spesifikke eller NPC-klasse
				-- Make the given NPC-group(s) hate the prop/NPC
				npcRelationshipPropFunc(
					D_HT,
					prophr_relationship_amount_npc,
					prophr_Combines_attacks,
					prophr_HumansResistance_attacks,
					prophr_Zombies_attacks,
					prophr_EnemyAliens_attacks,
					prophr_EveryNPC_attacks,
					true,
					ent,
					nil,
					nil,
					false
				)
			else
				-- Make the given NPC-group(s) netural for the prop/NPC
				npcNeutralRelationshipPropFunc(prophr_relationship_amount_npc)
				
				-- This will only be for disabling e.g. thinking
				npcRelationshipPropFunc(
					D_HT,
					prophr_relationship_amount_npc,
					prophr_Combines_attacks,
					prophr_HumansResistance_attacks,
					prophr_Zombies_attacks,
					prophr_EnemyAliens_attacks,
					prophr_EveryNPC_attacks,
					true,
					ent,
					nil,
					nil,
					false
				)
			end
		end

		-- For duplicator-tool
		dup_npc_SEM(ent, "prophrNPC", ent.prophr)
	else
		-- PROP-data
		--
		-- Set network-varibles
		--
		ent:SetNWString("prophr_prophr_material", ent.prophr.prophr_material)
		--
		--
		if (e_knapp_nede) then
			-- Create NPC-Hit-target(s)
			createNPCforHitTarget(self:GetOwner(), ent, prophr_ent_npc_class)
			--
			for k, v in pairs(ent:GetChildren()) do
				if (
					v:IsValid() and
					v:GetName() == "prophr_npc_ent"
				) then
					--
					-- Legg til single-connection
					if (
						prophr_single_connection and
						prophr_single_connection_with_class == 0
					) then
						local ent_skal_hate 	= prophr_spesific_relationship[1]
						local ent_skal_motta 	= v
						--
						-- Vanlig
						lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold96")
						addentityrelationship(ent_skal_hate,
							ent_skal_motta,
							D_HT,
							ent.prophr.prophr_relationship_amount_npc,
							"#add_ent_rel96"
						)
					else
						-- Legg til single-connection for klasse
						--
						--
						local ent_skal_motta	= prophr_spesific_relationship[2]
						local ent_skal_hate		= nil
						--
						if (
							prophr_spesific_relationship != nil and
							prophr_spesific_relationship[1] != nil
						) then
							for l, w in pairs(ents.FindByClass(prophr_spesific_relationship[1]:GetClass())) do
								ent_skal_hate = w
								--
								lagreForreForhold(ent_skal_hate, ent_skal_motta, "#lagreførreforhold67")
								addentityrelationship(ent_skal_hate,
									ent_skal_motta,
									D_HT,
									ent_skal_motta.prophr.prophr_relationship_amount_npc,
									"#add_ent_rel67"
								)
							end
						end
					end
				end
			end
		else
			if (prophr_hostiles_attacks == 1) then
				-- Create NPC-Hit-target(s)
				createNPCforHitTarget(self:GetOwner(), ent, prophr_ent_npc_class)
				--
				-- Mellom to spesifikke eller NPC-klasse
				--
				-- Make the given NPC-group(s) hate the prop
				npcRelationshipPropFunc(
					D_HT,
					prophr_relationship_amount_npc,
					prophr_Combines_attacks,
					prophr_HumansResistance_attacks,
					prophr_Zombies_attacks,
					prophr_EnemyAliens_attacks,
					prophr_EveryNPC_attacks,
					false,
					nil,
					nil,
					nil,
					false
				)
				--
			else
				-- Make NPC's (Hostile) Neutral for THE PropHr-prop
				npcNeutralRelationshipPropFunc(prophr_relationship_amount_npc)
			end
		end

		-- For duplicator-tool
		dup_prophr_SEM(ent, "prophr", ent.prophr)
	end
	--
	-- Reset health function
	if (prophr_health_reset_timer_checkbox == 1) then
		timer.Stop("prophr_health_reset_"..ent:EntIndex())
		--
		timer.Create(
			"prophr_health_reset_"..ent:EntIndex(),
			(prophr_health_reset_timer_value * 60),
			prophr_health_reset_timer_interval_value,
			function()
				--
				-- Reset health
				if (ent.prophr != nil) then
					ent:SetNWInt("prophr_health", ent.prophr.prophr_health)
					ent:SetNWInt("prophr_health_left", ent.prophr.prophr_health)
					--
					ent.prophr.prophr_health_left = ent.prophr.prophr_health
				end
			end)
	else
		timer.Stop("prophr_health_reset_"..ent:EntIndex())
	end
	--
	-- Everything OK
	return true
end
