
AddCSLuaFile()
if SERVER then
	-- util.AddNetworkString("grapple_stopsound")
end

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName = "Grappling Hook"
ENT.Author = "Bobblehead"
ENT.Information = "A grappling hook for ninja shit."
ENT.Category = "Other"

ENT.Editable = false
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

-- local LandSound = Sound( "weapons/crossbow/hit1.wav" )
local LandSound = Sound( "bobble/grapple_hook/grappling_hook_impact.mp3" )
local FailSound = Sound( "weapons/hegrenade/he_bounce-1.wav" )


function ENT:Initialize()
	self:SetModel("models/props_junk/meathook001a.mdl")
	self:SetModelScale(.5)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetFlying(true)
	
	if SERVER then
		self:SetUseType(SIMPLE_USE)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:GetPhysicsObject():SetMass(1)
		-- self:GetPhysicsObject():SetDragCoefficient( 5 )
	else
		-- sound.PlayFile( "sound/bobble/cable_whip.mp3", "3d", function( station )
			-- if ( IsValid( station ) ) then
				-- self.ropesound = station
				-- station:SetPos(self:GetPos())
				-- station:Play()
			-- end
		-- end )
	end
end

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 9, "Flying" );
	self:NetworkVar( "Entity", 9, "User" );
end

function ENT:Think()
	if SERVER then
		if self:GetFlying() and self:GetVelocity():LengthSqr() < 2 then
			self:Remove()
		end
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:PhysicsCollide(data,obj)
	local other = data.HitEntity
	if other:IsWorld() or !other:GetPhysicsObject():IsMotionEnabled() then
		
		local norm = data.HitNormal
		norm.z = math.Round(norm.z,2)
		local tooclose = util.TraceLine({start=self:GetPos(),endpos=self:GetPos()+Vector(0,0,-1)*80,filter=self,mask=MASK_SOLID_BRUSHONLY}).Hit
		
		if norm.z != 0 or tooclose then
			self:EmitSound(FailSound)
		else
			-- net.Start("grapple_stopsound")
				-- net.WriteEntity(self)
			-- net.Broadcast()
			
			self:PhysicsDestroy()
			self.OnWall=-norm
			self:SetPos(data.HitPos-norm)
			local ang = norm:Angle()
			ang:RotateAroundAxis(data.HitNormal,145)
			ang:RotateAroundAxis(data.HitNormal:Angle():Right(),0)
			ang:RotateAroundAxis(data.HitNormal:Angle():Up(),-90)
			self:SetAngles(ang)
			self:EmitSound(LandSound, 80, 100, 1)
			-- timer.Simple(.1,function()
				-- if self:IsValid() then
					self:SetFlying(false)
				-- end
			-- end)
			
			-- local rope = constraint.CreateKeyframeRope( self:GetPos(), 2, "cable/cable2", self, self, Vector(0,0,0),0, self:GetOwner(), (self:GetOwner().OnWall or Vector(0,0,1))*20, 0, {Collide = 1} )
		end
		
	end
end
if CLIENT then
	-- net.Receive("grapple_stopsound",function()
		-- local hook = net.ReadEntity()
		-- if IsValid(hook.ropesound) then
			-- hook.ropesound:Stop()
		-- end
	-- end)
end

function ENT:OnRemove()
	if IsValid(self:GetUser()) then
		rhook.DetachWall(self:GetUser())
	end
end

function ENT:Use(ply)
	if self:GetFlying() then return end
	if IsValid(self:GetUser()) and self:GetUser() != ply then //One user per hook.
		return
	end
	
	local normal = self.OnWall
	local last = self:GetUser()
	if ply == self:GetUser() or (IsValid(self:GetUser()) and self:GetUser().OnWall) then
		rhook.DetachWall(ply)
		ply.Hook = NULL
		ply:SetNWEntity("Hook",NULL)
		
	end
	
	if last == ply then
		self:SetUser(NULL)
	else
		
		local tooclose = util.TraceHull({start=self:GetPos()+normal*72,endpos=self:GetPos()+normal*72+Vector(0,0,-80),mins=Vector(-36,-36,0),maxs=Vector(36,36,8),filter={ply,self},mask=MASK_SOLID}).Hit
		
		if !tooclose then
			self:SetUser(ply)
			ply.Hook = self
			ply:SetNWEntity("Hook",self)
			
			if !ply.OnWall then
				rhook.AttachWall(ply,normal)
			end
		else
			self:EmitSound(FailSound)
		end
	end
end

hook.Add("FindUseEntity","Grapple_hook",function(ply,ent)
	
	if IsValid(ply.Hook) then return ply.Hook end
	for k,v in pairs(ents.FindByClass("ent_grapplehook")) do
		
		if IsValid(v:GetUser()) and v:GetUser() != ply then //One user per hook.
			continue
		end
		
		local start = v:GetPos()+v:GetUp()*10-v:GetRight()*2
		local tr = util.TraceLine({start=start,endpos=start+Vector(0,0,-1)*10000,mask=MASK_SOLID_BRUSHONLY})
		
		local dist = util.DistanceToLine( start, tr.HitPos+Vector(0,0,40), ply:GetShootPos() )
		
		if dist < 70 then
			return v
		end
	end
end)
 
local spool = { model = "models/props/de_prodigy/spoolwire.mdl", bone = "ValveBiped.Bip01_Spine", pos = Vector(0.414, 3.697, -2.372), angle = Angle(-8.183, -15.195, -1.17), size = Vector(0.041, 0.041, 0.076) }
hook.Add("PostDrawTranslucentRenderables","Grapple_hook",function(skybox)
	if not skybox then
		for k,v in pairs(ents.FindByClass("ent_grapplehook"))do
			local user = v:GetUser()
			render.SetMaterial(Material("cable/cable2"))
			local start = v:GetPos()+v:GetUp()*10-v:GetRight()*2
			if IsValid(user) and user.OnWall then //Connect wire to player
				
				user.spool = user.spool or ClientsideModel(spool.model)
				local scale = Matrix()
				scale:Scale(spool.size)
				user.spool:EnableMatrix("RenderMultiply",scale)
				local bone = user:LookupBone(spool.bone)
				if not bone then return end
				local bpos,bang = user:GetBonePosition(bone)
				spool.pos = bpos + Vector(0.414, 3.697, -2.372)
				spool.angle= bang + Angle(-8.183, -15.195, -1.17)
				render.Model(spool,user.spool)
				
				render.SetMaterial(Material("cable/cable2"))
				render.DrawBeam( start, spool.pos+spool.angle:Up()*2, 1, 1, 0, color_white )
				
			elseif not v:GetFlying() or not IsValid(v:GetOwner()) then //Dangle wire
				local tr = util.TraceLine({start=start,endpos=start+Vector(0,0,-1)*10000,mask=MASK_SOLID_BRUSHONLY})
				local endpos = tr.HitPos
				endpos.z = math.min(endpos.z+40,start.z)
				render.DrawBeam( start, endpos, 1, 1, 0, color_white )
			elseif v:GetFlying() then //Connect wire to weapon
				local ply = v:GetOwner()
				if EyePos() == ply:GetShootPos() and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "weapon_grapplehook" then --first person
					local bpos,bang = ply:GetViewModel():GetBonePosition(ply:GetViewModel():LookupBone("ValveBiped.Crossbow_base"))
					bpos=bpos + bang:Up() * 3
					render.DrawBeam( start, bpos, 1, 1, 0, color_white )
				else
					local b = ply:GetAttachment(2)
					if b then
						local bpos,bang = b.Pos,b.Ang
						bpos=bpos + bang:Up()*4 + bang:Forward()*8
						render.DrawBeam( start, bpos, 1, 1, 0, color_white )
					end
				end
				
			end
		end
	end
end)