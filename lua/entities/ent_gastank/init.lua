AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include("shared.lua")
 
function ENT:Initialize()
 
 	self:SetModel( "models/props_c17/canister01a.mdl" )
 	self:SetModelScale( 0.38, 0 )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.capacity = yb.settings.GasTankAmount
	self.usedup = false
	self.atached = false
	self.Strength = yb.settings.health.GasTank
 
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then

		phys:Wake()

	end

end

function ENT:Think()

	if self.capacity < 1 then

		self.usedup = true

	end

	if self.usedup == true then

		self:Remove()

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

function ENT:OnRemove()

	if self.atached == true then

		self.entdist.GasTankAdded = false
		self.entdist.GasInside = 0

	end

end

function ENT:Touch( e )

	if e:GetClass() == "ent_distiller" && e.GasTankAdded != true then

		self.entdist = e

		self.atached = true

	end

end