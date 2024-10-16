
AddCSLuaFile( "shared.lua" )

SWEP.Author			= "Hoff"
SWEP.Instructions	= ""

SWEP.Category = "[MVG] Miscellaneous Equipment"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/hoff/weapons/tac_insert/c_tac_insert.mdl"
SWEP.WorldModel			= "models/hoff/weapons/tac_insert/w_tac_insert.mdl"
SWEP.ViewModelFOV = 75

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= ""
SWEP.Primary.Delay = 0

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.PrintName			= "Tactical Insertion"			
SWEP.Slot				= 3
SWEP.SlotPos			= 4
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

SWEP.UseHands = true

SWEP.Next = CurTime()
SWEP.Primed = 0

hook.Add("Initialize","CreateTacInsertConvars",function()
	if !ConVarExists( "Tac_RespawnLimit" ) then
		CreateConVar("Tac_RespawnLimit", 0, { CHEAT, FCVAR_REPLICATED }) 
	end
end)

SWEP.Offset = {
	Pos = {
		Up = -1,
		Right = 0,
		Forward = 2,
	},
	Ang = {
		Up = 45,
		Right = 180,
		Forward = 45,
	}
}

function SWEP:DrawWorldModel( )
    if not IsValid( self.Owner ) then
        self:DrawModel( )
        return
    end

    local bone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )
    if not bone then
        self:DrawModel( )
        return
    end

    local pos, ang = self.Owner:GetBonePosition( bone )
    pos = pos + ang:Right() * self.Offset.Pos.Right + ang:Forward() * self.Offset.Pos.Forward + ang:Up() * self.Offset.Pos.Up
    ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
    ang:RotateAroundAxis( ang:Forward(), self.Offset.Ang.Forward )
    ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up )

    self:SetRenderOrigin( pos )
    self:SetRenderAngles( ang )

    self:DrawModel()
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_IDLE)
	self.Next = CurTime()
	self.Primed = 0
	self.Owner.Tacs = self.Owner.Tacs or {}
end

function SWEP:Initialize()
	self:SetWeaponHoldType("fist")
end

function SWEP:Equip(NewOwner)
end

function SWEP:Holster()
	self.Next = CurTime()
	self.Primed = 0
	return true
end

function SWEP:PrimaryAttack()	
	if self:GetNWBool("clickclick") == true and self.Primed == 2 then 
		return 
	end
	self:SetNWBool("clickclick", true)
	if self.Next < CurTime() and self.Primed == 0 then
		self.Next = CurTime() + self.Primary.Delay
		
		if self.Owner:IsValid() and self.Owner:Alive() then
		timer.Simple(0.35,function() if self:IsValid() then self:EmitSound("hoff/mpl/seal_tac_insert/clip.wav") end end)
		
		timer.Simple(0.7,function() if self:IsValid() then self:EmitSound("hoff/mpl/seal_tac_insert/beep.wav") end end)
		timer.Simple(0.95,function() if self:IsValid() then self:EmitSound("hoff/mpl/seal_tac_insert/beep.wav") end end)
		
		
		timer.Simple(1.2,function() if self:IsValid() then self:EmitSound("hoff/mpl/seal_tac_insert/flick_1.wav") end end)
		timer.Simple(1.3,function() if self:IsValid() then self:EmitSound("hoff/mpl/seal_tac_insert/flick_2.wav") end end)
		self:SendWeaponAnim(ACT_VM_PULLPIN)
		self.Primed = 1
		end
	end
end


function SWEP:SecondaryAttack()
end

function SWEP:DeployShield()
	self.Primed = 3
	if !SERVER then
		return
	end
	timer.Simple(0.4,function()
		if self.Owner:Alive() and self.Owner:IsValid() then
			for k, v in pairs( self.Owner.Tacs ) do
				timer.Simple( 0.01 * k, function()
					if IsValid(self) then
						if IsValid( v ) then
							v:Remove()
							table.remove( self.Owner.Tacs, k )
						end
					end
				end)
			end	
		end


		local ent = ents.Create("cod-tac-insert")
		ent:SetPos(self.Owner:GetPos())

		local trace = util.TraceLine({
			start = self.Owner:GetPos(),
			endpos = self.Owner:GetPos() + Vector(0, 0, -75),
			filter = function(ent)
				if !IsValid(ent) then
					return false
				end
				if ent:GetClass() == "player" || ent:GetClass() == "seal6-tac-insert" then
					return false
				end
				return true
			end
		})

		if trace.Hit then
			ent:SetPos(trace.HitPos)
		end

		ent:Spawn()
		ent.TacOwner = self.Owner
		ent.Owner = self.Owner
		ent:SetNWString("TacOwner", self.Owner:Nick())
		ent:SetNWString("OwnerID", self.Owner:SteamID())
		ent:SetAngles(Angle(self.Owner:GetAngles().x,self.Owner:GetAngles().y,self.Owner:GetAngles().z) + Angle(0,-90,0))
		table.insert( self.Owner.Tacs, ent )
			
		undo.Create("Tactical Insertion")
		undo.AddEntity(ent)
		undo.SetPlayer(self.Owner)
		undo.AddFunction(function(undo)
			local ent = undo.Entities[1]

			-- Check if the entity is still valid
			if ent:IsValid() then
				-- Remove the entity from the owner's Tac table
				table.RemoveByValue(undo.Owner.Tacs, ent)
			else
				-- The Tac doesn't exist anymore (probably exploded)
				return false
			end
		end)
		undo.Finish()

		self.Owner:AddCount("sents", ent) -- Add to the SENTs count ( ownership )
		self.Owner:AddCount("my_props", ent) -- Add count to our personal count
		self.Owner:AddCleanup("sents", ent) -- Add item to the sents cleanup
		self.Owner:AddCleanup("my_props", ent) -- Add item to the cleanup	
	end)

	hook.Add("PlayerSpawn","TacSpawner"..self.Owner:SteamID(),function( ply )

		if ply.Tacs == nil then 
			ply.Tacs = {} 
		end
		for k, v in pairs( ply.Tacs ) do
			timer.Simple( 0, function()
				if !IsValid( v ) then
					return
				end
				
				ply:SetPos(v:GetPos())
				ply:SetAngles(v:GetAngles())
				v.RespawnCounter = v.RespawnCounter + 1
				local RespawnLimit = GetConVar("Tac_RespawnLimit"):GetInt()
				if RespawnLimit > 0 and v.RespawnCounter >= RespawnLimit then
					if ply:Alive() and ply:IsValid() then
						for k, v in pairs( ply.Tacs ) do
							timer.Simple( 0 * k, function()
								if !IsValid( v ) then
									return
								end
								local effect = EffectData()
								effect:SetStart(v:GetPos())
								effect:SetOrigin(v:GetPos())
								util.Effect("cball_explode", effect, true, true)
								sound.Play(Sound("npc/assassin/ball_zap1.wav"), v:GetPos(), 100, 100)
								hook.Remove("PlayerSpawn","TacSpawner"..v:GetNWString("OwnerID"))
								v:Remove()
								table.remove( ply.Tacs, k )
							end )
						end	
					end
				end				
			end )
		end
	end)

	timer.Simple(0.5,function() 
		if IsValid(self) then 
			self:SetNWBool("clickclick", false)
			self.Owner:StripWeapon("seal6-tac-insert")
		end 
	end)
end

function SWEP:SetNext()
	if self.Next < CurTime() + 0.5 then
		return
	end
	self.Next = CurTime()
end

function SWEP:Think()
	if self.Next < CurTime() then
		if self.Primed == 1 and not self.Owner:KeyDown(IN_ATTACK) then
			self.Primed = 2
			self:SetNext()
		elseif self.Primed == 2 and CurTime() > self.Next + 1.3 then
			self.Primed = 0
			self:DeployShield()
			self:SendWeaponAnim(ACT_VM_THROW)
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		end
	end
end

function SWEP:SecondaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1.1)
	self:SetNextSecondaryFire(CurTime() + 1.2)
end

function SWEP:ShouldDropOnDie()
	return false
end

if CLIENT then

	surface.CreateFont( "Arialf", { font = "Arial", antialias = true, size = 35 } )

	function SWEP:DrawHUD()
		if self:GetNWBool("clickclick") == true then
			return
		end
		
		local x = ScrW() / 2.0
		local y = ScrH() / 2.7
		local nxt = self:GetNextPrimaryFire()

		local w, h = 200, 18

		surface.SetDrawColor(255, 255, 255, 255)
		draw.DrawText("Press LMB To Deploy", "Arialf", ScrW()/2, y - 65, Color(255, 255, 255, 255),TEXT_ALIGN_CENTER)
	end
end	
