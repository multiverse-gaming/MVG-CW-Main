local OBJ = RDV.VEHICLE_REQ.AddVehicle("LAAT Gunship")

--[[---------------------------------]]----
-- Set the Class of the Vehicle.
--[[---------------------------------]]--

OBJ:SetClass("lvs_repulsorlift_gunship")

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
  "Cuy'val Dar General",
  "Medical General",
  "Supreme General",
  "Battalion General",
  "Assistant General",
  "327th Marshal Commander",
  "327th Commander",
  "327th Executive Officer",
  "327th Major",
  "327th Talon Squadron",
  "Jedi Grand Master",
  "Jedi General Aayla Secura",
  "Jedi Sentinel",
  "Jedi Sentinel Temple Guard",
  "Jedi Council Member",
  "RC Fixer",
  "CF99 Tech",
  "Fleet Maverick",
  "Fleet StarFighter Officer",
  "Fleet Admiral",
  "Grand Admiral"
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

-- OBJ:BlacklistHangar("Landing Pad 1")

--[[---------------------------------]]--
--  CustomChecks (Optional)
--[[---------------------------------]]--

function OBJ:CanGrant(ply) -- Optional, falls back to teams
end

function OBJ:CanRequest(ply) -- Optional, falls back to teams
end
