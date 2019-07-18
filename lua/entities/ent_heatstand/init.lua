AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include("shared.lua")

function ENT:TableOfProps()

	local stand1 = ents.Create( "prop_physics" )
	stand1:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
	stand1:SetPos( self:LocalToWorld( Vector( 0, -15, 5 ) ) )
	stand1:SetAngles( self:LocalToWorldAngles( Angle( 0, 27, 90 ) ) )
	stand1:SetModelScale( 1, 0)
	stand1:SetParent( self )

	stand1 = nil

	local stand2 = ents.Create( "prop_physics" )
	stand2:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
	stand2:SetPos( self:LocalToWorld( Vector( -10, -17, 5 ) ) )
	stand2:SetAngles( self:LocalToWorldAngles( Angle( 0, 153, 90 ) ) )
	stand2:SetModelScale( 1, 0)
	stand2:SetParent( self )

	stand2 = nil

	local stand3 = ents.Create( "prop_physics" )
	stand3:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
	stand3:SetPos( self:LocalToWorld( Vector( 10, 17, 5 ) ) )
	stand3:SetAngles( self:LocalToWorldAngles( Angle( 0, 65, 90 ) ) )
	stand3:SetModelScale( 1, 0)
	stand3:SetParent( self )

	stand3 = nil

	local stand4 = ents.Create( "prop_physics" )
	stand4:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
	stand4:SetPos( self:LocalToWorld( Vector( -10, 15, 5 ) ) )
	stand4:SetAngles( self:LocalToWorldAngles( Angle( 0, 198, 90 ) ) )
	stand4:SetModelScale( 1, 0)
	stand4:SetParent( self )

	stand4 = nil

	local heater = ents.Create( "prop_physics" )
	heater:SetModel( "models/props_lab/tpplug.mdl" )
	heater:SetPos( self:LocalToWorld( Vector( -10, 16.5, 9.5 ) ) )
	heater:SetAngles( self:LocalToWorldAngles( Angle( 25, 0, 90 ) ) )
	heater:SetModelScale( 1, 0)
	heater:SetParent( self )

	heater = nil

end
 
function ENT:Initialize()
 
 	self:SetModel( "models/props_junk/wood_pallet001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.usedup = false
	self:TableOfProps()
	self.Strength = yb.settings.health.HeatStand
 
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then

		phys:Wake()

	end

end

function ENT:OnTakeDamage(damage)

	if damage:IsBulletDamage() then

		self.Strength = self.Strength - damage:GetDamage()

		if self.Strength < 1 then

			self:Remove()

		end

	end

end

function ENT:Think()

	if self.usedup == true then

		self:Remove()

	end

end