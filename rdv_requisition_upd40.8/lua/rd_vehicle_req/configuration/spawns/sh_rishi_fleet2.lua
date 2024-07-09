local OBJ = RDV.VEHICLE_REQ.AddSpawn("Fleet Hanger 2")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_mvg_rishirepublic") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(1141.520386, -266.817596, -1293.968750))


OBJ:SetAngles(Angle(2.507999, 177.755615, 0.000000))

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
  "Jedi Sentinel",
  "Jedi Council Member",
  "RC Fixer",
  "RC Impact",
  "CF99 Tech",
  "Engineering Officer",
  "Medical Officer",
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
  "327th General Aayla Secura",
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
  "327th Jedi",
  "Jedi Guardian",
  "RC Clone Advisor",
  "Fleet Recruit",
  "Fleet Officer",
  "Fleet Lieutenant",
  "Fleet Seniority",
  "Fleet Admiral",
  "Grand Admiral",
  "Fleet Strategic and Operational Command",
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
    "Fleet Recruit",
    "Fleet Officer",
    "Fleet Lieutenant",
    "Fleet Seniority",
    "Fleet Admiral",
    "Grand Admiral",
    "Fleet Strategic and Operational Command",
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
