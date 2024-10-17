AddCSLuaFile( "shared.lua" )

SWEP.Author			= ""
SWEP.Instructions	= "Right click to throw, Left click to explode"

SWEP.Category = "Star Wars Grenades"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= ""
SWEP.WorldModel			= "models/riddickstuff/bactagrenade/bactanade.mdl"  --models/riddickstuff/bactagrenade/bactanade.mdl
SWEP.ViewModelFOV = 70

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "XBowBolt"
SWEP.Primary.Delay = 1

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.PrintName			= "Thermal Detonator"			
SWEP.Slot				= 5
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false

 --game.AddAmmoType( {
	--name = "bo_c4",
	 --dmgtype = DMG_BULLET,
	-- tracer = TRACER_LINE,
	--plydmg = 1,
	 --npcdmg = 1,
	 --force = 2000,
	 --minsplash = 10,
	 --maxsplash = 5



SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = -2,
		Forward = 0,
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = -45,
	}
}

function SWEP:DrawWorldModel( )
	local hand, offset, rotate

	if not IsValid( self.Owner ) then
		self:DrawModel( )
		return
	end

	if not self.Hand then
		self.Hand = self.Owner:LookupAttachment( "anim_attachment_rh" )
	end

	hand = self.Owner:GetAttachment( self.Hand )

	if not hand then
		self:DrawModel( )
		return	
	end

	offset = hand.Ang:Right( ) * self.Offset.Pos.Right + hand.Ang:Forward( ) * self.Offset.Pos.Forward + hand.Ang:Up( ) * self.Offset.Pos.Up

	hand.Ang:RotateAroundAxis( hand.Ang:Right( ), self.Offset.Ang.Right )
	hand.Ang:RotateAroundAxis( hand.Ang:Forward( ), self.Offset.Ang.Forward )
	hand.Ang:RotateAroundAxis( hand.Ang:Up( ), self.Offset.Ang.Up )

	self:SetRenderOrigin( hand.Pos + offset )
	self:SetRenderAngles( hand.Ang )

	self:DrawModel( )
end

function SWEP:Deploy()
	--if !IsValid(self.Owner.C4s) then self.Owner.C4s = {} end
end


function SWEP:Think()
	
end  

function SWEP:Equip(NewOwner)
	if self.Owner.C4s == nil then 
		self.Owner.C4s = {} 
	end
	self.Owner:GiveAmmo(25,"XBowBolt")
	
end


function SWEP:PrimaryAttack()

	if not IsFirstTimePredicted() then return end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)	

	timer.Simple(0.1,function() 
		if IsValid(self) then 
			self:EmitSound("hoff/mpl/seal_c4/c4_click.wav") 
		end 
	end)
	
	if self.Owner:Alive() and self.Owner:IsValid() then
	-- thanks chief tiger
		local Owner = self.Owner
		if SERVER then
			for k, v in pairs( Owner.C4s ) do
				timer.Simple( .05 * k, function()
					if IsValid( v ) then
						v:Explode()
						table.remove( Owner.C4s, k )	
		--				Owner.C4s[k] = null
					end				
				end )
		end
		    self.Owner.C4s = {}
		end	
	end
	
	self:SetNextPrimaryFire(CurTime() + 1.1)
	self:SetNextSecondaryFire(CurTime() + 1.2)
end

function SWEP:SecondaryAttack()
 
    if not IsFirstTimePredicted() then return end

    if ( self:Ammo1() <= 0 ) then
        return false
    end

    self:SendWeaponAnim(ACT_VM_THROW)  
	timer.Simple(0.1,function() 
		if IsValid(self) then 
			self:EmitSound("hoff/mpl/seal_c4/whoosh_00.wav") 
		end 
	end)

    --self:TakePrimaryAmmo(1)
    local tr = self.Owner:GetEyeTrace()
    if SERVER then
        if #(self.Owner.C4s) > 9 then
            return false
        end
        local ent = ents.Create("cod-c4")
               
		ent:SetPos(self.Owner:GetShootPos())
        ent:SetAngles(Angle(1,0,0))

		ent.Owner = self.Owner
        ent.C4Owner = self.Owner       
        ent:Spawn()
        table.insert( self.Owner.C4s, ent )
    end
 
    self.Owner:RemoveAmmo(1,"XBowBolt")
   
    self:SetNextPrimaryFire(CurTime() + 1.1)
    self:SetNextSecondaryFire(CurTime() + 1.2)
end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:OnRemove()
	local owner = self.Owner
--[[ 	timer.Simple(0.5,function()
		if owner:IsValid() == false then
			if SERVER then
				for k, v in pairs( owner.C4s ) do
					timer.Simple( .05 * k, function()
						if IsValid( v ) then
							v:Remove()
						end				
					end)
				end
			end
		end
	end) ]]
end

function SWEP:Reload()
end
