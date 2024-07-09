local OBJ = RDV.VEHICLE_REQ.AddSpawn("Tank Bay 1")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_venator_advanced_mvg") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(2414.715088, -2294.329102, -1388.384155))


OBJ:SetAngles(Angle(6.732257, 2.543610, 0.000000))


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
  "Wolfpack General",
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
  "212th Lieutenant",
  "RC Sev",
  "RC Fi",
  "ARC Marshal Commander",
  "ARC Command",
  "501st ARC",
  "212th ARC",
  "Green Company ARC",
  "Wolfpack ARC",
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
  "Wolfpack Alpha ARC",
  "Coruscant Guard Alpha ARC",
  "Wookiee",
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
  "327th Medic Officer",
  "327th Medic Trooper",
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
    "Wolfpack Reconnaissance Officer",
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
