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
  "CE General",
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
  "CE Marshal Chief",
  "CE Chief",
  "CE Assistant Chief",
  "CE Chief Technician",
  "CE Engineer",
  "CE Razor Squadron",
  "CE ARC",
  "CE Alpha ARC",
  "CE Medic Officer",
  "CE Specialist",
  "CE EOD",
  "Jedi Grand Master",
  "GC Grand Master",
  "Jedi General Aayla Secura",
  "CE General Aayla Secura",
  "501st Jedi",
  "212th Jedi",
  "CE Jedi",
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
  "Fleet Engineering Officer",
  "Fleet Security Officer",
  "Fleet Medical Officer"
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
