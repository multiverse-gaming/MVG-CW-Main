AddCSLuaFile()

ENT.Type 				= "anim"
ENT.Base 				= "base_gmodentity"
ENT.PrintName 			= "Jump Jet"
ENT.Spawnable 			= true
ENT.RenderGroup			= RENDERGROUP_TRANSLUCENT
ENT.Category = "MVG"



function ENT:Initialize()

	if SERVER then
		self:SetModel( "models/thrusters/jetpack.mdl" )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		self:SetPos( self:GetPos() + self:GetUp() * 10 )

	
		self:SetUseType( SIMPLE_USE )
	end

end

function ENT:Use( _, ent )
	if ( not IsValid( ent ) or not ent:IsPlayer() ) then return end

	if ent:GetNWBool( "HasJumpJet", false ) then
		//DarkRP.notify( ent, 1, 3, "You're already wearing a jump jet!")
		ent:ChatPrint( "You're already wearing a jump jet!" )
	else
		ent:SetNWBool( "HasJumpJet", true )
		ent:SetNWBool("CanJumpAgain", true)
		ent:ChatPrint( "You have equipped a jump jet!" )
	end
	//DarkRP.notify( ent, 1, 3, "You have equipped a jump jet!")

	self:Remove()
end



if CLIENT then

	--Make and hide a clientside jetpack model
	local model = ClientsideModel( "models/thrusters/jetpack.mdl" )
	model:SetNoDraw( true )

	local offsetvec = Vector( 3, -5.6, 0 )
	local offsetang = Angle( 180, 90, -90 )

	hook.Add( "PostPlayerDraw" , "manual_model_draw_example" , function( ply )

		--Don't draw jump jets on players who don't have them
		if not ply:GetNWBool( "HasJumpJet", false ) then return end

		--Get the spine bone we'll be drawing the jump jet on
		local boneid = ply:LookupBone( "ValveBiped.Bip01_Spine2" )


		if not boneid then
			return
		end

		local matrix = ply:GetBoneMatrix( boneid )

		if not matrix then
			return
		end

		--Transform our bone positions
		local newpos, newang = LocalToWorld( offsetvec, offsetang, matrix:GetTranslation(), matrix:GetAngles() )

		--Set the model's position and angle 
		model:SetPos( newpos )
		model:SetAngles( newang )
		model:SetupBones()
		
		--Actually draw the jump jet
		//model:DrawModel()

	end )

end