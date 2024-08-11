local OBJ = RDV.VEHICLE_REQ.AddSpawn("Main Hanger")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_mvg_rishirepublic") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(4985.976563, 8352.242188, -13873.968750))


OBJ:SetAngles(Angle(0.924006, -87.624161, 0.000000))

--[[---------------------------------]]--
--  Requesting Permissions (Optional)
--[[---------------------------------]]--

OBJ:AddRequestTeams({ -- Optional, falls back to customcheck
  "CE General",
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
  "CE Marshal Chief",
  "CE Chief",
  "CE Assistant Chief",
  "CE Chief Technician",
  "CE Engineer",
  "CE Razor Squadron",
  "CE EOD",
  "CE ARC",
  "CE Medic Officer",
  "CE Medic Trooper",
  "CE Specialist",
  "CE Medic Trooper",
  "CE Trooper",
  "Jedi Grand Master",
  "Jedi Sentinel Temple Guard",
  "Jedi General Aayla Secura",
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
  "ARC Alpha 501st",
  "ARC Alpha 212th",
  "ARC Alpha Green Company",
  "ARC Alpha Galactic Marines",
  "ARC Alpha Wolfpack",
  "ARC Alpha 327th",
  "ARC Alpha Coruscant Guard",
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
  "501st Medical Officer",
  "212th Medical Officer",
  "Green Company Medical Officer",
  "Galactic Marines Medical Officer",
  "Coruscant Guard Medical Officer",
  "Wolfpack Medical Officer",
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
  "CE General Aayla Secura",
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
  "CE Jedi",
  "Jedi Guardian",
  "Smuggler",
  "RC Clone Advisor",
  "Fleet Ensign",
  "Fleet Officer",
  "Fleet Lieutenant",
  "Fleet Lieutenant Commander",
  "Fleet Commander",
  "Fleet Captain",
  "Fleet Commodore",
  "Fleet Admiral",
  "Grand Admiral",
  "Fleet Engineering Officer",
  "Fleet Security Officer",
  "Fleet Medical Officer",
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
    "Wolfpack Reconnaissance Officer",
    "Engineering Officer",
    "Medical Officer",
    "NSO Advisor",
    "Fleet Recruit",
    "Fleet Officer",
    "Fleet Lieutenant",
    "Fleet Seniority",
    "Fleet Admiral",
    "Grand Admiral",
    "Fleet Intelligence Officer",
    "Fleet Research and Development Medic",
    "Fleet Research and Development Engineer",
    "Supreme General",
    "Battalion General",
    "Assistant General",
    "CE General",
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
    "Fleet Recruit",
    "Fleet Officer",
    "Fleet Lieutenant",
    "Fleet Seniority",
    "Fleet Admiral",
    "Grand Admiral",
    "Fleet Intelligence Officer",
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
