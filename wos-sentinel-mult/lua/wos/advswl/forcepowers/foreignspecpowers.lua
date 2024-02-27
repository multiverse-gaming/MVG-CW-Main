wOS = wOS or {}
wOS.ForcePowers = wOS.ForcePowers or {}

wOS.ForcePowers:RegisterNewPower({
		name = "Guardian Saber Throw",
		icon = "T",
		image = "wos/forceicons/throw.png",
		cooldown = 5,
		manualaim = false,
		description = "Throws your lightsaber. It will return to you.",
		action = function(self)
			if self:GetForce() < 50 then return end
			self:SetForce( self:GetForce() - 50 )
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
	name = "Guardian Force Shield",
	icon = "FS",
	image = "wos/forceicons/group_heal.png",
	cooldown = 180,
	description = "Protect yourself and those behind you.",
	action = function( self )
		if ( self:GetForce() < 100 || CLIENT || !self:GetOwner():IsOnGround() ) then return end
			self:SetForce(self:GetForce() - 100)
			local shield = ents.Create("prop_dynamic")
			shield:SetModel("models/hunter/plates/plate2x2.mdl")
			shield:SetMaterial("models/props_combine/stasisfield_beam")
			shield:SetColor(Color(0, 161, 255, 140))
			shield:SetPos(self:GetOwner():GetPos() + self:GetOwner():EyeAngles():Up() * 50 + self:GetOwner():EyeAngles():Forward() * 40)
			shield:SetAngles(self:GetOwner():EyeAngles() + Angle(90, 0, 0))
			shield:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
			shield:SetSolid(SOLID_BSP)
			shield:AddEffects(EF_NOSHADOW)
			shield:Spawn()
			shield:Activate()

			timer.Simple(15, function()
				if shield:IsValid() then
					shield:Remove()
				end
			end)

			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Sentinel Charge",
		icon = "CH",
		distance = 1200,
		image = "wos/forceicons/charge.png",
		target = 1,
		cooldown = 5,
		manualaim = true,
		description = "Lunge at your enemy",
		action = function( self )
			local ent = self:SelectTargets( 1, 1000 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 20 ) then self:SetNextAttack( 0.2 ) return end
			local newpos = ( ent:GetPos() - self:GetOwner():GetPos() )
			newpos = newpos / newpos:Length()
			self:GetOwner():SetLocalVelocity( newpos*500 + Vector( 0, 0, 275 ) )
			self:SetForce( self:GetForce() - 30 )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
        	self:GetOwner():SetSequenceOverride( "ryoku_a_left_t1", 3 )
			self:SetNextAttack( 0.9 )
			self.AerialLand = false
			return true
		end
})

wOS.ForcePowers:RegisterNewPower({
		name = "Sentinel Heal",
		icon = "H",
		image = "wos/forceicons/heal.png",
		cooldown = 0,
		target = 1,
		manualaim = false,
		description = "Heal yourself.",
		action = function( self )
			if ( self:GetForce() < 3 or self:GetOwner():Health() >= self:GetOwner():GetMaxHealth() or CLIENT ) then return end
			self:SetForce( self:GetForce() - 3 )

			self:SetNextAttack( 0.2 )

			local ed = EffectData()
			ed:SetOrigin( self:GetOwner():GetPos() )
			util.Effect( "rb655_force_heal", ed, true, true )

			self:GetOwner():SetHealth( self:GetOwner():Health() + 5 )
			self:GetOwner():Extinguish()
		end
})

wOS.ForcePowers:RegisterNewPower({
	name = "Consular Hardened Force Push",
	icon = "CFP",
	target = 1,
	distance = 150,
	description = "Hurt your opponent for 100, yourself for 50",
	image = "wos/forceicons/pull.png",
	cooldown = 15,
	manualaim = false,
	action = function( self )
		if ( self:GetForce() < 75 && self:Health() < 50 ) then return end
		local ent = self:SelectTargets( 1 )[ 1 ]
		if not IsValid( ent ) then return end

		self:SetForce( self:GetForce() - 75 )
		self:PlayWeaponSound( "lightsaber/force_repulse.wav" )
		local dmg = DamageInfo()
		dmg:SetAttacker( self:GetOwner() || self )
		dmg:SetInflictor( self:GetOwner() || self )
		dmg:SetDamageType( DMG_DISSOLVE )
		if (ent:Health() < 100) then
			dmg:SetDamage( ent:Health()-1 )
		else
			dmg:SetDamage( 100 )
		end
		ent:TakeDamageInfo( dmg )
		dmg:SetDamage( 50 )
		self:GetOwner():TakeDamageInfo( dmg )
		local newpos = ( self:GetOwner():GetPos() - ent:GetPos() )
		newpos = newpos / newpos:Length()
		ent:SetVelocity( newpos*-700 + Vector( 0, 0, 300 ) )
		self:GetOwner():SetNW2Float( "wOS.ForceAnim", CurTime() + 0.3 )
		self:SetNextAttack( 1.5 )
		return true
	end
})

wOS.ForcePowers:RegisterNewPower({
    name = "Consular Force EMP",
    icon = "EMP",
    image = "wos/forceicons/icefuse/blind.png",
    cooldown = 50,
    manualaim = false,
    description = "Weak electromagnetic pulse that hurts only droids",
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
                    v:TakeDamage( 200, self.Owner, self )
                end
            end
        end

        self:SetForce( self:GetForce() - 100 )
        self:SetNextAttack( 1 )
        return true
    end
})