include("shared.lua")

function ENT:OnFrame()
	self:BTLProjector()
	self:DamageFX()
	self:EngineEffects()
end

ENT.EngineGlow = Material( "sprites/light_glow02_add" )
ENT.LightGlow = Material( "sprites/light_glow02_add" )
ENT.LightMaterial = Material( "effects/lvs/laat_spotlight" )
ENT.Red = Color( 255, 0, 0, 255)
ENT.SignalSprite = Material( "sprites/light_glow02_add" )
ENT.Spotlight = Material( "effects/lvs/spotlight_projectorbeam" )

function ENT:PostDrawTranslucent()
	if not self:GetEngineActive() then return end
	
	local Size = 160 + self:GetThrottle() * 40 * 0.8
	local Sizeblue = 120 + self:GetThrottle() * 70 * 0.8


	render.SetMaterial( self.EngineGlow )
	render.DrawSprite( self:LocalToWorld( Vector(-70,0,34.35) ), Size, Size, Color( 250, 150, 0) )
	render.DrawSprite( self:LocalToWorld( Vector(-70,0,34.35) ), Sizeblue, Sizeblue, Color( 0, 46, 250) )

end

function ENT:EngineEffects()
	if not self:GetEngineActive() then return end

	local T = CurTime()

	if (self.nextEFX or 0) > T then return end

	self.nextEFX = T + 0.01
	
		local emitter = ParticleEmitter( self:GetPos(), false )
		local Pos = {
			Vector(-70,0,34.35),
			}

		if emitter then
			for _, v in pairs( Pos ) do
				local Sub = Mirror and 1 or -1
				local vOffset = self:LocalToWorld( v )
				local vNormal = -self:GetForward()

				vOffset = vOffset + vNormal * 4

				local particle = emitter:Add( "sprites/heatwave", vOffset )
				if not particle then return end

				particle:SetVelocity( vNormal * math.Rand(1000,1000) + self:GetVelocity() )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( .05 )
				particle:SetStartAlpha( 255 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(24,24) )
				particle:SetEndSize( math.Rand(20,0) )
				particle:SetRoll( math.Rand(-1,1) * 100 )
				
				particle:SetColor( 255, 255, 255 )
			
				Mirror = true
			end
			
			emitter:Finish()
		end
	
end

function ENT:DamageFX()
	self.nextDFX = self.nextDFX or 0

	if self.nextDFX < CurTime() then
		self.nextDFX = CurTime() + 0.05

		local HP = self:GetHP()
		local MaxHP = self:GetMaxHP()

		if HP > MaxHP * 0.5 then return end

		local effectdata = EffectData()
			effectdata:SetOrigin( self:LocalToWorld( Vector(-30,0,43) ) )
			effectdata:SetRadius(.05)
			effectdata:SetEntity( self )
		util.Effect( "lvs_engine_blacksmoke", effectdata )

		if HP <= MaxHP * 0.25 then
			
			local effectdata = EffectData()
				effectdata:SetOrigin( self:LocalToWorld( Vector(-85,65,14) ) )
				effectdata:SetNormal( self:GetUp() )
				effectdata:SetMagnitude( math.Rand(0.5,1.5) )
				effectdata:SetEntity( self )
			util.Effect( "lvs_exhaust_fire", effectdata )

			local effectdata = EffectData()
				effectdata:SetOrigin( self:LocalToWorld( Vector(-85,-65,14) ) )
				effectdata:SetNormal( self:GetUp() )
				effectdata:SetMagnitude( math.Rand(0.5,1.5) )
				effectdata:SetEntity( self )
			util.Effect( "lvs_exhaust_fire", effectdata )
		end
	end
end

function ENT:BTLProjector()
	local Fire = self:GetBTLFire()

	if Fire == self.OldFireBTL then return end

	self.OldFireBTL = Fire
	
	if Fire then
		local effectdata = EffectData()
		effectdata:SetEntity( self )
		util.Effect( "lvs_laat_left_projector", effectdata )
	end
end

function ENT:CalcViewOverride( ply, pos, angles, fov, pod )
	if ply == self:GetDriver() and not pod:GetThirdPersonMode() then
		return pos + self:GetForward() * 10 - self:GetUp() * -5, angles, fov
	end

	local GunnerPod = self:GetGunnerSeat()

	if ply == GunnerPod and not pod:GetThirdPersonMode() then
		return pos + self:GetForward() * 10 - self:GetUp() * -5, angles, fov
	end

	if pod ~= GunnerPod and pod:GetThirdPersonMode() then
		return pos, angles, fov
	end

	if pod ~= GunnerPod and not pod:GetThirdPersonMode() then
		pod:SetThirdPersonMode(true)
		return pos, angles, fov
	end

	if pod == GunnerPod and pod:GetThirdPersonMode() then
		GunnerPod:SetCameraDistance(-1)
		return GunnerPod:LocalToWorld( Vector(-11.5,105,0) ), angles, fov
	end
end

function ENT:RemoveLight()
	if IsValid( self.projector ) then
		self.projector:Remove()
		self.projector = nil
	end

	if IsValid( self.frojector ) then
		self.frojector:Remove()
		self.frojector = nil
	end
end

function ENT:OnRemoved()
	self:RemoveLight()
end

ENT.LightMaterial = Material( "effects/lvs/laat_spotlight" )
ENT.GlowMaterial = Material( "sprites/light_glow02_add" )

function ENT:PreDraw()
	self:DrawDriverBTL()

	return true
end

function ENT:PreDrawTranslucent()
	if self:GetSpotlightToggle() == false then 
		self:RemoveLight()
		return false
	end

	if not IsValid( self.projector ) then
		local thelamp = ProjectedTexture()
		thelamp:SetBrightness( 10 ) 
		thelamp:SetTexture( "effects/flashlight/soft" )
		thelamp:SetColor( Color(255,255,255) ) 
		thelamp:SetEnableShadows( false ) 
		thelamp:SetFarZ( 4000 ) 
		thelamp:SetNearZ( 1 ) 
		thelamp:SetFOV( 80 )
		self.projector = thelamp
	end

	local attachment = {
		Pos = Vector(162.5,0,-12.5),
		Ang = Angle(90, 0, 0)
	}

	if attachment then
		local StartPos = self:LocalToWorld(attachment.Pos)
		local Dir = self:LocalToWorldAngles(attachment.Ang):Up()

		render.SetMaterial( self.LightGlow )
		render.DrawSprite( StartPos + Dir * 0, 20, 20, Color( 255, 255, 255, 255) )

		render.SetMaterial( self.LightMaterial )
		render.DrawBeam(  StartPos - Dir * 0,  StartPos + Dir * 100, 90, 0, 1, Color( 255, 255, 255, 12) ) 
		
		if IsValid( self.projector ) then
			self.projector:SetPos( StartPos )
			self.projector:SetAngles( Dir:Angle() )
			self.projector:Update()
		end
	end

	return false
end

local COLOR_RED = Color(255,0,0,255)
local COLOR_WHITE = Color(255,255,255,255)

function ENT:LVSPreHudPaint( X, Y, ply )
	if self:GetIsCarried() then return false end

	if ply == self:GetDriver() then
		local Col = self:WeaponsInRange() and COLOR_WHITE or COLOR_RED

		local Pos2D = self:GetEyeTrace().HitPos:ToScreen() 

		self:PaintCrosshairCenter( Pos2D, Col )
		self:PaintCrosshairOuter( Pos2D, Col )
		self:LVSPaintHitMarker( Pos2D )
	end

	return true
end

function ENT:DrawDriverBTL()
	local pod = self:GetGunnerSeat()

	if not IsValid( pod ) then return end

	local plyL = LocalPlayer()
	local ply = pod:GetDriver()

	if not IsValid( ply ) or (ply == plyL and plyL:GetViewEntity() == plyL and not pod:GetThirdPersonMode()) then return end

	if self:GetBodygroup(1) == 2 then
		ply:SetSequence( "sit_rollercoaster" )
		ply:DrawModel()

		return
	end

	local ID = self:LookupAttachment( "muzzle_ballturret_left" )
	local Muzzle = self:GetAttachment( ID )

	if not Muzzle then return end

	local _,Ang = LocalToWorld( Vector(0,0,0), Angle(-90,0,-90), Muzzle.Pos, Muzzle.Ang )

	local LAng = self:WorldToLocalAngles( Ang )
	LAng.p = 0
	LAng.r = 0

	ply:SetSequence( "sit_rollercoaster" )
	ply:SetRenderAngles( self:LocalToWorldAngles( LAng ) )
	ply:DrawModel()
end
