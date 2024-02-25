local OBJ = RDV.VEHICLE_REQ.AddSpawn("Courtyard Vehicle Bay")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_anaxes_defcon_v2") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(-9982.913086, 100.307930, 128.031250))


OBJ:SetAngles(Angle( 6.468006, 2.004042, 0.000000))

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
  "212th Marshal Commander",
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
  "327th ARC",
  "327th Alpha ARC",
  "Galactic Marines ARC",
  "Coruscant Guard ARC",
  "Galactic Marines ARC",
  "Coruscant Guard ARC",
  "501st Alpha ARC",
  "212th Alpha ARC",
  "Green Company Alpha ARC",
  "Galactic Marines Alpha ARC",
  "104th Alpha ARC",
  "Coruscant Guard Alpha ARC",
  "Wookiee",
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
  "501st Medic Officer",
  "212th Medic Officer",
  "Green Company Medic Officer",
  "Galactic Marines Medic Officer",
  "Coruscant Guard Medic Officer",
  "104th Medic Officer",
  "327th Medic Officer",
  "327th Medic Trooper",
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
  "327th K Company",
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
