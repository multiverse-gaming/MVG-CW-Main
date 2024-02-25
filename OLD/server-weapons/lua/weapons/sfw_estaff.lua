

AddCSLuaFile()
AddCSLuaFile( "base/scifi_base.lua" )
include( "base/scifi_base.lua" )

hook.Add( "GetFallDamage", "rmt_nofall_trump", function( ply, speed )
	if ( IsValid( ply ) && IsValid( ply:GetActiveWeapon() ) && ply:GetActiveWeapon():GetClass() == "sfw_eblade" ) then
		local wep = ply:GetActiveWeapon()

		if ( ply:KeyDown( IN_DUCK ) ) then
			ply:SetNWFloat( "SWL_FeatherFall", CurTime() )
			wep:SetNextAttack( 0.5 )
			ply:ViewPunch( Angle( speed / 32, 0, math.random( -speed, speed ) / 128 ) )
			return 0
		end
	end
end )

SWEP.PrintName				= "Energy Staff"
SWEP.Author					= "Drugz"

SWEP.Purpose				= "A Energy Staff"
SWEP.Instructions			= "Mouse1 to strike, Mouse2 to stab/dash."

SWEP.Slot					= 0
SWEP.SlotPos				= 4

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/tfa/comm/gg/prp_magna_guard_weapon_combined.mdl"
SWEP.ShowviewModel         = false
SWEP.ShowWorldModel         = false
SWEP.HoldType 				= "ar2"
SWEP.DeploySpeed 			= 2.8
SWEP.ViewModelFOV			= 64
SWEP.Weight					= 1
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}



--SWEP.ViewModelBoneMods = {
--	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(44.908, 0, 0) },
--	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.06, 0), angle = Angle(-1.116, 15.425, 0) },
--	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.23, 20.188, 0) },
--	["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.608, 0, 0) },
--	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0.629, -1.045, 0), angle = Angle(-6.178, 0.275, 0) },
--	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.171, 7.776, 0) },
--	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0.061, -0.504, 0.225), angle = Angle(-4.911, 16.455, 3.701) },
--	["ValveBiped.Bip01_L_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.485, -9.593, 0) }
--}

SWEP.SciFiSkin				= "nil"
SWEP.SciFiWorld 			= "nil"

if ( CLIENT ) then
SWEP.WepSelectIcon 			= surface.GetTextureID( "/vgui/circle" )
end

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.Automatic	= true

SWEP.ViewModelSprintAng 	= Angle( -10, -10, 0 )

SWEP.SciFiFamily			= { "vtec", "melee_simple", "useshook", "infammo", "autoregen" }
SWEP.SciFiWorldStats		= {
	["1"] = { text = "Damage: 				 15 - 50, +5", color = Color( 180, 180, 180 ) },
	["2"] = { text = "Crit. mul.: 				 --", color = Color( 180, 180, 180 ) },
	["3"] = { text = "Damage type: 	Impact, Energy", color = Color( 110, 180, 255 ) },
	["4"] = { text = "Attack speed: 	(max.) 2.5", color = Color( 180, 180, 180 ) },
	["5"] = { text = "Range: 						 82 units", color = Color( 180, 180, 180 ) },
	["6"] = { text = "Recharge rate: 60", color = Color( 180, 180, 180 ) },
	["7"] = { text = "Damage is positively effected by the wielder's movement speed.", color = Color( 180, 180, 180 ) },
	["8"] = { text = "Damage decreases with lower blade charge.", color = Color( 180, 180, 180 ) },
--	["9"] = { text = "... They ask for your allegiance, and you shall give it ...", color = Color( 255, 20, 20 ) }
}

SWEP.ViewModelMeleePos		= Vector( 2, 4, -2 )
SWEP.ViewModelMeleeAng		= Angle( 10, 20, -20 )

SWEP.SciFiMeleeTime			= 0
SWEP.SciFiMeleeASpeed		= 0.35
SWEP.SciFiMeleeRange		= 52
SWEP.SciFiMeleeDamage		= 3
SWEP.SciFiMeleeSound		= "scifi.melee.swing.light"

SWEP.HitDistance			= 82

SWEP.SciFiRegenDelay		= 0.6





--[[SWEP.VElements = {
	["0"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2.476, 4.776), angle = Angle(-4.618, 70.052, 72), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0+"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 3, 4.2), angle = Angle(173.481, 70, 95), size = Vector(0.402, 0.547, 1.536), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2.476, 2), angle = Angle(-4.618, 70.052, 72), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["0+++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 2, -2), angle = Angle(173.481, 70, 95), size = Vector(0.402, 0.547, 1.536), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/saphyre/saph_core", skin = 0, bodygroup = {} },
	["1"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18, 6, 2.2), angle = Angle(170, 70, 102), size = Vector(0.402, 0.547, 3), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["1+"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 5.5, 3), angle = Angle(-4.618, 72, 72), size = Vector(0.402, 0.547, 3), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} },
	["1++"] = { type = "Model", model = "models/gibs/hgibs_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 3, 2), angle = Angle(-4.618, 70.052, 72), size = Vector(0.402, 0.547, 1.143), color = Color(255, 255, 255, 255), surpresslightning = true, material = "models/weapons/misc/energy_surf", skin = 0, bodygroup = {} }
}--]]


SWEP.VElements = {
	["FX1"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-18.701, 0, 0), angle = Angle(0, 0, 0), size = { x = 4, y = 4 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX1++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "FX1", pos = Vector(-1.558, 0, 0), angle = Angle(0, 0, 0), size = { x = 4, y = 4 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX1+++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "FX1", pos = Vector(-3.636, 0, 0), angle = Angle(0, 0, 0), size = { x = 4, y = 4 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX1+"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "FX1", pos = Vector(-5.2, 0, 0, 0), angle = Angle(0, 0, 0), size = { x = 4, y = 4 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["Staff"] = { type = "Model", model = "models/tfa/comm/gg/prp_magna_guard_weapon_combined.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-6.753, 1.557, -9.87), angle = Angle(80, 68.96, -31.559), size = Vector(0.625, 0.625, 0.625), color = Color(150, 150, 150, 255), surpresslightning = true, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["FX++++++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-27.532, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-28.571, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(26.493, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-32.728, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-30.65, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-32.728, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-24.417, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(25.454, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-31.688, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(31.687, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(27.531, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(29.61, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-26.494, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-25.455, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-30.65, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-24.417, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(29.61, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(24.416, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(30.649, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["Staff"] = { type = "Model", model = "models/tfa/comm/gg/prp_magna_guard_weapon_combined.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.299, 1, 0.675), angle = Angle(72.986, 140.636, -47.923), size = Vector(0.85, 1, 1), color = Color(150, 150, 150, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["FX+++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(32.727, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++++++++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-29.611, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(27.531, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(24.416, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(28.57, 0, 0), size = { x = 3.545, y = 3.545 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++++++++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(32.727, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX+++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-28.571, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true},
	["FX++"] = { type = "Sprite", sprite = "particle/particle_glow_04", bone = "ValveBiped.Bip01_R_Hand", rel = "Staff", pos = Vector(-26.494, 0, 0), size = { x = 5.816, y = 5.816 }, color = Color(185, 0, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true}
}

--resource.AddSingleFile( "weapons/eblade/eblade_idle.wav" )

local SwingElectric = {"npc/vort/claw_swing1.wav","npc/vort/claw_swing2.wav", }
local HitElectric = { "weapons/stunstick/stunstick_impact2.wav", "weapons/stunstick/stunstick_fleshhit1.wav", "weapons/stunstick/stunstick_fleshhit2.wav" }
local HitDefault = Sound( "phx/epicmetal_hard1.wav" )
local comfort = 0

function SWEP:SubInit()

	self.NextRegenTime = 0
	comfort = 52

end




function SWEP:SetupDataTables()

	self:NetworkVar( "Int", 0, "SciFiMelee" )
	self:NetworkVar( "Float", 0, "NextMeleeAttack" )
	self:NetworkVar( "Float", 1, "NextIdle" )

end

if ( CLIENT ) then

	function SWEP:CustomAmmoDisplay()

		self.AmmoDisplay = self.AmmoDisplay or {}
		self.AmmoDisplay.Draw = true

		if ( self.Primary.ClipSize > -1 ) then
			self.AmmoDisplay.PrimaryClip = self:Clip1()
		end

		return self.AmmoDisplay

	end

end

function SWEP:UpdateNextIdle()

	local vm = self.Owner:GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )

end

function SWEP:Think()

	if ( self.Owner:GetActiveWeapon() ~= self.Weapon ) then return end

	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if ( IsExistent( self ) ) and ( IsExistent( self:GetNWEntity( "blade" ) ) ) then

		local blade = self:GetNWEntity( "blade" )
		local vm_blade = self.Owner:GetVelocity()
		local velo = math.Clamp( ( math.Round( ( math.abs( vm_blade.y ) + math.abs( vm_blade.x ) + math.abs( vm_blade.z ) ) ) / 3000 ), 0.01, 0.25 )

               if ( CLIENT ) then
			EmitSound( "", blade:GetPos(), blade:EntIndex(), CHAN_STATIC, velo, 50, SND_CHANGE_PITCH, 60 + velo * 10 )

		end

		if ( self:GetNWBool( "eblade_active" ) == true ) then
		--	CreateParticleSystem( blade, "blade_glow", PATTACH_POINT_FOLLOW, 1, Vector( 0, 0, 0 ) )
		--	ParticleEffectAttach( "blade_glow", PATTACH_POINT_FOLLOW, blade, 0 ) -- wtf, garry? why you rekt this function?
			self:SetNWBool( "eblade_active", false )
		end

	end

	if ( idletime > 0 && CurTime() > idletime ) and ( SERVER ) then

		vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle_melee2" ) )

		self:UpdateNextIdle()

	end

	local meleetime = self:GetNextMeleeAttack()

	if ( meleetime > 0 && CurTime() > meleetime ) then

		self:DealDamage()

		self:SetNextMeleeAttack( 0 )

	end

	if ( SERVER ) then

		if( self.NextRegenTime <= CurTime() ) then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) then
				self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
			end
		end

		if ( self.Weapon:Clip1() >= 101 ) then
			self.Weapon:SetClip1( 100 )
		end

	end

	self:SciFiMath()
	self:SciFiMelee()

end

function SWEP:Deploy()

	if ( self.Owner:IsNPC() ) then self:Remove() end --Those NPC-peasants aren't mighty enough to use this weapon.

	local vm = self.Owner:GetViewModel()

	self.Weapon:SetHoldType( "electrostaff [wos]" )

	self.Weapon:EmitSound("weapons/smack.wav", 50, 100)

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )

	self:UpdateNextIdle()

	self:SetClip1( 60 )
end


function SWEP:PrimaryAttack()

	self:SetNWBool( "eblade_active", true )

	--[[if !self.Owner:KeyDown(IN_RIGHT) then
	    self.Owner:SelectWeightedSequence(ACT_MP_ATTACK_STAND_PRIMARYFIRE)
    else
        self.Owner:SelectWeightedSequence(ACT_MP_ATTACK_STAND_PRIMARY)
    end--]]

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vmanims = {ACT_VM_HITCENTER, ACT_VM_PRIMARYATTACK}

	self.Weapon:SendWeaponAnim( vmanims[math.random( 1, #vmanims )] )

	local anim = ""

	if ( GetRelChance( comfort ) ) then
		self.Owner:ViewPunch( Angle( 0, 2, 0 ) )
		anim = "midslash1"
		comfort = comfort - 10
	else
		self.Owner:ViewPunch( Angle( 0, -2, 0 ) )
		anim = "midslash2"
		comfort = comfort + 10
	end

	--local vm = self.Owner:GetViewModel()
	--vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )



	self:EmitSound( SwingElectric[ math.random( 1, #SwingElectric ) ] )

	local weaken = 0.4 + ( self.SciFiACC / 30 )

	self:UpdateNextIdle()
	self:SetNextMeleeAttack( CurTime() + 0.2 )

	self:SetNextPrimaryFire( CurTime() + weaken )
	--self:SetNextSecondaryFire( CurTime() + weaken + 0.1 )

	self.NextRegenTime = CurTime() + self.SciFiRegenDelay

	self:AddSciFiACC( 12 )

end

--[[function SWEP:SecondaryAttack()

self.Weapon:SetNextSecondaryFire(CurTime() + 1.4)
self.Owner:SetVelocity( self.Owner:GetAimVector() * 250 + Vector( 0, 0, 250 ) )


end --]]

function SWEP:DealDamage()

--	local anim = self:GetSequenceName( self.Owner:GetViewModel():GetSequence() )
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
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mins = Vector( -16, -16, -8 ),
			maxs = Vector( 16, 16, 8 ),
			mask = MASK_SHOT_HULL
		} )
	end

	if ( tr.Hit && !( game.SinglePlayer() && CLIENT ) ) then

		self:EmitSound( HitElectric[ math.random( 1, #HitElectric ) ] )

		util.Decal( "manhackcut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )

		if ( anim == "stab" ) then
			ParticleEffect( "hpw_protego_main", tr.HitPos, self.Owner:EyeAngles(), self )  --hpw_aguamenti_sparks  --ParticleEffect( "blade_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		else
			ParticleEffect( "hpw_protego_main", tr.HitPos, self.Owner:EyeAngles(), self )--, tr.HitPos, self.Owner:EyeAngles(), self ) --ParticleEffect( "blade_hit", tr.HitPos, self.Owner:EyeAngles(), self )
		end

		if ( self:Clip1() > 0 ) then
				if ( !game.SinglePlayer() && SERVER ) then
				local fx2 = ents.Create( "light_dynamic" )
				if ( !IsValid( fx2 ) ) then return end
				fx2:SetKeyValue( "_light", "70 110 255 255" )
				fx2:SetKeyValue( "spotlight_radius", 256 )
				fx2:SetKeyValue( "distance", 512 )
				fx2:SetKeyValue( "brightness", 2 )
				fx2:SetPos( tr.HitPos )
				fx2:Spawn()
				fx2:Fire( "kill", "", 0.12 )
				end
			self:EmitSound( HitDefault )
		end

	end

	local hit = false

	if ( SERVER && IsValid( tr.Entity ) && ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity:Health() > 0 ) ) then

		local dmginfo = DamageInfo()
		local dmgforce = self.Owner:GetRight() * 100 + self.Owner:GetForward() * 1000 + playervelo * 10

		local attacker = self.Owner
		if ( !IsValid( attacker ) ) then attacker = self end
		dmginfo:SetAttacker( attacker )
		dmginfo:SetInflictor( self )

		if ( self:Clip1() > 0 ) then
		--	self:DealAoeDamage( bit.bor( DMG_AIRBOAT, DMG_NEVERGIB ), 25 * amp, self.Owner:GetShootPos() + self.Owner:GetAimVector() * 16, 64 )
			for k,v in pairs ( ents.FindInSphere( tr.HitPos, 56 ) ) do
				if ( v ~= self.Owner ) && ( v:GetOwner() ~= self.Owner ) then
					self:DealDirectDamage( bit.bor( DMG_AIRBOAT, DMG_NEVERGIB ), 25 * amp, v, self.Owner, dmgforce )
				end
			end
			dmginfo:SetDamage( ( math.random( 50, 80 ) + ( self:Clip1() / 4 ) ) * amp + velo )
			dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_NEVERGIB ) )
			self:TakePrimaryAmmo( math.Clamp( 25, 0, self:Clip1() ) )
		else
			dmginfo:SetDamage( math.random( 50, 80 ) * amp + velo )
		end

		dmginfo:SetDamageForce( dmgforce )

		tr.Entity:TakeDamageInfo( dmginfo )

		hit = true

	end

	if ( SERVER && IsValid( tr.Entity ) ) then
		local phys = tr.Entity:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:ApplyForceOffset( self.Owner:GetAimVector() * 80 * phys:GetMass(), tr.HitPos )
		end
	end


	self:SetNWBool( "eblade_active", false )

	self.Owner:LagCompensation( false )

end
