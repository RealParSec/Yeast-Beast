AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include( "shared.lua" )

function ENT:TableOfProps()

	if self.PipesAdded == true then

		local barrelpipe = ents.Create( "prop_physics" )
		barrelpipe:SetModel( "models/props_canal/mattpipe.mdl" )
		barrelpipe:SetPos( self:LocalToWorld( Vector( 0, -20.5, 73.6 ) ) )
		barrelpipe:SetAngles( self:LocalToWorldAngles( Angle( 90, 90, 0 ) ) )
		barrelpipe:SetModelScale( 1, 0)
		barrelpipe:SetParent( self )

		barrelpipe = nil

		local filterpipe = ents.Create( "prop_physics" )
		filterpipe:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
		filterpipe:SetPos( self:LocalToWorld( Vector( -10, 10, 68 ) ) )
		filterpipe:SetAngles( self:LocalToWorldAngles( Angle( 90, 90, 0 ) ) )
		filterpipe:SetModelScale( 1, 0)
		filterpipe:SetParent( self )

		filterpipe = nil

		local gaspipe1 = ents.Create( "prop_physics" )
		gaspipe1:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
		gaspipe1:SetPos( self:LocalToWorld( Vector( 0, -63, 3 ) ) )
		gaspipe1:SetAngles( self:LocalToWorldAngles( Angle( 0, 90, 90 ) ) )
		gaspipe1:SetModelScale( 1, 0)
		gaspipe1:SetParent( self )

		gaspipe1 = nil

	end

	if self.HeatStandAdded == true then

		local standplate = ents.Create( "prop_physics" )
		standplate:SetModel( "models/props_junk/wood_pallet001a.mdl" )
		standplate:SetPos( self:LocalToWorld( Vector( 0, -54, 4 ) ) )
		standplate:SetAngles( self:LocalToWorldAngles( Angle( 0, 0, 0 ) ) )
		standplate:SetModelScale( 1, 0)
		standplate:SetParent( self )

		standplate = nil

		local heater = ents.Create( "prop_physics" )
		heater:SetModel( "models/props_lab/tpplug.mdl" )
		heater:SetPos( self:LocalToWorld( Vector( 0, -48, 4 ) ) )
		heater:SetAngles( self:LocalToWorldAngles( Angle( -90, 0, 0 ) ) )
		heater:SetModelScale( 1, 0)
		heater:SetParent( self )

		heater = nil

		local stand1 = ents.Create( "prop_physics" )
		stand1:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
		stand1:SetPos( self:LocalToWorld( Vector( 9, -48, 4 ) ) )
		stand1:SetAngles( self:LocalToWorldAngles( Angle( 0, 90, 0 ) ) )
		stand1:SetModelScale( 1, 0)
		stand1:SetParent( self )

		stand1 = nil

		local stand2 = ents.Create( "prop_physics" )
		stand2:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
		stand2:SetPos( self:LocalToWorld( Vector( -9, -48, 4 ) ) )
		stand2:SetAngles( self:LocalToWorldAngles( Angle( 0, 90, 0 ) ) )
		stand2:SetModelScale( 1, 0)
		stand2:SetParent( self )

		stand2 = nil

		local stand3 = ents.Create( "prop_physics" )
		stand3:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
		stand3:SetPos( self:LocalToWorld( Vector( 0, -57, 4 ) ) )
		stand3:SetAngles( self:LocalToWorldAngles( Angle( 0, 0, 0 ) ) )
		stand3:SetModelScale( 1, 0)
		stand3:SetParent( self )

		stand3 = nil

		local stand4 = ents.Create( "prop_physics" )
		stand4:SetModel( "models/props_c17/playground_teetertoter_stan.mdl" )
		stand4:SetPos( self:LocalToWorld( Vector( 0, -39, 4 ) ) )
		stand4:SetAngles( self:LocalToWorldAngles( Angle( 0, 0, 0 ) ) )
		stand4:SetModelScale( 1, 0)
		stand4:SetParent( self )

		stand4 = nil

	end

end
 
function ENT:Initialize()
 
 	self:SetModel( "models/props_wasteland/kitchen_stove002a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.HeatStandAdded = false
	self.PipesAdded = false
	self.GasTankAdded = false
	self.GasInside = 0
	self.timer1 = 0
	self.timer2 = 0
	self:SetDisti( false )
	self.DistTime = yb.settings.DistTime
	self.Strength = yb.settings.health.Distiller

	self:SetAddBarrel(true)

	self:TableOfProps()
 
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

	if self.BarrelAdded == true then

		self:SetAddBarrel(false)

	else

		self:SetAddBarrel(true)

	end

	if self.HeatStandAdded == true or self.PipesAdded == true then

		local phys = self:GetPhysicsObject()

		phys:EnableMotion( false )

		self:SetAngles( Angle( 0, self:GetAngles().y, 0 ) )

	end
	
	if self.GasTankAdded == true then

		local gasphys = self.gasent:GetPhysicsObject()

		gasphys:EnableMotion( false )

		self.gasent:SetPos( self:LocalToWorld( Vector( -9.58, -77.9, 3.1 ) ) )

		self.gasent:SetAngles( self:LocalToWorldAngles( Angle( 0, 90, 90 ) ) )

		self.GasInside = self.gasent.capacity

	end

	if self.BarrelAdded == true then

		local barrelphys = self.EntBarrel:GetPhysicsObject()

		barrelphys:EnableMotion( false )

		self.EntBarrel:SetAngles( self:LocalToWorldAngles( Angle( 0, 90, 0 ) ) )
		self.EntBarrel:SetPos( self:LocalToWorld( Vector( 0, -48, 24 ) ) )

	end

	if self.BarrelAdded == true && self.GasTankAdded == true then

		if CurTime() > self.timer2 + 1 then

			self:SetDisti( true )
			self.gasent.capacity = self.gasent.capacity - 5

			if CurTime() > self.timer1 + self.DistTime then

				self:SetDisti( false )

				local result = ents.Create( "ent_hooch" )
				result:SetAngles( self:LocalToWorldAngles( Angle( 0, 0, 0 ) ) )
				result:SetPos( self:LocalToWorld( Vector( 40, 0, 25 ) ) )
				result:Spawn()
				result.Water = self.EntBarrel.WaterInside
				result.Sugar = self.EntBarrel.SugarInside
				result.Yeast = self.EntBarrel.YeastInside

				self.EntBarrel.ShakeProgress = 0
				self.EntBarrel.FermProgress = 0
				self.EntBarrel.Shaked = false
				self.EntBarrel.Fermented = false
				self.EntBarrel.SugarInside = 0
				self.EntBarrel.YeastInside = 0
				self.EntBarrel.WaterInside = 0
				self.EntBarrel:SetSugar(self.EntBarrel.SugarInside)
				self.EntBarrel:SetYeast(self.EntBarrel.YeastInside)
				self.EntBarrel:SetWater(self.EntBarrel.WaterInside)
				self.EntBarrel:SetProgress(0)
				self.EntBarrel:SetFermenting( false )
				self.EntBarrel.AllIngridients = false
				self.EntBarrel:SetAllTogether( 0 )
				self.EntBarrel.DistTouched = false


				local barrelphys = self.EntBarrel:GetPhysicsObject()

				barrelphys:EnableMotion( true )

				self.EntBarrel:SetAngles( self:LocalToWorldAngles( Angle( 0, 0, 0 ) ) )

				self.EntBarrel:SetPos( self:LocalToWorld( Vector( 50, -48, 0 ) ) )

				self.BarrelAdded = false

			end

			self.timer2 = CurTime()

		end

	end

	self:SetGasAmount(self.GasInside)

end

function ENT:Touch( e )

	if e:GetClass() == "ent_heatstand" && self.HeatStandAdded != true then

		self.HeatStandAdded = true

		self:TableOfProps()

		e.usedup = true

	end

	if e:GetClass() == "ent_pipes" && self.PipesAdded != true && self.HeatStandAdded == true then

		self.PipesAdded = true

		self:TableOfProps()

		e.usedup = true

	end

	if e:GetClass() == "ent_gastank" && self.GasTankAdded != true && self.PipesAdded == true then

		self.GasTankAdded = true

		self.gasent = e

	end

	if self.BarrelAdded == true && self.GasTankAdded == true then

		self.timer1 = CurTime()

		self.timer2 = CurTime()

	end

	if e:GetClass() == "ent_fermbarrel" && self.PipesAdded == true  then

		if e.Fermented == true then

			self.BarrelAdded = true

			self.EntBarrel = e

			self.timer1 = CurTime()

			self.timer2 = CurTime()

		end

	end

end