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
    "327th Storm Squadron",
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
    "Combat Engineer Jedi",
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
    "Grand Admiral",
    "Republic Intelligence",
    "RC Clone Advisor",
    "Clone Trooper Instructor",
    "501st Heavy Ordnance Officer",
    "212th Heavy Ordnance Officer",
    "Green Company Reconnaissance Officer",
    "Galactic Marines Breaching Officer",
    "104th Reconnaissance Officer",
    "Engineering Officer",
    "Medical Officer",
    "Fleet SOC Republic Intel",
    "Fleet SOC Advanced Warfare Division",
    "Fleet Probation Officer",
    "Fleet Ensign",
    "Fleet Officer",
    "Fleet Pilot",
    "Fleet Lieutenant",
    "Fleet Lieutenant Commander",
    "Fleet Commander",
    "Fleet Captain",
    "Fleet Commodore",
    "Fleet Admiral",
    "Grand Admiral",
    "Supreme General",
    "Battalion General",
    "Assistant General",
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
