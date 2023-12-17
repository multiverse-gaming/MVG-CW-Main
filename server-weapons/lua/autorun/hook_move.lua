
include("sh_rhook_config.lua")

if SERVER then
	AddCSLuaFile("sh_rhook_config.lua")
	resource.AddFile("sound/bobble/grapple_hook/grappling_hook_impact.mp3")
	resource.AddFile("sound/bobble/grapple_hook/grappling_hook_reel_start.wav")
	resource.AddFile("sound/bobble/grapple_hook/grappling_hook_reel_stop.mp3")
	resource.AddFile("sound/bobble/grapple_hook/grappling_hook_shoot.mp3")


	local function ClearHook(ent)
		if ent:IsPlayer() then
			if IsValid(ent.rhook) then
				ent.rhook:Remove()
			end
			if ent.OnWall then
				rhook.DetachWall(ent)
			end
		end
	end

	hook.Add("OnEntityRemoved","rhook",ClearHook)
	if rhook.RemoveOnDeath then
		hook.Add("DoPlayerDeath","rhook",ClearHook)
	end
	hook.Add("PlayerChangedTeam","rhook_change_job",ClearHook) //Added by Dandy, if changing jobs breaks the hook remove this :)

end

hook.Add("InitPostEntity","RaidHook TTT",function()
	local SWEP = weapons.GetStored("weapon_grapplehook")
	SWEP.Kind = rhook.TTTKind
	SWEP.CanBuy = rhook.TTTCanBuy
	SWEP.InLoadoutFor = rhook.TTTInLoadoutFor
	SWEP.LimitedStock = rhook.TTTLimitedStock
	SWEP.CanDrop = rhook.TTTCanDrop
	SWEP.EquipMenuData = {
	   type = "item_weapon",
	   desc = rhook.TTTDescription
	};
end)

hook.Add("HUDPaint","rhook",function()
	//debug
	-- surface.SetTextColor(color_white)
	-- surface.SetTextPos(ScrW()/2,ScrH()/2)
	-- surface.SetFont("Default")
	-- surface.DrawText(tostring(LocalPlayer():GetAngles()))

	-- local mins,maxs  =LocalPlayer():GetHull()
	-- debugoverlay.Box(LocalPlayer():GetPos(),mins,maxs,FrameTime()+.01,Color(255,255,255,20))

	if rhook.HookFindLedge(LocalPlayer()) then
		surface.SetFont("DermaLarge")
		local w,h = surface.GetTextSize(rhook.LedgeMsg)
		draw.RoundedBox(4,ScrW()/2-w/2-10,ScrH()/4-h/2-5,w+20,h+10,Color(0,0,0,200))
		draw.SimpleText(rhook.LedgeMsg,"DermaLarge",ScrW()/2,ScrH()/4,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end

end)

local ShatterSound = Sound("physics/glass/glass_largesheet_break1.wav")
local StopSound = Sound("bobble/grapple_hook/grappling_hook_reel_stop.mp3")
sound.Add({
	name = "GrappleReelStart",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = 100,
	sound = "bobble/grapple_hook/grappling_hook_reel_start.wav"
} )

local vec = FindMetaTable("Vector")
function vec:PlaneDistance(plane,normal)
	return normal:Dot(self-plane)
end

local lastfootstep = 1
local lastfoot = 0
local function PlayFootstep(ply,level,pitch,volume)

	local sound = math.random(1,4)
	while sound == lastfootstep do
		sound = math.random(1,4)
	end
	lastfoot = lastfoot == 0 and 1 or 0

	local filter = SERVER and RecipientFilter():AddPVS(ply:GetPos()) or nil
	if GAMEMODE:PlayerFootstep( ply, pos, lastfoot, "player/footsteps/concrete"..sound..".wav", .6, filter ) != nil then return end

	ply:EmitSound("player/footsteps/concrete"..sound..".wav",level,pitch,volume,CHAN_BODY)
	-- ply:PlayStepSound(1)
end

local function CollisionClamp(pos,vel,ply,k)
	local dt = FrameTime()
	local new = Vector(vel)
	if k == "x" then i1 = "y" i2 = "z" end
	if k == "y" then i1 = "x" i2 = "z" end
	if k == "z" then i1 = "y" i2 = "x" end

	new[i1] = 0
	new[i2] = 0

	local mins,maxs = ply:GetHull()
	local stepheight = ply:GetStepSize()
	-- local tr = util.TraceHull( { start = pos+ ply.OnWall*stepheight, endpos = pos+new*dt, filter = ply, mins=mins,maxs=maxs, mask=MASK_PLAYERSOLID} )
	local tr = util.TraceHull( { start = pos+ ply.OnWall*stepheight, endpos = pos+new*dt, filter = ply, mins=mins,maxs=maxs, mask=MASK_PLAYERSOLID} )

	if ( tr.Hit ) then
		--Move no further.
		pos[k] = tr.HitPos[k]

		--Push objects away.
		if IsValid(tr.Entity) and IsValid(tr.Entity:GetPhysicsObject()) then
			tr.Entity:GetPhysicsObject():ApplyForceOffset(vel,tr.HitPos)
		end

		vel[k] = 0

	else
		--Make our move.
		pos = pos + new * dt
	end
	return pos,vel
end

// Rotates a BBox as best it can.
// We only want to rotate to axis-aligned walls because the BBox is axis-aligned so we have to hard-code.
// In the source engine this is good nuff.
local function GetRotatedBBox(ply,norm)

	-- local mins,maxs = ply:GetHull()
	local mins, maxs = Vector(-16,-16,-16),Vector(16,16,16)
	local tol = .35

	if ply.OnWall:IsEqualTol(Vector(-1,0,0),tol) then
		mins = Vector(0,-16,-16)
		maxs = Vector(72,16,16)
	elseif ply.OnWall:IsEqualTol(Vector(1,0,0),tol) then
		mins = Vector(-72,-16,-16)
		maxs = Vector(0,16,16)
	elseif ply.OnWall:IsEqualTol(Vector(0,1,0),tol) then
		mins = Vector(-16,-72,-16)
		maxs = Vector(16,0,16)
	elseif ply.OnWall:IsEqualTol(Vector(0,-1,0),tol) then
		mins = Vector(-16,0,-16)
		maxs = Vector(16,72,16)
	end

	return mins,maxs
end
function rhook.HookFindLedge(ply)
	if not ply.OnWall then return false end
	local pos = ply:GetPos()
	local trace = {start=pos,endpos=pos-ply.OnWall*1000,filter=ply}
	local tr = util.TraceLine(trace)

	if tr.HitSky then return false end

	local uptrace = {}
	uptrace.start = tr.HitPos + tr.HitNormal*16
	uptrace.endpos = uptrace.start + Vector(0,0,rhook.LedgeDistance or 72)
	uptrace.filter = ply

	local uptr = util.TraceLine(uptrace)
	if uptr.Hit then return false end

	//Check if it's a ledge with room on top.
	local ledgetrace = {}
	ledgetrace.start = tr.HitPos + tr.HitNormal*16 + Vector(0,0,rhook.LedgeDistance or 72)
	ledgetrace.endpos = ledgetrace.start - tr.HitNormal*16
	ledgetrace.mins = Vector(-16,-16,0)
	ledgetrace.maxs = Vector(16,16,72)
	ledgetrace.mask = MASK_PLAYERSOLID

	local ledgetr = util.TraceHull(ledgetrace)

	//DEBUG:
	-- if CLIENT then
		-- debugoverlay.Line( tr.HitPos, ledgetrace.start, FrameTime()+.01, Color(0,0,255), false )
		-- debugoverlay.Line( ledgetrace.start, ledgetr.HitPos or ledgetrace.endpos, FrameTime()+.01, Color(0,0,255), false )
		-- debugoverlay.Box( ledgetrace.start, ledgetrace.mins, ledgetrace.maxs, FrameTime()+.01, Color(0,0,255, 100), false )
		-- if ledgetr.Hit then
			-- debugoverlay.Line( ledgetr.HitPos, ledgetrace.endpos, FrameTime()+.01, Color(255,0,0), false )
		-- end
		-- debugoverlay.Box(  ledgetr.HitPos or ledgetrace.endpos, ledgetrace.mins, ledgetrace.maxs, FrameTime()+.01, ledgetr.Hit and Color(255,0,0, 100) or Color(0,255,0, 100), false )
	-- end



	if !ledgetr.Hit then
		return ledgetr.HitPos
	else
		return false
	end

end

function rhook.AttachWall(ply,normal)
	ply:SetMoveType(MOVETYPE_WALK)

	//Enter wall walk
	ply.OnWall = normal
	//Set initial angles
	local a = ply:EyeAngles()
	a.r = 0
	a:RotateAroundAxis(ply.OnWall:Angle():Right(),-90)
	if SERVER or ply==LocalPlayer() then
		ply:SetEyeAngles(a)
	end

	ply.OldMins,ply.OldMaxs = ply:GetHull()
	ply.OldVO = ply:GetCurrentViewOffset()

	local nmin,nmax,vo= Vector(ply.OldMins), Vector(ply.OldMaxs), Vector(ply.OldMaxs)

	nmin,nmax = GetRotatedBBox(ply,ply.OnWall)

	vo = (nmax+nmin)/2 + ply.OnWall * (ply.OldVO.z)/2

	ply:SetHull(nmin,nmax)
	ply:SetCurrentViewOffset( vo )
	ply:SetPos(ply:GetPos()+Vector(0,0,16)+ply.OnWall*16)

	if rhook.ReelSound then
		ply.ReelSound = CreateSound(ply,"GrappleReelStart")
		ply.ReelSound:Play()
	end

	if CLIENT then
		ply:SetIK(false)
	else
		BroadcastLua("rhook.AttachWall(Player("..ply:UserID().."),Vector("..normal.x..","..normal.y..","..normal.z.."))")
	end
	ply:SetAllowFullRotation(true)
	-- print(ply.OnWall)
end
function rhook.DetachWall(ply)

	local mins,maxs = ply.OldMins or Vector(-16,-16,0),ply.OldMaxs or Vector(16,16,72)

	ply:SetHull(mins,maxs )
	ply:SetCurrentViewOffset(ply.OldVO or Vector(0,0,64))

	if not ply.OnWall then return end

	-- local pos = ply:GetPos()
	local pos = ply:GetPos()+ply.OnWall*maxs


	local ledge = rhook.HookFindLedge(ply)
	if ledge then
		pos = ledge
	end


	//sphere trace for antistuck
	local hulltr = {start=pos, endpos=pos, mask=MASK_PLAYERSOLID, filter=ply}
	local stuck = util.TraceEntity(hulltr,ply)
	if stuck.StartSolid then
		local dist = 16
		local accuracy = .5
		local found = false
		hulltr.start=pos
		local function unstick()
			for x=1,-1,-accuracy do
				for y=1,-1,-accuracy do
					for z=-1,1,accuracy do


						local dir = (Vector(x,y,z)-ply.OnWall):GetNormalized()
						hulltr.endpos = hulltr.start + dir*dist

						local line = util.TraceLine(hulltr)
						if not line.Hit and not line.StartSolid then
							local trace= {start=hulltr.endpos, endpos=hulltr.endpos, mask=MASK_PLAYERSOLID, mins=mins, maxs=maxs, filter=ply}
							local htr = util.TraceHull(trace)

							if not htr.Hit and not htr.StartSolid then
								-- local a = SERVER and debugoverlay.Box(hulltr.endpos,mins,maxs,15,Color(0,255,0,100))
								pos = hulltr.endpos
								found = true
							end
						end

						-- local a = SERVER and debugoverlay.Line(hulltr.start,hulltr.endpos,15,Color(255,0,0))


						if found then break end
					end
					if found then break end
				end
				if found then break end
			end
		end
		repeat
			unstick()
			dist = dist + 16
		until found or dist > 2000
	end
	timer.Simple(0,function()
		ply:SetPos(pos)
		-- local a = SERVER and debugoverlay.Cross(ply:GetPos(),4,15,Color(0,0,255))
	end)

	if rhook.ReelSound then
		ply.ReelSound:Stop()
		ply:EmitSound(StopSound)
	end

	local ang = ply:GetAngles()
	-- ang.r = 0
	if SERVER or ply==LocalPlayer() then
		ply:SetEyeAngles(ang)
	end

	ply:SetAllowFullRotation(false)

	if CLIENT then
		ply:DisableMatrix("RenderMultiply")
		ply:SetIK(true)
	else
		BroadcastLua("rhook.DetachWall(Player("..ply:UserID().."))")
	end

	ply.OnWall = nil
	ply.Hook = nil
	-- print("Off wall")
end

//DEBUG:
-- concommand.Add("grapple_wall",function(ply,c,a)
	-- local normal = ply:GetEyeTrace().HitNormal

	-- if !ply.OnWall then
		-- if IsValid(ply.Hook) then
			-- ply.Hook:Use(ply,ply,USE_ON,1)
		-- else
			-- BroadcastLua("rhook.AttachWall(Entity("..ply:EntIndex().."),Vector("..normal.x..","..normal.y..","..normal.z.."))")
			-- rhook.AttachWall(ply,normal)
		-- end
	-- else
		-- if IsValid(ply.Hook) then
			-- ply.Hook:Use(ply,ply,USE_ON,1)
		-- else
			-- BroadcastLua("rhook.DetachWall(Entity("..ply:EntIndex().."))")
			-- rhook.DetachWall(ply)
		-- end
	-- end
-- end)


//Change view angles.
hook.Add("StartCommand","rhook",function(ply,cmd)
	if ply.OnWall then

		//Change view angles.
		local wallnorm = ply.OnWall
		local mx,my = cmd:GetMouseX(), cmd:GetMouseY()

		local ang = cmd:GetViewAngles()

		//Remove normal mouse input. Stupid that we have to do this.
		ang = ang - Angle(my*.022,-mx*.022,0)

		//Rotate to our local angles
		-- local rot = math.abs(wallnorm.x+wallnorm.y)
		ang:RotateAroundAxis(wallnorm:Angle():Right(),90)

		// Add our own mouse input.
		ang.y = ang.y - mx*.022
		ang.p = ang.p + my*.022
		ang.p = math.Clamp(ang.p,-89,89)



		//Rotate playermodel
		if CLIENT then
			local mat = Matrix()
			local rot = ply.OnWall:Angle()
			local a = Angle(ang)
			a.y=0
			rot=rot-a

			local x,y = ply.OnWall.x, ply.OnWall.y
			local amt = -math.deg(math.atan2(y,x))
			rot:RotateAroundAxis(Vector(0,0,1),amt)

			mat:Rotate(rot)

			local maxs,mins = ply:GetHull()
			-- mat:Translate(ply.OnWall:Angle():Up()*-16)
			mat:Translate(ply.OnWall:Angle():Up()*-math.max(math.abs(mins.x),math.abs(maxs.x),math.abs(maxs.y),math.abs(mins.y)))

			ply:EnableMatrix("RenderMultiply",mat)
		end

		//Rotate back to world angles.
		ang:RotateAroundAxis(wallnorm:Angle():Right(),-90)
		cmd:SetViewAngles(ang)


	end
end)

hook.Add("SetupMove","rhook",function(ply,move,cmd)

	//setup movement
	local right = 0;
	local forward = 0;
	local maxspeed = ply:GetMaxSpeed()*2;
	if ply:Crouching() then
		maxspeed = ply:GetCrouchedWalkSpeed()*180
	end

	// forward/back
	if( cmd:KeyDown( IN_FORWARD ) ) then
		forward = forward + maxspeed;
	end
	if( cmd:KeyDown( IN_BACK ) ) then
		forward = forward - maxspeed;
	end

	// left/right
	if( cmd:KeyDown( IN_MOVERIGHT ) ) then
		right = right + maxspeed;
	end
	if( cmd:KeyDown( IN_MOVELEFT ) ) then
		right = right - maxspeed;
	end

	cmd:SetForwardMove( forward );
	cmd:SetSideMove( right );
	cmd:SetUpMove(0)

	move:SetMoveAngles(cmd:GetViewAngles(ang))

end)

local nextFootStepTime = CurTime()
local grav = GetConVar("sv_gravity")
hook.Add("Move","rhook",function( ply, move )
	if ply.OnWall then

		local dt = FrameTime()

		// Get information from the movedata
		local ang = move:GetMoveAngles()
		local pos = move:GetOrigin()
		local vel = move:GetVelocity()
		local mins,maxs = ply:GetHull()
		local tr = util.TraceHull( { start = pos, endpos = pos-ply.OnWall, filter = ply, mask=MASK_PLAYERSOLID, mins=ply:OBBMins(), maxs=ply:OBBMaxs()} )

		//Keys
		local acceleration = Vector()
		local forward = ply.OnWall:Cross(ang:Right())
		acceleration = acceleration + ( ang:Right() * move:GetSideSpeed() )
		acceleration = acceleration + forward * move:GetForwardSpeed()

		//Movement
		local accelSpeed = math.min( acceleration:Length(), ply:GetRunSpeed() );
		local accelDir = acceleration:GetNormal()
		acceleration = accelDir * accelSpeed * 3

		//Airaccel
		if !tr.Hit then
			acceleration = acceleration * .1
		else
			//Footsteps
			if (accelSpeed > 0) and IsFirstTimePredicted() then
				if ( tr.Hit ) then
					if CurTime()>nextFootStepTime then
						nextFootStepTime = CurTime() + .4
						PlayFootstep(ply,50,100,.4)
					end
				end
			end

			//Friction
			vel = vel * ( 0.98 - dt * 5 )

		end

		//Gravity:
		local gravity = -grav:GetFloat() * ply.OnWall
		acceleration = acceleration + gravity

		//Apply acceleration
		vel = vel + acceleration * dt

		//Correct frozen object walking.
		-- if tr.Hit then
			-- mul = tr.Entity:GetBrushPlaneCount() != nil
			-- mul = mul and tr.Entity:GetPhysicsObject():IsValid()
			-- mul = mul and !tr.Entity:IsWorld()
			-- if mul then
				-- vel = vel * 10
			-- end
		-- end

		//Jumping
		if IsFirstTimePredicted() then
			if move:KeyDown(IN_JUMP) then
				if ply.m_bSpacebarReleased then
					ply.m_bSpacebarReleased = false
					if ( tr.Hit ) then
						vel = vel + ply.OnWall * ply:GetJumpPower() * 2
						GAMEMODE:DoAnimationEvent(ply,PLAYERANIMEVENT_JUMP)
						ply.Jumped = CurTime()
						PlayFootstep(ply,40,100,.6)
					end
				end
			else
				ply.m_bSpacebarReleased = true
			end
		end

		//Window break
		if SERVER and rhook.BreakWindows then
			if tr.Hit and ply.Jumped and CurTime()-ply.Jumped > .1 then
				ply.Jumped = false
				if tr.Entity:IsValid() and tr.Entity:GetClass():find("func_breakable") then
					if tr.Entity:GetClass() == "func_breakable_surf" then
						tr.Entity:Fire("Shatter","0,0,0",0)
						tr.Entity:EmitSound(ShatterSound)
					else
						tr.Entity:Fire("RemoveHealth","50",0)
					end
				end
			end
		end

		//Collision checks
		pos,vel = CollisionClamp(pos,vel,ply,"x")
		pos,vel = CollisionClamp(pos,vel,ply,"y")
		pos,vel = CollisionClamp(pos,vel,ply,"z")

		//Max dist check
		if IsValid(ply.Hook) then
			local relpos = WorldToLocal(pos,ang,ply.Hook:GetPos(),ply.OnWall:Angle())
			local relvel = WorldToLocal(vel+pos,ang,ply.Hook:GetPos(),ply.OnWall:Angle()) - relpos
			local zdist = relpos.z+relvel.z*dt
			local maxXDist = math.min(rhook.MaxDist * -zdist/300, rhook.MaxDist)
			local maxZDist = -30

			-- print(relpos,relvel)
			//Above
			if zdist > maxZDist then
				relpos.z = maxZDist
				relvel.z = 0
			end

			//Sides
			if relpos.y + relvel.y * dt > maxXDist then
				relpos.y = maxXDist
				relvel.y = 0
			elseif relpos.y + relvel.y * dt < -maxXDist then
				relpos.y = -maxXDist
				relvel.y = 0
			end
			pos = LocalToWorld(relpos,ang,ply.Hook:GetPos(),ply.OnWall:Angle())
			vel = LocalToWorld(relvel+relpos,ang,ply.Hook:GetPos(),ply.OnWall:Angle()) - pos
		end

		//Apply changes
		move:SetVelocity( vel )
		move:SetOrigin( pos )


		//Change sounds
		if SERVER and rhook.ReelSound then
			local p = math.min(vel:Length(), 150)
			if p < 50 then p = 0 end
			ply.ReelSound:ChangePitch(p)
		end

		//Ignore default behavior
		return true
	end
end)

hook.Add("PlayerNoClip","rhook",function(ply,state)
	if ply.OnWall then
		return state == false
	end
end)


hook.Add("PlayerTick","rhook",function(ply,cmd)
	if ply.OnWall and IsValid(ply.Hook) then

		local hookpos=ply.Hook:GetPos()
		local pos = ply:GetPos()
		if pos:PlaneDistance(hookpos,ply.OnWall) < -25 then
			ply.Hook:Use(ply,ply,USE_ON,1)
		end

	end
end)

if CLIENT then
	hook.Add("Think", "rhook_camroll", function()
		local ply = LocalPlayer()
		if not ply:InVehicle() and not ply.OnWall then
			local a = ply:EyeAngles()
			if a.r != 0 then
				a.r = math.ApproachAngle(a.r, 0, FrameTime()*200)
				ply:SetEyeAngles(a)
			end
		end
	end)
end
