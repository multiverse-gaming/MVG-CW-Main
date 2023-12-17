include( "shared.lua" )

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Draw()

	self:DrawShadow( false )
	
	self:DrawModel()

end

local M_WhiteStripe = Material("models/hoff/weapons/tac_insert/sprites/fxt_lensflare_stripe_white")
local M_Headlight = Material("models/hoff/weapons/tac_insert/sprites/fxt_light_headlight")
local M_RaySpread = Material("models/hoff/weapons/tac_insert/sprites/fxt_light_ray_spread")
local startTime = CurTime()
local animationSpeed = 0.5 -- seconds to go from start to end
local startScale = 1.5
local endScale = 0.1

function ENT:Draw()
	self:DrawModel() 

	local pos = self:GetPos() + self:GetRight() * -4.5
	local angle = Angle(0, LocalPlayer():EyeAngles().yaw, 0)

	angle.Pitch = angle.Pitch - 180
	render.SetMaterial( M_WhiteStripe )
	render.DrawQuadEasy( pos + Vector(0,0,28), angle:Forward(), 3, 70, Color( 255, 255, 255 ), angle.pitch )

	render.SetMaterial( M_RaySpread )
	render.DrawQuadEasy( pos + Vector(0,0,36), angle:Forward(), 60, 70, Color( 255, 255, 255 ), angle.pitch )

	render.SetMaterial( M_Headlight )
	render.DrawQuadEasy( pos + Vector(0,0,3.2), angle:Up(), 12, 12, Color( 255, 255, 255 ), angle.pitch + 64 )

	local startPos = pos + Vector(0,0,18)
	local endPos = pos + Vector(0,0,48)

	local delta = (CurTime() - startTime) / animationSpeed
	delta = math.Clamp(delta, 0, 1) -- Clamp delta between 0 and 1
	local currentPos = LerpVector(delta, startPos, endPos)
    local curTime = CurTime()
    if curTime < startTime + animationSpeed then
        -- animation is still running
        local progress = (curTime - startTime) / animationSpeed
        local currentPos = LerpVector(progress, startPos, endPos)
		local currentScale = Lerp(delta, startScale, endScale)
        render.SetMaterial( M_WhiteStripe )
        render.DrawQuadEasy( currentPos, angle:Forward(), 5 * currentScale, 28, Color( 255, 255, 255 ), angle.pitch )
    else
        -- animation has finished, reset the start time for the next animation
        startTime = curTime
    end

end 

surface.CreateFont( "Arialf", { font = "Arial", antialias = true, size = 35 } )
hook.Add("HUDPaint","TacInsertText",function()
	local visible_entity = LocalPlayer():GetEyeTrace().Entity
	if !IsValid(visible_entity) then
		return
	end
	if !IsValid(LocalPlayer():GetEyeTrace().Entity) then
		return
	end
	local entityClass = visible_entity:GetClass()
	local player_to_entity_distance = LocalPlayer():GetPos():Distance(visible_entity:GetPos())
	if (entityClass  == 'cod-tac-insert') then
		if (player_to_entity_distance < 85) and visible_entity:IsValid() then
			draw.DrawText(visible_entity:GetNWString("TacOwner").."'s Tactical Insertion", "Arialf", ScrW()/2, ScrH()/2+150, Color(255, 255, 255, 255),TEXT_ALIGN_CENTER)							
			if visible_entity:GetNWString("OwnerID") == LocalPlayer():SteamID() then
				
							
				local useKey = input.LookupBinding("+use") or "E" -- fallback to "E" if not bound
				draw.DrawText("Press " .. string.upper(useKey) .. " to Pick Up", "Arialf", ScrW()/2, ScrH()/2+200, Color(255, 255, 255, 255),TEXT_ALIGN_CENTER)
			
			end
		end
	end
end)