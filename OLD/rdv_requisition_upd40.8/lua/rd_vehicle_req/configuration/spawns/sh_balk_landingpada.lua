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
    "327th General",
    "327th Commander",
    "327th Executive Officer",
    "327th Major",
    "327th Lieutenant",
    "327th Storm Squadron",
    "327th K Company",
    "327th ARC",
    "327th Medic Officer",
    "327th Sergeant",
    "327th Medic Trooper",
    "327th Trooper",
    "Jedi Grand Master",
    "Fleet Pilot",
    "Fleet Admiral",
    "Grand Admiral",
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
