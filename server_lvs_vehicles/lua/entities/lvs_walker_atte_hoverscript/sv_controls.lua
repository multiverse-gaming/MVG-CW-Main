
function ENT:StartCommand( ply, cmd )
	if self:GetDriver() ~= ply then return end

	local KeyJump = ply:lvsKeyDown( "VSPEC" )

	if self._lvsOldKeyJump ~= KeyJump then
		self._lvsOldKeyJump = KeyJump

		if KeyJump then
			self:ToggleVehicleSpecific()
		end
	end
end