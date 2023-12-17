include('shared.lua')

function ENT:Draw()

//Actually draw the model
self.Entity:DrawModel()

//Draw tooltip with networked information if close to view
local squad = self:GetNetworkedString( 52 )
if ( LocalPlayer():GetEyeTrace().Entity == self.Entity && EyePos():Distance( self.Entity:GetPos() ) < 256 ) then
AddWorldTip( self.Entity:EntIndex(), ( "Signal Alarm\n(" .. squad .. ")" ), 0.5, self.Entity:GetPos(), self.Entity  )
end
end

language.Add( 'halo_theme', 'Halo Theme' )