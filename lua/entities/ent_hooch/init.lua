AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( "shared.lua" )
include( "autorun/init.lua" )

math.randomseed( os.time() )
math.random() math.random() math.random()

local randomizer = math.random( 1, 10 )
local PS = randomizer * 1000
local PY = randomizer * 4
local PW = randomizer * 10
 
function ENT:Initialize()
 
 	self:SetModel( "models/props_borealis/bluebarrel001.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.Water = 0
	self.Sugar = 0
	self.Yeast = 0
	self.Quality = 0
 
	local phys = self:GetPhysicsObject()

	if phys:IsValid() then

		phys:Wake()

	end

end

function ENT:Think()

	self.Quality = (self.Sugar / PS ) + ( self.Yeast / PY ) + ( self.Water / PW ) / 3

	if self.Quality > 1 then

		self.Sugar = self.Sugar - PS
		self.Yeast = self.Yeast - PY
		self.Water = self.Water - PW

		self.Quality = 1 - ( ( ( self.Sugar / PS ) + ( self.Yeast / PY ) + ( self.Water / PW ) ) / 3 )

	end

	self.Quality = math.Round( self.Quality * 100 )

	self:SetQuality( self.Quality )

end

function ENT:Use( a, c )

	if self.Quality > 0 then

		c:addMoney(yb.settings.PerfectPrice * self.Quality / 100)

		self:Remove()
	
	end	

end