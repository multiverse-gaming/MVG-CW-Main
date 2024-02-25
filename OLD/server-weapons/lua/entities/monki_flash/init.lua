--Changed alot of this code for my own usage, OG Zeus made the origional flashbang swep, other addons used are part of the server.
AddCSLuaFile( "shared.lua" )
include("shared.lua")

local FLASH_INTENSITY = 1900

/*---------------------------------------------------------
Initialize
---------------------------------------------------------*/
function ENT:Initialize()
    if SERVER then
        self:SetModel( "models/sw_battlefront/weapons/rocketprojectile.mdl" )
		self.Entity:PhysicsInit( SOLID_VPHYSICS )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_VPHYSICS )
		self.Entity:DrawShadow( false )

    local phys = self:GetPhysicsObject()
    if (IsValid(phys)) then
        phys:SetMass(1)
    end
        self:DrawShadow( true )
    end
    self.ExplodeTimer = CurTime() + 100000
end

function ENT:PhysicsCollide( data, phys )
    if  (100 < data.Speed and 0.05 < data.DeltaTime) then
    self.ExplodeTimer = 0
    end
end

function ENT:Think()
    if SERVER and (self.ExplodeTimer and self.ExplodeTimer <= CurTime()) then
        self:Explode()
    end
    self:NextThink(CurTime())
    return true
end

/*---------------------------------------------------------
Explode
---------------------------------------------------------*/
function ENT:Explode()

	self.Entity:EmitSound(Sound("Flashbang.Explode"));
	
	local effectdata = EffectData()
	effectdata:SetOrigin( self.Entity:GetPos() )
	util.Effect( "rw_sw_impact_aqua", effectdata )	

	for _,pl in pairs(player.GetAll()) do

		local ang = (self.Entity:GetPos() - pl:GetShootPos()):GetNormalized():Angle()

		local tracedata = {};

		tracedata.start = pl:GetShootPos();
		tracedata.endpos = self.Entity:GetPos();
		tracedata.filter = pl;
		local tr = util.TraceLine(tracedata);

		if (!tr.HitWorld) then
			local dist = pl:GetShootPos():Distance( self.Entity:GetPos() )  
			local endtime = FLASH_INTENSITY / (dist * 4.3);

			if (endtime > 6) then
				endtime = 6;
			elseif (endtime < 2) then
				endtime = 0;
			end

			simpendtime = math.floor(endtime);
			tenthendtime = math.floor((endtime - simpendtime) * 7);

--			if (pl:GetNetworkedFloat("FLASHED_END") > CurTime()) then
--				pl:SetNetworkedFloat("FLASHED_END", endtime + pl:GetNetworkedFloat("FLASHED_END") + CurTime() - pl:GetNetworkedFloat("FLASHED_START"));
--			else
				pl:SetNetworkedFloat("FLASHED_END", endtime + CurTime());
--			end

			pl:SetNetworkedFloat("FLASHED_END_START", CurTime());
		end
	end
	self.Entity:Remove();
end