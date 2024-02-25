
AddCSLuaFile()

SWEP.ViewModelBoneMods = {
	["Base"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 0, 0 ) }
}

function SWEP:sckInit()

	if ( GetConVarNumber( "sfw_allow_sck" ) ~= 1 ) then return end

	if CLIENT then
	
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements)
		self:CreateModels(self.WElements)
		
		if ( IsValid(self.Owner) ) and ( self.Owner:IsPlayer() ) then
			local vm = self.Owner:GetViewModel()
			if ( IsValid(vm) ) then
				self:ResetBonePositions(vm)
				
				if ( self.ShowViewModel == nil or self.ShowViewModel ) then
					vm:SetColor( Color( 255, 255, 255, 255 )  )
				else
					vm:SetColor( Color( 255, 255, 255, 0 ) )
					vm:SetMaterial( "Debug/hsv" )			
				end
			end
		end
		
	end

end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetTexture( self.WepSelectIcon )

	y = y + 10
	x = x + 50
	wide = wide / 2

	surface.DrawTexturedRect( x, y,	wide, wide )

	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )

end

function SWEP:PreDrawViewModel( vm, ply, wep )

	vm:SetSubMaterial( 0, self.SciFiSkin )
	vm:SetSubMaterial( 1, self.SciFiSkin_1 )
	vm:SetSubMaterial( 2, self.SciFiSkin_2 )
	vm:SetSubMaterial( 3, self.SciFiSkin_3 )
	vm:SetSubMaterial( 4, self.SciFiSkin_4 )
	
end

function SWEP:OnRemove()

	if ( IsValid( self.Owner ) && CLIENT && self.Owner:IsPlayer() ) then
		local vm = self.Owner:GetViewModel()
		if ( IsValid( vm ) ) then 
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
			vm:SetSubMaterial( 3, "" )
			vm:SetSubMaterial( 4, "" )
			
			self:ResetBonePositions(vm)
		end
	end
	
end

if CLIENT then
local vmAngleDelayed = Angle( 0, 0, 0 )
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		if ( !IsValid( self.Owner ) || !IsValid( self ) ) then DevMsg( "@SciFiRender : !Error; Failed to verify owner or weapon." ) end
		
		if ( self.AdsBlur ) && ( GetConVarNumber( "sfw_allow_adsblur" ) == 1 && self:GetNWBool( "SciFiAds" ) ) then
			DrawToyTown( self.AdsBlurIntensity, self.AdsBlurSize )
		end
		
		if ( GetConVarNumber( "sfw_allow_renderacc" ) == 1 ) then
			self:AddAcc()
		end
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then

			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif ( v.type == "Sprite" || v.type == "Quad" || v.type == "Laser" ) then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.smaterial1 == "") then
					model:SetSubMaterial( 0, "" )
				elseif (model:GetMaterial() != v.smaterial1) then
					model:SetSubMaterial( 0, v.smaterial0 )
					model:SetSubMaterial( 1, v.smaterial1 )
					model:SetSubMaterial( 2, v.smaterial2 )
					model:SetSubMaterial( 3, v.smaterial3 )
					model:SetSubMaterial( 4, v.smaterial4 )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
				
			elseif ( v.type == "Laser" ) then

				if ( v.disabled ) then continue end
			
				local laser_color1 = Color( v.color.r, v.color.g, v.color.b, 115)
				local laser_color2 = Color( v.color.r, v.color.g, v.color.b, 225)
				local laser_color3 = Color( v.color.r, v.color.g, v.color.b, 60)
				
				if ( !v.range ) then
					v.range = 8192
				end

				--local mObject = vm:LookupBone( v.bone )
				local mPosition, mAngles = pos, ang --vm:GetBonePosition( mObject )
				local mOffset = v.pos
				local fw, rt, up = mAngles:Forward(), mAngles:Right(),  mAngles:Up()
				
				mAngles:RotateAroundAxis( up, v.angle.y )
				mAngles:RotateAroundAxis( rt, v.angle.p )
				mAngles:RotateAroundAxis( fw, v.angle.r )
				
				local mDirection = mAngles:Forward()

				local mOrigin = mPosition + fw * mOffset.x + rt * mOffset.y + up * mOffset.z
				
				local lasertrace = util.TraceLine( {
					start = mOrigin,
					endpos = mOrigin + mDirection * v.range,
					filter = function( ent ) if ( ent == self.Owner || ent:GetOwner() == self.Owner ) then return false else return true end end,
					mask = MASK_SHOT
				} )

				vmAngleDelayed = LerpAngle( 0.8, vmAngleDelayed, ang ) 
				
				local lAngles = ang.pitch + ang.yaw + ang.roll
				local mDelayed = vmAngleDelayed.pitch + vmAngleDelayed.yaw + vmAngleDelayed.roll

				local mBlurRaw = math.Round( math.abs( lAngles - mDelayed ) / 1, 2 )
				local mBlur = math.Clamp( mBlurRaw, 0, 4.2 ) + 1

				render.SetMaterial( self.mat_laser_glow )
				render.DrawSprite( lasertrace.StartPos, v.dot_size, v.dot_size, laser_color2 )
				if ( lasertrace.Hit && !lasertrace.HitSky ) then
					render.DrawSprite( lasertrace.HitPos, v.dot_size, v.dot_size, laser_color2 )
				end
				
				render.SetMaterial( self.mat_laser_haze )
				render.DrawBeam( lasertrace.HitPos, lasertrace.HitPos - mDirection * 4 * v.dot_size, v.haze_size, 0, 1, laser_color1 )
				
				render.SetMaterial( self.mat_laser_line )
				render.DrawBeam( lasertrace.StartPos, lasertrace.HitPos, v.line_size * mBlur, 0, 1, laser_color3 )
			end
			
		end
		
		self:AddVStatsDisp()

	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
	
		if ( GetConVarNumber( "sfw_allow_renderacc" ) == 1 ) then
			self:AddWAcc()
		end
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if ( self.SciFiWorld ~= nil ) then
			self:SetMaterial( self.SciFiWorld )
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif ( v.type == "Sprite" || v.type == "Quad" || v.type == "Laser" ) then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do

			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end

			if ( !pos ) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial

			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
				
			elseif ( v.type == "Laser" ) then
				
				if ( v.disabled ) then continue end
				
				local laser_color1 = Color( v.color.r, v.color.g, v.color.b, 115)
				local laser_color2 = Color( v.color.r, v.color.g, v.color.b, 225)
				local laser_color3 = Color( v.color.r, v.color.g, v.color.b, 80)
				
				if ( !v.range ) then
					v.range = 8192
				end

				local mObject = bone_ent:LookupBone( v.bone )
				local mPosition, mAngles = pos, ang --bone_ent:GetBonePosition( mObject )
				local mOffset = v.pos
				local fw, rt, up = mAngles:Forward(), mAngles:Right(),  mAngles:Up()
				
				mAngles:RotateAroundAxis( up, v.angle.y )
				mAngles:RotateAroundAxis( rt, v.angle.p )
				mAngles:RotateAroundAxis( fw, v.angle.r )
				
				local mDirection = mAngles:Forward()

				local mOrigin = mPosition + fw * mOffset.x + rt * mOffset.y + up * mOffset.z
				
				local lasertrace = util.TraceLine( {
					start = mOrigin,
					endpos = mOrigin + mDirection * v.range,
					filter = function( ent ) if ( ent == self.Owner || ent:GetOwner() == self.Owner ) then return false else return true end end,
					mask = MASK_SHOT
				} )
				
				render.SetMaterial( self.mat_laser_glow )
				render.DrawSprite( lasertrace.HitPos, v.dot_size, v.dot_size, laser_color2 )
				render.DrawSprite( lasertrace.StartPos, v.dot_size, v.dot_size, laser_color2 )
				
				render.SetMaterial( self.mat_laser_haze )
				render.DrawBeam( lasertrace.HitPos, lasertrace.HitPos - mDirection * 4 * v.dot_size, v.haze_size, 0, 1, laser_color1 )
				
				render.SetMaterial( self.mat_laser_line )
				render.DrawBeam( lasertrace.StartPos, lasertrace.HitPos, v.line_size, 0, 1, laser_color3 )
			end
			
		end
		
		if ( GetConVarNumber( "sfw_allow_renderacc" ) == 1 ) then
			self:AddRPGAcc()
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel( v.model, RENDERGROUP_VIEWMODEL ) --RENDER_GROUP_VIEW_MODEL_OPAQUE) --Fix for incorrect lighting on sck viewmodels.
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos( self:GetPos() )
					v.modelEnt:SetAngles( self:GetAngles() )
					v.modelEnt:SetParent( self )
					v.modelEnt:SetNoDraw( true )
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end
	
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v)
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end