
--[[-------------------------------------------------------------------
	Lightsaber Blink SWEP Hooks:
		We need this to get the Blink SWEP properly working as a force ability
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
 _____         _                 _            _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
----------------------------- Copyright 2017, David "King David" Wiltos ]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
-- Copyright 2017, David "King David" Wiltos ]]--

-- This is pretty much just for the hold fold space.
--[[
local mat = CreateMaterial("wOS.blinkGlow7", "UnlitGeneric", {
	["$basetexture"] = "particle/particle_glow_05",
	["$basetexturetransform"] = "center .5 .5 scale 1 1 rotate 0 translate 0 0",
	["$additive"] = 1,
	["$translucent"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$ignorez"] = 0
});

local mat2 = CreateMaterial("wOS.blinkBottom", "UnlitGeneric", {
	["$basetexture"] = "particle/particle_glow_05",
	["$basetexturetransform"] = "center .5 .5 scale 1 1 rotate 0 translate 0 0",
	["$additive"] = 1,
	["$translucent"] = 1,
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$ignorez"] = 1
});

local cyan = Color(150, 210, 255);
local globalbotvis, globaltopvis]]--

-- This is pretty much just for the hold fold space.
--[[
hook.Add( "PostDrawOpaqueRenderables", "wOS.BlinkCamHook", function()
	if LocalPlayer():GetNW2Float( "wOS.ShowBlink", 0 ) < CurTime() then return end;
			local bFoundEdge = false;

			local hullTrace = util.TraceHull({
				start = LocalPlayer():EyePos(),
				endpos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 2400,
				filter = LocalPlayer(),
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 9)
			});

			local groundTrace = util.TraceHull({
				start = hullTrace.HitPos + Vector(0, 0, 1),
				endpos = hullTrace.HitPos - Vector(0, 0, 1000),
				filter = LocalPlayer(),
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 1)
			});

			local edgeTrace;

			if (hullTrace.Hit and hullTrace.HitNormal.z <= 0) then
				local ledgeForward = Angle(0, hullTrace.HitNormal:Angle().y, 0):Forward();
				edgeTrace = util.TraceEntity({
					start = hullTrace.HitPos - ledgeForward * 33 + Vector(0, 0, 40),
					endpos = hullTrace.HitPos - ledgeForward * 33,
					filter = LocalPlayer()
				}, LocalPlayer());

				if (edgeTrace.Hit and !edgeTrace.AllSolid) then
					local clearTrace = util.TraceHull({
						start = hullTrace.HitPos,
						endpos = hullTrace.HitPos + Vector(0, 0, 35),
						mins = Vector(-16, -16, 0),
						maxs = Vector(16, 16, 1),
						filter = LocalPlayer()
					});

					if (!clearTrace.Hit) then
						groundTrace.HitPos = edgeTrace.HitPos;
						bFoundEdge = true;
					end;
				end;
			end;

			local distToGround = math.abs(hullTrace.HitPos.z - groundTrace.HitPos.z);
			local upDist = vector_up * 1.1;
			local quadPos = groundTrace.HitPos + upDist;

			local quadTrace = util.TraceLine({
				start = EyePos(),
				endpos = quadPos,
				filter = LocalPlayer()
			});

			local bottomVis = util.PixelVisible(quadPos, 3, util.GetPixelVisibleHandle());

			local visAlpha = math.Clamp(255, 0, 255);

			if (visAlpha > 0 and !quadTrace.Hit) then
				render.SetMaterial(mat2);
				render.DrawSprite(quadPos, 150, 150, ColorAlpha(cyan, visAlpha), bottomVis);
			end;

			render.SetMaterial(mat);
			render.DrawQuadEasy(quadPos, vector_up, 150, 150, cyan, 0);
			render.DrawQuadEasy(quadPos + upDist, -vector_up, 150, 150, cyan, 0);

			if (distToGround >= 10 and !bFoundEdge) then
				local mappedAlpha = math.Remap(distToGround, 0, 400, 255, 0);
				local mappedUV = math.max(math.Remap(distToGround - 100, 0, 700, 0.5, 1), 0);
				local midPoint = LerpVector(0.5, hullTrace.HitPos, quadPos);

				render.DrawBeam(hullTrace.HitPos, midPoint, 50, 0.5, mappedUV, ColorAlpha(cyan, math.Clamp(mappedAlpha, 0, 255)));
				render.DrawBeam(midPoint, quadPos, 50, mappedUV, 0.5, ColorAlpha(cyan, math.Clamp(mappedAlpha, 0, 255)));

				local visAlpha = math.Clamp(255, 0, 255);

				if (visAlpha > 0) then
					local newCol = ColorAlpha(cyan, visAlpha);
					render.SetMaterial(mat2);
					render.DrawSprite(hullTrace.HitPos, 100, 100, newCol);
					render.DrawSprite(hullTrace.HitPos, 100, 100, newCol);
				end;

			else
				render.SetMaterial(mat);
				render.DrawBeam(quadPos, groundTrace.HitPos + Vector(0, 0, 300), 50, 0.5, 1, cyan);
			end;
end )]]--

--[[
hook.Add( "RenderScreenspaceEffects", "wOS.DisorientForEmerald2", function()
	if LocalPlayer():GetNW2Float( "wOS.DisorientTime", 0 ) < CurTime() then return end
	local compare = LocalPlayer():GetNW2Float( "wOS.DisorientTime", 0 ) - CurTime()
	
	DrawMotionBlur( 1 - 1/7*compare, 1.0, 0.0 )
	
	local ColorModify = {}
	ColorModify[ "$pp_colour_addr" ] 		= 0
	ColorModify[ "$pp_colour_addg" ] 		= 0
	ColorModify[ "$pp_colour_addb" ] 		= 0
	ColorModify[ "$pp_colour_mulr" ] 		= 0
	ColorModify[ "$pp_colour_mulg" ] 		= 0
	ColorModify[ "$pp_colour_mulb" ] 		= 0
	ColorModify[ "$pp_colour_brightness" ] 	= -0.1*compare
	ColorModify[ "$pp_colour_contrast" ] 	= 1 + 1.3*compare
	ColorModify[ "$pp_colour_colour" ] 		= 1 - 0.1*compare
	
	DrawColorModify( ColorModify )
	
end )
]]--
hook.Add( "RenderScreenspaceEffects", "wOS.BlindScreenFuck", function()
	if LocalPlayer():GetNW2Float( "wOS.BlindTime", 0 ) < CurTime() then return end
	local compare = ( LocalPlayer():GetNW2Float( "wOS.BlindTime", 0 ) - CurTime() )/15
	
	local ColorModify = {}
	ColorModify[ "$pp_colour_addr" ] 		= 0
	ColorModify[ "$pp_colour_addg" ] 		= 0
	ColorModify[ "$pp_colour_addb" ] 		= 0
	ColorModify[ "$pp_colour_mulr" ] 		= 0
	ColorModify[ "$pp_colour_mulg" ] 		= 0
	ColorModify[ "$pp_colour_mulb" ] 		= 0	
	ColorModify[ "$pp_colour_brightness" ] 	= -1.2*compare
	ColorModify[ "$pp_colour_contrast" ] 	= 1 + 1.3*compare
	ColorModify[ "$pp_colour_colour" ] 		= 1 - 1*compare
	
	DrawColorModify( ColorModify )
	
end )