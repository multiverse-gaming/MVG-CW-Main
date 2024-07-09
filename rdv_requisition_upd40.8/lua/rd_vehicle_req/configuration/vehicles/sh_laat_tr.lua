local OBJ = RDV.VEHICLE_REQ.AddVehicle("LAAT Transport")

--[[---------------------------------]]----
-- Set the Class of the Vehicle.
--[[---------------------------------]]--

OBJ:SetClass("lvs_repulsorlift_transport")

--[[---------------------------------]]--
--  Model (Most likely un-needed)
--[[---------------------------------]]--

--OBJ:AddGrantRanks({
--    "PVT",
--})
-- OBJ:SetModel("models/blu/laat.mdl")

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
  "327th ARC",
  "327th Alpha ARC",
  "327th Medic Officer",
  "327th Sergeant",
  "327th K Company",
  "Jedi Grand Master",
  "GC Grand Master",
  "Jedi General Aayla Secura",
  "327th General Aayla Secura",
  "501st Jedi",
  "212th Jedi",
  "327th Jedi",
  "Jedi Sentinel",
  "Jedi Sentinel Temple Guard",
  "Jedi Council Member",
  "RC Fixer",
  "CF99 Tech",
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
})

-- Nicolas's Rank System Support

-- OBJ:AddGrantRanks({
--     "PVT",
--     "PFC",
-- })

--[[---------------------------------]]--
--  Vehicle Category
--[[---------------------------------]]--

OBJ:SetCategory("Gunship")

--[[---------------------------------]]--
--  Should we require a grant?
--[[---------------------------------]]--

OBJ:SetRequest(true)

--[[---------------------------------]]--
--  Enable changing vehicle skins. (Optional)
--[[---------------------------------]]--

OBJ:SetCustomizable(false)

--[[---------------------------------]]--
--  Force a Skin. (Optional)
--[[---------------------------------]]--

-- OBJ:SetSkin(0) -- Optional, falls back to skin 0

--[[---------------------------------]]--
--  Force Bodygroups. (Optional)
--[[---------------------------------]]--

-- OBJ:SetBodygroup(2, 1)
-- OBJ:SetBodygroup(1, 2)

--[[---------------------------------]]--
--  Price to spawn. (Optional)
--[[---------------------------------]]--

-- OBJ:SetPrice(200)

--[[---------------------------------]]--
--  Auto-Grant if no-one is online to do so.
--[[---------------------------------]]--

OBJ:SpawnAlone(true)

--[[---------------------------------]]--
--  Hangar Whitelist (Optional)
--[[---------------------------------]]--

-- OBJ:AddHangar("Main Hangar Bay")

--[[---------------------------------]]--
--  Hangar Blacklist (Optional)
--[[---------------------------------]]--

OBJ:BlacklistHangar({"Landing Bay Seven","Landing Bay Eight"})

--[[---------------------------------]]--
--  CustomChecks (Optional)
--[[---------------------------------]]--

function OBJ:CanGrant(ply) -- Optional, falls back to teams
end

function OBJ:CanRequest(ply) -- Optional, falls back to teams
end
