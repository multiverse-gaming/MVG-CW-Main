hook.Add("EntityTakeDamage", "PropHr:EntDamage", function(ent_target, ent_dmginfo)
	local ent = ent_target
	local ent_new_health_left = nil
	local bullseye_ent_parent = ent:GetParent()
	--
	--
	-- FOR NPC
	if (
		(
			ent.prophr != nil and
			ent.prophr.isNPC
		)
	) then
		if (
			ent:GetNWBool("prophr_active", false) == true
		) then
			--
			local ent_damage_hit      = ent_dmginfo:GetDamage()
			-- Set new health varible ...
			ent_new_health_left       = ent.prophr.prophr_health_left - ent_damage_hit
			-- ... Apply
			ent.prophr.prophr_health_left    = ent_new_health_left
			ent:SetNWInt("prophr_health_left", ent_new_health_left)
			--
			ent_dmginfo:ScaleDamage(0)
		end
		-- If the NPC is dead
		if (
			ent_new_health_left != nil and
			(
				ent_new_health_left < 0 or ent_new_health_left == 0
			)
		) then
			ent:SetNWBool("prophr_active", false)
			--
			local dmg_info_destory = DamageInfo()
			dmg_info_destory:SetDamage(10)
			dmg_info_destory:SetAttacker(ent)
			dmg_info_destory:SetDamageType(1)
			--
			ent:SetHealth(0)
			ent:TakeDamageInfo(dmg_info_destory)
		end
	else
		--
		-- FOR PROP
		if (
			(
				ent.prophr != nil and
				ent:GetNWBool("prophr_active", false) == true
			)
				or
			(
				bullseye_ent_parent.prophr != nil and
				bullseye_ent_parent:GetNWBool("prophr_active", false) == true
			)
		) then
			-- Check for damage on the PROP (set the var. "ent_new_health_left" option #1)
			if (
				!ent:IsNPC() and
				ent.prophr != nil and
				ent.prophr.prophr_material != "BREAKABLE"
			) then
				--
				local ent_damage_hit			= ent_dmginfo:GetDamage()
				-- Set new health varible ...
				ent_new_health_left				= ent.prophr.prophr_health_left - ent_damage_hit
				-- ... Apply
				ent.prophr.prophr_health_left	= ent_new_health_left
				ent:SetNWInt("prophr_health_left", ent_new_health_left)
			end
			--  Check for damage on the PropHr NPC (npc_bullseye) (set the var. "ent_new_health_left" option #2)
			if (
				ent:IsNPC() and
				ent:GetClass() == prophr_ent_npc_class and
				bullseye_ent_parent.prophr != nil
			) then
				--
				local bullseye_ent_damage						= ent_dmginfo:GetDamage()
				--
				-- Set new health varible ...
				ent_new_health_left								= bullseye_ent_parent.prophr.prophr_health_left - bullseye_ent_damage
				-- ... Apply
				bullseye_ent_parent.prophr.prophr_health_left 	= ent_new_health_left
				bullseye_ent_parent:SetNWInt("prophr_health_left", ent_new_health_left)
				-- Make PropHr NPC not loose any health; have this NPC only as an attack-point
				ent_dmginfo:ScaleDamage(0)
			end
			if (
				!ent:IsNPC() and
				ent.prophr != nil and
				ent.prophr.prophr_material == "BREAKABLE"
			) then
				--
				local ent_damage_hit      = ent_dmginfo:GetDamage()
				-- Set new health varible ...
				ent_new_health_left       = ent.prophr.prophr_health_left - ent_damage_hit
				-- ... Apply
				ent.prophr.prophr_health_left    = ent_new_health_left
				ent:SetNWInt("prophr_health_left", ent_new_health_left)
				--
				ent_dmginfo:ScaleDamage(0)
			end
			
			-- If the item is dead
			if (
				ent_new_health_left != nil and
				(
					ent_new_health_left < 0 or
					ent_new_health_left == 0
				)
			) then
				-- If NPC, set "ent" to be parent of prophr_ent_npc_class
				if (
					ent:IsNPC() and
					ent:GetClass() == prophr_ent_npc_class and
					bullseye_ent_parent.prophr != nil and
					bullseye_ent_parent.prophr.prophr_hostiles_attacks == 1
				) then
					ent = bullseye_ent_parent
				end
				-- Create new random position of killmodel-props
				local ent_z = nil
				local ent_lowest_point, ent_highest_point = ent:GetPhysicsObject():GetAABB()
				local ent_center_point = ent:WorldToLocal(ent:WorldSpaceCenter())
				--
				-- a
				local killmodel_new_pos_a = ent:LocalToWorld(Vector(
					ent_center_point.x + math.random(-45, 45),
					ent_center_point.y + math.random(-45, 45),
					ent_highest_point.z + 22
				))
				-- b
				local killmodel_new_pos_b = ent:LocalToWorld(Vector(
					ent_center_point.x + math.random(-45, 45),
					ent_center_point.y + math.random(-45, 45),
					ent_highest_point.z + 22
				))
				-- c
				local killmodel_new_pos_c = ent:LocalToWorld(Vector(
					ent_center_point.x + math.random(-45, 45),
					ent_center_point.y + math.random(-45, 45),
					ent_highest_point.z + 22
				))
				--
				local killmodel_a = ent.prophr.prophr_killmodel_a
				local killmodel_b = ent.prophr.prophr_killmodel_b
				local killmodel_c = ent.prophr.prophr_killmodel_c
				--
				if (
					killmodel_a != ""
					and killmodel_b != ""
					and killmodel_c != ""
					and ent.prophr.prophr_material != "BREAKABLE"
				) then
					local function legg_til(_killmodel, namn)
						_killmodel:SetAngles(Angle(
							ent:GetAngles().p * math.random(0, 360),
							ent:GetAngles().y * math.random(0, 360),
							ent:GetAngles().r * math.random(0, 360)
						))
						_killmodel:SetMoveType(MOVETYPE_VPHYSICS)
						_killmodel:SetName("["..namn.."]["..ent:EntIndex().."]")
						_killmodel:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
						_killmodel:Spawn()
						--
						local ekstra_energi = ent:GetPhysicsObject():GetInertia() * math.random(0.5, 1.5)
						local velX = (ent:GetPhysicsObject():GetVelocity().x * -1) * math.random(0.7, 1.2)
						local velY = (ent:GetPhysicsObject():GetVelocity().y * -1) * math.random(0.7, 1.2)
						local velZ = (ent:GetPhysicsObject():GetVelocity().z * -1) * math.random(0.7, 1.2)
						--
						local velX_ang = (ent:GetPhysicsObject():GetAngleVelocity().x * -1) * math.random(0.7, 1.1)
						local velY_ang = (ent:GetPhysicsObject():GetAngleVelocity().y * -1) * math.random(0.7, 1.1)
						local velZ_ang = (ent:GetPhysicsObject():GetAngleVelocity().z * -1) * math.random(0.7, 1.1)
						--
						if (velX <= 0) then velX = 1 end
						if (velY <= 0) then velY = 1 end
						if (velZ <= 0) then velZ = 1 end
						--
						if (velX_ang <= 0) then velX_ang = 1 end
						if (velY_ang <= 0) then velY_ang = 1 end
						if (velZ_ang <= 0) then velZ_ang = 1 end
						--
						_killmodel:GetPhysicsObject():AddVelocity(Vector(
							velX + ekstra_energi.x,
							velX + ekstra_energi.y,
							velX + ekstra_energi.z
						))
						_killmodel:GetPhysicsObject():AddAngleVelocity(Vector(
							velX_ang + ekstra_energi.x,
							velY_ang + ekstra_energi.y,
							velZ_ang + ekstra_energi.z
						))
						_killmodel:DrawShadow(false)
						_killmodel:SetRenderMode(RENDERMODE_TRANSALPHA)
					end
					-- a
					local killmodel_a = ents.Create("prop_physics")
					killmodel_a:SetModel(ent.prophr.prophr_killmodel_a)
					if (ent.prophr.prophr_material == "METAL") then
						--
						-- Gjer den litt mindre...
						killmodel_a:SetModelScale(0.5)
					else
						killmodel_a:SetModelScale(0.85)
					end
					killmodel_a:SetPos(killmodel_new_pos_a)
					legg_til(killmodel_a, "killmodel_a")
					-- b
					local killmodel_b = ents.Create("prop_physics")
					killmodel_b:SetModel(ent.prophr.prophr_killmodel_b)
					killmodel_b:SetModelScale(0.85)
					killmodel_b:SetPos(killmodel_new_pos_b)
					legg_til(killmodel_b, "killmodel_b")
					-- c
					local killmodel_c = ents.Create("prop_physics")
					killmodel_c:SetModel(ent.prophr.prophr_killmodel_c)
					if (ent.prophr.prophr_material == "DIRT") then
						--
						-- Gjer den litt mindre...
						killmodel_c:SetModelScale(0.5)
						killmodel_c:SetColor(Color(255, 212, 130, 255))
					else
						killmodel_c:SetModelScale(0.85)
					end
					killmodel_c:SetPos(killmodel_new_pos_c)
					legg_til(killmodel_c, "killmodel_c")
					-- Set timer to animate fading for kill props
					--
					local _i 	= 1
					local _i2 	= 70
					--
					if (prophr_material == "UNKNOWN") then
						local a_color = ColorToHSV(ColorRand(false))
						local b_color = ColorToHSV(ColorRand(false))
						local c_color = ColorToHSV(ColorRand(false))
						--
						killmodel_a:SetColor(HSVToColor(a_color, 0.9, 0.2))
						killmodel_b:SetColor(HSVToColor(b_color, 0.9, 0.2))
						killmodel_c:SetColor(HSVToColor(c_color, 0.9, 0.2))
					end
					--
					killmodel_a:SetModelScale(0, 6.2)
					killmodel_b:SetModelScale(0, 6.2)
					killmodel_c:SetModelScale(0, 6.2)
					-- i 9 sekund
					timer.Create("[prophr_animateKillProps]["..ent:EntIndex().."]", 0.09, 100, function()
						if (
							_i2 <= 50 and
							killmodel_a:IsValid() and
							killmodel_b:IsValid() and
							killmodel_c:IsValid()
						) then
							local killmodel_a_farge = killmodel_a:GetColor()
							local killmodel_b_farge = killmodel_b:GetColor()
							local killmodel_c_farge = killmodel_c:GetColor()
							--
							killmodel_a:SetColor(
								Color(killmodel_a_farge.r, killmodel_a_farge.g, killmodel_a_farge.b, (255 * _i))
							)
							killmodel_b:SetColor(
								Color(killmodel_b_farge.r, killmodel_b_farge.g, killmodel_b_farge.b, (255 * _i))
							)
							killmodel_c:SetColor(
								Color(killmodel_c_farge.r, killmodel_c_farge.g, killmodel_c_farge.b, (255 * _i))
							)
							
							_i = _i - 0.02

							if (255 * _i <= 0) then
								-- a
								killmodel_a:Remove()
								-- b
								killmodel_b:Remove()
								-- c
								killmodel_c:Remove()
							end
						end
						--
						_i2 = _i2 - 1
					end)
				end
				-- Remove old children connected to prop
				for k, v in pairs(ent:GetChildren()) do
					if (
						v:IsNPC() and
						v:GetClass() == prophr_ent_npc_class and
						string.match(v:GetName(),
						"prophr_npc_ent")
					) then
						prophr_slett_entity(v, "#slett_ent1")
					end
				end
				-- Remove Old, killed Prop
				ent:SetNWBool("prophr_active", false)
				
				if (
					ent.prophr != nil and
					ent.prophr.prophr_material == "BREAKABLE"
				) then
					-- For breakable props (need 'DamageInfo()' for NPC's to be able to destory the prop)
					local dmg_info_destory = DamageInfo()

					dmg_info_destory:SetDamage(10)
					dmg_info_destory:SetAttacker(ent)
					dmg_info_destory:SetDamageType(1)
					--
					ent:SetHealth(0)
					ent:TakeDamageInfo(dmg_info_destory)
				else
					-- For unbreakable props
					ent:Remove()
				end
			end
		else return nil end
	end
end)