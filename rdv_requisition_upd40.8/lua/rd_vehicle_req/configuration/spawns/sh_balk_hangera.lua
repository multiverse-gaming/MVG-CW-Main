local OBJ = RDV.VEHICLE_REQ.AddSpawn("Hanger A")

--[[---------------------------------]]--
--  Map
--[[---------------------------------]]--

OBJ:SetMap("rp_balarikan") -- Optional, falls back to the map you're playing on.

--[[---------------------------------]]--
--  Position and Angle
--[[---------------------------------]]--
-- 'getpos' in console, add commas between the numbers.

OBJ:SetPosition(Vector(9053.257813, 14288.732422, 141.501053))


OBJ:SetAngles(Angle(3.168098, -91.920059, 0.000000 ))

--[[---------------------------------]]--
--  Requesting Permissions (Optional)
--[[---------------------------------]]--

OBJ:AddRequestTeams({ -- Optional, falls back to customcheck
  "Combat Engineer General",
  "501st General",
  "212th General",
  "Green Company General",
  "Shock General",
  "Galactic Marines General",
  "104th General",
  "ARC General",
  "RC General",
  "Shadow General",
  "Medical General",
 "Supreme General",
  "Battalion General",
  "Assistant General",
  "212th Commander",
  "212th Executive Officer",
  "212th Major",
  "212th Heavy Ordnance Officer",
  "212th Ghost Company",
  "RC Sev",
  "RC Fi",
  "ARC Command",
  "501st ARC",
  "212th ARC",
  "Green Company ARC",
  "104th ARC",
  "Combat Engineer ARC",
  "Galactic Marines ARC",
  "Shock ARC",
  "Green Company Commander",
  "Green Company Executive Officer",
  "Green Company Major",
  "Green Company Marksman",
  "Medical Officer",
  "Medical Director",
  "Assistant Medical Director",
  "501st Medical Officer",
  "212th Medical Officer",
  "Green Company Medical Officer",
  "Galactic Marines Medical Officer",
  "Shock Medical Officer",
  "104th Medical Officer",
  "Combat Engineer Medic Officer",
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
    "Combat Engineer General",
    "501st General",
    "212th General",
    "Green Company General",
    "Shock General",
    "Galactic Marines General",
    "104th General",
    "ARC General",
    "RC General",
    "Shadow General",
    "Fleet SOC Republic Intel",
    "Fleet SOC Advanced Warfare Division",
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
