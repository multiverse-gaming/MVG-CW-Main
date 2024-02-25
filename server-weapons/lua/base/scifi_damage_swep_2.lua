
AddCSLuaFile()
AddCSLuaFile( "base/scifi_globals.lua" )
include( "base/scifi_globals.lua" )

function SWEP:DealDirectDamage( dmgtype, dmgamt, target, attacker, dmgforce )

	if ( !IsValid( target ) ) then return end
	if ( !dmgforce ) then dmgforce = Vector( 0, 0, 1 ) end
	
	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	dmg:SetAttacker( attacker )
	dmg:SetInflictor( self )
	dmg:SetDamageForce( dmgforce )
	dmg:SetDamage( dmgamt )
	
	if ( target:IsPlayer() || target:IsNPC() ) then
		target:TakeDamageInfo( dmg ) 
	end
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring( self ).." dealt "..tostring( dmgamt ).." ("..tostring( dmgtype )..") damage vs. "..tostring( target ) )
	end
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) == 3 ) then
		MsgC( NotiColor, "@SciFiDamage : !Report; "..tostring( self ).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage vs. "..tostring( target ).."\n" )
	end
	
end

function SWEP:DealAoeDamage( dmgtype, dmgamt, src, range )

	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( self.Owner == NULL || self == NULL ) then
		dmg:SetAttacker( Entity( 0 ) )
	else
		dmg:SetAttacker( self.Owner )
	end
	dmg:SetInflictor( self )
	dmg:SetDamageForce( Vector( 0, 0, 1 ) * ( dmgamt / 10 ) )
	dmg:SetDamage( dmgamt )
	
	util.BlastDamageInfo( dmg, src, range )
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) >= 1 ) then
		debugoverlay.Sphere( src, range, 0.5, Color( 255, 100, 100, 20 ), false )
		debugoverlay.Sphere( src, range / 2, 0.5, Color( 255, 50, 50, 25 ), false ) 
	end
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.."  ("..tostring( dmgtype )..") damage, within "..range.." units." )
	end
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) == 3 ) then
		MsgC( Color( 200, 175, 80 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.."  ("..tostring( dmgtype )..") damage, within "..range.." units.\n" )
	end
	
end

function SWEP:DealAoeDamageOverTime( dmgtype, dmgamt, src, range, lifetime, tickdelay, parent )

	local dmg = DamageInfo()
	dmg:SetDamageType( dmgtype )
	if ( self.Owner == "NULL" ) or ( self.Owner == nil ) then
		dmg:SetAttacker( ents.GetByIndex( 0 ) )
	else
		dmg:SetAttacker( self.Owner )
	end
	dmg:SetInflictor( self )
	dmg:SetDamageForce( Vector( 0, 0, 1 ) )
	dmg:SetDamage( dmgamt )
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) >= 1 ) then
		debugoverlay.Sphere( src, range, lifetime, Color( 200, 175, 80, 10 ), false ) 
		debugoverlay.Sphere( src, range / 2, lifetime, Color( 255, 205, 120, 25 ), false ) 
	end
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) >= 2 ) then
		DebugInfo( ArrangeElements( 4, 24 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds." )
	end
	
	if ( GetConVarNumber( "sfw_debug_showdmgranges" ) == 3 ) then
		MsgC( Color( 200, 175, 80 ), "@SciFiDamage : !Report; "..tostring(self).." dealt "..dmgamt.." ("..tostring( dmgtype )..") damage, within "..range.." units with a lifetime of "..lifetime.." seconds.\n" )
	end

	timer.Create( "hurt" .. parent:EntIndex(), tickdelay, 300, function()
		util.BlastDamageInfo( dmg, src, range )
	end )
	
	timer.Create( "SafeRemoveTimer".. parent:EntIndex(), lifetime, 0, function()
		timer.Destroy( "hurt" .. parent:EntIndex() )
		timer.Destroy( "SafeRemoveTimer" .. parent:EntIndex() )
	end )

end