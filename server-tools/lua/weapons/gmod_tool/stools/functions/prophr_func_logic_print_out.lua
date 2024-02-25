function prophr_print_out_NPC_relationship(ent_skal_hate, ent_skal_motta, fikk_tilgang, kjem_fraa_id)
    if (prophr_print_out_relationships_in_console()) then
        -- 0 	= An attacker (hater) with a connection to another single-con. entity.
        -- >0 	= A single-con. entity reciver (mottaker)
        -- nil 	= Not a PropHr entity or any connection to other single-con. entities
        --
        print("+")
        print("+-------------------------------------------------------------------------------------------------.")
        print("@@@@=>")
        print("Comes from   => ", kjem_fraa_id)
        print("@@@@=>")
        --
        local nr1 = "(   single-con.ID(s)  "
        local nr2 = "(is a single-con. entity?)"
        local nr3 = "(not a PropHr entity)"
        local nr4 = "single-con.ID(s)  =>  nil"
        local nr5 = "(is single-con.With class)"
        local nr6 = "(single-con.ClassVar and the HATERs class)"
        local nr7 = ""
        --
        local tips = "(can be inacurate... look for '#lagreførreforholdX' before '#add_ent_relX' for a valid situation in case of bugs. Where 'hate' and 'motta' should always get updated tables together. In case of neturalization, only '#add_ent_relX' should be called.)"
        --
        if (ent_skal_hate.prophr_single_connection_id != nil) then
            print("1. (hate)", ent_skal_hate, nr1, table.ToString(ent_skal_hate.prophr_single_connection_id, "=>", true), ")   :   true"..tips)
            print("---")
        else
            print("1. (hate): "..nr4, ":   false")
            print("---")
        end
        if (ent_skal_motta.prophr_single_connection_id != nil) then
            print("1. (motta)", ent_skal_motta, nr1, table.ToString(ent_skal_motta.prophr_single_connection_id, "=>", true), ")   :   true"..tips)
            print("---")
        else
            print("1. (motta): "..nr4, ":   false")
            print("---")
        end
        if (ent_skal_hate.prophr != nil) then
            print("2. NPC (hate):", ent_skal_hate.prophr.prophr_single_connection, nr2)
            print("4. NPC (hate):", ent_skal_hate.prophr.prophr_single_connection_with_class, nr5)
        else
            print("3. NPC (hate):", ent_skal_hate.prophr, nr3)
        end
        if (ent_skal_motta.prophr != nil) then
            print("2. NPC (motta):", ent_skal_motta.prophr.prophr_single_connection, nr2)
            print("4. NPC (motta):", ent_skal_motta.prophr.prophr_single_connection_with_class, nr5)
            if (
                ent_skal_motta.prophr != nil and
                ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class != nil and
                ent_skal_motta.prophr.prophr_single_connection_with_class == 1
            ) then
                print("5. NPC (motta/hate):", "'"..ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class.."' : '"..ent_skal_hate:GetClass().."'", nr6)
            end
        else
            print("3. NPC (motta):", ent_skal_motta.prophr, nr3)
        end
        if (ent_skal_hate.prophr != nil) then
            print("6. NPC (hate) angular  ID: ", ent_skal_hate.prophr.prophr_ent_npc_parent_ang_unik_id)
            print("6. NPC (hate) position ID:", ent_skal_hate.prophr.prophr_ent_npc_parent_pos_unik_id)
        else
            print("6. NPC (hate) angular  unique ID is    =>    nil")
            print("6. NPC (hate) position unique ID is    =>    nil")
        end
        if (ent_skal_motta.prophr != nil) then
            print("6. NPC (motta) angular  ID: ", ent_skal_motta.prophr.prophr_ent_npc_parent_ang_unik_id)
            print("6. NPC (motta) position ID:", ent_skal_motta.prophr.prophr_ent_npc_parent_pos_unik_id)
        else
            print("6. NPC (motta) angular  unique ID is    =>    nil")
            print("6. NPC (motta) position unique ID is    =>    nil")
        end
        --
        --
        print("** ** *********")
        print("(NPC) Adding relationship? Gained access to add    => ", fikk_tilgang)
        print("********* ** **")
        print("+-------------------------------------------------------------------------------------------------.")
    end
end
--
--
function prophr_print_out_PROP_relationship(ent_skal_hate, ent_skal_motta, fikk_tilgang, kjem_fraa_id)
    if (prophr_print_out_relationships_in_console()) then
        -- 0 	= An attacker (hater) with a connection to another single-con. entity.
        -- >0 	= A single-con. entity reciver (mottaker)
        -- nil 	= Not a PropHr entity or any connection to other single-con. entities
        --
        print("+")
        print("+-------------------------------------------------------------------------------------------------.")
        print("@@@@=>")
        print("Comes from   => ", kjem_fraa_id)
        print("@@@@=>")
        --
        local nr1 = "(   single-con.ID(s)  "
        local nr2 = "(is a single-con. entity?)"
        local nr3 = "(not a PropHr entity)"
        local nr4 = "single-con.ID(s)  =>  nil"
        local nr5 = "(is single-con.With class)"
        local nr6 = "(single-con.ClassVar and the HATERs class)"
        local nr7 = ""
        --
        local tips = "(can be inacurate... look for '#lagreførreforholdX' before '#add_ent_relX' for a valid situation in case of bugs. Where 'hate' and 'motta' should always get updated tables together. In case of neturalization, only '#add_ent_relX' should be called.)"
        --
        if (ent_skal_hate.prophr_single_connection_id != nil) then
            print("1. (hate)", ent_skal_hate, nr1, table.ToString(ent_skal_hate.prophr_single_connection_id, "=>", true), ")   :   true"..tips)
            print("---")
        else
            print("1. (hate): "..nr4, ":   false")
            print("---")
        end
        if (ent_skal_motta.prophr_single_connection_id != nil) then
            print("1. (motta)", ent_skal_motta, nr1, table.ToString(ent_skal_motta.prophr_single_connection_id, "=>", true), ")   :   true"..tips)
            print("---")
        else
            print("1. (motta): "..nr4, ":   false")
            print("---")
        end
        if (ent_skal_hate.prophr != nil) then
            print("2. PROP (hate):", ent_skal_hate.prophr.prophr_single_connection, nr2)
            print("4. PROP (hate):", ent_skal_hate.prophr.prophr_single_connection_with_class, nr5)
        else
            print("3. PROP (hate):", ent_skal_hate.prophr, nr3)
        end
        if (ent_skal_motta.prophr != nil) then
            print("2. PROP (motta):", ent_skal_motta.prophr.prophr_single_connection, nr2)
            print("4. PROP (motta):", ent_skal_motta.prophr.prophr_single_connection_with_class, nr5)
            if (
                ent_skal_motta.prophr != nil and
                ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class != nil and
                ent_skal_motta.prophr.prophr_single_connection_with_class == 1
            ) then
                print("5. PROP (motta/hate):", "'"..ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class.."' : '"..ent_skal_hate:GetClass().."'", nr6)
            end
        else
            print("3. PROP (motta):", ent_skal_motta.prophr, nr3)
        end
        if (ent_skal_hate.prophr != nil) then
            print("6. PROP (hate) angular  ID: ", ent_skal_hate.prophr.prophr_ent_npc_parent_ang_unik_id)
            print("6. PROP (hate) position ID:", ent_skal_hate.prophr.prophr_ent_npc_parent_pos_unik_id)
        else
            print("6. PROP (hate) angular  unique ID is    =>    nil")
            print("6. PROP (hate) position unique ID is    =>    nil")
        end
        if (ent_skal_motta.prophr != nil) then
            print("6. PROP (motta) angular  ID: ", ent_skal_motta.prophr.prophr_ent_npc_parent_ang_unik_id)
            print("6. PROP (motta) position ID:", ent_skal_motta.prophr.prophr_ent_npc_parent_pos_unik_id)
        else
            print("6. PROP (motta) angular  unique ID is    =>    nil")
            print("6. PROP (motta) position unique ID is    =>    nil")
        end
        --
        --
        print("** ** *********")
        print("(PROP) Adding relationship? Gained access to add    => ", fikk_tilgang)
        print("********* ** **")
        print("+-------------------------------------------------------------------------------------------------.")
    end
end