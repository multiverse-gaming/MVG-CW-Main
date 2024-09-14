local OBJ = RDV.VEHICLE_REQ.AddSpawn("Main Hanger Central Channel")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_venator_advanced_mvg") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(-2446.838379, -431.145905, -1405.968750))


OBJ:SetAngles(Angle(-2.111741, -0.708533, 0.000000))

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
  "Wolfpack General",
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
  "Jedi Sentinel Temple Guard",
  "Jedi Sentinel",
  "Jedi Council Member",
  "RC Fixer",
  "RC Atin",
  "RC Impact",
  "CF99 Tech",
  "Engineering Officer",
  "212th Commander",
  "212th Executive Officer",
  "212th Major",
  "212th Heavy Ordnance Officer",
  "212th Ghost Company",
  "212th Lieutenant",
  "RC Sev",
  "RC Fi",
  "ARC Marshal Commander",
  "ARC Command",
  "501st ARC",
  "212th ARC",
  "Green Company ARC",
  "Wolfpack ARC",
  "Galactic Marines ARC",
  "Coruscant Guard ARC",
  "501st Alpha ARC",
  "212th Alpha ARC",
  "Green Company Alpha ARC",
  "Galactic Marines Alpha ARC",
  "Wolfpack Alpha ARC",
  "Coruscant Guard Alpha ARC",
  "Green Company Marshal Commander",
  "Green Company Commander",
  "Green Company Executive Officer",
  "Green Company Major",
  "Green Company Marksman",
  "Green Company Ranger",
  "Green Company Lieutenant",
  "Medical Officer",
  "Medical Marshal Commander",
  "Medical Director",
  "Assistant Medical Director",
  "501st Medic Officer",
  "212th Medic Officer",
  "Green Company Medic Officer",
  "Galactic Marines Medic Officer",
  "Coruscant Guard Medic Officer",
  "Wolfpack Medic Officer",
  "Wookiee",
  "RC Charger",
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
  "Jedi Council Member",
  "Jedi Guardian",
  "Smuggler",
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
    "Wolfpack Reconnaissance Officer",
    "Fleet Engineering Officer",
    "Fleet Medical Officer",
    "Fleet Security Officer",
    "NSO Advisor",
    "Fleet SOC Republic Intel",
    "Fleet SOC Advanced Warfare Division",
    "Fleet Probation Officer",
    "Fleet Ensign",
    "Fleet Recruit",
    "Fleet Member",
    "Fleet High Ranking",
    "Fleet Pilot",
    "Fleet Chief of Intelligence",
    "Fleet Intelligence Officer",
    "Fleet Lieutenant",
    "Fleet Lieutenant Commander",
    "Fleet Commander",
    "Fleet Captain",
    "Fleet Commodore",
    "Fleet Seniority",
    "Fleet Admiral",
    "Grand Admiral",
    "Supreme General",
    "Battalion General",
    "Assistant General",
    "Combat Engineer General",
    "501st General",
    "212th General",
    "Green Company General",
    "Coruscant Guard General",
    "Galactic Marines General",
    "Wolfpack General",
    "ARC General",
    "RC General",
    "Shadow General",
    "Jedi Grand Master",
    "Medical General",
    "Fleet Maverick",
    "Fleet StarFighter Officer",
    "Fleet Director of Research and Development",
    "Fleet Research and Development Officer"
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
