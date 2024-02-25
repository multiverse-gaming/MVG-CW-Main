function TOOL:RightClick(tr)
	if (prophr_print_out_relationships_in_console()) then
		print("(PropHr) RIGHT-CLICK activated")
	end
	--
	if CLIENT then return true end
	--
	local ent = tr.Entity
	-- Get the prop-entity
	--
	if (
		ent:IsNPC() and
		ent:GetClass() == prophr_ent_npc_class and
		string.match(ent:GetName(), "prophr_npc_ent")
	) then
		ent = ent:GetParent()
	else
		if (
			!ent:IsValid() or
			ent:GetClass() != "prop_physics" or
			ent:GetClass() != "prop_ragdoll"
		) then return false end
	end
	if (ent.prophr == nil) then return false end
	--
	-- Custom Console-Varibles
	GetConVar("prophr_health"):SetInt(ent.prophr.prophr_health)
	GetConVar("prophr_health_bar_active"):SetInt(ent.prophr.prophr_health_bar_active)
	GetConVar("prophr_health_left_text_active"):SetInt(ent.prophr.prophr_health_left_text_active)
	--
	GetConVar("prophr_hostiles_attacks"):SetInt(ent.prophr.prophr_hostiles_attacks)
	GetConVar("prophr_Combines_attacks"):SetInt(ent.prophr.prophr_Combines_attacks)
	GetConVar("prophr_HumansResistance_attacks"):SetInt(ent.prophr.prophr_HumansResistance_attacks)
	GetConVar("prophr_Zombies_attacks"):SetInt(ent.prophr.prophr_Zombies_attacks)
	GetConVar("prophr_EnemyAliens_attacks"):SetInt(ent.prophr.prophr_EnemyAliens_attacks)
	GetConVar("prophr_EveryNPC_attacks"):SetInt(ent.prophr.prophr_EveryNPC_attacks)
	--
	GetConVar("prophr_relationship_amount_npc"):SetInt(ent.prophr.prophr_relationship_amount_npc)
	--
	GetConVar("prophr_new_health_onchange"):SetInt(ent.prophr.prophr_new_health_onchange)
	GetConVar("prophr_new_healthLeft_onchange"):SetInt(ent.prophr.prophr_new_healthLeft_onchange)
	--
	if (ent.prophr.prophr_fear_the_hostile_npc != nil) then
		GetConVar("prophr_fear_the_hostile_npc"):SetInt(ent.prophr.prophr_fear_the_hostile_npc)
		GetConVar("prophr_hate_the_hostile_npc"):SetInt(ent.prophr.prophr_hate_the_hostile_npc)
	end
	--
	if (ent.prophr.prophr_optimized_hitbox_system != nil) then
		GetConVar("prophr_optimized_hitbox_system"):SetInt(ent.prophr.prophr_optimized_hitbox_system)
	end
	--
	if (ent.prophr.prophr_disable_thinking != nil) then
		GetConVar("prophr_disable_thinking"):SetInt(ent.prophr.prophr_disable_thinking)
	end
	--
	if (ent.prophr.prophr_single_connection_with_class != nil) then
		GetConVar("prophr_single_connection_with_class"):SetInt(ent.prophr.prophr_single_connection_with_class)
	end
	--
	return true
end