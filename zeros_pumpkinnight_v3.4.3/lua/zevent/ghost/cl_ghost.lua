/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if SERVER then return end
zpn = zpn or {}
zpn.Ghost = zpn.Ghost or {}

/*
	Initializes the Ghost entity
*/
function zpn.Ghost.Initialize(Ghost)
	zclib.EntityTracker.Add(Ghost)
	Ghost.LastHealth = 9999999
	Ghost.LastState = -1
end

/*
	Gets called when the ghost getting removed
*/
function zpn.Ghost.OnRemove(Ghost)
	Ghost:StopParticles()
	Ghost:StopSound("zpn_tornado_sfx")
end

/*
	Called when the ghost is being drawn
*/
function zpn.Ghost.Draw(Ghost)
	if zclib.util.InDistance(LocalPlayer():GetPos(), Ghost:GetPos(), 1000) then
		zpn.Ghost.HealthBar(Ghost)
	end
end

/*
	Called each frame
*/
function zpn.Ghost.OnThink(Ghost)
	local curState = Ghost:GetActionState()

	if Ghost.LastState ~= curState then Ghost.LastState = curState end

	zclib.util.LoopedSound(Ghost, "zpn_tornado_sfx", Ghost.LastState == 5)

	if Ghost.LastState == 3 then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

		local curHealth = Ghost:GetMonsterHealth()
		if curHealth ~= Ghost.LastHealth then

			if curHealth < Ghost.LastHealth then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

				// Ghost got Damaged
				zpn.Ghost.PlayMultiSequence(Ghost, zpn.Theme.Ghost.anim[ "hit" ], zpn.Theme.Ghost.anim[ "paralize_loop" ])
				Ghost:EmitSound("zpn_ghost_woow")
			end

			Ghost.LastHealth = curHealth
		end
	end
end

function zpn.Ghost.HealthBar(Ghost)
	cam.Start3D2D(Ghost:LocalToWorld(Vector(0,0,125 + (1 * math.abs(math.sin(CurTime()) * 1)))), zclib.HUD.GetLookAngles(), 0.1)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zpn.Theme.Design.icon_health_bar_bg)
		surface.DrawTexturedRect(-200, 25 ,400, 50)

		local hbar = (400 / zpn.config.Ghost.Health) * Ghost:GetMonsterHealth()
		draw.RoundedBox(5, -200, 25 ,hbar, 50, zpn.Theme.Design.color_health)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- eeef1f9bffac53aeb6f93177fbce2d95804c17ead173d13b94d501d399d51bb4
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

		surface.SetDrawColor(zpn.default_colors["white02"])
		surface.SetMaterial(zpn.Theme.Design.icon_health_bar_alpha)
		surface.DrawTexturedRect(-200, 25 ,400, 50)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198018619040

	cam.End3D2D()
end

function zpn.Ghost.PlayMultiSequence(Ghost,seq01, seq02)

	// Play first animation
	zclib.Animation.Play(Ghost, seq01, 1)

	local timerid = "Ghost_" .. Ghost:EntIndex() .. "_animtimer"

	// Remove anim timer if exist
	zclib.Timer.Remove(timerid)

	// Play next animation after first anim finished
	zclib.Timer.Create(timerid, Ghost:SequenceDuration(Ghost:GetSequence()), 1, function()
		zclib.Timer.Remove(timerid)
		if not IsValid(Ghost) then return end
		if Ghost.LastState == 0 then return end
		zclib.Animation.Play(Ghost, seq02, 1)
	end)
end
