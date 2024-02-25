hook.Add("OnEntityCreated", "PropHr:EntCreated", function(ent)
    if (
        string.match(ent:GetClass(), "npc_") != nil and
        ent:GetClass() != prophr_ent_npc_class and
        ent:IsValid() and
        ent:IsNPC()
    ) then
        local prophr_Combines_attacks 			= GetConVar("prophr_Combines_attacks"):GetInt()
        local prophr_HumansResistance_attacks 	= GetConVar("prophr_HumansResistance_attacks"):GetInt()
        local prophr_Zombies_attacks 			= GetConVar("prophr_Zombies_attacks"):GetInt()
        local prophr_EnemyAliens_attacks 		= GetConVar("prophr_EnemyAliens_attacks"):GetInt()
        local prophr_EveryNPC_attacks 			= GetConVar("prophr_EveryNPC_attacks"):GetInt()
        --
        -- Make the given NPC-group(s) hate the prop (må ha ein liten delay... For at alt skal fungera saman)
        timer.Simple(0.39, function ()
            if (prophr_print_out_relationships_in_console()) then
                print("+ ++ ++ +")
                print("Spawned entity :", ent)
                print("+ ++ ++ +")
            end
            --
            npcRelationshipPropFunc(
                D_HT,
                GetConVar("prophr_relationship_amount_npc"):GetInt(),
                prophr_Combines_attacks,
                prophr_HumansResistance_attacks,
                prophr_Zombies_attacks,
                prophr_EnemyAliens_attacks,
                prophr_EveryNPC_attacks,
                true,
                nil,
                ent,
                nil,
                true
            )
        end)
    end
end)