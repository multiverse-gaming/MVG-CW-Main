

AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )
AddCSLuaFile( "base/scifi_hooks.lua" )
include( "base/scifi_hooks.lua" )
AddCSLuaFile( "base/scifi_dropmagic.lua" )
include( "base/scifi_dropmagic.lua" )
AddCSLuaFile( "base/scifi_render.lua" )
include( "base/scifi_render.lua" )
AddCSLuaFile( "base/scifi_hud.lua" )
include( "base/scifi_hud.lua" )
AddCSLuaFile( "base/scifi_damage_swep.lua" )
include( "base/scifi_damage_swep.lua" )
AddCSLuaFile( "base/scifi_elementals.lua" )
include( "base/scifi_elementals.lua" )

--local amp = GetConVarNumber( "sfw_damageamp" )
--local pfx = GetConVarNumber( "sfw_fx_particles" )

SWEP.Base 					= "weapon_base"

SWEP.Author					= "Drugz"
SWEP.Category				= "Drugzs Electro Staffs"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AdminOnly				= false
SWEP.UseHands				= true

SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= false
SWEP.DrawAmmo				= true
SWEP.DrawWeaponInfoBox		= true

SWEP.PrintName 				= "Yet another sci-fi weapon"
SWEP.Purpose				= "[PLACEHOLDER]"
SWEP.Instructions			= "[PLACEHOLDER]"

SWEP.ViewModel				= "models/weapons/c_smg1.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.HoldType 				= "smg"
SWEP.HoldTypeNPC 			= "smg"
SWEP.DeploySpeed 			= 3
SWEP.UseSCK 				= true

SWEP.SciFiSkin				= ""
SWEP.SciFiSkin_1			= ""
SWEP.SciFiSkin_2			= ""
SWEP.SciFiSkin_3			= ""
SWEP.SciFiSkin_4			= ""
SWEP.SciFiWorld 			= ""

SWEP.DefaultSwayScale		= 2.0
SWEP.DefaultBobScale		= 2.0
SWEP.SprintSwayScale		= 1
SWEP.SprintBobScale			= 3
SWEP.ViewModelFOV			= 54
SWEP.Weight					= 5

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/icons/icon_custom.vmt" )
end

SWEP.Primary.ClipSize		= 40
SWEP.Primary.DefaultClip	= 40
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""

SWEP.VfxMuzzleAttachment 	= "muzzle"
SWEP.VfxMuzzleParticle 		= "ngen_muzzle"
SWEP.VfxHeatForce 			= false
SWEP.VfxHeatParticle 		= "gunsmoke"
SWEP.VfxHeatThreshold 		= 0.75
SWEP.VfxMuzzleProjexture 	= "effects/mf_light"

SWEP.SciFiFamily			= { "base" }
SWEP.SciFiWorldStats		= nil --{ ["1"] = { text = "A scifi weapon", color = Color( 180, 180, 180 ) } }

SWEP.SciFiACC				= 2
SWEP.SciFiACCRecoverRate	= 0.2

SWEP.Charge 				= 1
SWEP.ChargeMax				= 100
SWEP.ChargeAdd				= 1
SWEP.ChargeDrain			= 1

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeRecoverTime 	= 0.32
SWEP.SciFiMeleeASpeed		= 0.6
SWEP.SciFiMeleeRange		= 56
SWEP.SciFiMeleeDamage		= 7
SWEP.SciFiMeleeDamageType	= bit.bor( DMG_CLUB, DMG_NEVERGIB )
SWEP.SciFiMeleeSound		= "scifi.melee.swing.medium"
SWEP.SciFiMeleeChargeMax	= 100

SWEP.AdsPos 				= Vector( -2, 1, -1 )
SWEP.AdsAng 				= Vector( 0, 0, 0 )
SWEP.AdsFov					= 40
SWEP.AdsFovTransitionTime	= 0.16
SWEP.AdsFovCompensation 	= 0.2
SWEP.AdsRecoilMul			= 0.8
SWEP.AdsTransitionAnim		= true
SWEP.AdsTransitionSpeed		= 22
SWEP.AdsBlur 				= true
if ( CLIENT ) then
	SWEP.AdsBlurIntensity		= 6
	SWEP.AdsBlurSize			= ScrH() / 3
	SWEP.AdsMSpeedScale			= GetConVarNumber( "sfw_adsmspeedscale" )
end
SWEP.AdsSounds 				= false
SWEP.AdsSoundEnable 		= "scifi.ancient.sight.turnon"
SWEP.AdsSoundDisable		= "scifi.ancient.sight.turnoff"
SWEP.AdsRTScopeEnabled 		= false
SWEP.AdsRTScopeFlip 		= false
SWEP.AdsRTScopeSizeX 		= 512
SWEP.AdsRTScopeSizeY 		= 512
SWEP.AdsRTScopeScaling 		= false
SWEP.AdsRTScopeScaleX 		= 1
SWEP.AdsRTScopeScaleY 		= 1
SWEP.AdsRTScopeMaterial		= Material( "models/weapons/misc/rt_scope.vmt" )
SWEP.AdsRTScopeOffline		= "models/weapons/misc/rt_scope_offline_baset.vtf"

SWEP.ViewModelHomePos		= Vector( 0, 0, 0 )
SWEP.ViewModelHomeAng		= Angle( 0, 0, 0 )
SWEP.ViewModelSprintPos		= Vector( 3, 0.72, 0.8 )
SWEP.ViewModelSprintAng		= Angle( -10, 35, -5 )
SWEP.ViewModelDuckPos		= Vector( -1, 0, 1 )
SWEP.ViewModelDuckAng		= Angle( 0, 0, -5 )
SWEP.ViewModelMeleePos		= Vector( 16, 10, -6 )
SWEP.ViewModelMeleeAng		= Angle( -10, 95, -90 )
SWEP.ViewModelInspectable 	= true
SWEP.ViewModelMenuPos		= Vector( 12, 3.2, -6 )
SWEP.ViewModelMenuAng		= Angle( 20, 35, -10 )
SWEP.ViewModelReloadAnim 	= false
SWEP.ViewModelReloadPos		= Vector( -1, -1, 0 )
SWEP.ViewModelReloadAng		= Angle( -2, 2, 0 )

SWEP.SprintAnim				= true
SWEP.SprintAnimIdle			= true
SWEP.SprintAnimSpeed		= 8

SWEP.ReloadOnTrigger 		= true
SWEP.ReloadRealisticClips 	= false
SWEP.ReloadTime				= 2.2
SWEP.ReloadSND				= "Weapon_SMG1.Reload"
SWEP.ReloadACT				= ACT_VM_RELOAD
SWEP.ReloadAnimEndIdle 		= false
SWEP.ReloadModels 			= false
SWEP.ReloadGib 				= "models/dav0r/hoverball.mdl"
SWEP.ReloadGibMass 			= nil

SWEP.DepletedSND			= "Weapon_Pistol.Empty"

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

SWEP.VElements = {

}

SWEP.WElements = {

}

SWEP.mat_laser_line = Material( "effects/laser_line.vmt" )
SWEP.mat_laser_haze = Material( "effects/laser_haze.vmt" )
SWEP.mat_laser_glow = Material( "effects/blueflare1.vmt" )

local menu = 0
local sprint = 0
local crouch = 0
local melee = 0
local relanim = 0
local Mul = 0

if ( CLIENT ) then

	local function Circle( x, y, radius, seg )

		local cir = {}

		table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
		for i = 0, seg do
			local a = math.rad( ( i / seg ) * -360 )
			table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
		end

		local a = math.rad( 0 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

		surface.DrawPoly( cir )
		
	end

	local lensring = surface.GetTextureID("effects/sight_lens")
	local lenswarp = surface.GetTextureID("effects/sight_lens_refract") 
	local lensline = surface.GetTextureID("effects/laser_haze") 
	
	function SWEP.DrawScopeOverlay( ply, wep )
	
		local midx, midy = wep.AdsRTScopeSizeX / 2, wep.AdsRTScopeSizeY / 2
		local plyETrace = ply:GetEyeTrace()
		local clrWorld = render.GetLightColor( plyETrace.HitPos ) * 100
		local brtWorld = clrWorld.r + clrWorld.g + clrWorld.b
		local clrSight = Color( 200, 15, 10, 128 )
		local lines_start = Vector( midx, midy )
		
		cam.Start2D()
		
			draw.NoTexture()
			surface.SetDrawColor( 255, 10, 30, 255 )
			Circle( 256, 256, 2, 16 )
			surface.SetTexture( lensline )
			surface.SetDrawColor( 255, 10, 30, 32 )
			
			render.DrawLine( lines_start - Vector( 0, 16 ), lines_start - Vector( 0, 46 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 0, 16 ), lines_start + Vector( 0, 46 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, 0 ), lines_start - Vector( 128, 0 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 0 ), lines_start + Vector( 128, 0 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, -16 ), lines_start - Vector( 64, -16 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 16 ), lines_start + Vector( 64, 16 ), clrSight, false ) 
			render.DrawLine( lines_start - Vector( 16, -32 ), lines_start - Vector( 32, -32 ), clrSight, false ) 
			render.DrawLine( lines_start + Vector( 16, 32 ), lines_start + Vector( 32, 32 ), clrSight, false ) 
			
			surface.SetDrawColor( 1, 1, 1, 1 )
			surface.SetTexture( lenswarp )
			surface.DrawTexturedRect( 0, 0, wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY )
			surface.SetDrawColor( 1, 1, 1, 255 )
			surface.SetTexture( lensring )
			surface.SetDrawColor( 2 + brtWorld, 2 + brtWorld, 2 + brtWorld, 255 - brtWorld )
			surface.SetTexture( lensring )
			surface.DrawTexturedRect( 0, 0, wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY )
			
		cam.End2D()
	end

	local function DrawRTScope( VOrigin, VAngles, VFov )
		local ply = LocalPlayer()
		local wep = nil
		
		if ( IsValid( ply ) ) then
			wep = ply:GetActiveWeapon()
		end
	
		if ( !ply ) || ( ply && !ply:Alive() ) then return end
		if ( !IsValid( wep ) ) then return end
		if ( !wep.AdsRTScopeEnabled ) then return end
	
		local mat_scope = wep.AdsRTScopeMaterial
		local IsAds = wep:GetNWBool( "SciFiAds" )

		if ( IsAds ) then
			local newrt = {}
	
			local ScopeRT = GetRenderTarget( "_rt_Scope", wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY, true )
					
			local x, y = ScrW(), ScrH()
			local old = render.GetRenderTarget()
			
			local ang = ply:EyeAngles()
			ang:RotateAroundAxis(ang:Forward(), -1)
			
			newrt.angles = ang
			newrt.origin = ply:GetShootPos()
			newrt.x = 0
			newrt.y = 0
			newrt.w = x
			newrt.h = y
			newrt.fov = wep.AdsFov --2.5
			newrt.drawviewmodel = false
			newrt.drawhud = false

			render.SetRenderTarget( ScopeRT )
			render.SetViewPort(0, 0, wep.AdsRTScopeSizeX, wep.AdsRTScopeSizeY)
			
			if ( IsAds ) then 
				render.RenderView( newrt )
			end
			
			wep.DrawScopeOverlay( ply, wep )
			
			render.SetViewPort( 0, 0, x, y )
			render.SetRenderTarget( old )
			
			if ( mat_scope ) then
				mat_scope:SetTexture( "$basetexture", ScopeRT )
				
				if ( wep.AdsRTScopeScaling ) then
					local ScaleX, ScaleY = wep.AdsRTScopeScaleX, wep.AdsRTScopeScaleY
					local Rotate = wep.AdsRTScopeRotation
					local matrix = Matrix()
					
					matrix:Scale( Vector( ScaleX, ScaleY ) )
					
					mat_scope:SetMatrix( "$basetexturetransform", matrix )
				else
					mat_scope:SetUndefined( "$basetexturetransform" )
				end
			end
		else 
			if ( mat_scope ) then
				mat_scope:SetTexture( "$basetexture", wep.AdsRTScopeOffline )
			end
		end	
	end

	hook.Add( "RenderScene", "SciFiBaseDrawRTScope", DrawRTScope )

	function SWEP:CustomAmmoDisplay()

		self.AmmoDisplay = self.AmmoDisplay or {}
		self.AmmoDisplay.Draw = true
		
		if ( self.Primary.ClipSize > -1 ) then
			self.AmmoDisplay.PrimaryClip = self:Clip1()
			self.AmmoDisplay.PrimaryAmmo = self:Ammo1()
		end
		
		if self.Secondary.ClipSize > 0 then
			self.AmmoDisplay.SecondaryClip = self:Clip2()
			self.AmmoDisplay.SecondaryAmmo = self:Ammo2()
		end
		
		return self.AmmoDisplay
		
	end

end

if ( SERVER ) then

	function SWEP:GetCapabilities()
		return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK2, CAP_WEAPON_RANGE_ATTACK1, CAP_WEAPON_RANGE_ATTACK2, CAP_MOVE_GROUND, CAP_MOVE_JUMP )
	end
	
	AccessorFunc( SWEP, "fNPCMinBurst", "NPCMinBurst" )
	AccessorFunc( SWEP, "fNPCMaxBurst", "NPCMaxBurst" )
	AccessorFunc( SWEP, "fNPCFireRate", "NPCFireRate" )
	AccessorFunc( SWEP, "fNPCMinRestTime", "NPCMinRest" )
	AccessorFunc( SWEP, "fNPCMaxRestTime", "NPCMaxRest" )

end

function SWEP:SetupDataTables()

	self:NetworkVar( "Int", 0, "SciFiMelee" )

end

function SWEP:Initialize()

	self:SetWeaponHoldType( self.HoldType )
	self:SetDeploySpeed( self.DeploySpeed )
	
	if( self.UseSCK ) then
		self:sckInit()
	end
	
	if ( self.Owner:IsNPC() && SERVER ) then
	
		self:SetNPCFireRate( 0.01 )
		self:SetNPCMinBurst( 4 )
		self:SetNPCMaxBurst( 4 )
		self:SetNPCMinRest( 0 )
		self:SetNPCMaxRest( 1 )
		
		if ( self.HoldTypeNPC ) then
			self:SetupWeaponHoldTypeForAI( self.HoldTypeNPC )
		else
			self:SetupWeaponHoldTypeForAI( "ar2" )
		end
			
		self.Owner:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
		self.Owner:SetKeyValue("FireRate","0.01")
		self.Owner:SetKeyValue("spawnflags","16")
	--	self.Owner:SetKeyValue("spawnflags","256")
		self.Owner:SetKeyValue("spawnflags","1024")
		self.Owner:SetKeyValue("spawnflags","16384")
	end
	
	self:SubInit()
	
end

function SWEP:SubInit()

end

function SWEP:AddAcc()

end

function SWEP:AddWAcc()

end

function SWEP:Think()
	
	self:Anims()
	self:Ads()
	self:SciFiMath()
	self:SciFiMelee()
	
end

function SWEP:SciFiMath()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) end
	if ( self.Owner:IsNPC() ) then return end

	if ( self.SciFiACC >= 0 ) then
		self.SciFiACC = math.Clamp( self.SciFiACC - self.SciFiACCRecoverRate, 0, ( GetConVarNumber( "sfw_sk_maxacc" ) ) )
	end
	
	if ( self.SciFiACC <= 0 ) then
		self.SciFiACC = 0 
	end

end

function SWEP:GetSciFiACC()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) end
	local value = 0

	if ( SERVER && game.SinglePlayer() ) || ( CLIENT ) then
		value = self.SciFiACC
	end
	
	return value

end

function SWEP:SetSciFiACC( value )

	local cmdAccMax = GetConVarNumber( "sfw_sk_maxacc" )
	local cmdDevmode = GetConVarNumber( "developer" )
	
	if ( SERVER && game.SinglePlayer() ) || ( CLIENT ) then
		if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end
		
		if ( value > ( cmdAccMax * 1.3 ) ) || ( value < 0 ) then
			if ( cmdDevmode ) then
				DevMsg( "@"..self:GetClass().." : !Error; Tried to set an incorrect SciFiACC value ("..value..")! Maximum value is "..GetConVarNumber( "sfw_sk_maxacc" ).."!" )
			end
		else
			math.Clamp( value, 0, cmdAccMax )
		end
	end

end

function SWEP:AddSciFiACC( value, ignoreads )
	
	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) end

	local cmdAccMax = GetConVarNumber( "sfw_sk_maxacc" )
	local cmdDevmode = GetConVarNumber( "developer" )
	
	local IsAds = self:GetNWBool( "SciFiAds" )

	if ( self.Owner:IsNPC() ) then self.SciFiACC = 0 return end
	
	if ( value > ( cmdAccMax * 1.4 ) ) || ( value < 0 ) then
		if ( cmdDevmode ) then
			DevMsg( "@"..self:GetClass().." : !Error; Potential SciFiACC overflow ("..self.SciFiACC + value..")! Maximum value is "..GetConVarNumber( "sfw_sk_maxacc" ).."!" )
		end
	else
		if ( IsAds && !ignoreads ) then
			self.SciFiACC = math.Clamp( self.SciFiACC + ( value * self.AdsRecoilMul ), 0, cmdAccMax )
		else
			self.SciFiACC = math.Clamp( self.SciFiACC + value, 0, cmdAccMax )
		end
	end

end

function SWEP:IsFamily( tag )

	if ( table.HasValue( self.SciFiFamily, tag ) && self.SciFiFamily ~= nil ) then
		return true
	else
		return false
	end

end

function SWEP:IsSprinting()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) end
	
	if ( !self.Owner:IsPlayer() ) then 
		return false
	end
	
	local cmd_advanims = GetConVarNumber( "sfw_allow_advanims" )
	local key_sprint = self.Owner:KeyDown( IN_SPEED )
	local key_crouch = self.Owner:KeyDown( IN_DUCK )
	local key_fw = self.Owner:KeyDown( IN_FORWARD )
	local key_rt = self.Owner:KeyDown( IN_RIGHT )
	local key_lt = self.Owner:KeyDown( IN_LEFT )
	
	if ( cmd_advanims < 1 ) then return false end
	
	if ( key_sprint ) && ( !key_crouch ) && ( key_fw || key_rt || key_lt ) then
		self:SetAds( false )
		return true
	else
		return false
	end

end

function SWEP:GetViewModelEnt()

	local viewmodel

	if ( !IsValid( self.Owner ) ) then
		viewmodel = self
	end
	
	if ( self.Owner:IsPlayer() ) then
		viewmodel = self.Owner:GetViewModel()
	end
	
	if ( self.Owner:IsNPC() ) || ( !game.SinglePlayer() && !self.Owner ) then
		viewmodel = self.Owner:GetActiveWeapon()
	end
	
	if ( !IsValid( viewmodel ) ) then return end
	return viewmodel

end

function SWEP:GetProjectileSpawnPos( static )

	local cmdOffset 	= GetConVarNumber( "sfw_allow_actualspawnoffset" )
	
	if ( !isnumber( cmdOffset ) ) then
		cmdOffset = 1
	end
	
	local pOwnerAV		= self.Owner:GetAimVector()
	local pOwnerSP 		= self.Owner:GetShootPos()
	local pOwnerEyes	= self.Owner:EyePos()

	if ( cmdOffset == 1 ) then
		local rt = self.Owner:GetRight()
		local up = self.Owner:GetUp()
		
		local vmEntity 		= self:GetViewModelEnt()
		local vmAttach 		= vmEntity:LookupAttachment( "Muzzle" )

		if ( !vmAttach ) then
			vmAttach = vmEntity:LookupAttachment( "1" )
		end
		
		if ( !vmAttach ) then
			static = true
		end
		
		if ( static ) && ( self.Owner:IsPlayer() ) then
			local pos = pOwnerSP + ( rt * 10 + up * -10 )
			return pos
		else
			local pos = self.Owner:GetAttachment( vmAttach ).Pos
			return pos
		end		
	else
		local pos = pOwnerEyes + ( pOwnerAV * 20 )
		return pos
	end

end

function SWEP:Equip( NewOwner )

	if ( self.Owner:IsPlayer() && GetConVarNumber( "cl_showhints" ) == 1 ) then
		if ( !table.HasValue( self.Owner:GetWeapons(), "sfw_" ) ) then
			self.Owner:SendHint( "sfw_remi_dmgamp", 0.05 )
		end
		
		if ( !table.HasValue( self.Owner:GetWeapons(), "sfw_" ) ) then
			self.Owner:SendHint( "sfw_remi_melee", 0.45 )
		end
		
		if ( self:IsFamily( "modes_bfire" ) ) then
			self.Owner:SendHint( "sfw_bfire_equip_1", 0.05 )
		end
		
		if ( self:IsFamily( "modes_grenade" ) ) then
			self.Owner:SendHint( "sfw_bnade_equip_1", 0.05 )
		end
		
		if ( self:IsFamily( "enerbow" ) ) then
			self.Owner:SendHint( "sfw_charge_equip_1", 0.05 )
		end
		
		if ( self:IsFamily( "infammo" ) && self:IsFamily( "autoregen" ) ) then
			self.Owner:SendHint( "sfw_autoregen_equip_1", 0.05 )
		end
		
		if ( !self:IsFamily( "nomelee" ) ) then
			self.Owner:SendHint( "sfw_passivemelee", 0.05 )
		end
	end
	
	if ( NewOwner:IsNPC() ) then
		self:SetNWBool( "MobDrop", true )
		if ( self.SciFiWorld ~= nil && self.SciFiWorld ~= "" ) then
			self:SetMaterial( self.SciFiWorld )
		end
	end

	if ( self.Owner:IsPlayer() ) && ( self.Primary.Ammo ~= "SciFiAmmo" || self.Primary.Ammo ~= "none" ) && ( GetConVarNumber( "vh_campaign" ) == 0 ) then
		self.Owner:GiveAmmo( self.Primary.ClipSize * 8, self.Primary.Ammo )
	end
	
	if ( self.Owner:IsPlayer() ) && ( self:IsFamily( "custom" ) && self:IsFamily( "infammo" ) ) then
		if ( self.Owner:Armor() <= 100 ) then
			self.Owner:SetArmor( math.Clamp( self.Owner:Armor() + 20, 0, 100 ) )
		else
			self.Owner:SetArmor( self.Owner:Armor() + 10 )
		end
	end

end

function SWEP:Deploy() 

	self:SetAds( false )	

	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetSciFiMelee( 0 )
		self.SciFiMeleeCharge = 0
		self.SciFiACC = 2.5
	end
	
	if ( CLIENT ) then
		self:SetSciFiMelee( 0 ) -- doubled as a hotfix for level transitions.
	end
	
	menu = 0
	sprint = 0
	rouch = 0
	melee = 0
	Mul = 0

	return true
	
end

function SWEP:Holster( wep )

	if ( CLIENT ) && ( IsValid(self.Owner) ) && ( self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	self:SetAds( false )
	
	self:OnRemove()
	return true

end

function SWEP:ShouldDropOnDie()

	return true
	
end

function SWEP:OwnerChange()

end

function SWEP:CanPrimaryAttack( cap, canunderwater )

	--if ( CLIENT ) then return end
	
	if ( !cap ) then
		cap = 0
	end
	
	local cmd_advanims = GetConVarNumber( "sfw_allow_advanims" )
	local IsReloading = self:GetNWBool( "IsReloading" )
	local IsSprinting = self:IsSprinting()

	if ( self.Weapon:Clip1() <= cap ) then
		if ( self.DepletedSND ) then
			self:EmitSound( self.DepletedSND )
--			self:SendWeaponAnim( ACT_VM_DRYFIRE )
		end
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		
		if ( self.ReloadOnTrigger ) then
			self:Reload()
		end
		return false
	end
	
	if ( IsReloading ) then
		return false
	end
	
	if ( IsSprinting ) && ( cmd_advanims >= 1 ) then
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		if ( canunderwater == true ) then
			return true
		end
		
		self:EmitSound( self.DepletedSND )
--		self:SendWeaponAnim( ACT_VM_DRYFIRE )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		return false
	end

	return true
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	if( event == 21 or event == 22 ) then
		return true
	end

end

function SWEP:DoMuzzleEffect()

	local cmd_fx_particles = GetConVarNumber( "sfw_fx_particles" )
	local cmd_fx_heat = GetConVarNumber( "sfw_fx_heat" )
	
	if ( cmd_fx_particles == -1 ) then return end

	local pOwnerSP = self.Owner:GetShootPos()

	local vmEntity = self:GetViewModelEnt()
	
	if ( !game.SinglePlayer && self.Owner:ShouldDrawLocalPlayer() ) then 
		vmEntity = self.Owner:GetActiveWeapon()
	end
	
	local vmAttach

	if ( self.VfxMuzzleAttachment ) then
		vmAttach = vmEntity:LookupAttachment( self.VfxMuzzleAttachment )
	else
		vmAttach = vmEntity:LookupAttachment( "muzzle" )
		
		if ( vmAttach == 0 ) then
			vmAttach = vmEntity:LookupAttachment( "1" )
		end
	end
	
	if ( vmAttach == 0 ) then DevMsg( "@"..self:GetClass().." : !Error; Invalid muzzle attachment ID." ) return end
	
	local vmOrigin = self.Owner:GetAttachment( vmAttach ).Pos
	
	if ( !isvector( vmOrigin ) ) then DevMsg( "@"..self:GetClass().." : !Error; Invalid muzzle attachment position." ) return end
	
	
	local ed = EffectData()
	ed:SetOrigin( vmOrigin )
	ed:SetEntity( self )
	ed:SetAttachment( vmAttach )
	util.Effect( "sfw_muzzle_generic", ed )

	if ( game.SinglePlayer && SERVER || !game.SinglePlayer ) then
		local maxacc = GetConVarNumber( "sfw_sk_maxacc" ) * self.VfxHeatThreshold
		
		if ( ( self.VfxHeatForce ) || ( cmd_fx_heat >= 1 ) ) && ( self.SciFiACC >= maxacc ) then
			ParticleEffectAttach( self.VfxHeatParticle, PATTACH_POINT_FOLLOW, vmEntity, vmAttach )
		end
	end
	
end

function SWEP:PrimaryAttack()

	if (  !self:CanPrimaryAttack( 0 ) ) then return end
	
	self:SetNextPrimaryFire( CurTime() + 0.08 )

	local viewmodel = self:GetViewModelEnt()
	local amp = GetConVarNumber( "sfw_damageamp" )
	
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( .0021, .0021 ) * self.SciFiACC
	bullet.Tracer = 1
	bullet.TracerName = "ca3_tracer" 
	bullet.Force = 4
	bullet.HullSize = 1
	bullet.Damage = 8 * amp
	bullet.Callback = function( attacker, tr, dmginfo )
	
		ParticleEffect( "ngen_hit", tr.HitPos, Angle( 0, 0, 0 ), fx )
		sound.Play( "scifi.ca3.hit", tr.HitPos, SOUNDLVL_NORM, math.random( 95, 102 ), 1.0 )
	
		if ( GetRelChance( 8 ) ) then 
			ParticleEffect( "hornet_blast", tr.HitPos, Angle( 0, 0, 0 ), fx )
			DoElementalEffect( { Element = EML_SHOCK, Target = tr.Entity, Attacker = self.Owner, Damage = 30 } )
			self:DealAoeDamage( bit.bor( DMG_SHOCK, DMG_RADIATION ), 12 * amp, tr.HitPos, 40 )
		end
	end
	
	self.Owner:FireBullets( bullet, false )
	
	self:DoMuzzleEffect()
	self:DrawMuzzleLight( "120 110 255 120" , 155, 500, 0.07 )
	
	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( math.random( -0.6, -1 ), math.random( -0.1, -0.5 ), math.random( -0.1, -0.3 ) ) * ( self.SciFiACC * 0.1 ) )
	end
	
	self:AddSciFiACC( 3.4 )
	
	self:EmitSound( "cat.vk21.pfire" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:TakePrimaryAmmo( 1 )
	
end

function SWEP:CanSecondaryAttack()

	if ( self.Weapon:Clip1() < 30 ) then
		self:EmitSound( "Weapon_ar2.Empty" )
		self:Reload()
		return false
	end
	
	if ( self.Owner:WaterLevel() == 3 ) then
		self:EmitSound( self.DepletedSND )
		self:SetNextSecondaryFire( CurTime() + 0.2 )
		return false
	end
	
	if ( self:IsSprinting() ) and ( GetConVarNumber( "sfw_allow_advanims" ) >= 1 ) then
		return false
	end

	return true

end

function SWEP:SecondaryAttack()

end

function SWEP:CreateReloadModels()

	if ( !self.ReloadModels ) then return end
	if ( GetConVarNumber( "sfw_allow_propcreation" ) == 0 ) then return end

	if ( SERVER ) then
		local pOwnerPos = self.Owner:GetPos()
		local pOwnerSP = self.Owner:GetShootPos()
		local pOwnerEA = self.Owner:EyeAngles()
		local fw = pOwnerEA:Forward()
		
		local ent = ents.Create( "prop_physics" )
		if (  !IsValid( ent ) ) then return end
		ent:SetModel( self.ReloadGib )
		ent:SetPos( Vector( pOwnerPos.x, pOwnerPos.y, pOwnerSP.z - 24 ) )
		ent:SetAngles( pOwnerEA + AngleRand() )
		ent:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR ) --COLLISION_GROUP_DEBRIS )
		ent:Spawn()
			
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		if ( self.ReloadGibMass ) then
			phys:SetMass( self.ReloadGibMass )
		end
		phys:SetMaterial( "weapon" )
		phys:ApplyForceCenter( fw * 64 )
		
		SafeRemoveEntityDelayed( ent, 10 )
	end

end

function SWEP:CanReload()

	if ( self.Weapon:Clip1() >= self.Primary.ClipSize ) then
		return false
	end
	
	if ( self.Owner:IsPlayer() ) then
		if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) < 1 ) then
			return false
		end

		if ( self:GetNWBool( "IsReloading" ) == true ) then
			return false
		end
		
		if ( ( self:IsSprinting() ) and ( GetConVarNumber( "sfw_allow_advanims" ) >= 1 ) ) then
			return false
		end
	end	
	
	return true
	
end

function SWEP:OnReload()

end

function SWEP:OnReloadFinish()

end

function SWEP:Reload()
	
	if ( !self:CanReload() ) then return end
	
	self:OnReload()
	self:CreateReloadModels()
	
	if ( self.Owner:IsPlayer() ) then
		self:SetNWBool( "IsReloading", true )
		self:SetAds( false )
		
		if ( self.ReloadRealisticClips ) then
			if ( self:Clip1() > 0 ) then
				self:SetClip1( 1 )
				self.Primary.ClipSize = self.Primary.ClipSize + 1
			else
				self:SetClip1( 0 )
			end
		end
		
		timer.Simple( self.ReloadTime, function()
			if ( IsValid( self ) ) then
				if ( self.ReloadRealisticClips ) then
					self.Primary.ClipSize = self.Primary.DefaultClip
				end
				
				if ( self.ReloadAnimEndIdle ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end
			
				self:SetNWBool( "IsReloading", false )
				self:OnReloadFinish()
			end
		end )
	end
	
	if ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() ) then
		self:SetNextPrimaryFire( CurTime() + self.ReloadTime )
		self:SetNextSecondaryFire( CurTime() + self.ReloadTime )
		self:EmitSound( self.ReloadSND )

		self:SetNWInt( "BurstCount", 5 )

		if ( self.Owner:IsPlayer() ) then
			self:DefaultReload( self.ReloadACT )
			self.Owner:DoReloadEvent()
		else
			self:SetClip1( self.Primary.ClipSize )
		end
	end
	
end

function SWEP:DrawMuzzleLight( color, fov, range, lifetime )

	if ( GetConVarNumber( "sfw_allow_muzzlelights" ) ~= 1 ) then return end
	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
	local ang = self.Owner:EyeAngles()
	local wep = self:GetViewModelEnt()
	local pnt = wep:LookupAttachment( "Muzzle" )

	if ( !pnt || pnt == 0 ) then
		pnt = wep:LookupAttachment( "1" )
	end
	
	if ( !pnt || pnt == 0 ) then return end
	
	local att = self.Owner:GetAttachment( pnt )
	local pos = att.Pos + ang:Forward() * 16 + ( VectorRand() * ( self.SciFiACC / 10 ) )
	
--[[
	if ( isstring( color ) ) then
		color = string.ToColor( color )
	end
	
	if ( CLIENT ) then
		local realtime = ProjectedTexture()
		if ( !realtime:IsValid() ) then return end
		realtime:SetEnableShadows( true )
		realtime:SetColor( color )
		realtime:SetFOV( fov )
		realtime:SetNearZ( 16 )
		realtime:SetFarZ( range )
		realtime:SetTexture( self.MuzzleLightTexture )
		realtime:SetPos( pos )
		realtime:SetAngles( ang )
		realtime:Update()
	end
]]--	

	if ( SERVER ) then
		local realtime = ents.Create( "env_projectedtexture" )
		if ( !IsValid( realtime ) ) then return end
		realtime:SetKeyValue( "targetname", "realtimelight" )
		realtime:SetPos( pos )
		realtime:SetAngles( ang )		
		realtime:SetKeyValue( "lightfov", fov * math.random( 0.98, 1.02 ) )
		realtime:SetKeyValue( "lightworld", 1 )	
		realtime:SetKeyValue( "lightcolor", color )
		realtime:SetKeyValue( "enableshadows", 1 )
		realtime:SetKeyValue( "farz", range )
		realtime:SetKeyValue( "nearz", 16 )
		realtime:Fire( "SpotlightTexture", self.VfxMuzzleProjexture, 0 )
		--ParticleEffectAttach( "flare_halo_0", 1, realtime, -1 )
		realtime:Fire( "kill", "", lifetime )
	end
	
end

function SWEP:SciFiMelee()

	if ( GetConVarNumber( "sfw_allow_melee" ) < 1 ) then return end
	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) end
	if ( !self.Owner:IsPlayer() ) then return end
	if ( self.Owner:InVehicle() ) then return end
	if ( self.Owner:KeyDown( IN_ATTACK ) || self.Owner:KeyDown( IN_ATTACK2 ) ) then return end
	if ( self:IsSprinting() ) then return end
	if ( self:GetNWBool( "SciFiAds" ) ) then return end
	if ( self:GetNWBool( "IsReloading" ) ) then return end
	if ( !self.SciFiMeleeCharge ) then self.SciFiMeleeCharge = 0 end

	if ( self.Owner:KeyDown( IN_GRENADE2 ) && !self.Owner:KeyPressed( IN_ATTACK ) ) then
		self.SciFiMeleeCharge = math.Clamp( self.SciFiMeleeCharge + 1, 0, self.SciFiMeleeChargeMax )
	else
		self.SciFiMeleeCharge = math.Clamp( self.SciFiMeleeCharge - 0.5, 0, self.SciFiMeleeChargeMax )
	end
		
	-- ToDo: Add a cvar related key binding?
	if ( self.Owner:KeyReleased( IN_GRENADE2 ) ) then

		if ( self.SciFiMeleeTime <= CurTime() ) && ( self:GetNextPrimaryFire() < CurTime() ) then

			self:SetSciFiMelee( 1 )
			
			self:EmitSound( self.SciFiMeleeSound )
			self.Owner:ViewPunch( Angle( math.random( 1, 2 ), math.random( 1, 5 ), math.random( 0, 0.1 ) ) * ( 1 + self.SciFiACC * 0.5 + self.SciFiMeleeCharge / 10 ) )
			
			timer.Simple( self.SciFiMeleeRecoverTime, function()
				if ( IsValid( self ) && IsValid( self.Owner ) && self.Owner:Alive() ) then
					self:SetSciFiMelee( 0 )
				end
			end )
			
			local amp = GetConVarNumber( "sfw_damageamp" )
			local playervelo = self.Owner:GetVelocity()
			local velo = math.Clamp( ( math.Round( ( math.abs( playervelo.y ) + math.abs( playervelo.x ) + math.abs( playervelo.z ) ) ) / 64 ), 1, 10 )

			self.Owner:LagCompensation( true )
			
			local tr = util.TraceLine( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
				filter = self.Owner,
				mask = MASK_SHOT_HULL
			} )

			if ( !IsValid( tr.Entity ) ) then 
				tr = util.TraceHull( {
					start = self.Owner:GetShootPos(),
					endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * ( self.SciFiMeleeRange + self.SciFiMeleeCharge / 8 ) ,
					filter = self.Owner,
					mins = Vector( -10, -4, -2 ),
					maxs = Vector( 10, 4, 2 ),
					mask = MASK_SHOT_HULL
				} )
			end

			local hit = false
			
			if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:GetOwner() ~= self.Owner ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 || tr.Entity:GetClass() == "prop_ragdoll" || tr.Entity:GetClass() == "prop_physics" ) ) then
				
				local dmginfo = DamageInfo()
			
				local attacker = self.Owner
				if ( !IsValid( attacker ) ) then attacker = self end
				dmginfo:SetAttacker( attacker )
				dmginfo:SetInflictor( attacker )
				dmginfo:SetDamage( self.SciFiMeleeDamage * amp + velo + self.SciFiMeleeCharge / 10 )
				dmginfo:SetDamageForce( self.Owner:GetRight() * 512 + self.Owner:GetForward() * 4096 + playervelo * 16 )
				dmginfo:SetDamageType( self.SciFiMeleeDamageType )
				
				if ( tr.Entity:GetClass() == "item_item_crate" ) then
					dmginfo:SetDamage( self.SciFiMeleeDamage * 3 * amp + velo )
				end
				
				if ( util.GetSurfacePropName( tr.SurfaceProps ) == "glass" && tr.Entity:GetClass() == "func_breakable" ) then
					dmginfo:SetDamage( self.SciFiMeleeDamage * 4 * amp + velo )
				end
				
				if ( self.Owner:WaterLevel() == 3 ) then
					dmginfo:SetDamage( dmginfo:GetDamage() / 2 )
				end
				
				local phys = tr.Entity:GetPhysicsObject()
				
				if ( IsValid( phys ) ) then
					phys:ApplyForceCenter( self.Owner:GetRight() * 512 + self.Owner:GetForward() * 4096 + playervelo * 16 )
				end
				
				if ( tr.Entity:IsNPC() ) then
					local target = tr.Entity	
					if ( !target:IsCurrentSchedule( SCHED_BACK_AWAY_FROM_ENEMY ) && target:GetMaxHealth() <= 150 && !target:GetNWBool( "bliz_frozen" ) == true ) then
						target:SetSchedule( SCHED_FEAR_FACE ) -- step aside, peasants!
						target:SetSchedule( SCHED_MOVE_AWAY )
						target:SetSchedule( SCHED_BACK_AWAY_FROM_ENEMY )
						target:SetSchedule( SCHED_RUN_FROM_ENEMY )
						timer.Simple( 50 / target:Health(), function()
							if ( IsValid( target ) ) and ( SERVER ) then
								target:SetSchedule( SCHED_WAKE_ANGRY )
							end
						end )
					end
				end

				tr.Entity:TakeDamageInfo( dmginfo )
				
				hit = true
				
			end

			if ( !( game.SinglePlayer() && CLIENT ) ) then
				if ( tr.Hit && !tr.HitWorld ) then
					self:EmitSound( "scifi.melee.hit.body" )
				elseif( tr.HitWorld ) then
					self:EmitSound( "scifi.melee.hit.world" )
				end
			end

			if ( SERVER && IsValid( tr.Entity ) ) then
				local phys = tr.Entity:GetPhysicsObject()
				if ( IsValid( phys ) ) then
					phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
				end
			end

			self.Owner:LagCompensation( false )
			
			delay = CurTime() + self.SciFiMeleeASpeed + ( self.SciFiACC / 30 )

			self:SetNextPrimaryFire( delay + 0.1 )
			self.SciFiMeleeTime = delay
			self:AddSciFiACC( 12 )
			
			self.SciFiMeleeCharge = 0
	
		end
	end

end

function SWEP:AdjustMouseSensitivity()
	
	if ( CLIENT ) then
		local IsAds = self:GetNWBool( "SciFiAds" )
	
		if ( IsAds ) then
			return self.AdsMSpeedScale
		else
			return 1
		end
	end

end

function SWEP:CanAds()

	if ( !IsValid( self.Owner ) ) then 
		return false
	end
	if ( self.Owner:IsNPC() ) then 
		return false
	end

	local key_use = self.Owner:KeyDown( IN_USE ) 
	local keyp_sprint = self.Owner:KeyPressed( IN_SPEED )
	local keyd_sprint = self.Owner:KeyDown( IN_SPEED )
	local IsReloading = self:GetNWBool( "IsReloading" )
	local cmd_advanims = GetConVarNumber( "sfw_allow_advanims" )
	
	if ( key_use ) then
		return false
	end
	
	if ( IsReloading ) then
		return false
	end
	
	if ( self.Owner:InVehicle() ) then
		return false
	end
	
	return true

end

function SWEP:Ads()

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end

	if ( self.Owner:KeyPressed( IN_ATTACK2 ) ) then
		self:SetAds( true, true )
	end

	if ( self.Owner:KeyReleased( IN_ATTACK2 ) || self:GetNWBool( "IsReloading" ) == true ) then
		self:SetAds( false, true )
	end

end
--[[
if ( SERVER ) then
	util.AddNetworkString( "SciFiADS" )
end]
]
--[[
net.Receive( "SciFiADS", function( len, ply )

	local bool = net.ReadBool()
	local wep = ply:GetActiveWeapon()
	
	if ( IsValid( wep ) ) then
		wep:SetNWBool( "SciFiAds", bool )
	end
	
end )
]]

function SWEP:SetAds( b, playsounds )

	if ( !IsValid( self.Owner ) ) then return end
	if ( self.Owner:IsNPC() ) then return end
	if SERVER then
		local wep = self.Owner:GetActiveWeapon()
		if ( self:CanAds() && b ) then
			wep:SetNWBool("SciFiAds", true)
		else
			wep:SetNWBool("SciFiAds", false)
		end
	end
	
	if ( CLIENT ) then
		--[[
		net.Start( "SciFiADS" )
		
		if ( self:CanAds() && b ) then
			net.WriteBool( true )
		else
			net.WriteBool( false )
		end
		
		net.SendToServer()
		]]
		
		if ( self.AdsSounds ) && ( playsounds ) && ( self:CanAds() ) then
			if ( b ) then
				self:EmitSound( self.AdsSoundEnable )
			else
				self:EmitSound( self.AdsSoundDisable )
			end
		end
	end

	if ( SERVER ) then
		if ( !b ) then
			local key_sprint = self.Owner:KeyDown( IN_SPEED )
		
			if ( key_sprint ) then
				self.Owner:SetFOV( 0, 0 )
			else
				self.Owner:SetFOV( 0, self.AdsFovTransitionTime )
			end
			
		end
		
		if ( b ) && ( self:CanAds() ) && ( !self.AdsRTScopeEnabled ) then
		local cmd_enginefov = GetConVarNumber( "fov_desired" )
		local fovcompensation = cmd_enginefov / 56 + ( cmd_enginefov - 90 )
		local fov = self.AdsFov
		fov = math.Round( self.AdsFov * fovcompensation, 2 )
	
		self.Owner:SetFOV( math.Clamp( fov, self.AdsFov, cmd_enginefov ), self.AdsFovTransitionTime )
		end
	end
	
	self:OnAds( b )

end

function SWEP:TranslateFOV( pFov )

	return pFov 
	
end

function SWEP:OnAds( adsBool )

end

function SWEP:Anims()

	if ( !self.Owner:IsPlayer() ) then return end
	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) end

	if ( GetConVarNumber( "sfw_allow_advanims" ) < 1 ) then return end
	
	if ( !self.SprintAnim ) then return end
	
	local IsReloading = self:GetNWBool( "IsReloading" )
	local IsAds = self:GetNWBool( "SciFiAds" )

	if ( self:IsSprinting() ) then
		if ( self.SprintAnimIdle && !IsReloading ) then
			self:SendWeaponAnim( ACT_VM_IDLE_LOWERED )			
		end

		self.SwayScale = self.SprintSwayScale
		self.BobScale = self.SprintBobScale
	else
		if ( IsAds ) then
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else
			self.SwayScale 	= self.DefaultSwayScale
			self.BobScale 	= self.DefaultBobScale
		end
	end

	if ( self.SprintAnimIdle ) then
	
		local key_speed_pressed = self.Owner:KeyPressed( IN_SPEED )
		local key_speed_released = self.Owner:KeyReleased( IN_SPEED )

		if ( key_speed_pressed ) && ( self:IsSprinting() && !IsReloading ) then
			self:SendWeaponAnim( ACT_VM_LOWERED_TO_IDLE )
		end
		
		if ( key_speed_released ) && ( !IsReloading ) then
			self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )

			timer.Simple( 0.05, function() 
				if ( IsValid( self ) ) && ( IsValid( self:GetViewModelEnt() ) ) then
					self:SendWeaponAnim( ACT_VM_IDLE )
				end
			end )
		end
	end

end

function SWEP:ModulateViewModelPosition( pos, ang, newpos, newang, factor )

	local rt = ang:Right()
	local up = ang:Up()
	local fw = ang:Forward()
	
	if ( !game.SinglePlayer() ) then
		factor = factor * 0.8
	end
	
	pos = pos + newpos.x * rt * factor
	pos = pos + newpos.y * fw * factor
	pos = pos + newpos.z * up * factor
	
	ang:RotateAroundAxis( rt, self.ViewModelHomeAng.x + ( newang.x * factor ) )
	ang:RotateAroundAxis( up, self.ViewModelHomeAng.y + ( newang.y * factor ) )
	ang:RotateAroundAxis( fw, self.ViewModelHomeAng.z + ( newang.z * factor ) )
	
	return pos, ang
	
end

local vecSprint = Vector( 0, 0, 0 )
local angSprint = Angle( 0, 0, 0 )
--[[
local CUserCmd 

hook.Add( "CreateMove", "DeliverCMoveDataToMyFrontDoor", function( pInput ) 
	if ( CLIENT ) then 
		CUserCmd = pInput 
	end 
end )
]]--
	
function SWEP:GetViewModelPosition( pos, ang )

	if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiWeapons : !Error; Failed to verify owner or weapon." ) return end

	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	local IsAds = self:GetNWBool( "SciFiAds" )
	local IsReloading = self:GetNWBool( "IsReloading" )
	local cmd_anims = GetConVarNumber( "sfw_allow_advanims" )
	local cmd_kb_inspect = GetConVarNumber( "sfw_kb_inspect" )
	local WaterLevel = self.Owner:WaterLevel()
	local TimeStep = FrameTime()
	
	if ( !IsValid( self ) || !IsValid( self.Owner ) ) then return end
	
		local vang = self.Owner:EyeAngles()
		
		if ( !IsAds ) && ( cmd_anims >= 1 ) then
	
		-- x, z, y / x, y, z on z-top --

	--	local moveX, moveY = CUserCmd:GetUpMove(), CUserCmd:GetSideMove()
		local vmod_pos = Vector( vang.pitch * -0.014, math.abs( vang.pitch * 0.01 ), math.abs( vang.pitch * 0.018 ) ) --Vector( vang.pitch * -0.02, math.abs( vang.pitch * 0.075 ), vang.pitch * -0.02 )
		local vmod_ang = Angle( 0, 0, 0 ) --Angle( moveY, moveX, 0 )

		pos = pos + vmod_pos
		ang = ang + vmod_ang
		
		if ( self.ViewModelReloadAnim ) then
			if ( IsReloading ) then
				relanim = Lerp( TimeStep * 6, relanim, 1 )
			else
				relanim = Lerp( TimeStep * 4, relanim, 0 )
			end
			
			pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelReloadPos, self.ViewModelReloadAng, relanim )
		end
	
		if ( self.ViewModelInspectable ) then
			if ( input.IsKeyDown( cmd_kb_inspect ) || input.IsMouseDown( cmd_kb_inspect ) ) then
				menu = Lerp( TimeStep * 6, menu, 1 )
			else
				menu = Lerp( TimeStep * 4, menu, 0 )
			end
			
			pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelMenuPos, self.ViewModelMenuAng, menu )
		end
		
		if ( self:IsSprinting() && !self.Owner:Crouching() ) then
			sprint = Lerp( TimeStep * ( self.SprintAnimSpeed / 4 ), sprint, 1 )		
		elseif ( WaterLevel > 2 ) then  
			sprint = Lerp( TimeStep * 1, sprint, 0 )
		else
			sprint = Lerp( TimeStep * self.SprintAnimSpeed, sprint, 0 )
		end
		
		--[[
		local f_SprintSpeed = self.Owner:GetVelocity():Length() / 1
		local f_SprintCos = math.cos( CurTime() * ( 8 + f_SprintSpeed / 100 ) )
		local f_SprintSin = math.sin( CurTime() * ( 8 + f_SprintSpeed / 100 ) )
		
		vecSprint.x = math.Approach( self.ViewModelSprintPos.x, ( self.ViewModelSprintPos and self.ViewModelSprintPos.x or 4 ), TimeStep * 25 + math.Clamp( math.atan( f_SprintCos * f_SprintSin, f_SprintCos * f_SprintSin ), -0.4, 0.1) )
		vecSprint.y = math.Approach( self.ViewModelSprintPos.y, ( self.ViewModelSprintPos and self.ViewModelSprintPos.y or -2 ), TimeStep * 25 + math.Clamp( math.atan( f_SprintCos * f_SprintSin, f_SprintCos * f_SprintSin ), 0, 0.2))
		vecSprint.z = math.Approach( self.ViewModelSprintPos.z, ( self.ViewModelSprintPos and self.ViewModelSprintPos.z or -0.25 ), TimeStep * 25 + math.Clamp( math.atan( f_SprintCos * f_SprintSin, f_SprintCos * f_SprintSin ), 0, 0.4))

		angSprint.pitch = math.Approach( self.ViewModelSprintAng.pitch, ( self.ViewModelSprintAng and self.ViewModelSprintAng.pitch or 4 ), TimeStep * 25 + math.Clamp( math.atan( f_SprintCos * f_SprintSin, f_SprintCos * f_SprintSin ), -0.4, 0.1) )
		angSprint.yaw = math.Approach( self.ViewModelSprintAng.yaw, ( self.ViewModelSprintAng and self.ViewModelSprintAng.yaw or -2 ), TimeStep * 25 + math.Clamp( math.atan( f_SprintCos * f_SprintSin, f_SprintCos * f_SprintSin ), 0, 0.2))
		angSprint.roll = math.Approach( self.ViewModelSprintAng.roll, ( self.ViewModelSprintAng and self.ViewModelSprintAng.roll or -0.25 ), TimeStep * 25 + math.Clamp( math.atan( f_SprintCos * f_SprintSin, f_SprintCos * f_SprintSin ), 0, 0.4))
		]]--
		
		pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelSprintPos, self.ViewModelSprintAng, sprint )
		
		if ( !self:IsSprinting() && self.Owner:Crouching() ) then
			crouch = Lerp( TimeStep * 10, crouch, 1 )		
		elseif ( WaterLevel > 2 ) then  
			crouch = Lerp( TimeStep * 6, crouch, 0 )
		else
			crouch = Lerp( TimeStep * 10, crouch, 0 )
		end
		
		pos, ang = self:ModulateViewModelPosition( pos, ang, self.ViewModelDuckPos, self.ViewModelDuckAng, crouch )

		if ( self.SciFiMeleeCharge ) && ( self.SciFiMeleeCharge >= 20 ) then
			pos = pos + self.ViewModelSprintPos.z * Forward * ( self.SciFiMeleeCharge - 20 ) * -0.022
			melee = Lerp( TimeStep * 2, melee, -0.2 )
		end
		
		if ( self:GetSciFiMelee() == 1 ) then
			if ( WaterLevel < 3 ) then
				melee = Lerp( TimeStep * 24, melee, 1 )
			else
				melee = Lerp( TimeStep * 6, melee, 1 )
			end
		else
			if ( WaterLevel < 3 ) then
				melee = Lerp( TimeStep * 8, melee, 0 )
			else
				melee = Lerp( TimeStep * 2, melee, 0 )
			end
		end
		
		pos = pos + self.ViewModelMeleePos.x * Right * melee
		pos = pos + self.ViewModelMeleePos.y * Forward * melee
		pos = pos + self.ViewModelMeleePos.z * Up * melee
		
		ang:RotateAroundAxis( ang:Right(), self.ViewModelHomeAng.x + ( self.ViewModelMeleeAng.x * melee ) )
		ang:RotateAroundAxis( ang:Up(), self.ViewModelHomeAng.y + ( self.ViewModelMeleeAng.y * melee ) )
		ang:RotateAroundAxis( ang:Forward(), self.ViewModelHomeAng.z + ( self.ViewModelMeleeAng.z * melee ) )
		
	end
	
	if ( !self.AdsPos ) then return pos, ang end
	
	local speed = self.AdsTransitionSpeed
	
	if ( !game.SinglePlayer() ) then
		speed = speed * 0.8
	end
	
	if ( self.AdsTransitionAnim && cmd_anims >= 1 ) then
		if ( IsAds ) then
			Mul = Lerp( TimeStep * speed, Mul, 0.975 )
		else
			Mul = Lerp( TimeStep * speed, Mul, 0 )
		end
	else 
		if ( IsAds ) then
			Mul = 0.975
		else
			Mul = 0
		end
	end
	
--	local cmd_enginefov = GetConVarNumber( "fov_desired" )
--	local fovcompensation = ( cmd_enginefov - 75 ) * self.AdsFovCompensation
	
	pos = pos + self.AdsPos.x * Right * Mul
	pos = pos + self.AdsPos.y * Forward * Mul
	pos = pos + self.AdsPos.z * Up * Mul
	
	ang:RotateAroundAxis( ang:Right(), self.AdsAng.x * Mul )
	ang:RotateAroundAxis( ang:Up(), self.AdsAng.y * Mul )
	ang:RotateAroundAxis( ang:Forward(), self.AdsAng.z * Mul )

	return pos, ang
	
end

function SWEP:TranslateActivity( act )

	if ( self.Owner:IsNPC() ) then
		if ( self.ActivityTranslateAI[ act ] ) then
			return self.ActivityTranslateAI[ act ]
		end
		return -1
	end

	if ( self.ActivityTranslate[ act ] != nil ) then
		return self.ActivityTranslate[ act ]
	end

	return -1

end

function SWEP:SetupWeaponHoldTypeForAI( t )

	if ( t == "grenade" ) then
	
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_GRENADE_TOSS 
	
	end
	
	if ( t == "smg" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_SMG1
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SMG1
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_SMG1
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_SMG1_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_SMG1

	return end
	
	if ( t == "ar2" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SMG1
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
--		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_AR2
--		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_SMG1
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_SMG1
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_AR2_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_AR2

	return end
	
	if ( t == "shotgun" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_AR2
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_AR2
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_AR2
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_AR2_LOW
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_AR2_LOW
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_AR2

	return end

end