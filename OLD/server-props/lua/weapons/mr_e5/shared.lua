
SWEP.PrintName = "E5"
SWEP.Author = "Rexfor"
SWEP.Contact = "no"
SWEP.Purpose = "THESE ARE NPC GUNS ONLY"
SWEP.Instructions = ""
SWEP.Category = ""
SWEP.Spawnable= false
SWEP.AdminSpawnable= false
SWEP.AdminOnly = false

SWEP.ViewModelFOV = 60
SWEP.ViewModel = "" 
SWEP.WorldModel = "models/megarex/e5.mdl"
SWEP.ViewModelFlip = false
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 2
SWEP.SlotPos = 1
 
SWEP.UseHands = true

SWEP.HoldType = "ar2" 
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.ReloadSound = "cybertronian/tfpistolreload.wav"

SWEP.Base = "weapon_base"

SWEP.Primary.Sound = Sound ("cybertronian/tfionshoot.wav") 
SWEP.Primary.Damage = 40
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 45
SWEP.Primary.Ammo = "AR2"
SWEP.Primary.DefaultClip = 135
SWEP.Primary.Spread = 0.1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Delay = .5
SWEP.Primary.Force = 10

-- npc weapon
list.Add( "NPCUsableWeapons", { class = "mr_e5", title = "SWBF205 E5" } )


SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"



function SWEP:Initialize()
util.PrecacheSound(self.Primary.Sound) 
util.PrecacheSound(self.ReloadSound) 
        self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()
 
if ( !self:CanPrimaryAttack() ) then return end
 
local bullet = {} 
bullet.Num = self.Primary.NumberofShots 
bullet.Src = self.Owner:GetShootPos() 
bullet.Dir = self.Owner:GetAimVector() 
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 1
bullet.TracerName = "redlaser1"
bullet.Force = self.Primary.Force 
bullet.Damage = self.Primary.Damage 
bullet.AmmoType = self.Primary.Ammo 
 
local rnda = self.Primary.Recoil * -1 
local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
self:ShootEffects()
 
self.Owner:FireBullets( bullet ) 
self:EmitSound(Sound(self.Primary.Sound))  
self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end 

function SWEP:DoImpactEffect( tr, nDamageType )

	if ( tr.HitSky ) then return end

	local effectdata = EffectData()
	effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
	effectdata:SetNormal( tr.HitNormal )
	util.Effect( "Impact", effectdata )

end

function SWEP:Proficiency()
timer.Simple(0, function()
if !self:IsValid() or !self.Owner:IsValid() then return; end
 self.Owner:SetCurrentWeaponProficiency(5)
 self.Owner:CapabilitiesAdd( CAP_FRIENDLY_DMG_IMMUNE )
 self.Owner:CapabilitiesRemove( CAP_WEAPON_MELEE_ATTACK1 )
 self.Owner:CapabilitiesRemove( CAP_INNATE_MELEE_ATTACK1 )

	end)
end

function SWEP:Deploy()
self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
-- And you can also use this
self:SetPlaybackRate(1) -- 1 is normal
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
self.Owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RELOAD_AR2)
self:EmitSound(Sound(self.ReloadSound)) 
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

