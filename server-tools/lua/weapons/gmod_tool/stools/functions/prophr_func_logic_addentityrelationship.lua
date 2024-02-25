function gi_tilgang_for_tillegging_av_forhold(ent_skal_hate, ent_skal_motta, for_prop_eller_npc, kjem_fraa_id)
    ----------------
    ---NPC GROUPS---
    ----------------
    local ent_skal_hate_npc_group   = nil
    local ent_skal_motta_npc_groups = {}
    --
    function find_npc_group_nr(ent_spawned_class)
        -- COMBINE (Group nr. 0)
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
            ent_skal_hate_npc_group = 0
        end
        -- HUMAN + RESISTANCE (Group nr. 1)
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
            ent_skal_hate_npc_group = 1
        end
        -- ZOMBIE (Group nr. 2)
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
            ent_skal_hate_npc_group = 2
        end
        -- ALIEN (Group nr. 3)
        if (
            ent_spawned_class == "npc_antlion" or
            ent_spawned_class == "npc_antlionguard" or
            ent_spawned_class == "npc_barnacle"
        ) then
            --
            ent_skal_hate_npc_group = 3
        end
        -- Every NPC (Group nr. 4)
        if (prophr_EveryNPC_attacks == 1) then
            ent_skal_hate_npc_group = 4
        end
    end
    --
    -- NPC Skal Hate
    find_npc_group_nr(ent_skal_hate:GetClass())
    -- NPC Skal Motta
    if (ent_skal_motta.prophr != nil) then
        for k, v in pairs(ent_skal_motta.prophr) do
            --
            -- COMBINE (Group nr. 0)
            if (k == "prophr_Combines_attacks") then
                if (v == 1) then
                    table.insert(ent_skal_motta_npc_groups, 0)
                end
            end
            -- HUMAN + RESISTANCE (Group nr. 1)
            if (k == "prophr_HumansResistance_attacks") then
                if (v == 1) then
                    table.insert(ent_skal_motta_npc_groups, 1)
                end
            end
            -- ZOMBIE (Group nr. 2)
            if (k == "prophr_Zombies_attacks") then
                if (v == 1) then
                    table.insert(ent_skal_motta_npc_groups, 2)
                end
            end
            -- ALIEN (Group nr. 3)
            if (k == "prophr_EnemyAliens_attacks") then
                if (v == 1) then
                    table.insert(ent_skal_motta_npc_groups, 3)
                end
            end
            -- Every NPC (Group nr. 4)
            if (k == "prophr_EveryNPC_attacks") then
                if (v == 1) then
                    table.insert(ent_skal_motta_npc_groups, 4)
                end
            end
        end
    else return print("(PropHr ERROR) Entity which shall recive, does not have valid PropHr-data.") end
    --
    --
    -- If the NPC-class does not exist in the PropHr-data, cancel
    if (next(ent_skal_motta_npc_groups) == nil) then
        return false
    else
        local match_funnet = false
        for k, v in pairs(ent_skal_motta_npc_groups) do
            if (v == ent_skal_hate_npc_group) then
                match_funnet = true
            end
            --
            if (k == #ent_skal_motta_npc_groups) then
                if (!match_funnet) then
                    return false
                end
            end
        end
    end
    --
    --
    -----------
    ---MOTTA---
    -----------
    local function ent_skal_MOTTA_ER_single_connection()
        if (
            ent_skal_motta.prophr_single_connection_id != nil and
            !table.HasValue(ent_skal_motta.prophr_single_connection_id, 0)
        ) then return true else return false end
    end
    local function ent_skal_MOTTA_ER_IKKJE_single_connection_med_klasse()
        if (
            ent_skal_motta.prophr != nil and
            ent_skal_motta.prophr.prophr_single_connection_with_class == 0
        ) then return true else return false end
    end
    local function ent_skal_MOTTA_ER_single_connection_med_klasse()
        if (
            ent_skal_motta.prophr != nil and
            ent_skal_motta.prophr.prophr_single_connection_with_class == 1
        ) then return true else return false end
    end
    local function ent_skal_MOTTA_ER_prophr()
        if (ent_skal_motta.prophr != nil) then return true else return false end
    end
    local function ent_skal_MOTTA_ER_IKKJE_prophr()
        if (ent_skal_motta.prophr == nil) then return true else return false end
    end
    local function ent_skal_MOTTA_ER_vanlig_prophr()
        -- Om e.g. "E" blei brukt, får begge NPC denne verdien, men den eine trenger ikkje nødvendigvis
        -- å ha verdien ".prophr" etter seg
        if (
            ent_skal_motta.prophr_single_connection_id != nil and
            table.HasValue(ent_skal_motta.prophr_single_connection_id, 0)
        ) then return true else return false end
    end
    local function ent_skal_MOTTA_ER_IKKJE_single_connection()
        if (ent_skal_motta.prophr_single_connection_id == nil) then return true else return false end
    end
    ----------
    ---HATE---
    ----------
    local function ent_skal_HATE_ER_vanlig_prophr()
        -- Om e.g. "E" blei brukt, får begge NPC denne verdien, men den eine trenger ikkje nødvendigvis
        -- å ha verdien ".prophr" etter seg
        if (
            ent_skal_hate.prophr_single_connection_id != nil and
            table.HasValue(ent_skal_hate.prophr_single_connection_id, 0)
        ) then return true else return false end
    end
    local function ent_skal_HATE_ER_single_connection_med_klasse()
        if (
            ent_skal_hate.prophr != nil and
            ent_skal_hate.prophr.prophr_single_connection_with_class == 1
        ) then return true else return false end
    end
    local function ent_skal_HATE_ER_IKKJE_single_connection_med_klasse()
        if (
            ent_skal_hate.prophr != nil and
            ent_skal_hate.prophr.prophr_single_connection_with_class == 0
        ) then return true else return false end
    end
    local function ent_skal_HATE_ER_single_connection()
        if (
            ent_skal_hate.prophr_single_connection_id != nil and
            !table.HasValue(ent_skal_hate.prophr_single_connection_id, 0)
        ) then return true else return false end
    end
    local function ent_skal_HATE_ER_prophr()
        if (ent_skal_hate.prophr != nil) then return true else return false end
    end
    local function ent_skal_HATE_ER_IKKJE_prophr()
        if (ent_skal_hate.prophr == nil) then return true else return false end
    end
    local function ent_skal_HATE_ER_IKKJE_single_connection()
        if (ent_skal_hate.prophr_single_connection_id == nil) then return true else return false end
    end
    --
    --
    --
    local returnMessage = "=>    is the condition who granted access."
    if (prophr_print_out_relationships_in_console()) then
        print("** ** ** ****>")
    end
    function nr1()
        if (
            -- Visst MOTTAKAR er single-connection

            -- OG HATAR er single-connection
            -- OG HATAR ikkje er PropHr

            -- OG HATAR og MOTTAKAR har same single-connection-ID
            ent_skal_MOTTA_ER_single_connection() and
            ent_skal_motta.prophr != nil and
            --
            ent_skal_HATE_ER_single_connection() and
            ent_skal_HATE_ER_IKKJE_prophr() and
            ent_skal_hate.prophr != nil and
            --
            ent_skal_motta.prophr.prophr_single_connection_id == ent_skal_hate.prophr.prophr_single_connection_id

        ) then
            print(ent_skal_hate.prophr.prophr_single_connection_id, ent_skal_motta.prophr_single_connection_id)
            if (prophr_print_out_relationships_in_console()) then
                print("#1", returnMessage)
            end
            return true
        else return false end
    end
    function nr2()
        if (
            -- Visst MOTTAKAR er vanlig PropHr

            -- OG HATAR ikkje er single-connection
            -- OG HATAR ikkje er PropHr
            ent_skal_MOTTA_ER_vanlig_prophr() and
            --
            ent_skal_HATE_ER_IKKJE_single_connection() and
            ent_skal_HATE_ER_IKKJE_prophr()
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#2", returnMessage)
            end
            return true
        else return false end
    end
    function nr3()
        if (
            -- Visst MOTTAKAR er vanlig PropHr
            
            -- OG HATAR er single-connection
            -- OG HATAR er vanlig PropHr
            -- OG HATAR er del av ein single-connection
            -- ***
            (
                ent_skal_MOTTA_ER_vanlig_prophr() or
                ent_skal_MOTTA_ER_IKKJE_single_connection()
            ) and
            --
            ent_skal_HATE_ER_single_connection() and
            ent_skal_HATE_ER_prophr() and
            ent_skal_hate.prophr.prophr_single_connection == true
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#3", returnMessage)
            end
            return true
        else return false end
    end
    function nr4()
        if (
            -- Visst MOTTAKAR er vanlig PropHr

            -- OG HATAR er single-connection
            -- OG HATAR er vanlig PropHr
            -- OG HATAR er del av ein single-connection
            ent_skal_MOTTA_ER_vanlig_prophr() and
            --
            ent_skal_HATE_ER_single_connection() and
            ent_skal_HATE_ER_prophr() and
            ent_skal_hate.prophr.prophr_single_connection == false
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#4", returnMessage)
            end
            return true
        else return false end
    end
    function nr5()
        if (
            -- Visst MOTTAKAR er vanlig PropHr

            -- OG HATAR er single-connection
            ent_skal_MOTTA_ER_vanlig_prophr() and
            --
            ent_skal_HATE_ER_single_connection()
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#5", returnMessage)
            end
            return true
        else return false end
    end
    function nr6()
        if (
            -- Visst MOTTAKAR er vanlig PropHr

            -- Visst HATAR er vanlig PropHr
            -- OG HATAR ikkje er PropHr
            ent_skal_MOTTA_ER_vanlig_prophr() and
            --
            ent_skal_HATE_ER_vanlig_prophr() and
            ent_skal_HATE_ER_IKKJE_prophr()
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#6", returnMessage)
            end
            return true
        else return false end
    end
    function nr7()
        if (
            -- Visst MOTTAKAR er vanlig PropHr
            -- OG MOTTAKAR er del av ein single-connection

            -- OG HATAR er single-connection
            -- OG HATAR ikkje er PropHr
            ent_skal_MOTTA_ER_single_connection() and
            ent_skal_motta.prophr.prophr_single_connection == true and
            --
            ent_skal_HATE_ER_single_connection() and
            ent_skal_HATE_ER_IKKJE_prophr()
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#7", returnMessage)
            end
            return true
        else return false end
    end
    function nr8()
        if (
            -- Visst MOTTAKAR er vanlig PropHr
            -- OG MOTTAKAR er del av ein single-connection
            -- OG MOTTAKAR er knytt til single-con. for klasser

            -- OG HATAR ikkje er single-connection
            -- OG HATAR ikkje er PropHr

            -- OG MOTTAKAR single-con. klasse-variabel er lik HATAR sin klasse
            ent_skal_MOTTA_ER_single_connection() and
            ent_skal_motta.prophr.prophr_single_connection == true and
            ent_skal_MOTTA_ER_single_connection_med_klasse() and
            --
            (
                ent_skal_HATE_ER_IKKJE_single_connection() or
                ent_skal_HATE_ER_single_connection()
            ) and
            ent_skal_HATE_ER_IKKJE_prophr() and
            --
            ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class == ent_skal_hate:GetClass() and
            --
            ent_skal_motta.prophr.prophr_ent_npc_parent_pos_unik_id == nil and
            ent_skal_motta.prophr.prophr_ent_npc_parent_ang_unik_id == nil
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#8", returnMessage)
            end
            return true
        else return false end
    end
    function nr9()
        if (
            -- 

            -- OG MOTTAKAR single-con. klasse-variabel er lik HATAR sin klasse
            ent_skal_MOTTA_ER_single_connection() and
            ent_skal_motta.prophr.prophr_single_connection == true and
            ent_skal_MOTTA_ER_single_connection_med_klasse() and
            --
            ent_skal_HATE_ER_single_connection() and
            ent_skal_hate.prophr.prophr_single_connection == true and
            ent_skal_HATE_ER_single_connection_med_klasse() and
            --
            ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class == ent_skal_hate:GetClass() and
            --
            ent_skal_motta.prophr.prophr_ent_npc_parent_pos_unik_id != ent_skal_hate.prophr.prophr_ent_npc_parent_pos_unik_id and
            ent_skal_motta.prophr.prophr_ent_npc_parent_ang_unik_id != ent_skal_hate.prophr.prophr_ent_npc_parent_ang_unik_id
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#9", returnMessage)
            end
            return true
        else return false end
    end
    function nr10()
        if (
            -- 

            -- OG MOTTAKAR single-con. klasse-variabel er lik HATAR sin klasse
            ent_skal_MOTTA_ER_single_connection() and
            ent_skal_motta.prophr.prophr_single_connection == true and
            ent_skal_MOTTA_ER_single_connection_med_klasse() and
            --
            ent_skal_HATE_ER_single_connection() and
            ent_skal_hate.prophr.prophr_single_connection == true and
            ent_skal_HATE_ER_IKKJE_single_connection_med_klasse() and
            --
            ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class == ent_skal_hate:GetClass() and
            --
            ent_skal_motta.prophr.prophr_ent_npc_parent_pos_unik_id != ent_skal_hate.prophr.prophr_ent_npc_parent_pos_unik_id and
            ent_skal_motta.prophr.prophr_ent_npc_parent_ang_unik_id != ent_skal_hate.prophr.prophr_ent_npc_parent_ang_unik_id
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#10", returnMessage)
            end
            return true
        else return false end
    end
    function nr11()
        if (
            -- 
            ent_skal_MOTTA_ER_IKKJE_single_connection() and
            ent_skal_motta.prophr.prophr_single_connection == false and
            --
            ent_skal_HATE_ER_IKKJE_prophr() and
            ent_skal_HATE_ER_IKKJE_single_connection()
            
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#11", returnMessage)
            end
            return true
        else return false end
    end
    function nr12()
        if (
            --
            ent_skal_MOTTA_ER_IKKJE_single_connection() and
            ent_skal_motta.prophr.prophr_single_connection == true and
            --
            ent_skal_HATE_ER_single_connection() and
            ent_skal_HATE_ER_IKKJE_prophr()
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#12", returnMessage)
            end
            return true
        else return false end
    end
    function nr13()
        if (
            --
            ent_skal_MOTTA_ER_vanlig_prophr() and
            ent_skal_MOTTA_ER_IKKJE_single_connection_med_klasse() and
            ent_skal_motta.prophr.prophr_single_connection == false and
            --
            ent_skal_HATE_ER_vanlig_prophr() and
            ent_skal_HATE_ER_IKKJE_single_connection_med_klasse() and
            ent_skal_hate.prophr.prophr_single_connection == false
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#13", returnMessage)
            end
            return true
        else return false end
    end
    function nr14()
        if (
            ent_skal_MOTTA_ER_single_connection()
            and ent_skal_MOTTA_ER_prophr()
            and ent_skal_MOTTA_ER_single_connection_med_klasse()
            --
            and ent_skal_HATE_ER_IKKJE_single_connection()
            --
            and ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class == ent_skal_hate:GetClass()
            --
            and (
                ent_skal_HATE_ER_prophr()
                and ent_skal_motta.prophr.prophr_ent_npc_parent_pos_unik_id != ent_skal_hate.prophr.prophr_ent_npc_parent_pos_unik_id
                and ent_skal_motta.prophr.prophr_ent_npc_parent_ang_unik_id != ent_skal_hate.prophr.prophr_ent_npc_parent_ang_unik_id
                and ent_skal_motta.prophr.prophr_single_connection == true
            ) or (
                ent_skal_HATE_ER_IKKJE_prophr()
                and ent_skal_MOTTA_ER_single_connection_med_klasse()
                and ent_skal_motta.prophr.prophr_single_connection == true
                and ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class == ent_skal_hate:GetClass()
            )
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#14", returnMessage)
            end
            return true
        else return false end
    end
    function nr15()
        if (
            ent_skal_MOTTA_ER_IKKJE_single_connection()
            and ent_skal_motta.prophr.prophr_single_connection == true
            and ent_skal_MOTTA_ER_single_connection_med_klasse()
            --
            and ent_skal_HATE_ER_IKKJE_single_connection()
            and ent_skal_HATE_ER_IKKJE_prophr()
            --
            and ent_skal_motta.prophr.prophr_single_connection_with_class_NPC_Class == ent_skal_hate:GetClass()
        )
        then
            if (prophr_print_out_relationships_in_console()) then
                print("#15", returnMessage)
            end
            return true
        else return false end
    end
    --
    --
    if (
        -- Uten single-con. med klasse spesifikt
        nr1() or
        nr2() or
        nr3() or
        nr4() or
        nr5() or
        nr6() or
        nr7() or
        nr11() or
        nr12() or
        nr13() or
        -- Single-con. med klasse spesifikt
        nr8() or
        nr9() or
        nr10() or
        nr14() or
        nr15()
    ) then
        if (prophr_print_out_relationships_in_console()) then
            print("** ** ** ****>")
            --
            if (for_prop_eller_npc == "npc") then
                prophr_print_out_NPC_relationship(ent_skal_hate, ent_skal_motta, true, kjem_fraa_id)
            else
                prophr_print_out_PROP_relationship(ent_skal_hate, ent_skal_motta, true, kjem_fraa_id)
            end
        end
        --
        return true
    else
        if (prophr_print_out_relationships_in_console()) then
            print("** ** ** ****>")
            --
            if (for_prop_eller_npc == "npc") then
                prophr_print_out_NPC_relationship(ent_skal_hate, ent_skal_motta, false, kjem_fraa_id)
            else
                prophr_print_out_PROP_relationship(ent_skal_hate, ent_skal_motta, false, kjem_fraa_id)
            end
        end
        --
        return false
    end
end