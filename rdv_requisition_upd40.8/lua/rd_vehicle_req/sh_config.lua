--[[---------------------------------]]--
--	Menu Model
--[[---------------------------------]]--

RDV.VEHICLE_REQ.CFG.Menu = {
    Model = "models/epsilon/cwa_furniture/warroom/eps_warroom_holotable.mdl",
}

--[[---------------------------------]]--
--	Prefix
--[[---------------------------------]]--

RDV.VEHICLE_REQ.CFG.Overhead = {
    Accent = Color(30,150,220),
}

RDV.VEHICLE_REQ.CFG.Prefix = {
    Appension = "ACR",
    Color = Color(255,0,0)
}

--[[---------------------------------]]--
--	Extra Tabs
--[[---------------------------------]]--
-- true to enable, false to disable.
RDV.VEHICLE_REQ.CFG.Tabs = {
    ["active"] = false,
}

--[[---------------------------------]]--
--	Max Vehicles Allowed to be spawned at all times.
--[[---------------------------------]]--
-- false to disable or number

RDV.VEHICLE_REQ.CFG.MaxVehicles = false

--[[---------------------------------]]--
--	Max Distance for Hangars
--[[---------------------------------]]--

RDV.VEHICLE_REQ.CFG.Distance = false

--[[---------------------------------]]--
--	Should we display locations of hangars?
--[[---------------------------------]]--

RDV.VEHICLE_REQ.CFG.HDisplay = false

--[[---------------------------------]]--
--	Size of Hangars (Determines Blockage)
--[[---------------------------------]]--

RDV.VEHICLE_REQ.CFG.Size = 200

--[[---------------------------------]]--
--	Auto-Deny Time
--[[---------------------------------]]--

RDV.VEHICLE_REQ.CFG.Waiting = 20

--[[---------------------------------]]--
--	Self-Grant
--[[---------------------------------]]--
-- Should players be able to grant their own vehicle-
-- if they meet the requirements?

RDV.VEHICLE_REQ.CFG.SGrant = true

--[[---------------------------------]]--
--	Model(s)
--[[---------------------------------]]--
-- Playermodels

RDV.VEHICLE_REQ.CFG.Models = {
    "models/ace/sw/r4.mdl",
}

--[[---------------------------------]]--
--	Stance(s)
--[[---------------------------------]]--

RDV.VEHICLE_REQ.CFG.Stances = {
    "pose_standing_02",
    "idle_all_01",
    "idle_all_02"
}

--[[---------------------------------]]--
--	Customization
--[[---------------------------------]]--
-- Should we auto-customize Bodygroups and Skins?

RDV.VEHICLE_REQ.CFG.Randomize = false
