function addentityrelationship(ent_skal_hate, ent_skal_motta, forhold, priority, id_plass)
    if (
        ent_skal_hate != nil and
        ent_skal_motta != nil and
        ent_skal_hate:IsValid() and
        ent_skal_motta:IsValid() and
        #ent_skal_motta:GetChildren() > 0
    ) then
        --
        -- Om det ikkje er riktig NPC
        for k, v in pairs(ent_skal_motta:GetChildren()) do
            --
            local funnet_ein_prophr_npc_ent = false
            --
            if (
                v:GetName() == "prophr_npc_ent"
            ) then
                funnet_ein_prophr_npc_ent = true
                --
                if (
                    ent_skal_hate:IsValid() and
                    v:IsValid() and
                    forhold != nil and
                    ent_skal_hate:Disposition(v) != forhold
                ) then
                    if (prophr_print_out_relationships_in_console()) then
                        print("..................................................")
                        print(id_plass, ent_skal_hate, v, "rel.type (1.0): "..forhold, "amount: "..priority)
                        print("..................................................")
                    end
                    ent_skal_hate:AddEntityRelationship(
                        v,
                        forhold,
                        priority
                    )
                end
            end
            --
            if (
                funnet_ein_prophr_npc_ent == false and
                k == #ent_skal_motta:GetChildren()
            ) then
                --
                -- Spekulerer for at det er ein NPC med e.g. eit våpen, som gjer den har andre unga
                if (
                    ent_skal_hate:IsValid() and
                    ent_skal_motta:IsValid() and
                    forhold != nil and
                    ent_skal_hate:Disposition(ent_skal_motta) != forhold
                ) then
                    if (prophr_print_out_relationships_in_console()) then
                        print("..........................................................................................")
                        print(id_plass, ent_skal_hate, ent_skal_motta, "rel.type (1.1): "..forhold, "amount: "..priority)
                        print("...........................................................................................")
                    end
                    ent_skal_hate:AddEntityRelationship(
                        ent_skal_motta,
                        forhold,
                        priority
                    )
                end
            end
        end
    else
        --
        -- Vanlig
        if (
            ent_skal_hate != nil and
            ent_skal_motta != nil and
            ent_skal_hate:IsValid() and
            ent_skal_motta:IsValid() and
            ent_skal_hate:Disposition(ent_skal_motta) != forhold
        ) then
            if (prophr_print_out_relationships_in_console()) then
                print("..........................................................................................")
                print(id_plass, ent_skal_hate, ent_skal_motta, "rel.type (2): "..forhold, "amount: "..priority)
                print("...........................................................................................")
            end
            ent_skal_hate:AddEntityRelationship(
                ent_skal_motta,
                forhold,
                priority
            )
        else
            -- DETTE ER EIGENTLEG IKKJE EIT PROBLEM...
            --PrintMessage(HUD_PRINTTALK, "PropHr ERROR (addentityrelationship) : Unknown entity... One entity is not valid.")
        end
    end
end