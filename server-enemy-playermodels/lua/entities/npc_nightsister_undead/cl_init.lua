include('shared.lua')

language.Add("npc_nightsister_undead", "Undead Nightsister")
killicon.Add("npc_nightsister_undead","HUD/killicons/default",Color ( 255, 80, 0, 255 ) )

function ENT:Initialize()	
end

function ENT:Draw()	
	--self:SetModelScale( Vector(5,5,5) )
	self.Entity:DrawModel()
end