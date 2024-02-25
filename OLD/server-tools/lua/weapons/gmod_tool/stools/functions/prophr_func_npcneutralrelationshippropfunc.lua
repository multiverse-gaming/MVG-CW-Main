local function npcNeutralRelationshipPropFunc(prophr_relationship_amount)
	-- Make NPC's (Hostile) Neutral for THE PropHr-prop
	for k, v in pairs(ents.FindByClass("npc_*")) do
		for l, q in pairs(ents.FindByClass(prophr_ent_npc_class)) do
			if (
				v:IsValid() and
				q:IsValid() and
				v:IsNPC() and
				q:IsNPC() and
				v:GetClass() != prophr_ent_npc_class and
				q:GetParent().prophr != nil
			) then
				addentityrelationship(v,
					q,
					D_NU,
					GetConVar("prophr_relationship_amount_npc"):GetInt(),
					"#add_ent_rel11"
				)
			end
		end
	end
end