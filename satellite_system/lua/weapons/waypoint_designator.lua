AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.Category = "[Kaito] Artillery System"

SWEP.PrintName = "Waypoint Designator"
SWEP.Author = "Ace"
SWEP.Contact = "github.com/hiisuuii/waypointsystem-swep"
SWEP.Instructions = "R to change color, LMB to place/remove, RMB to zoom"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/ace/sw/w_macrobinoculars.mdl"

SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Slot = 2
SWEP.SlotPos = 10
SWEP.Weight = 1 
SWEP.DrawAmmo = false
SWEP.DrawWeaponInfoBox = true
SWEP.DrawCrosshair = true
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false


local LastRld = -1
local zoomed = false

local colors = {
		[1] = "Red",
		[2] = "Green",
		[3] = "Blue",
		[4] = "Yellow",
		[5] = "Purple"
		}

if SERVER then
	util.AddNetworkString("wpname")
	util.AddNetworkString("kaito_waypoints_sounds")
end

function SWEP:ShouldDrawViewModel()
	return false
end

function SWEP:Initialize()
	self:SetHoldType("camera")
	self.waypointcolor = 1
	self.WaypointName = ""

end

function SWEP:Precache()
	util.PrecacheSound( "kaito/macroping/waypoint_place.mp3" )
	util.PrecacheSound( "kaito/macroping/waypoint_remove.mp3" )
	util.PrecacheSound( "kaito/macroping/waypoint_fail.mp3" )
	util.PrecacheSound( "kaito/macroping/swep_zoom.mp3" )
	util.PrecacheSound( "kaito/macroping/swep_change_color.mp3" )
end

function SWEP:Reload()
	if LastRld < CurTime() then 
		if self.waypointcolor >= 5 then
			self.waypointcolor = 1
		elseif self.waypointcolor >= 1 then
			self.waypointcolor = self.waypointcolor + 1
		end
		if CLIENT then
			self.Weapon:EmitSound( "kaito/macroping/swep_change_color.mp3", 35, 100, 1, CHAN_WEAPON )
			self.Owner:ChatPrint("Waypoint color set to "..colors[self.waypointcolor])
		end
		//print(waypointcolor) //debug
		LastRld = CurTime() + 0.5
	end
end

function SWEP:Deploy()
	zoomed = false
end

function SWEP:Think()
	
end

function SWEP:PrimaryAttack()
	if SERVER then

		if self.Owner:KeyDown(IN_SPEED) and self.Owner:IsAdmin() then
			for k,v in ipairs(ents.FindByClass("waypoint_marker")) do
				v:Remove()
			end
			self.Owner:ChatPrint("All Waypoints cleared")
			return 
		end

		local hitpos = self.Owner:GetEyeTrace().HitPos
		local alreadyPoint = false

		for k,v in ipairs(ents.FindInSphere(hitpos,320)) do
			if v:GetClass() == "waypoint_marker" then
				if (v:GetWPOwner() == self.Owner) or (self.Owner:IsAdmin()) then
					net.Start("kaito_waypoints_sounds")
						net.WriteString("remove")
					net.Send(self.Owner)
					v:Remove()
				else
					self.Owner:ChatPrint("That waypoint is not owned by you! It is owned by "..v:GetWPOwner():GetName())
					net.Start("kaito_waypoints_sounds")
						net.WriteString("fail")
					net.Send(self.Owner)
					
				end
				alreadyPoint = true
			else
				alreadyPoint = false
			end
		end

		if alreadyPoint then
			return
		else
			ent = ents.Create("waypoint_marker")
			ent:SetPos(self.Owner:GetEyeTrace().HitPos)
			ent:SetColorType(self.waypointcolor)
			ent:SetWPOwner(self.Owner)
			local sendCheck = GetConVar("macroping_play_sounds_all"):GetInt()
			if (sendCheck == 0) then
				net.Start("kaito_waypoints_sounds")
					net.WriteString("add")
				net.Send(self.Owner)
			else
				net.Start("kaito_waypoints_sounds")
					net.WriteString("add")
				net.Broadcast()
			end
			
			
		end
	end

	

end

function SWEP:SecondaryAttack()
	local checkPlaySounds = GetConVar("macroping_play_zoom_sounds"):GetInt()
	if(self.Owner:KeyDown(IN_SPEED)) then
		if(IsFirstTimePredicted()) then
			self:DermaPanel()
			//print("EEEEEEEEEEEEEEEE") //debug
		zoomed = false
		end
	elseif not (self.Owner:KeyDown(IN_SPEED)) then
		if not(zoomed) then
			if(IsFirstTimePredicted()) then
			//if CLIENT then
				self.Owner:SetFOV(20,0.3)
				if (checkPlaySounds != 0) then
					self.Weapon:EmitSound( "kaito/macroping/swep_zoom.mp3", 40, 100, 1, CHAN_WEAPON )
				end
				
			//end
			zoomed = true
			end
		elseif(zoomed) then
			if(IsFirstTimePredicted()) then
			//if CLIENT then
				self.Owner:SetFOV(0,0.3)
				if (checkPlaySounds != 0) then
					self.Weapon:EmitSound( "kaito/macroping/swep_zoom.mp3", 40, 100, 1, CHAN_WEAPON )
				end
				
			//end
			zoomed = false
			end
		end
	end
end

function SWEP:DrawHUD()
	local shouldDrawMatOverlay = GetConVar("macroping_draw_scifi"):GetInt()
	if (shouldDrawMatOverlay != 0) then
		DrawMaterialOverlay("effects/combine_binocoverlay", -2)
	end
	local binOverlay = Material("kaito/bino_overlay.png")
	local shouldDrawBinOverlay = GetConVar("macroping_draw_overlay"):GetInt()
	if (shouldDrawBinOverlay != 0) then
		surface.SetDrawColor(0, 0, 0, 255)
		surface.SetMaterial(binOverlay)
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	end
	
end

function SWEP:AdjustMouseSensitivity()
     
	//if self.Owner:KeyDown(IN_ATTACK2) then
	if(zoomed) then
       	return 0.2
   	else 
   	 	return 1
   	end
end

function SWEP:DermaPanel()
	if CLIENT then
		local Frame = vgui.Create( "DFrame" )
		local framew = ScrW()* 300/1920
		local frameh = ScrH() * 75/1080
		Frame:SetPos( ScrW()/2 - (framew)/2, ScrH()/2 - (frameh)/2 ) 
		Frame:SetSize( framew, frameh+25 ) 
		Frame:SetTitle( "Set waypoint name" ) 
		Frame:SetVisible( true ) 
		Frame:SetDraggable( true ) 
		Frame:ShowCloseButton( true ) 
		Frame:MakePopup()

		local NameEntry = vgui.Create("DTextEntry", Frame)
		NameEntry:SetPos(10, 40)
		NameEntry:SetSize(framew - (ScrW() * 20/1920),25)
		NameEntry:SetText("Waypoint Name")
		NameEntry:SetUpdateOnType(true)
		NameEntry.OnValueChange = function()
			self.WaypointName = NameEntry:GetValue()
		end
		NameEntry.OnEnter = function()
			self.WaypointName = NameEntry:GetValue()
			net.Start("wpname")
			net.WriteString(self.WaypointName)
			net.SendToServer()
		end

		local desc = vgui.Create("DLabel", Frame)
		desc:SetPos(10,70)
		desc:SetSize(framew - (ScrW() * 20/1920), 25)
		desc:SetText("ENTER to confirm")

	end
end