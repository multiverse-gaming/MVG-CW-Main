
TOOL.Category		= "LVS"
TOOL.Name			= "LAAT/c Picker"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "Vector_x" ] = 0
TOOL.ClientConVar[ "Vector_y" ] = 0
TOOL.ClientConVar[ "Vector_z" ] = 0
TOOL.ClientConVar[ "Angle_p" ] = 0
TOOL.ClientConVar[ "Angle_y" ] = 0
TOOL.ClientConVar[ "Angle_r" ] = 0
TOOL.ClientConVar[ "AirDrop" ] = 1

function TOOL:LeftClick( trace )
	local ply = self:GetOwner()
	if ( IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then return end
	if SERVER then 
		local ent = trace.Entity
		local Vector_x = self:GetClientNumber( "Vector_x", 0 )
		local Vector_y = self:GetClientNumber( "Vector_y", 0 )
		local Vector_z = self:GetClientNumber( "Vector_z", 0 )
		local Angle_p = self:GetClientNumber( "Angle_p", 0 )
		local Angle_y = self:GetClientNumber( "Angle_y", 0 )
		local Angle_r = self:GetClientNumber( "Angle_r", 0 )
		local AirDrop = self:GetClientNumber( "AirDrop", 0 )
        
	    ent.LAATC_PICKUPABLE = true
	    ent.LAATC_PICKUP_POS = Vector(Vector_x,Vector_y,Vector_z)
	    ent.LAATC_PICKUP_Angle = Angle(Angle_p,Angle_y,Angle_r)
	    if AirDrop == 1 then 
	    	ent.LAATC_DROP_IN_AIR = true
	    else 
	    	ent.LAATC_DROP_IN_AIR = false
	    end
	    

	end
	return true
end

function TOOL:RightClick( trace )
	local ply = self:GetOwner()
	if CLIENT then return true end
	if ( IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then return end
	local ent = trace.Entity
	ent.LAATC_PICKUPABLE = false
	
	return true
end

function TOOL:Think()

end

function TOOL:Reload( trace )
	local ent = trace.Entity
	local ply = self:GetOwner()
end



function TOOL.BuildCPanel( CPanel  )
	
	CPanel:AddControl( "Slider", { Label = "Position: X", Command = "lvs_laatc_picker_Vector_x", Type = "Int", Min = -100, Max = 100 } )
	CPanel:AddControl( "Slider", { Label = "Position: Y", Command = "lvs_laatc_picker_Vector_y", Type = "Int", Min = -100, Max = 100 } )
	CPanel:AddControl( "Slider", { Label = "Position: Z", Command = "lvs_laatc_picker_Vector_z", Type = "Int", Min = -100, Max = 100 } )
	CPanel:AddControl( "Slider", { Label = "Angle: P", Command = "lvs_laatc_picker_Angle_p", Type = "Int", Min = -180, Max = 180 } )
	CPanel:AddControl( "Slider", { Label = "Angle: Y", Command = "lvs_laatc_picker_Angle_y", Type = "Int", Min = -180, Max = 180 } )
	CPanel:AddControl( "Slider", { Label = "Angle: R", Command = "lvs_laatc_picker_Angle_r", Type = "Int", Min = -180, Max = 180 } )
	CPanel:AddControl( "CheckBox", { Label = "Can Drop in Air", Command = "lvs_laatc_picker_AirDrop"} )
end
