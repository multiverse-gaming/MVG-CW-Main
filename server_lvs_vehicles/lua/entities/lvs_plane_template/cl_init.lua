include("shared.lua")

-- called when a trail effect is started
function ENT:OnTrail( active, id )
end

-- called when the vehicle is spawned. Use this instead of ENT:Initialize
function ENT:OnSpawn()
	-- register a wing-tip trail vortex effect.
	-- self:RegisterTrail( Pos, StartSize, EndSize, LifeTime, min_flight_speed, activation_speed )

	-- example:
	-- self:RegisterTrail( Vector(40,200,70), 0, 20, 2, 1000, 400 )
end

-- use this instead of ENT:OnRemove
function ENT:OnRemoved()
end

-- use this instead of ENT:Think()
function ENT:OnFrame()
end

function ENT:LVSPreHudPaint( X, Y, ply )
	return true -- return false to prevent original hud paint from running
end

function ENT:PreDraw() -- function is called in ENT:Draw() right before self:DrawModel() is called.
	return true -- set to false to prevent model from drawing.  Note this will not stop ENT:PostDraw() from being called
end

function ENT:PreDrawTranslucent() -- function is called in ENT:DrawTranslucent() right before self:DrawModel() is called
	return false -- set to true to draw the model in translucent
end

function ENT:PostDraw()
	-- called in ENT:Draw() after the self:DrawModel() is called
end

function ENT:PostDrawTranslucent()
	-- called in ENT:DrawTranslucent() after the self:DrawModel() is called.
end

-- called when the engine is turned on or off
function ENT:OnEngineActiveChanged( Active )
end

-- called when either an ai is activated/deactivated or when a player is sitting/exiting the driver seat
function ENT:OnActiveChanged( Active )
end

--[[ -- edit view here. This is run before the LVS' camera is run
function ENT:CalcViewOverride( ply, pos, angles, fov, pod )
	return pos, angles, fov
end
]]
