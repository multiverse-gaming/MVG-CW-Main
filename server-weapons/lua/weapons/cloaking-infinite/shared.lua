AddCSLuaFile()
include("weapons/ce_bcr_config.lua")
------------------------------------
-- SWEP Info
------------------------------------
SWEP.Author = "Temporary Solutions"
SWEP.Category = "MVG"
SWEP.PrintName = "Electroplating Cloak"
SWEP.Base = "weapon_base"
SWEP.Instructions = [[Left-Click: Toggle Cloak
Right-Click: N/A]]
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = true
------------------------------------
-- SWEP Models
------------------------------------
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
--SWEP.HoldType               =   "normal"
------------------------------------
-- SWEP Slot Properties
------------------------------------
SWEP.AutoSwitchTo = true
SWEP.AutoSwithFrom = true
SWEP.Slot = 5
SWEP.SlotPos = 120
------------------------------------
-- SWEP Weapon Properties
------------------------------------
--SWEP.m_WeaponDeploySpeed 	= 	100
SWEP.OnRemove = onDeathDropRemove
SWEP.OnDrop = onDeathDropRemove
SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
--[[
	Hey me, don't forget if you're going to copy paste this for the other 3 sweps you need to:
	Change cloakconfig.MaxCharge0
	Edit SWEP:Equip, The Timers, and HudDraw
	And change ce_bc2_0
]]
--
cloakconfig.CloakType = "Material"
cloakconfig.CloakMaterial = "models/shadertest/shader3"
cloakconfig.CloakFireMode = 1

function SWEP:Initialize()
	--self:SetHoldType(self.HoldType)
	sound.Add({
		name = "CloakTauntSound",
		channel = CHAN_STATIC,
		volume = cloakconfig.TauntVolume,
		level = 70,
		pitch = {95, 100},
		sound = cloakconfig.TauntSound
	})
end

local function Cloak(ply)
	local plyVelocity = ply:GetVelocity()
	local plyWeapon = ply:GetActiveWeapon()
	local col = ply:GetColor()
	ply:SetNWBool("HideHUD", true)
	local untilVelAlpha = math.max(0, plyVelocity:Length() - cloakconfig.CloakUntilVel) -- Keeps player completly cloaked until they meet a set velocity.
	local approachAlpha = math.Approach(col.a, untilVelAlpha, 500 * FrameTime()) -- Gradually get to the alpha (Instead of snapping to it).
	approachAlpha = math.max(approachAlpha, cloakconfig.MinimumVisibility) -- If the alpha is being set below the set minimum, just use the minimum.
	--[[
    	This is a fix for most weapons not going invisible unless the
    	alpha is 0. I don't think I can fix this as
    	it probably has to do with the weapon's models or textures.
    --]]
	local wepAlpha = 0

	if untilVelAlpha >= 70 then
		wepAlpha = untilVelAlpha
	else
		wepAlpha = 0
	end

	if cloakconfig.CloakEffectOn ~= "" then
		local effectpos = ply:GetPos()
		local effectdata = EffectData()
		effectdata:SetOrigin(effectpos)
		effectdata:SetNormal(Vector(0, 0, 0))
		util.Effect(cloakconfig.CloakEffectOn, effectdata)
	end

	ply:RemoveAllDecals()
	ply:DrawShadow(false)
	ply:SetDSP(cloakconfig.DistortSound)

	if cloakconfig.CloakType == "Transparent" then
		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(255, 255, 255, approachAlpha))
		plyWeapon:SetRenderMode(RENDERMODE_TRANSALPHA)
		plyWeapon:SetColor(Color(255, 255, 255, wepAlpha))
	elseif cloakconfig.CloakType == "Material" then
		ply:SetMaterial(cloakconfig.CloakMaterial, true)
		plyWeapon:SetMaterial(cloakconfig.CloakMaterial, true)
	end

	if SERVER then
		--if approachAlpha < cloakconfig.MinimumNPCVisibility then
		ply:SetNoTarget(true)
		--else
		--ply:SetNoTarget(false)
		--end
	end
end

local function Uncloak(ply, forced, debug, holdcharge)
	--print(debug)
	if forced and cloakconfig.ForceDisableSound ~= "" and ply.CloakActive then
		ply:EmitSound(cloakconfig.ForceDisableSound)
		--print("0 1")
	elseif cloakconfig.DisableSound ~= "" and debug ~= "Equip" and ply.CloakActive then
		ply:EmitSound(cloakconfig.DisableSound)
	end

	--print("0 2")
	ply:SetNWBool("HideHUD", false)
	ply.CloakActive = false
	ply:SetDSP(0)
	ply:DrawShadow(true)
	ply:SetRenderMode(RENDERMODE_NORMAL)
	ply:SetColor(Color(255, 255, 255, 255))
	ply:SetMaterial("")

	if SERVER then
		ply:SetNoTarget(false)
	end

	if not holdcharge then
		ply:SetNWFloat("CloakCharge", cloakconfig.MaxCharge0)
	end

	timer.Simple(cloakconfig.ToggleTime, function()
		ply.AllowedToggle = true
	end)

	if cloakconfig.CloakEffectOff ~= "" then
		local effectpos = ply:GetPos()
		local effectdata = EffectData()
		effectdata:SetOrigin(effectpos)
		effectdata:SetNormal(Vector(0, 0, 0))
		util.Effect(cloakconfig.CloakEffectOff, effectdata)
	end

	-- Uncloaks previously cloaked weapons
	for k, v in pairs(ply:GetWeapons()) do
		if IsValid(v) then
			v:SetRenderMode(RENDERMODE_NORMAL)
			v:SetColor(Color(255, 255, 255, 255))
		end
	end
end

local DontSpam = 0

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

	if ply.CloakActive == nil then
		ply.CloakActive = false
	elseif ply.AllowedToggle == nil then
		ply.AllowedToggle = true
	end

	if DontSpam < CurTime() then
		if SERVER then
			if not ply.CloakActive and ply.AllowedToggle then
				ply.CloakActive = true
				ply.AllowedToggle = false

				if cloakconfig.EnableSound ~= "" then
					ply:EmitSound(cloakconfig.EnableSound)
				end
			elseif ply.CloakActive then
				if cloakconfig.CloakMode == "Charge" then
					Uncloak(ply, false, "Primary", true)
				else
					Uncloak(ply, false, "Primary")
				end
			else
				if cloakconfig.ToggleFailureSound ~= "" then
					ply:EmitSound(cloakconfig.ToggleFailureSound)
				end
			end
		end

		DontSpam = CurTime() + 0.5
	end
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Reload()
	ply = self:GetOwner()

	if (self.nextreload or 0) <= CurTime() and cloakconfig.TauntSound ~= "" then
		self.nextreload = CurTime() + cloakconfig.TauntDelay
		ply:EmitSound("CloakTauntSound")
	end
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(true)
end

function SWEP:Equip()
	local ply = self.Owner

	--(Removes Other Cloaks)--
	if ply:HasWeapon("cloaking-1") then
		ply:StripWeapon("cloaking-1")
	elseif ply:HasWeapon("cloaking-2") then
		ply:StripWeapon("cloaking-2")
	elseif ply:HasWeapon("cloaking-3") then
		ply:StripWeapon("cloaking-3")
	end

	Uncloak(ply, false, "Equip")

	if cloakconfig.CloakMode == "Rechage" then
		self.Owner.CloakCharge = cloakconfig.MaxCharge0
	end
end

hook.Add("PlayerPostThink", "ce_bc2_0_ThinkHook", function(ply)
	if ply.CloakActive then
		Cloak(ply)
	end

	if not ply.LastCharge then
		ply.LastCharge = CurTime()
	end

	if SERVER and ply:HasWeapon("cloaking-0") then
		if cloakconfig.CloakMode == "Charge" and cloakconfig.MaxCharge0 ~= 0 then
			-- Depletes Charge
			if ply.LastCharge + (1 * cloakconfig.ChargeLossMultiplier) <= CurTime() and ply:GetNWFloat("CloakCharge") > 0 and ply.CloakActive then
				ply:SetNWFloat("CloakCharge", ply:GetNWFloat("CloakCharge") - 1)
				ply.LastCharge = CurTime()
			elseif ply.LastCharge + (1 * cloakconfig.ChargeGainMultiplier) <= CurTime() and ply:GetNWFloat("CloakCharge") < cloakconfig.MaxCharge0 and not ply.CloakActive and not ply.CloakPause then
				-- Adds Charge
				ply:SetNWFloat("CloakCharge", ply:GetNWFloat("CloakCharge") + 1)
				ply.LastCharge = CurTime()
			elseif ply.CloakActive and ply:GetNWFloat("CloakCharge") == 0 then
				-- Uncloaks when out of charge
				Uncloak(ply, true, "Charge", true)
			end
		end
	end

	-- Its like charge, without the recharge
	if ply:HasWeapon("cloaking-infinite") then
		if cloakconfig.CloakMode == "Timer" and cloakconfig.MaxCharge0 ~= 0 then
			if ply.LastCharge + 1 <= CurTime() and ply:GetNWFloat("CloakCharge") > 0 and ply.CloakActive then
				ply:SetNWFloat("CloakCharge", ply:GetNWFloat("CloakCharge") - 1)
				ply.LastCharge = CurTime()
			elseif ply.CloakActive and ply:GetNWFloat("CloakCharge") == 0 and cloakconfig.MaxCharge0 ~= 0 then
				Uncloak(ply, true, "Timer0")
				ply:SetNWFloat("CloakCharge", cloakconfig.MaxCharge0)
			end
		end
	end

	-- Copy pasted as an attempted bugfix for some weapons being a pain in the ass
	local plyVelocity = ply:GetVelocity()
	local plyWeapon = ply:GetActiveWeapon()
	local col = ply:GetColor()
	local untilVelAlpha = math.max(0, plyVelocity:Length() - cloakconfig.CloakUntilVel) -- Keeps player completly cloaked until they meet a set velocity.
	local approachAlpha = math.Approach(col.a, untilVelAlpha, 500 * FrameTime()) -- Gradually get to the alpha (Instead of snapping to it).
	approachAlpha = math.max(approachAlpha, cloakconfig.MinimumVisibility) -- If the alpha is being set below the set minimum, just use the minimum.
	--[[
    	This is a fix for most weapons not going invisible unless the
    	alpha is 0. I don't think I can fix this as
    	it probably has to do with the weapon's models or textures.
    --]]
	local wepAlpha = 0

	if untilVelAlpha >= 70 then
		wepAlpha = untilVelAlpha
	else
		wepAlpha = 0
	end

	if cloakconfig.CloakType == "Transparent" and ply.CloakActive then
		plyWeapon:SetRenderMode(RENDERMODE_TRANSALPHA)
		plyWeapon:SetColor(Color(255, 255, 255, wepAlpha))
	elseif cloakconfig.CloakType == "Material" and ply.CloakActive then
		plyWeapon:SetMaterial(cloakconfig.CloakMaterial, true)
	end
end)

hook.Add("EntityFireBullets", "ce_bc2_0_UncloakOnFire", function(ent, bullet)
	if IsValid(ent) and ent:IsPlayer() and ent.CloakActive then
		Uncloak(ent, true, "Fired")
	end
end)

hook.Add("EntityTakeDamage", "ce_bc2_0_UncloakOnDamage", function(ent, dmginfo)
	if IsValid(ent) and ent:IsPlayer() and ent.CloakActive then
		if cloakconfig.CloakDamageMode == 1 then
			Uncloak(ent, true, "Damage")
		elseif cloakconfig.CloakDamageMode == 2 then
			if cloakconfig.CloakMode == "Charge" then
				ent:SetNWFloat("CloakCharge", ent:GetNWFloat("CloakCharge") - cloakconfig.LoseChargeAmountHurt)
			elseif cloakconfig.CloakMode == "Timer" then
				print("Yeah you probably shouldn't set a charge option if you're using the timer mode.\nDefaulting to Option 1")
				GetConVar("bc2_CloakDamageMode"):SetInt(1)
				Uncloak(ent, true, "Damage2")
			end
		elseif cloakconfig.CloakDamageMode == 3 and ent:Alive() then
			Uncloak(ent, true, "Damage3", true)
			ent.AllowedToggle = false
			ent.CloakPause = true

			timer.Simple(cloakconfig.TempDisableTimeHurt, function()
				if IsValid(ent) and not ent.DidSomethingStupid then
					ent.CloakActive = true
				end

				ent.AllowedToggle = true
				ent.DidSomethingStupid = false
				ent.CloakPause = false
			end)
		end
	end
end)

cloakconfig.FootstepVolume = 0

--[[hook.Add("PlayerFootstep", "ce_bc2_0_SilentSteps", function(ply, pos, foot, sound, volume, rf)
    if ply.CloakActive then
    	//ply:EmitSound(sound, 20, nil, cloakconfig.FootstepVolume, 4)
   		return true
	else
    	return false
 	end
end) --]]
hook.Add("HUDDrawTargetID", "ce_bc2_0_HidePlayerID", function()
	if CLIENT then
		local gplytr = util.GetPlayerTrace(LocalPlayer())
		local ent = util.TraceLine(gplytr).Entity
		local col = 255

		if IsValid(ent) then
			col = ent:GetColor()
		end

		if ent:IsPlayer() and IsValid(ent) then
			if cloakconfig.CloakType == "Transparent" and ent.CloakActive and col.a < cloakconfig.MinimumIDVisibility then
				return false
			elseif cloakconfig.CloakType == "Material" and ent.CloakActive then
				return false
			else
				return
			end
		end
	end
end)

hook.Add("HUDPaint", "ce_bc2_1_DrawThings", function()
	local ply = LocalPlayer()

	if IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) then
		local activeweapon = ply:GetActiveWeapon():GetClass()

		if ply.CloakActive and cloakconfig.CloakOverlay ~= "" then
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(Material(cloakconfig.CloakOverlay))
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end

		if ply:HasWeapon("cloaking-0") and GetConVar("bc2_ShowCloakCharge"):GetBool() and (activeweapon == "cloaking-0" or ply:GetNWFloat("CloakCharge") ~= cloakconfig.MaxCharge0) and cloakconfig.MaxCharge0 ~= 0 then
			draw.SimpleText(ply:GetNWFloat("CloakCharge"), "DermaLarge", ScrW() / 2 - 25, 900, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end
	end
end)

hook.Add("HUDShouldDraw", "DarkRP_HideDarkPlayerID", function(hudName)
	if hudName ~= "DarkRP_EntityDisplay" then return end
	local playersToDraw = {}

	for _, ply in pairs(player.GetAll()) do
		if IsValid(ply) and not ply:GetNWBool("HideHUD") then
			table.insert(playersToDraw, ply)
		end
	end

	return true, playersToDraw
end)

hook.Add("PlayerEnteredVehicle", "ce_bc2_0_UncloakEnteringVehicle", function(ply, veh, seat)
	if ply.CloakActive and cloakconfig.UncloakInVehicle then
		Uncloak(ply, false, "Vehicle")
	end
end)

-- Accidents
local function onDemote(source, demoted, reason)
	if demoted.CloakActive then
		Uncloak(demoted, false, "Demoted")
		demoted.DidSomethingStupid = true
	end
end

local function UncloakOnAccident(ply)
	Uncloak(ply, false, "Accident")
	ply.DidSomethingStupid = true
end

hook.Add("PlayerDeath", "ce_bc2_0_Death", UncloakOnAccident)
hook.Add("playerAFKDemoted", "ce_bc2_0_AFK", UncloakOnAccident)
hook.Add("onPlayerDemoted", "ce_bc2_0_Demoted", onDemote)
hook.Add("playerArrested", "ce_bc2_0_Arrested", UncloakOnAccident)
hook.Add("playerStarved", "ce_bc2_0_Starved", UncloakOnAccident)
hook.Add("OnPlayerChangedTeam", "ce_bc2_0_ChangedTeam", UncloakOnAccident)