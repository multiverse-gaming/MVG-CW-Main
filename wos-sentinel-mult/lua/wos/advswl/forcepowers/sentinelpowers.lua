wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
	name = "Force Slow",
	icon = "SL",
	target = 1,
	distance = 300,
	description = "Slow your opponents movement",
	image = "wos/forceicons/push.png",
	cooldown = 30,
	manualaim = false,
	action = function( self )
		if ( self:GetForce() < 50 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) || !ent:IsPlayer() then return end
		self:SetForce( self:GetForce() - 50 )
		self:PlayWeaponSound( "lightsaber/force_repulse.wav" )

		ent:SetRunSpeed( ent:GetRunSpeed() - 70 )
		timer.Simple(7, function()
			ent:SetRunSpeed( ent:GetRunSpeed() + 70 )
		end)
		return true
	end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Force EMP",
    icon = "EMP",
    image = "wos/forceicons/icefuse/blind.png",
    cooldown = 35,
    manualaim = false,
    description = "Electromagnetic Pulse that hurts only droids",
    action = function( self )
        if ( self:GetForce() < 100 ) then return end
        local entpos = self.Owner:GetPos() + Vector(0, 0, 60)
        local entindex = self.Owner:EntIndex()

        timer.Create("tesla_zap" .. entindex,math.Rand(0.03,0.1), math.random(5, 10), function()
            local lightning = ents.Create( "point_tesla" )
            lightning:SetPos(entpos)
            lightning:SetKeyValue("m_SoundName", "")
            lightning:SetKeyValue("texture", "sprites/bluelight1.spr")
            lightning:SetKeyValue("m_Color", "255 255 150")
            lightning:SetKeyValue("m_flRadius", "350")
            lightning:SetKeyValue("beamcount_max", "15")
            lightning:SetKeyValue("thick_min", "15")
            lightning:SetKeyValue("thick_max", "30")
            lightning:SetKeyValue("lifetime_min", "0.3")
            lightning:SetKeyValue("lifetime_max", "0.4")
            lightning:SetKeyValue("interval_min", "0.15")
            lightning:SetKeyValue("interval_max", "0.25")
            lightning:Spawn()
            lightning:Fire("DoSpark", "", 0)
            lightning:Fire("kill", "", 0.2)

            local light = ents.Create("light_dynamic")
            light:SetPos( entpos )
            light:Spawn()
            light:SetKeyValue("_light", "100 100 255")
            light:SetKeyValue("distance","550")
            light:Fire("Kill","",0.20)
            sound.Play( "k_lab.teleport_spark" , entpos, 310)
        end)

        for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 300 ) ) do
            if v:IsValid() && v:IsNPC() then
                local npc = v:GetClass()
                if npc == "npc_antlionguard" || npc == "npc_antlion" || npc == "npc_zombie"
                || npc == "npc_rebel" || npc == "npc_zombie"
                || npc == "npc_poisonzombie" || npc == "npc_fastzombie_torso" || npc == "npc_fastzombie"
                || npc == "npc_headcrab" || npc == "npc_headcrab_black" then
                    -- Intenionally left empty.
                else
                    v:TakeDamage( 450, self.Owner, self )
                end
            end
        end

        self:SetForce( self:GetForce() - 100 )
        self:SetNextAttack( 1 )
        return true
    end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Saber Throw",
		icon = "T",
		image = "wos/forceicons/throw.png",
		cooldown = 3,
		manualaim = false,
		description = "Throws your lightsaber. It will return to you.",
		action = function(self)
			if self:GetForce() < 20 then return end
			self:SetForce( self:GetForce() - 20 )
			self:SetEnabled(false)
			self:SetBladeLength(0)
			self:SetNextAttack( 1 )
			self:GetOwner():DrawWorldModel(false)

			local ent = ents.Create("ent_lightsaber_thrown")
			ent:SetModel(self:GetWorldModel())
			ent:Spawn()
			ent.CustomSettings = table.Copy( self.CustomSettings )
			ent:SetBladeLength(self:GetMaxLength())
			ent:SetMaxLength(self:GetMaxLength())
			ent:SetBladeWidth( self:GetBladeWidth() )
			ent:SetCrystalColor(self:GetCrystalColor())
			ent:SetInnerColor( self:GetInnerColor() )
			ent:SetDarkInner( self:GetDarkInner() )
			ent:SetWorldModel( self:GetWorldModel() )
			ent.SaberThrowDamage = self.SaberThrowDamage

			local pos = self:GetSaberPosAng()
			ent:SetPos(pos)
			pos = pos + self:GetOwner():GetAimVector() * 750
			ent:SetEndPos(pos)

			ent:SetOwner(self:GetOwner())
			return true
		end
})
wOS.ForcePowers:RegisterNewPower({
		name = "Fold Space",
		icon = "TP",
		description = "Phase to a new location.",
		image = "wos/forceicons/icefuse/teleport.png",
		cooldown = 25,
		manualaim = false,
		action = function( self )
			if ( self:GetForce() < 100 ) then return end
			local bFoundEdge = false;
			local hullTrace = util.TraceHull({
				start = self.Owner:EyePos(),
				endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 900, -- Half of the nerf - it was 3000
				filter = self.Owner,
				mins = Vector(-16, -16, 0),
				maxs = Vector(16, 16, 9)
			});

			local groundTrace = util.TraceEntity({
				start = hullTrace.HitPos + Vector(0, 0, 1),
				endpos = hullTrace.HitPos - (self.Owner:EyePos() - self.Owner:GetPos()),
				filter = self.Owner
			}, self.Owner);

			local edgeTrace;
			if (hullTrace.Hit and hullTrace.HitNormal.z <= 0) then
				local ledgeForward = Angle(0, hullTrace.HitNormal:Angle().y, 0):Forward();
				edgeTrace = util.TraceEntity({
					start = hullTrace.HitPos - ledgeForward * 33 + Vector(0, 0, 40),
					endpos = hullTrace.HitPos - ledgeForward * 33,
					filter = self.Owner
				}, self.Owner);
					if (edgeTrace.Hit and !edgeTrace.AllSolid) then
					local clearTrace = util.TraceHull({
						start = hullTrace.HitPos,
						endpos = hullTrace.HitPos + Vector(0, 0, 35),
						mins = Vector(-16, -16, 0),
						maxs = Vector(16, 16, 1),
						filter = self.Owner
					});
					bFoundEdge = !clearTrace.Hit;
				end;
			end;

			local endPos = ( bFoundEdge and edgeTrace.HitPos ) or groundTrace.HitPos;
			self.Owner:SetPos( endPos )
			self.Owner:EmitSound("ambient/energy/zap" .. math.random(1, 2) .. ".wav");

			-- Original debuff
			--[[
			originalRunSpeed = self:GetOwner():GetRunSpeed() -- Other half of the nerf.
			originalWalkSpeed = self:GetOwner():GetWalkSpeed()
			self:GetOwner():SetRunSpeed( 10 )
			self:GetOwner():SetWalkSpeed( 10 )
			timer.Simple(1,	function ()
				self:GetOwner():SetRunSpeed( originalRunSpeed )
				self:GetOwner():SetWalkSpeed( originalWalkSpeed )
			end)]]--
			
			-- New debuff
			self.Owner:SetNW2Float( "wOS.DisorientTime", CurTime() + 1 )
			self.Owner:SetNW2Float( "wOS.SaberAttackDelay", CurTime() + 1 )

			self:SetForce( self:GetForce() - 100 )
			return true
		end,
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Light",
	icon = "L",
	image = "wos/forceicons/lightstream.png",
	cooldown = 15,
	description = "You generate light through the force",
	action = function( self )
		if ( self:GetForce() < 30 ) then return end
			self:SetForce(self:GetForce() - 30)
			local light = ents.Create("light_dynamic")
            light:SetPos( self:GetOwner():GetPos() )
			light:SetParent(self:GetOwner())
            light:Spawn()
            light:SetKeyValue("_light", "255 160 66")
            light:SetKeyValue("distance","3000")
            light:Fire("Kill","",15)
    		self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Force Breach",
	icon = "BR",
	description = "Make a path",
	image = "wos/forceicons/icefuse/breach.png",
	cooldown = 1,
	manualaim = false,
	action = function( self )
		if self:GetForce() < 30 then return end
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			if not IsValid( tr.Entity ) then return end
			local entityClass = tr.Entity:GetClass()

			-- Just opens or closes doors.
            if (entityClass == "func_door" || entityClass == "prop_door_rotating" || entityClass == "func_door_rotating") then
                tr.Entity:Fire("unlock", "", 0)
                tr.Entity:Fire("toggle","", 0)
                self:SetForce( self:GetForce() - 30 )
                self:SetNextAttack( 1 )
    			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
                return true
			end
		end,
})

wOS.ForcePowers:RegisterNewPower({
		name = "Force Blind",
		icon = "FB",
		image = "wos/forceicons/icefuse/blind.png",
		cooldown = 70,
		target = 1,
		distance = 1200,
		manualaim = true,
		description = "Make your escape or final blow",
		action = function( self )
			if ( self:GetForce() < 75 ) then return end
			local ply = self:SelectTargets( 1 )[ 1 ]
			if not IsValid( ply ) then return end
			if not ply:IsPlayer() then return end
			if not ply:Alive() then return end
			if ply == self.Owner then return end
			ply:SetNW2Float( "wOS.BlindTime", CurTime() + 7 )

			self.Owner:SetNW2Float( "wOS.ForceAnim", CurTime() + 0.5 )
			self:SetForce( self:GetForce() - 75 )
			self:SetNextAttack( 0.5 )
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Cloak",
		icon = "C",
		image = "wos/forceicons/advanced_cloak.png",
		cooldown = 30,
		description = "Shrowd yourself with the force for 15 seconds",
		action = function( self )
			if (self:GetCloaking()) then
				-- If cloaking, go on CD and turn cloak off so you can attack.
				self.CloakTime = CurTime()
				self:GetOwner():SetNoTarget(false)
				return true
			end
			if ( self:GetForce() < 75) then return end

			self:SetForce( self:GetForce() - 75 )
			self:SetNextAttack( 0.7 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )

			self.CloakTime = CurTime() + 15
			-- Look up timer.Create and see delay and repitions in the arguments. You will see why it's like this.
			timer.Create("wos.Custom.Cloaking." .. self:GetOwner():SteamID64(), 0.25, 40 + 1, function() 
				if self:GetCloaking() then 
					if self.Owner:GetVelocity():Length() > 130 then
						self:GetOwner():SetNoTarget(false)
					else
						self:GetOwner():SetNoTarget(true)
					end
				else
					self:GetOwner():SetNoTarget(false)
				end	
			end)

			timer.Simple(15, function()
				if self:GetCloaking() then
					self:SetCloaking(false)
				end
				self:GetOwner():SetNoTarget(false)
			end)
		end
})