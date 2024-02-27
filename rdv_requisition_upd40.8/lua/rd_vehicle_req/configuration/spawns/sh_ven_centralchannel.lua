local OBJ = RDV.VEHICLE_REQ.AddSpawn("Main Hanger Central Channel")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_venator_classic_dc") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(-5902.674316, -67.105789, 4071.031250))


OBJ:SetAngles(Angle(2.368239, 3.045133, 0.000000))

--[[---------------------------------]]--
--  Requesting Permissions (Optional)
--[[---------------------------------]]--

OBJ:AddRequestTeams({ -- Optional, falls back to customcheck
  "327th General",
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
  "327th Marshal Commander",
  "327th Commander",
  "327th Executive Officer",
  "327th Major",
  "327th Lieutenant",
  "327th Talon Squadron",
  "327th K Company",
  "327th ARC",
  "327th Alpha ARC",
  "327th Medic Officer",
  "327th Medic Trooper",
  "327th Sergeant",
  "327th Medic Trooper",
  "327th Trooper",
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
  "RC Sev",
  "RC Fi",
  "ARC Marshal Commander",
  "ARC Command",
  "501st ARC",
  "212th ARC",
  "Green Company ARC",
  "104th ARC",
  "Galactic Marines ARC",
  "Coruscant Guard ARC",
  "501st Alpha ARC",
  "212th Alpha ARC",
  "Green Company Alpha ARC",
  "Galactic Marines Alpha ARC",
  "104th Alpha ARC",
  "Coruscant Guard Alpha ARC",
  "Green Company Marshal Commander",
  "Green Company Commander",
  "Green Company Executive Officer",
  "Green Company Major",
  "Green Company Marksman",
  "Green Company Ranger",
  "Medical Officer",
  "Medical Marshal Commander",
  "Medical Director",
  "Assistant Medical Director",
  "501st Medical Officer",
  "212th Medical Officer",
  "Green Company Medical Officer",
  "Galactic Marines Medical Officer",
  "Coruscant Guard Medical Officer",
  "104th Medical Officer",
  "Wookiee",
  "RC Charger",
  "Jedi Consular",
  "Jedi Grand Master",
  "Jedi General Quinlan Vos",
  "Jedi General Aayla Secura",
  "Jedi Commander Ahsoka Tano",
  "Jedi General Obi-Wan Kenobi",
  "Jedi General Plo Koon",
  "Jedi General Kit Fisto",
  "Jedi General Shaak Ti",
  "Jedi General Ki-Adi-Mundi",
  "Jedi General Luminara Unduli",
  "Jedi Council Member",
  "Jedi Master Mace Windu",
  "Jedi Sentinel",
  "Jedi General Anakin Skywalker",
  "Jedi Guardian",
  "Smuggler",
  "RC Clone Advisor",
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
    "Fleet Admiral",
    "Grand Admiral",
    "Supreme General",
    "Battalion General",
    "Assistant General",
    "327th General",
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
