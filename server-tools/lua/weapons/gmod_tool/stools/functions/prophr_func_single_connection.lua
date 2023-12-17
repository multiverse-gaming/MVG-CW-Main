function resetSpesificRel(leggTilNr1)
	-- Reset
	prophr_spesific_relationship = {}
	if (
		k == #prophr_spesific_relationship and
		leggTilNr1 == true
	) then
		-- Legg til fyrste (nr. 1/2) Entity
		table.insert(prophr_spesific_relationship, ent)
	end
end
--
-- For om brukar vil at ein prop/NPC og ein NPC (eller NPC-klasse) skal angripe ein prop
local function single_connection_bytt_om_kanskje(key_down_boolean, ent)
   
end