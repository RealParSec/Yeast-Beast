AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include("shared.lua")
 
function ENT:Initialize()
 
 	self:SetModel( "models/props_lab/box01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.SugarAmount = 0
	self.YeastAmount = 2
	self.WaterAmount = 0
	self.Strength = yb.settings.health.Yeast
 
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

	if self.YeastAmount < 1 then

		self:Remove()

	end

end