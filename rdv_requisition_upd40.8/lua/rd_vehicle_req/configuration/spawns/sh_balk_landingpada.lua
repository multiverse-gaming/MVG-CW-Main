local OBJ = RDV.VEHICLE_REQ.AddSpawn("Landing Pad A")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_balarikan") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(7520.281250, 11895.923828, 245.358246))


OBJ:SetAngles(Angle(9.504107, 2.855947, 0.000000))

--[[---------------------------------]]--
--  Requesting Permissions (Optional)
--[[---------------------------------]]--

OBJ:AddRequestTeams({ -- Optional, falls back to customcheck
    "Combat Engineer General",
    "Combat Engineer Chief",
    "Combat Engineer Assistant Chief",
    "Combat Engineer Chief Technician",
    "Combat Engineer Technician",
    "Combat Engineer Razor Squadron",
    "Combat Engineer EOD",
    "Combat Engineer ARC",
    "Combat Engineer Medic Officer",
    "Combat Engineer Specialist",
    "Combat Engineer Medic Trooper",
    "Combat Engineer Trooper",
    "Jedi Grand Master",
    "Fleet Pilot",
    "Fleet Admiral",
    "Grand Admiral",
    "Jedi Consular",
    "Jedi Grand Master",
    "GC Grand Master",
    "Jedi Master Mace Windu",
    "Jedi General Anakin Skywalker",
    "501st General Anakin Skywalker",
    "Jedi General Obi-Wan Kenobi",
    "212th General Obi-Wan Kenobi",
    "Jedi Commander Ahsoka Tano",
    "501st Commander Ahsoka Tano",
    "Jedi General Plo Koon",
    "WP General Plo Koon",
    "Jedi General Kit Fisto",
    "RC General Kit Fisto",
    "Jedi General Aayla Secura",
    "Combat Engineer General Aayla Secura",
    "Jedi General Shaak Ti",
    "CG General Shaak Ti",
    "Jedi General Ki-Adi-Mundi",
    "GM General Ki-Adi-Mundi",
    "Jedi General Quinlan Vos",
    "Shadow General Quinlan Vos",
    "Jedi General Luminara Unduli",
    "GC General Luminara Unduli",
    "Jedi Sentinel",
    "Jedi Council Member",
    "501st Jedi",
    "212th Jedi",
    "Coruscant Guard Temple Guard",
    "Jedi Temple Guard",
    "CG Temple Guard Chief",
    "Jedi General Cin Drallig",
    "Temple Guard Chief",
    "Combat Engineer Jedi",
    "Galactic Marines Jedi",
    "Wolfpack Jedi",
    "Jedi Guardian",
    "Bounty Hunter"
})

-- Nicolas's Rank System Support

-- OBJ:AddRequestRanks({
--     "PVT",
--     "PFC",
-- })

--[[---------------------------------]]--
--  Granting Permissions (Optional)
--[[---------------------------------]]--

OBJ:AddGrantTeams({ -- Optional, falls back to customcheck
    "Supreme General",
    "Battalion General",
    "Assistant General",
    "Combat Engineer General",
    "501st General",
    "212th General",
    "Green Company General",
    "Coruscant Guard General",
    "Galactic Marines General",
    "104th General",
    "ARC General",
    "RC General",
    "Shadow General",
    "Jedi Grand Master",
    "Medical General",
    "Fleet Recruit",
    "Fleet Officer",
    "Fleet Medical Officer",
    "Fleet Engineering Officer",
    "Fleet Security Officer",
    "Fleet Lieutenant",
    "Fleet Seniority",
    "Fleet Admiral",
    "Grand Admiral",
    "Fleet SOC Advanced Warfare Division",
    "Fleet SOC Republic Intel",
    "Fleet Research and Development Medic",
    "Fleet Research and Development Engineer",
    "Jedi Grand Master"
})

-- Nicolas's Rank System Support

-- OBJ:AddGrantRanks({
--     "PVT",
--     "PFC",
-- })

--[[---------------------------------]]--
--  CustomChecks (Optional)
--[[---------------------------------]]--

function OBJ:CanGrant(ply) -- Optional, falls back to teams
end

function OBJ:CanRequest(ply) -- Optional, falls back to teams
end
