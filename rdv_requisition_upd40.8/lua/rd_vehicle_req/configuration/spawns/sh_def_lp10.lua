local OBJ = RDV.VEHICLE_REQ.AddSpawn("Landing Pad 10")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_anaxes_defcon_v2") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(-11841.996094, 2219.366943, 248.031250))


OBJ:SetAngles(Angle(3.661726, 4.537624, 0.000000))

--[[---------------------------------]]--
--  Requesting Permissions (Optional)
--[[---------------------------------]]--

OBJ:AddRequestTeams({ -- Optional, falls back to customcheck
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
  "Medical General",
  "Supreme General",
  "Battalion General",
  "Assistant General",
  "Combat Engineer Marshal Chief",
  "Combat Engineer Chief",
  "Combat Engineer Assistant Chief",
  "Combat Engineer Chief Technician",
  "Combat Engineer Technician",
  "Combat Engineer Razor Squadron",
  "Combat Engineer EOD",
  "Combat Engineer ARC",
  "Combat Engineer Alpha ARC",
  "Combat Engineer Medic Officer",
  "Combat Engineer Medic Trooper",
  "Combat Engineer Specialist",
  "Combat Engineer Medic Trooper",
  "Combat Engineer Trooper",
  "Jedi Grand Master",
  "Jedi General Aayla Secura",
  "Jedi Sentinel",
  "Jedi Council Member",
  "RC Fixer",
  "RC Impact",
  "CF99 Tech",
  "Engineering Officer",
  "Medical Officer",
  "Jedi Consular",
  "Jedi Sentinel Temple Guard",
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
  "RC Clone Advisor",
  "Bounty Hunter",
  "Fleet Recruit",
  "Fleet Officer",
  "Fleet Lieutenant",
  "Fleet Seniority",
  "Fleet Admiral",
  "Grand Admiral",
  "Fleet Engineering Officer",
  "Fleet Security Officer",
  "Fleet Medical Officer"
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
    "NSO Advisor",
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
    "Fleet Research and Development Engineer"
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
