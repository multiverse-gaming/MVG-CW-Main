
function EFFECT:Init( data )

	local ent = data:GetEntity()
	local time = data:GetScale()

	self.Time = time
	
	self.ClientProp = ClientsideModel( "models/effects/splodeglass.mdl" )
	self.ClientProp:SetPos( ent:GetPos() )
	self.ClientProp:SetModelScale( 0.01 )
	
	self.LifeTime = CurTime() + time
	self.CallEnt = ent
end

function EFFECT:Think()
	if not self.CallEnt then return false end
	if self.LifeTime < CurTime() + self.Time*0.35 then
		self.ClientProp:SetPos( self.ClientProp:GetPos() + self.CallEnt:GetAimVector()*40 )
		if self.LifeTime < CurTime() then
			self.ClientProp:Remove()
			self:Remove()
		end
	else
		self.ClientProp:SetModelScale( math.min( 0.3, self.ClientProp:GetModelScale() + 0.3/self.Time*10*FrameTime() ) )
	end
	return true
end

function EFFECT:Render()
end
