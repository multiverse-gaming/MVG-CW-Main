
TOOL.Category = "Event Tools"
TOOL.Name = "Conquest"


if CLIENT then
	language.Add( "tool.republic_conquest.name", "Conquest" )
	language.Add( "tool.republic_conquest.desc", "Creates objectives for players to do!" )
	language.Add( "tool.republic_conquest.0", "Left Click: Creates a configured objecitve." )
end

if SERVER then
	util.AddNetworkString("RQ_SyncConquestRemoval")
end

local function QueueConquestRemoval(index)
	if CLIENT then
		net.Start("RQ_SyncConquestRemoval")
			net.WriteUInt(index, 16)
		net.SendToServer()
	end
end

local ConVarsDefault = TOOL:BuildConVarList()

local function BuildCPanel()
	local CPanel = controlpanel.Get("republic_conquest")

	CPanel:ClearControls()

    CPanel:AddControl( "ComboBox", 
	{ 
		MenuButton = 1,
		Folder = "republic_conquest",
		Options = { [ "#preset.default" ] = ConVarsDefault },
		CVars = table.GetKeys( ConVarsDefault ) 
	}
	)

	CPanel:AddControl("Header", 
	{
		Text = "Republic Conquest",
		Description = "Put down control points for players to conquer!"
	}
	)	
	CPanel:AddControl( "slider", 
	{ 
		Label = "Radius:",
	 	Command = "republic_conquest_radius",
		min = "1",
		max = "10000"
	}
	)
	CPanel:ControlHelp("What is the radius of your control point?")

	CPanel:AddControl( "slider", 
	{ 
		Label = "Time:",
	 	Command = "republic_conquest_time",
		min = "1",
		max = "10000"
	}
	)

	CPanel:ControlHelp("How long does it take to capture your control point?")

	CPanel:AddControl( "ComboBox", 
	{
		Label = "Point Icon:",
		Command = "republic_conquest_icon",
		Options = list.Get("RQ_PointIcons")
	} 
	)

	CPanel:AddControl( "checkbox", 
	{ 
		Label = "Display?", 
		Command = "republic_conquest_display"
	} 
	)

    CPanel:ControlHelp("Sets if the point should display at all times. If not, it will only display when the player is in it.")

	CPanel:AddControl( "label", { Text = "Every single player / NPC in the radius will add 5% to the capture rate, max at 50% at 10 players."})
	CPanel:AddControl( "label", { Text = "Do math, use twice the duration you want it to be captured."})

	CPanel:AddControl( "Header", 
	{ 
		Description = "Delete a control point! Click on the index you placed!" 
	} 
	)

	local Panel = controlpanel.Get("republic_conquest")
	local ComboBox = Panel:ListBox()
	ComboBox:CleanList()
	ComboBox:SetTall( 300 )

	local Limit = 100
	local Count = 0
	
	for k, v in ipairs( RepublicConquest.Point ) do
		if isnumber(RepublicConquest.Point
[k]) then return end
	
		if RepublicConquest.Point[k]["Active"] then
			local Item = ComboBox:AddItem( "Control Point Index #".. tostring( k ).. " for ".. tostring(RepublicConquest.Point[k]["Time"]).."s" )

			Item.DoClick = function()
				QueueConquestRemoval(k) 
				RepublicConquest:RemovePoint(k)
			end
		end
		Count = Count + 1
		if ( Count > Limit ) then break end
	end

	CPanel:AddControl("button", { Label = "Delete All", Command = "republic_conquest_deleteall" })
end

list.Set("RQ_PointIcons", "Blank", 				{republic_conquest_icon = "blank"})
list.Set("RQ_PointIcons", "Capture", 				{republic_conquest_icon = "capture"})
list.Set("RQ_PointIcons", "Command Post", 				{republic_conquest_icon = "post"})
list.Set("RQ_PointIcons", "Destroy", 				{republic_conquest_icon = "destroy"})
list.Set("RQ_PointIcons", "Defend", 				{republic_conquest_icon = "defend"})


net.Receive("RepublicConquest_Menu", function()
	BuildCPanel()
end)

function TOOL:BuildCPanel()
	BuildCPanel()
end

function TOOL:Deploy()
	self.Owner.ShouldDisplayRepublic = true
end

function TOOL:Holster()
	self.Owner.ShouldDisplayRepublic = false
end

function TOOL:Think()
	self.Owner.ShouldDisplayRepublic = true
end

TOOL.ClientConVar[ "radius" ] = "100"
TOOL.ClientConVar[ "time" ] = "500"
TOOL.ClientConVar[ "icon" ] = "blank"
TOOL.ClientConVar[ "display" ] = "1"

function TOOL:LeftClick(tr)
	if not IsFirstTimePredicted() then return end
	self:SetupConquest(tr.HitPos)
end

function TOOL:RightClick(tr)
	if not IsFirstTimePredicted() then return end
end

function TOOL:SetupConquest(pos, pos1, pos2)
	local radius = self:GetClientInfo("radius")
	local owner = self.Owner
	local time = self:GetClientInfo("time")
	local icon = self:GetClientInfo("icon")
	local display = self:GetClientInfo("display")

	RepublicConquest:AddPoint(pos, radius, pos1, pos2, owner, time, icon, display)
end

if CLIENT then
	hook.Add( "PostDrawTranslucentRenderables", "PreviewRepublicToolgunSphere", function()
		if LocalPlayer().ShouldDisplayRepublic == true then
			if not IsValid(LocalPlayer():GetActiveWeapon()) then return end
			if LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" then

				render.SetColorMaterial()

				local pos = LocalPlayer():GetEyeTrace().HitPos
				
				local radius = GetConVarNumber("republic_conquest_radius")
				render.DrawSphere( pos, radius, 30, 30, Color( 0, 175, 175, 100 ) )
			end
		end
	end )
end

concommand.Add("republic_conquest_deleteall", function()
	net.Start("RepublicConquest_SyncServerRemovalAll")
		RepublicConquest:ClearAll()
	net.SendToServer()
end)