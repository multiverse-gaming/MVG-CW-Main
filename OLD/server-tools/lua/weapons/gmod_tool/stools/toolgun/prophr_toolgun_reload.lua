-- RESET
function reset_reload(rel_amount, ent, reset_tool_vars)
	--
	local isNPC = false
	--
	-- Reset TOOL-varible
	if (reset_tool_vars) then resetSpesificRel() end
	-- Nøytraliser forhold for alle NPC...
	npcNeutralRelationshipNPCFunc(rel_amount, ent)
	--
	timer.Stop("prophr_health_reset_"..ent:EntIndex())
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
			if (
				!ent:IsValid() or
				(
					ent:GetClass() != "prop_physics"
					and ent:GetClass() != "prop_ragdoll"
				)
			) then return false end
		end
	end
	if (ent.prophr == nil) then return false end
	--
	-- If PropHr is activated on entity => Remove PropHr-properties
	if (ent:GetNWBool("prophr_active", false) == true) then
		--
		ent:SetNWBool("prophr_active", false)
		--
		ent:SetNWInt("prophr_health", nil)
		ent:SetNWInt("prophr_health_left", nil)
		--
		ent:SetNWBool("prophr_health_bar_active", nil)
		ent:SetNWBool("prophr_health_left_text_active", nil)
		--
		ent:SetNWBool("prophr_Combines_attacks", nil)
		ent:SetNWBool("prophr_HumansResistance_attacks", nil)
		ent:SetNWBool("prophr_Zombies_attacks", nil)
		ent:SetNWBool("prophr_EnemyAliens_attacks", nil)
		ent:SetNWBool("prophr_EveryNPC_attacks", nil)
		--
		ent:SetNWBool("prophr_relationship_amount_npc", nil)
		--
		ent:SetNWString("prophr_prophr_material", nil)
		--
		if (ent:GetNWBool("prophr_isNPC", false) == true) then ent:SetNWInt("prophr_disable_thinking", nil) end
		--
		ent:SetNWBool("prophr_isNPC", nil)
		--
		-- Remove all children of entity with the respective class (the old ones)
		if (!isNPC) then
			for k, v in pairs(ent:GetChildren()) do
				if (
					v:IsNPC() and
					v:GetClass() == prophr_ent_npc_class and
					string.match(v:GetName(), "prophr_npc_ent")
				) then
					prophr_slett_entity(v, "#slett_ent3")
				end
			end
		else
			-- Remove all possible flags
			ent:RemoveEFlags(EFL_NO_THINK_FUNCTION)
		end
		--
		-- Reset prop
		ent.prophr = nil
		if (ent.EntityMods != nil) then ent.EntityMods.prophr = nil end
		ent:SetCollisionGroup(COLLISION_GROUP_NONE)
		ent:RemoveEFlags(EFL_DONTBLOCKLOS)
	end
end
--
--
function TOOL:Reload(tr)
	if CLIENT then return true end
	--
	local ent = tr.Entity
	--
	if (prophr_print_out_relationships_in_console()) then
		print("(PropHr) 'R'-KEY activated on:", ent)
	end
	--
	reset_reload(GetConVar("prophr_relationship_amount_npc"):GetInt(), ent, true)
	
	-- Everything OK
	return true
end