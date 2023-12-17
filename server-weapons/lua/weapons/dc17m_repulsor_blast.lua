if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Repulsor Blast"
ATTACHMENT.ShortName = "Repulsor Blast"
ATTACHMENT.Icon = "entities/dc17m_holosight.png"
ATTACHMENT.Description = { 
    TFA.AttachmentColors["+"], "Discharges a short-range shockwave that temporarily disorients enemies and knocks them back.",


}

ATTACHMENT.WeaponTable = {
    ["VElements"] = {
		["rifle_module"] = {["active"] = false},
		["rifle_mag"] = {["active"] = false},
		["sniper_module"] = {["active"] = false},
		["repulsor_blast"] = {["active"] = true},
	},
	["WElements"] = {
		["rifle_module"] = {["active"] = false},
		["rifle_mag"] = {["active"] = false},
		["sniper_module"] = {["active"] = false},
		["repulsor_blast"] = {["active"] = true},
	},
    ["Primary"] = {
		["Sound"] = "w/dc17m.wav",
        ["RPM"] = 8,
        ["Damage"] = 75,
        ["ClipSize"] = 1,
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
    if CLIENT then return end

    local currentTarget = trace.Entity


    for k,v in pairs (ents.FindInCone(self.Owner:GetPos(), self.Owner:GetAimVector(), 250, math.cos(math.rad(60)))) do
        if v ~= self.Owner then
            if self.Owner:IsLineOfSightClear( v ) then
                
                if (v:IsNPC() || v:IsPlayer()) then

                    if (IsValid(curT) and curT:IsPlayer()) then
                        if timer.Exists("effectemp" .. currentTarget:EntIndex()) then return end

                        if currentTarget.OriginalMovementSpeed_Run == nil and currentTarget.OriginalMovementSpeed_Walk == nil then
                            currentTarget.OriginalMovementSpeed_Run = currentTarget:GetRunSpeed()
                            currentTarget.OriginalMovementSpeed_Walk = currentTarget:GetWalkSpeed()
                        end



                        currentTarget:SetRunSpeed(currentTarget.OriginalMovementSpeed_Run * movementSpeed)
                        currentTarget:SetWalkSpeed(currentTarget.OriginalMovementSpeed_Walk * movementSpeed)


                        timer.Create("effectemp" .. currentTarget:EntIndex(), delay, 1, function()
                            if currentTarget.OriginalMovementSpeed_Run != nil and currentTarget.OriginalMovementSpeed_Walk != nil then

                                currentTarget:SetRunSpeed(currentTarget.OriginalMovementSpeed_Run)
                                currentTarget:SetWalkSpeed(currentTarget.OriginalMovementSpeed_Walk)
                            end

                        end)
                    end

                    --local rag = RagdollTC(v,5)
                    v:SetVelocity(force*math.random(40, 25))
                    v:TakeDamage( 10, self.Owner, self )				
                end

            end
        end
end

-- Hook To Check if dies to reset stats:

hook.Add("PlayerDeath", "effect_emp_death", function(victim, inflictor, attacker)
    if timer.Exists("effectemp" .. victim:EntIndex()) then 
        victim:SetRunSpeed(victim.OriginalMovementSpeed_Run)
        victim:SetWalkSpeed(victim.OriginalMovementSpeed_Walk)

        victim.OriginalMovementSpeed_Run = nil
        victim.OriginalMovementSpeed_Walk = nil

        timer.Remove("effectemp" .. victim:EntIndex())
    end
end)