--/*-----------------------------------------------------------
--	Nice DeathScreen
--	
--	Copyright © 2015 Szymon (Szymekk) Jankowski
--	All Rights Reserved
--	Steam: https://steamcommunity.com/id/szymski
---------------------------------------------------------------*/

include("NDS_config.lua")
local Config = NDSConfig

NDS_Enabled = true

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("nds_config.lua")

	CreateConVar("nds_ver", 1, FCVAR_NOTIFY)

	util.AddNetworkString("NDS_death")

	hook.Add("PlayerDeath", "NDSDeath", function(victim, inflictor, attacker) 
		if !NDS_Enabled then return end
		if victim:IsBot() then return end
		net.Start("NDS_death")
		net.WriteEntity(attacker)
		if IsValid(attacker) && attacker.GetRoleString then
			local role = attacker:GetRoleString()
			role = role:sub(1,1):upper() .. role:sub(2)
			net.WriteString(role)
		end
		net.Send(victim)
		
		local group = victim:GetUserGroup()
		local respawnDelay = (Config.GroupRespawnDelay or {})[group] or Config.RespawnDelay
		
		victim:SetNWInt("respawndelay", CurTime() + respawnDelay)
		if Config.ForceRespawn then
			timer.Simple(respawndelay + 0.2, function()
				if IsValid(victim) && !victim:Alive() then
					victim:Spawn()
				end
			end)
		end
	end)

	hook.Add("PlayerDeathSound", "NDSDeathSound", function()
		return !Config.DefaultSound
	end)


	hook.Add("PlayerSpawn", "NDSPlayerSpawn", function(ply)
		if !ply.GetRoleString && ply:GetNWInt("respawndelay") > CurTime() then
			ply:KillSilent()
			timer.Simple(0.1,function()
				ply:KillSilent()
			end)
		end
	end)

	return
end

/*------------------------------------
	Main
--------------------------------------*/

local MatGradientUp = Material("vgui/gradient-u")
local MatGradientDown = Material("vgui/gradient-d")

local active = false
local deathTime = 0
local attacker = nil

local oldHUDPaint = nil

local function DrawBox(x, y, w, h)
	surface.SetDrawColor(Config.SleekBoxColor)
	surface.DrawRect(x, y, w, h)

	surface.SetDrawColor(255, 255, 255, 50)
	surface.DrawLine(x+1, y+1, x+w-2, y+1)
	surface.SetDrawColor(255, 255, 255, 20)
	surface.DrawLine(x+w-2, y+1, x+w-2, y+h-1)

	surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawOutlinedRect(x, y, w, h)

	surface.SetDrawColor(0, 0, 0, 80)
	surface.SetMaterial(MatGradientDown)
	surface.DrawTexturedRect(x, y+h*0.7, w, h*0.3)
end

NDSP = NDSP

if IsValid(NDSP) then
	NDSP:Remove()
	NDSP = nil
end

surface.CreateFont("name_font", {
	font = "Roboto",
	size = 38,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

local plyKiller = nil

local function ShowPlayerInfo(killer)
	if !IsValid(killer) then
		plyKiller = LocalPlayer()
	else
		plyKiller = killer
	end

	if IsValid(NDSP) then
		NDSP:Remove()
		NDSP = nil
	end

	NDSP = vgui.Create("DPanel")
	NDSP:SetSize(300,400)
	function NDSP:Paint(w, h)
		DrawBox(0,0,w,h)
	end
	NDSP:SetPos(20, ScrH()/2-NDSP:GetTall()/2)

	NDSP.Avatar = NDSP:Add("AvatarImage")
	NDSP.Avatar:SetSize(96, 96)
	NDSP.Avatar:SetPlayer(plyKiller, 128)
	NDSP.Avatar:SetPos(300/2 - 96/2,16)

	NDSP.Name = NDSP:Add( "DLabel" )
	NDSP.Name:SetFont( "name_font" )
	NDSP.Name:SetTextColor( Color( 255, 255, 255 ) )
	NDSP.Name:DockMargin( 8, 0, 0, 0 )
	NDSP.Name:SetPos(0,120)
	function NDSP.Name:Think()
		if !IsValid(plyKiller) then return end
		NDSP.Name:SetText(plyKiller:Name())
		NDSP.Name:SizeToContents()
		NDSP.Name:CenterHorizontal()
	end

	local pos = 120

	if Config.ShowJob && plyKiller.getDarkRPVar then
		pos = pos + 40
		NDSP.Job = NDSP:Add( "DLabel" )
		NDSP.Job:SetFont( "name_font" )
		NDSP.Job:SetTextColor( Color( 255, 255, 255 ) )
		NDSP.Job:DockMargin( 8, 0, 0, 0 )
		NDSP.Job:SetPos(0,pos)
		function NDSP.Job:Think()
			if !IsValid(plyKiller) then return end
			NDSP.Job:SetText(plyKiller:getDarkRPVar("job"))
			NDSP.Job:SizeToContents()
			NDSP.Job:CenterHorizontal()
		end
	end

	if Config.ShowRole && plyKiller.GetRoleString then
		pos = pos + 40
		NDSP.Role = NDSP:Add( "DLabel" )
		NDSP.Role:SetFont( "name_font" )
		NDSP.Role:SetTextColor(Config.RoleColors[plyKiller.nds_role] or Color( 255, 255, 255 ) )
		NDSP.Role:DockMargin( 8, 0, 0, 0 )
		NDSP.Role:SetPos(0, pos)
		NDSP.Role:SetText(plyKiller.nds_role or "")
		NDSP.Role:SizeToContents()
		NDSP.Role:CenterHorizontal()

		/*function NDSP.Role:Think()
			if !IsValid(plyKiller) then return end
			NDSP.Role:SetText(plyKiller:GetRoleString())
			NDSP.Role:SizeToContents()
			NDSP.Role:CenterHorizontal()
		end*/
	end

	if Config.ShowHP then
		pos = pos + 40
		NDSP.Health = NDSP:Add( "DLabel" )
		NDSP.Health:SetFont( "name_font" )
		NDSP.Health:SetTextColor( Color( 255, 255, 255 ) )
		NDSP.Health:DockMargin( 8, 0, 0, 0 )
		NDSP.Health:SetPos(0,pos)
		function NDSP.Health:Think()
			if !IsValid(plyKiller) then return end
			NDSP.Health:SetText("Health: " .. plyKiller:Health() .. "%")
			NDSP.Health:SizeToContents()
			NDSP.Health:CenterHorizontal()
		end
	end
	
	if Config.ShowArmor then
		pos = pos + 40
		NDSP.Armor = NDSP:Add( "DLabel" )
		NDSP.Armor:SetFont( "name_font" )
		NDSP.Armor:SetTextColor( Color( 255, 255, 255 ) )
		NDSP.Armor:DockMargin( 8, 0, 0, 0 )
		NDSP.Armor:SetPos(0,pos)
		function NDSP.Armor:Think()	
			if !IsValid(plyKiller) then return end
			NDSP.Armor:SetText("Armor: " .. plyKiller:Armor() .. "%")
			NDSP.Armor:SizeToContents()
			NDSP.Armor:CenterHorizontal()
		end
	end

	NDSP:SetSize(300,pos+48)
	NDSP:SetPos(-400, ScrH()/2-NDSP:GetTall()/2)

	function NDSP:Think()
		if !IsValid(plyKiller) then
			self:Remove()
		end

		if Config.SmoothAnim then
			self:SetPos(math.Clamp(Lerp(FrameTime()*10,self:GetPos(),40),-400,30),ScrH()/2-NDSP:GetTall()/2)
		else
			self:SetPos(math.Clamp(self:GetPos()+500*FrameTime(),-400,30),ScrH()/2-NDSP:GetTall()/2)
		end
	end

end

local p = 0

local function OnDeath(ply, Attacker, inflictor, role)
	active = true
	deathTime = RealTime()

	if Config.SoundEffect != 0 then
		ply:SetDSP(Config.SoundEffect, false)
	end

	if Config.StopSounds then
		RunConsoleCommand("stopsound")
	end

	attacker = Attacker

	if IsValid(attacker) && attacker:IsPlayer() then
		attacker.nds_role = role

		attacker.nds_wep = nil
		if Config.ShowWeapon && IsValid(attacker:GetActiveWeapon()) then
			attacker.nds_wep = attacker:GetActiveWeapon():GetPrintName()
		end
	end

	if Config.HideHUD then
		if GAMEMODE then
			oldHUDPaint = GAMEMODE.HUDPaint
			function GAMEMODE:HUDPaint() end
		else
			oldHUDPaint = GM.HUDPaint
			function GM:HUDPaint() end
		end

		vgui.GetWorldPanel():SetVisible(false)
	end

	if Config.ShowKillerInfo then
		timer.Simple(2, function()
			if IsValid(attacker) && IsValid(attacker.CPPIGetOwner and attacker:CPPIGetOwner() or attacker:GetOwner()) && (attacker.CPPIGetOwner and attacker:CPPIGetOwner() or attacker:GetOwner()) != LocalPlayer() then
				ShowPlayerInfo(attacker.CPPIGetOwner and attacker:CPPIGetOwner() or attacker:GetOwner())
				// Hey baby - 76561198018684576 && 0.8.3
			elseif IsValid(attacker) && attacker:IsPlayer() && attacker != LocalPlayer() then
				ShowPlayerInfo(attacker)
			end
			
		end)
	end

	if Config.URLSound != "" then
		sound.PlayURL(Config.URLSound, "", function(snd)
			if !IsValid(snd) then return end
			snd:Play()
			NDSSND = snd
		end)
	end

	p = 10

	//ShowPlayerInfo()
end

/*------------------------------------
	Player View
--------------------------------------*/

local lastPos = Vector(0,0,0)
local lastAng = Angle(0,0,0)

hook.Add("CalcView", "NDSCalcView", function(ply, pos, angles, fov)
	if !active || RealTime() < deathTime+2 || !Config.KillerCamera then
		lastPos = pos
		lastAng = angles
		return
	end

	if attacker == LocalPlayer() then return end	

	if IsValid(attacker) && attacker:IsPlayer() then
		local view = { }

		lastAng = LerpAngle(FrameTime()*5, lastAng,  Angle(0,attacker:EyeAngles().y - 180,0))
		lastPos = LerpVector(FrameTime()*5, lastPos, attacker:GetPos() + Vector(0,0,60))

		view.fov = fov
		view.origin = lastPos - (lastAng:Forward()*100)
		view.angles = lastAng
	 
		return view
	elseif IsValid(attacker) && attacker:IsNPC() then
		local view = { }

		lastAng = LerpAngle(FrameTime()*5, lastAng, attacker:GetAngles() - Angle(0,180,0))
		lastPos = LerpVector(FrameTime()*5, lastPos, attacker:GetPos() + Vector(0,0,60))

		view.fov = fov
		view.origin = lastPos - (lastAng:Forward()*100)
		view.angles = lastAng
	 
		return view
	elseif IsValid(attacker) then
		local view = { }

		lastPos = LerpVector(FrameTime()*5, lastPos, attacker:WorldSpaceCenter())

		local tr = util.TraceLine({
			start = lastPos, 
			endpos = lastPos - (angles:Forward()*100), 
			filter = function(ent) if ( ent == attacker ) then return false end end
		})

		view.fov = fov
		view.origin = lastPos - (angles:Forward()*90) * tr.Fraction
		view.angles = angles
	 
		return view
	end
end)

/*------------------------------------
	Effects
--------------------------------------*/

hook.Add("RenderScreenspaceEffects", "NDSEffects", function()
	if !active then return end
	
	if Config.BlackAndWhite then
		local tab = {
			[ "$pp_colour_addr" ] = 0, 
			[ "$pp_colour_addg" ] = 0, 
			[ "$pp_colour_addb" ] = 0, 
			[ "$pp_colour_brightness" ] = 0, 
			[ "$pp_colour_contrast" ] = 1, 
			[ "$pp_colour_colour" ] = 1-math.Clamp((RealTime() - deathTime)*4, 0, 1), 
			[ "$pp_colour_mulr" ] = 0, 
			[ "$pp_colour_mulg" ] = 0, 
			[ "$pp_colour_mulb" ] = 0

		}
		DrawColorModify(tab)
	end

end)

surface.CreateFont("death_font", {
	font = "Roboto",
	size = 51,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

local MatBlur = Material("pp/blurscreen")

hook.Add("HUDPaintBackground", "NDSHUD", function()
	if !active then return end

	if Config.ScreenBlur then
		local f = math.Clamp(4-(RealTime() - deathTime), 0, 1)

		surface.SetDrawColor(255, 255, 255, 255*f)
		surface.SetMaterial(MatBlur)

		for i = 1, 8 do
			MatBlur:SetFloat("$blur", 4)
			MatBlur:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end
	end

	surface.SetDrawColor(Color(0,0,0))

	if Config.SmoothAnim then
		p = math.Clamp(Lerp(FrameTime()*4,p,-0.1), 0, 1)
	else
		p = math.Clamp(3-(RealTime() - deathTime), 0, 1)
	end

	if Config.DeathScreenStyle == 1 then
		DrawBox(-2,-ScrH()/9*p-2, ScrW()+4, ScrH()/9+4)
		DrawBox(-2,ScrH() - ScrH()/9 + ScrH()/9*p, ScrW()+4, ScrH()/9)
	else
		surface.SetMaterial(MatGradientUp)
		surface.DrawTexturedRect(-2,-ScrH()/9*p-2, ScrW()+4, ScrH()/9+4)
		surface.SetMaterial(MatGradientDown)
		surface.DrawTexturedRect(-2,ScrH() - ScrH()/9 + ScrH()/9*p, ScrW()+4, ScrH()/9)
	end

	local text = "You died"

	if attacker == LocalPlayer() || IsValid(attacker) && (attacker.CPPIGetOwner and attacker:CPPIGetOwner() or attacker:GetOwner()) == LocalPlayer() then
		text = "You killed yourself"
	elseif IsValid(attacker) && attacker:IsPlayer() then
		text = attacker:Name() .. " has killed you"
		if attacker.nds_wep then
			text = text .. " using " .. attacker.nds_wep
		end
	elseif IsValid(attacker) && attacker:IsNPC() then
		text = "You were killed by an NPC"
	elseif IsValid(attacker) && IsValid(attacker.CPPIGetOwner and attacker:CPPIGetOwner() or attacker:GetOwner()) then
		text = "You were killed by " .. (attacker.CPPIGetOwner and attacker:CPPIGetOwner() or attacker:GetOwner()):Name() .. "'s prop"
	elseif IsValid(attacker) then
		text = "You were killed by a prop"
	end

	if Config.BottomText != "" then
		text = Config.BottomText
	end

	draw.DrawText(text, "death_font", ScrW()/2, ScrH() - (ScrH()/9/2)-24 + ScrH()/9*p, Color(255,255,255, 255*(1-p)), TEXT_ALIGN_CENTER)

	local secs = LocalPlayer():GetNWInt("respawndelay") - CurTime()
	if secs > 0 then
		draw.DrawText(string.format(Config.SecondsText, math.floor(secs+1)), "death_font", ScrW()/2, -ScrH()/9*p-2+ScrH()/9/2-24, Color(255,255,255, 255*(1-p)), TEXT_ALIGN_CENTER)
	else
		draw.DrawText(Config.ForceRespawn and "Respawning" or Config.RespawnText, "death_font", ScrW()/2, -ScrH()/9*p-2+ScrH()/9/2-24, Color(255,255,255, 255*(1-p)), TEXT_ALIGN_CENTER)
	end
	
	if Config.BlackScreen then
		surface.SetDrawColor(Color(0,0,0,255*math.Clamp(4-(RealTime() - deathTime), 0, 1)))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end

end)

/*------------------------------------
	Other
--------------------------------------*/

hook.Add("Tick", "NDSTick", function() 
	if Config != NDSConfig then
		Config = NDSConfig
	end
	if active && LocalPlayer():Alive() && RealTime() > deathTime + 2 then
		active = false
		if IsValid(NDSP) then
			NDSP:Remove()
			NDSP = nil
		end
		LocalPlayer():SetDSP(0, false)
		if oldHUDPaint then
			GAMEMODE.HUDPaint = oldHUDPaint
		end
		vgui.GetWorldPanel():SetVisible(true)
		if IsValid(NDSSND) then
			NDSSND:Stop()
			NDSSND = nil
		end
	end

	if IsValid(NDSP) && (!IsValid(plyKiller) || !active) then
		NDSP:Remove()
	end
end)

net.Receive("NDS_death", function()
	if !NDS_Enabled then return end
	OnDeath(LocalPlayer(), net.ReadEntity(), nil, (LocalPlayer().GetRoleString and net.ReadString() or ""))
end)

hook.Add("HUDShouldDraw", "NDSShouldDraw", function(hud)
	if hud == "CHudDamageIndicator" then return false end
	if active && hud == "FG-Local-HUDPaint" then return false end
end)

hook.Add("PlayerDeathSound", "NDSDeathSound", function()
	return !Config.DefaultSound
end)

hook.Add("CreateMove", "NDSMove",function(cmd)
	if LocalPlayer():GetNWInt("respawndelay") > CurTime() then
		cmd:ClearButtons()
		cmd:ClearMovement()
	else
		if active && LocalPlayer().IsRole && cmd:GetButtons() > 0 && LocalPlayer():GetNWInt("respawndelay") < CurTime()  then
			active = false
			if IsValid(NDSP) then
				NDSP:Remove()
				NDSP = nil
			end
			LocalPlayer():SetDSP(0, false)
			if oldHUDPaint then
				GAMEMODE.HUDPaint = oldHUDPaint
			end
			vgui.GetWorldPanel():SetVisible(true)
		end
	end
end)