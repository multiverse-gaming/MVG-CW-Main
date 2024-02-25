
EFFECT.Mat = Material( "trails/tube" )

function EFFECT:Init( data )

	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	
	self.StartPos = self.Position
	self.EndPos = data:GetOrigin()
	
	local dir = self.StartPos - self.EndPos
	dir:Normalize()
	
	self.Dir = dir
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )
	
	self.Alpha = 100
	self.Color = Color( 0, 255, 255, self.Alpha )

end

function EFFECT:Think( )

	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

	self.Alpha = self.Alpha - FrameTime() * 200
	self.Color = Color( 255, 255, 255, self.Alpha )
	
	return self.Alpha > 0

end

function EFFECT:Render( )

	if self.Alpha < 1 then return end
	
	if ( self.Alpha < 1 ) then return end

	self.Length = (self.StartPos - self.EndPos):Length()
		
	local texcoord = CurTime() * -0.2
	
	for i = 1, 10 do
	
		render.SetMaterial( self.Mat )
		
		texcoord = texcoord + i * 0.05 * texcoord
	
		render.DrawBeam( self.StartPos, self.EndPos, 1,	texcoord, texcoord + (self.Length / (128 + self.Alpha)), self.Color )
							
	end

end
