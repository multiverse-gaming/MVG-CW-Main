AddCSLuaFile()

ENT.PrintName		= 'Personal Shield'
ENT.Base			= 'base_gmodentity'
ENT.Type			= 'anim'
ENT.Model			= 'models/hunter/misc/sphere2x2.mdl'
ENT.RenderGroup		= RENDERGROUP_TRANSLUCENT
ENT.Radius			= 48									-- Sphere radius, 48 is default (Do not change this value!)
ENT.DamageCapacity	= 200									-- The amount of damage gets absorbed
ENT.RechargeTime	= 30									-- Recharge time, in seconds
ENT.DamageEffect	= true									-- Emit lightup effect on the sphere when is damaged
ENT.Spawnable		= false
ENT.TimeReenableForShooting = 5								-- Shooting time amount waiting to reenable.

local wepoffset = Vector(0,0,36)

function ENT:SetupDataTables()
	self:NetworkVar('Entity',0,'ShieldOwner')
	self:NetworkVar('Bool',0,'Active') -- If its currently active.
	self:NetworkVar('Bool',1,'Damaged') 
	self:NetworkVar('Int',0,'ActiveOffset')

	self:NetworkVar('Bool', 2, 'AutoEnable')
end

if SERVER then

	function ENT:Initialize(owner)
		if !IsValid(owner) then return end
		local owwep = owner:GetWeapon('personal_shield_activator')
		if !IsValid(owwep) then return end
		self:SetModel(self.Model)
		--self:PhysicsInitSphere(self.Radius,'no_decal')
		--self:PhysicsInit(SOLID_NONE)
		--self:SetModelScale(self.Radius/48)
		--self:SetModelScale(0.2) -- This just makes it look smaller in the c-menu.
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		self:PhysWake()
		self:Activate()
		self:AddEffects(EF_NOSHADOW)
		self:SetShieldOwner(owner)
		owner:SetNWEntity('PShield',self)
		self:SetOwner(owner)
		self:SetPos(owner:GetPos() + wepoffset)
		self:SetParent(owwep)
		self:SetMaxHealth(self.DamageCapacity)
		self:SetHealth(self.DamageCapacity)
		self.SoundLoop = CreateSound(self,'ambient/machines/combine_shield_loop3.wav')
		self.SoundLoop:SetSoundLevel(60)
		self:ToggleShield(true)
	end

	function ENT:ToggleShield(bool)
		if bool and self:GetDamaged() then return end
		if( bool and (self:GetActiveOffset() > CurTime()) ) then return end -- Dont run if we set an offset not to enable.

		self:SetActive(bool)
		self:SetNoDraw(!bool)
		self:SetSolid(bool and SOLID_BSP or SOLID_NONE)
		local owner = self:GetShieldOwner()
		if IsValid(owner) then
			--owner:SetNWEntity('PShield',bool and self or NULL)
			if bool then
				owner:ScreenFade(SCREENFADE.IN,Color(255,255,255,32),0.4,0)
			end
		end
		if bool then
			self.SoundLoop:PlayEx(0.32,64)
			self:EmitSound('ambient/machines/thumper_hit.wav',60,64,.64,CHAN_ITEM)
		else
			self.SoundLoop:Stop()
			self:EmitSound('ambient/machines/thumper_shutdown1.wav',60,100,.64,CHAN_ITEM)
		end
	end

	function ENT:OnTakeDamage(dmg)
		if !self:GetActive() then return end
		self:SetHealth(self:Health()-dmg:GetDamage())
		if self:Health() <= 0 then
			self:ToggleShield(false)
			self:SetActiveOffset(CurTime()+self.RechargeTime)

			self:SetDamaged(true)
			return
		end
		local ed = EffectData()
		ed:SetOrigin(dmg:GetDamagePosition())
		ed:SetNormal((dmg:GetDamagePosition()-self:GetPos()):GetNormalized())
		ed:SetRadius(1)
		util.Effect('cball_bounce',ed)
		util.Effect('AR2Explosion',ed)
		self:EmitSound(('ambient/energy/weld%s.wav'):format(math.random(1,2)),75,math.random(144,192),.64,CHAN_ITEM)
	end

	function ENT:Think()

		-- When to reenable automatically from being disabled physically.
		if self:Health() <= 0 and !self:GetActive() and self:GetActiveOffset() <= CurTime() then 
			self:SetHealth(self.DamageCapacity)
			self:SetDamaged(false)
			self:ToggleShield(true)
		end

		if( self:GetAutoEnable() and self:GetActiveOffset() <= CurTime() ) then
			self:SetAutoEnable(false)
			self:ToggleShield(true)
		end

	end
	
	function ENT:ShotBullet()
		return
	end
end

if CLIENT then

	local rendmat = Material('models/props_combine/stasisshield_sheet')
	local startalpha = 16

	function ENT:DrawTranslucent()
		if !self:GetActive() then return end
		local owner = self:GetShieldOwner()
		if owner == LocalPlayer() and !LocalPlayer():ShouldDrawLocalPlayer() then return end
		local rendcol = HSVToColor(180+5*math.sin(SysTime()*4),1,1)
		rendcol.a = startalpha+16*(math.sin(SysTime()*4)+1)/2
		render.SetColorMaterial()
		render.DrawSphere(owner:GetPos()+wepoffset,self.Radius,16,16,rendcol)
		render.SetMaterial(rendmat)
		render.OverrideBlend(true,2,4,BLENDFUNC_ADD)
		render.DrawSphere(owner:GetPos()+wepoffset,self.Radius,16,16,rendcol)
		render.OverrideBlend(false,2,4,BLENDFUNC_ADD)
	end

end