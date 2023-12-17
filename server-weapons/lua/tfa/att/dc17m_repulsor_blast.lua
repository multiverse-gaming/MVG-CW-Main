if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Repulsor Blast Module"
ATTACHMENT.ShortName = "B.L.M"
ATTACHMENT.Icon = "entities/dc17m_magext.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["="], "Discharges a short-range shockwave that temporarily disorients enemies and knocks them back.",
}

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ClipSize"] = 1,
		["RPM"] = 200,
		["Sound"] = "w/dc17mrocket.wav",
	},
}

function ATTACHMENT:Attach(wep)
    wep:Unload()
end

function ATTACHMENT:Detach(wep)
    wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end

local delay = 1 -- How long the effect last
local movementSpeed = 0.3 -- How much movement speed is reduced to.

function ATTACHMENT:CustomBulletCallback(wep, attacker, trace, dmginfo)
    local currentTarget = trace.Entity
    local aim = attacker:GetAimVector()
	local force  = (attacker:GetUp()*math.random(10, 15)) + (attacker:GetForward()*math.random(30, 60))
   
    if SERVER then
		for k,v in pairs (ents.FindInCone(attacker:GetPos(), attacker:GetAimVector(), 250, math.cos(math.rad(60)))) do --AOE
            print(v)
			if v ~= attacker then
				if attacker:IsLineOfSightClear( v ) then
					if (v:IsNPC() || v:IsPlayer()) then
						v:SetVelocity(force*math.random(30, 20)) --knockback
						v:TakeDamage( 75, attacker, self ) --damage
					end
				end
			end
		end
	end
end