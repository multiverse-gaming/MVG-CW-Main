-- YOU CAN EDIT AND REUPLOAD THIS FILE.
-- HOWEVER MAKE SURE TO RENAME THE FOLDER TO AVOID CONFLICTS

include("shared.lua")

function ENT:LFSCalcViewFirstPerson( view, ply ) -- modify first person camera view here
	--[[
	if ply == self:GetDriver() then
		-- driver view
	elseif ply == self:GetGunner() then
		-- gunner view
	else
		-- everyone elses view
	end
	]]--

	return view
end

function ENT:LFSCalcViewThirdPerson( view, ply ) -- modify third person camera view here
	return view
end

function ENT:LFSHudPaint( X, Y, data, ply ) -- driver only
end

function ENT:LFSHudPaintPassenger( X, Y, ply ) -- all except driver
end

function ENT:CalcEngineSound( RPM, Pitch, Doppler )
	if self.ENG then
		self.ENG:ChangePitch(  math.Clamp( 60 + Pitch * 40 + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( Pitch, 0.5,1) )
	end
end

function ENT:EngineActiveChanged( bActive )
	if bActive then
		self.ENG = CreateSound( self, "vehicles/airboat/fan_blade_fullthrottle_loop1.wav" )
		self.ENG:PlayEx(0,0)
	else
		self:SoundStop()
	end
end

function ENT:OnRemove()
	self:SoundStop()

	if IsValid( self.TheRotor ) then -- if we have an rotor
		self.TheRotor:Remove() -- remove it
	end
end

function ENT:SoundStop()
	if self.ENG then
		self.ENG:Stop()
	end
end

function ENT:AnimFins()
	--[[ function gets called each frame by the base script. you can do whatever you want here ]]--
end


function ENT:AnimCabin()
	--[[ function gets called each frame by the base script. you can do whatever you want here ]]--
end

function ENT:AnimLandingGear()
	--[[ function gets called each frame by the base script. you can do whatever you want here ]]--
end

function ENT:ExhaustFX()
	--[[ function gets called each frame by the base script. you can do whatever you want here ]]--
end
