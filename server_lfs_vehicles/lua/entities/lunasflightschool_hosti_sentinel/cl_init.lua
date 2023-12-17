include("shared.lua")


function ENT:DamageFX()
	local HP = self:GetHP()
	if HP <= 0 or HP > self:GetMaxHP() * 0.5 then return end
	
	self.nextDFX = self.nextDFX or 0
	
	if self.nextDFX < CurTime() then
		self.nextDFX = CurTime() + 0.05

		local Wing1 = self.WingAng1
		local Wing2 = self.WingAng2

		if not Wing1 or not Wing2 then return end

		local Size = 120

		local MirrorY = false
		for d = 0,1 do

			local InvY = MirrorY and 1 or -1

			local Rot = self:LocalToWorldAngles( Angle(MirrorY and Wing2 or Wing1,0,0) )
			local Pos = self:LocalToWorld( Vector(10,110 * InvY,15) ) - Rot:Right() * 70 * InvY + Rot:Forward() * -120

			local effectdata = EffectData()
				effectdata:SetOrigin( Pos )
			util.Effect( "lfs_blacksmoke", effectdata )
			MirrorY = true
		end
	end
end


function ENT:CalcEngineSound( RPM, Pitch, Doppler )
	if self.ENG then
		self.ENG:ChangePitch(  math.Clamp(math.Clamp(  70 + 45, 50,255) + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( -1 + 1, 0.5,1) )
	end

	if self.DIST then
		self.DIST:ChangePitch(  math.Clamp(math.Clamp( 150, 50,255) + Doppler,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1 + 1, 0.5,1) )
	end
end

function ENT:SoundStop()
	if self.DIST then
		self.DIST:Stop()
	end
	
	if self.ENG then
		self.ENG:Stop()
	end
end



