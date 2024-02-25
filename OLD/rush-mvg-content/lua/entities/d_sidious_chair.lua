ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Base = "base_anim"
ENT.Type = "vehicle"

ENT.PrintName = "Darth Sidious Chair"
ENT.Author = "Syphadias, Liam0102s Help"
ENT.Category = "Star Wars Vehicles: Chairs"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = false;
ENT.AdminSpawnable = false;
ENT.EntModel = "models/starwars/syphadias/props/d_sidious_chair/d_sidious_chair.mdl";

list.Set("SWVehicles", ENT.PrintName, ENT);
if SERVER then



AddCSLuaFile();
function ENT:SpawnFunction(pl, tr)
	local e = ents.Create("d_sidious_chair");
	e:SetPos(tr.HitPos + Vector(0,0,20));
	e:SetAngles(Angle(0,pl:GetAimVector():Angle().Yaw,0));
	e:Spawn();
	e:Activate();
	return e;
end

function ENT:Initialize()

	self:SetModel(self.EntModel);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);
	self:StartMotionController();
	self:SetUseType(SIMPLE_USE);
	self:SetRenderMode(RENDERMODE_TRANSALPHA);

	self:SecretChair(self:GetPos()+self:GetUp()*16+self:GetForward()*1,self:GetAngles()+Angle(0,-90,8)); // Will most likely require tinkering for position
	
	local phys = self:GetPhysicsObject()

	if(phys:IsValid()) then
		phys:Wake()
		phys:SetMass(100000)
	end
end

function ENT:SecretChair(pos,ang)

	local e = ents.Create("prop_vehicle_prisoner_pod");
	e:SetPos(pos);
	e:SetAngles(ang);
	e:SetParent(self);
	e:SetModel("models/nova/airboat_seat.mdl");
	e:SetRenderMode(RENDERMODE_TRANSALPHA);
	e:SetColor(Color(255,255,255,0));
	e:Spawn();
	e:Activate();
	e.IsSyphSeat = true;
	self.Chair = e;
end

hook.Add("PlayerEnteredVehicle","SyphSeatEnter", function(p,v)
	if(IsValid(p) and IsValid(v)) then
		if(v.IsSyphSeat) then
			p:SetNWEntity("SyphSeat",v)
		end
	end
end)

hook.Add("PlayerLeaveVehicle","SyphSeatExit", function(p,v)
	if(IsValid(p) and IsValid(v)) then
		if(v.IsSyphSeat) then
			p:SetNWEntity("SyphSeat",NULL)
		end
		p:SetPos(v:GetPos()+v:GetUp()*10+v:GetForward()*52)
		p:SetEyeAngles(Angle(0,v:GetAngles().y+90,0))
	end
end)

function ENT:Use(p)
	
	if(!IsValid(self.Chair)) then return end;
	p:EnterVehicle(self.Chair);

end

end

if CLIENT then
	
	function ENT:Draw() self:DrawModel() end
	
	local View = {}
	hook.Add("CalcView", "SyphSeatView", function()

		local p = LocalPlayer();
		local Seat = p:GetNWEntity("SyphSeat",NULL);

		if(IsValid(Seat)) then
			if(Seat:GetThirdPersonMode()) then
				local pos = Seat:GetPos()+LocalPlayer():GetAimVector():GetNormal()*-100+Seat:GetUp()*175;
				local face = ((Seat:GetPos() + Vector(0,0,100))- pos):Angle();
					View.origin = pos;
					View.angles = face;
				return View;
			end
		end
	end)
	
	hook.Add( "ShouldDrawLocalPlayer", "SyphSeatPlayerDraw", function( p )
		local Seat = p:GetNWEntity("SyphSeat",NULL);
		if(IsValid(Seat)) then
			if(Seat:GetThirdPersonMode()) then
				return true;
			end
		end
	end);
end