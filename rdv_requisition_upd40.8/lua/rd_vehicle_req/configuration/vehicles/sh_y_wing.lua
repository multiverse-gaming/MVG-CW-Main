local OBJ = RDV.VEHICLE_REQ.AddVehicle("Y-Wing")

--[[---------------------------------]]----
-- Set the Class of the Vehicle.
--[[---------------------------------]]--

OBJ:SetClass("lvs_starfighter_ywing")

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
  "CE General",
  "CE Marshal Chief",
  "CE Chief",
  "CE Assistant Chief",
  "CE Chief Technician",
  "CE Razor Squadron",
  "RC Fixer",
  --"RC Impact",
  "CF99 Tech"
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

OBJ:SetCategory("Heavy Bomber")

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
