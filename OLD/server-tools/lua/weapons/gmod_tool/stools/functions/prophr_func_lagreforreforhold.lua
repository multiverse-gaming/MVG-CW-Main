-- Lagre førre forhold
function lagreForreForhold(ent_skal_hate, ent_skal_motta, _id)
	--
    local function modifiser_forhold(_ent_skal_hate, _ent_skal_motta)
        resetSpesificRel() -- Reset tool-gun... Om "E" blei brukt.
        --
		--
		if (
			_ent_skal_hate:IsValid() and
            _ent_skal_motta:IsValid() and
            _ent_skal_hate != _ent_skal_motta
		) then
            if (_ent_skal_hate.prophr_npc_relationship_to_prophr == nil) then
                _ent_skal_hate.prophr_npc_relationship_to_prophr = {}
            end
            if (_ent_skal_motta.prophr_prophr_relationship_to_npc == nil) then
                _ent_skal_motta.prophr_prophr_relationship_to_npc = {}
            end
			--
			--
			-- Sjekk at eit forhold allerie ikkje eksiterer... for å ikkje legge dobbelt opp!
            local function legg_til(_table, _data, ent, ent_samanliknig, id)
                --
                if (#_table <= 0) then
                    --
                    local function sett_inn()
                        --
                        if (prophr_print_out_relationships_in_console()) then
                            print("---@_____________@---")
                            print(_id, id.." (1)", ent_skal_hate, ent_skal_motta)
                            print("___@-------------@___")
                        end
                        
                        if (id == "hate") then
                            -- Det er hatar som skal få ny data
                            table.insert(_ent_skal_hate.prophr_npc_relationship_to_prophr, _data)
                        else
                            -- Det er mottakar som skal få ny data
                            table.insert(_ent_skal_motta.prophr_prophr_relationship_to_npc, _data)
                        end
                        --
                        if (prophr_print_out_relationships_in_console()) then
                            print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
                            print(table.ToString(_table, id.."#(1)", true))
                            print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
                        end
                    end
                    --
                    -- Om det er f.eks. ein gruppe med mange NPC som blir kjøyrt i løkke og den
                    -- same entityen kjem opp; berre kjøyr her ein gong då...
                    local ent_samanliknig_table = nil
                    if (id == "hate") then
                        ent_samanliknig_table = ent_samanliknig.prophr_npc_relationship_to_prophr
                    else
                        ent_samanliknig_table = ent_samanliknig.prophr_prophr_relationship_to_npc
                    end
                    --
                    if (
                        ent_samanliknig_table != nil and
                        #ent_samanliknig_table > 0
                    ) then
                        local funnet_ein = false
                        --
                        for k, v in pairs(ent_samanliknig_table) do
                            --
                            -- Vanlig
                            if (id == "hate") then
                                -- Det er hatar som skal få ny data
                                if (
                                    v.prophr_npc_ent != nil and
                                    v.prophr_npc_ent == ent and
                                    (
                                        v.prophr != nil and
                                        !v.prophr.prophr_single_connection
                                    )
                                     or
                                    (
                                        v.prophr == nil and
                                        ent.prophr != nil and
                                        !ent.prophr.prophr_single_connection
                                    )
                                ) then
                                    if (prophr_print_out_relationships_in_console()) then
                                        print("HATE, funnet (1). Will not update this entities table. Loop key:", k, "Hate-ent.:", ent)
                                    end
                                    funnet_ein = true
                                end
                            else
                                -- Det er mottakar som skal få ny data
                                if (
                                    v.hostile_npc_ent != nil and
                                    v.hostile_npc_ent == ent and
                                    (
                                        v.prophr != nil and
                                        !v.prophr.prophr_single_connection
                                    )
                                     or
                                    (
                                        v.prophr == nil and
                                        ent.prophr != nil and
                                        !ent.prophr.prophr_single_connection
                                    )
                                ) then
                                    if (prophr_print_out_relationships_in_console()) then
                                        print("MOTTA, funnet (1). Will not update this entities table. Loop key:", k, "Motta-ent.:", ent)   
                                    end
                                    funnet_ein = true
                                end
                            end
                            --
                            --
                            if (
                                k == #ent_samanliknig_table and
                                !funnet_ein
                            ) then
                                sett_inn()
                            end
                        end
                    else
                        sett_inn()
                    end
                else
                    local nokler_som_skal_slettes_hater = {}
                    local nokler_som_skal_slettes_mottaker = {}
                    --
                    -- Finn ting som skal slettast frå table
                    for k, v in pairs(_table) do
                        if (id == "hate") then
                            -- Det er hatar som skal få ny data
                            if (
                                (
                                    v.prophr_npc_ent != nil and
                                    !v.prophr_npc_ent:IsValid()
                                )
                                    or
                                (
                                    v.prophr_npc_ent == nil
                                )
                            ) then
                                if (prophr_print_out_relationships_in_console()) then
                                    print("(2) HATE : remove", v.hostile_npc_ent, "key"..k, "connected to", ent)
                                end
                                table.insert(nokler_som_skal_slettes_hater, k)
                            end
                        else
                            -- Det er mottakar som skal få ny data
                            if (
                                (
                                    v.hostile_npc_ent != nil and
                                    !v.hostile_npc_ent:IsValid()
                                )
                                    or
                                (
                                    v.hostile_npc_ent == nil
                                )
                            ) then
                                if (prophr_print_out_relationships_in_console()) then
                                    print("(2) MOTTA : remove", v.hostile_npc_ent, "key"..k, "connected to", ent)
                                end
                                table.insert(nokler_som_skal_slettes_mottaker, k)
                            end
                        end
                    end
                    -- Slett "nøkler" frå table
                    nokler_som_skal_slettes_hater       = table.Reverse(nokler_som_skal_slettes_hater) -- Reversert
                    nokler_som_skal_slettes_mottaker    = table.Reverse(nokler_som_skal_slettes_mottaker) -- Reversert
                    -- Det er hatar som skal få ny data
                    for k, v in pairs(nokler_som_skal_slettes_hater) do
                        --
                        -- Slett eldre entity om det eksisterer ein null-entity (e.g. når ein blir sletta av brukar)...
                        table.remove(_ent_skal_hate.prophr_npc_relationship_to_prophr, v)
                        _ent_skal_hate.prophr_npc_relationship_to_prophr = _table -- Lagre
                        --
                        -- Om tabel er tom => sett den til nil
                        if (next(_ent_skal_hate.prophr_npc_relationship_to_prophr) == nil) then
                            _ent_skal_hate.prophr_npc_relationship_to_prophr = nil

                            return
                        end
                    end
                    -- Det er mottakar som skal få ny data
                    for k, v in pairs(nokler_som_skal_slettes_mottaker) do
                        --
                        -- Slett eldre entity om det eksisterer ein null-entity (e.g. når ein blir sletta av brukar)...
                        table.remove(_table, v)
                        _ent_skal_motta.prophr_prophr_relationship_to_npc = _table -- Lagre
                        --
                        -- Om tabel er tom => sett den til nil
                        if (next(_ent_skal_motta.prophr_prophr_relationship_to_npc) == nil) then
                            _ent_skal_motta.prophr_prophr_relationship_to_npc = nil

                            return
                        end
                    end
                    --
                    -- Data er ferdig-redigert => Sett evt. inn ny
                    local funnet_ein = false
                    --
                    for k, v in pairs(_table) do
                        --
                        -- Vanlig
                        if (id == "hate") then
                            -- Det er hatar som skal få ny data
                            if (
                                v.prophr_npc_ent != nil and
                                v.prophr_npc_ent == ent_samanliknig
                            ) then
                                --
                                if (prophr_print_out_relationships_in_console()) then
                                    print("HATE, funnet (2). Will not update this entities table (already exists in the table). Loop key:", k, "Hate-ent.:", ent)
                                    print("Parent (if there is one)", ent:GetParent())
                                    PrintTable(_table)
                                end
                                funnet_ein = true
                            end
                        else
                            -- Det er mottakar som skal få ny data
                            if (
                                v.hostile_npc_ent != nil and
                                v.hostile_npc_ent == ent_samanliknig
                            ) then
                                --
                                if (prophr_print_out_relationships_in_console()) then
                                    print("MOTTA, funnet (2). Will not update this entities table (already exists in the table). Loop key:", k, "Motta-ent.:", ent)
                                    print("Parent (if there is one)", ent:GetParent())
                                    PrintTable(_table)
                                end
                                funnet_ein = true
                            end
                        end
                        --
                        -- DENNA KODEN HER GÅR INN I EVIG LØKKE.....
                        if (
                            k == #_table and
                            !funnet_ein
                        ) then
                            if (prophr_print_out_relationships_in_console()) then
                                print("---@_____________@---")
                                print(_id, id.." (2)", ent_skal_hate, ent_skal_motta)
                                print("___@-------------@___")
                            end

                            if (id == "hate") then
                                -- Det er hatar som skal få ny data
                                table.insert(_ent_skal_hate.prophr_npc_relationship_to_prophr, _data)
                            else
                                -- Det er mottakar som skal få ny data
                                table.insert(_ent_skal_motta.prophr_prophr_relationship_to_npc, _data)

                                if (
                                    _ent_skal_motta.prophr != nil and
                                    _ent_skal_motta.prophr.isNPC
                                ) then
                                    --
                                    for l, w in pairs(_ent_skal_motta.prophr_prophr_relationship_to_npc) do
                                        if (w.prophr != nil) then
                                            -- Gjer sånn at mottakar hatar "w.hostile_npc_ent"
                                            -- Må ha denne når du legger til vanlig prophr på ein NPC (den fyrste) (ikkje duplikasjon...)
                                            _finnTilhoyrandeKlasse(
                                                w.hostile_npc_ent,
                                                _ent_skal_motta,
                                                w.prophr.prophr_Combines_attacks,
                                                w.prophr.prophr_HumansResistance_attacks,
                                                w.prophr.prophr_Zombies_attacks,
                                                w.prophr.prophr_EnemyAliens_attacks,
                                                w.prophr.prophr_EveryNPC_attacks
                                            )
                                        end
                                    end
                                end
                            end
                            --
                            if (prophr_print_out_relationships_in_console()) then
                                print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
                                print(table.ToString(_table, id.."#(2)", true))
                                print("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
                            end
                        end
                    end
                end
			end
			--
			--
            -- Hate
			legg_til(
				_ent_skal_hate.prophr_npc_relationship_to_prophr,
				{
					prophr_npc_ent = _ent_skal_motta,
					original_rel_to_hostile_npc = _ent_skal_hate:Disposition(_ent_skal_motta),
                    prophr_npc_ent_class = _ent_skal_motta:GetClass()
				},
				_ent_skal_hate,
				_ent_skal_motta,
				"hate"
			)
			-- Motta
			legg_til(
				_ent_skal_motta.prophr_prophr_relationship_to_npc,
				{
					hostile_npc_ent = _ent_skal_hate,
					original_rel_to_prophr_npc = _ent_skal_motta:Disposition(_ent_skal_hate),
                    hostile_npc_ent_class = _ent_skal_hate:GetClass()
				},
				_ent_skal_motta,
				_ent_skal_hate,
				"motta"
			)
        else
            if (_ent_skal_hate != _ent_skal_motta) then
                PrintMessage(HUD_PRINTTALK, "PropHr ERROR (SAVE PREV. RELATIONSHIP) : (4) Could not save previous relationship between entities. One or more entity is invalid.")
			    print(_ent_skal_hate, _ent_skal_motta)
            end
		end
	end
	--
	-- Visst det er ein prop, ellers om det er ein npc
	-- DETTE ER FRITT... KAN BESTEMME SJØLV OM VIL HA PROP ELLER NPC-BULLSEYE F.EKS.
    if (
        ent_skal_hate != nil and
        ent_skal_motta != nil and
        ent_skal_hate:IsValid() and
		ent_skal_motta:IsValid()
    ) then
        --
        -- Om PROP er ent_skal_motta, eller om npc_bullseye er ent_skal_motta
        if (#ent_skal_motta:GetChildren() > 0) then
            --
            local funnet_ein_prophr_npc_ent = false
            --
            for k, v in pairs(ent_skal_motta:GetChildren()) do
                if (
                    v:IsValid() and
                    v:GetName() == "prophr_npc_ent"
                ) then
                    funnet_ein_prophr_npc_ent = true
                    --
                    local __ent_skal_hate 	= ent_skal_hate
                    local __ent_skal_motta 	= v
                    --
                    -- PROP
                    modifiser_forhold(__ent_skal_hate, __ent_skal_motta)
                end
                --
                if (
                    funnet_ein_prophr_npc_ent == false and
                    k == #ent_skal_motta:GetChildren()
                ) then
                    --
                    -- Spekulerer for at det er ein NPC med e.g. eit våpen, som gjer den har andre unga
                    modifiser_forhold(ent_skal_hate, ent_skal_motta) -- kjøyre ikkje
                end
            end
        else
            --
            -- NPC garantert
            modifiser_forhold(ent_skal_hate, ent_skal_motta)
        end  
    else
        -- DETTE ER EIGENTLEG IKKJE EIT PROBLEM...
        --PrintMessage(HUD_PRINTTALK, "PropHr ERROR (lagreForreForhold) : Unknown entity... One entity is not valid.")
    end
end