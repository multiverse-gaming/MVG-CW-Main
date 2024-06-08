local OBJ = RDV.VEHICLE_REQ.AddSpawn("Jedi Temple Pad 1")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_anaxes_defcon_v2") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(9679.220703, 5223.344727, -8932.169922))


OBJ:SetAngles(Angle(5.807987, 40.052078, 0.000000))

--[[---------------------------------]]--
--  Requesting Permissions (Optional)
--[[---------------------------------]]--

OBJ:AddRequestTeams({ -- Optional, falls back to customcheck
  "Jedi Grand Master",
  "Jedi General Aayla Secura",
  "Jedi Sentinel",
  "Jedi Sentinel Temple Guard",
  "Jedi Council Member",
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
  "Jedi Guardian"
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
    "Fleet Strategic and Operational Command",
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
    "Shock General",
    "Galactic Marines General",
    "104th General",
    "ARC General",
    "RC General",
    "Shadow General",
    "Jedi Grand Master",
    "Medical General"
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
