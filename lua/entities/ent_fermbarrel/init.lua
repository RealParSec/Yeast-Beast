AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

math.randomseed( os.time() )

math.random() math.random() math.random()

function ENT:TableOfProps()

	local funnel = ents.Create( "prop_physics" )
	funnel:SetModel( "models/props_junk/MetalBucket01a.mdl" )
	funnel:SetPos( self:LocalToWorld( Vector( 9.78, 0, 46.5 ) ) )
	funnel:SetModelScale( 0.21, 0)
	funnel:SetParent( self )

	funnel = nil

end

function ENT:Initialize()

	self:SetModel( "models/props_c17/oildrum001.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.funnel = {}

	self:TableOfProps()

	self.MaxShakeSpeed = 600
	self.MinShakeSpeed = 350
	self.ShakeProgress = 0
	self.FermProgress = 0
	self.Shaked = false
	self.Fermented = false
	self.interval = yb.settings.FermTime
	self.timer = CurTime()
	self.SugarInside = 0
	self.YeastInside = 0
	self.WaterInside = 0
	self:SetSugar(self.SugarInside)
	self:SetYeast(self.YeastInside)
	self:SetWater(self.WaterInside)
	self.SoundTime = CurTime()
	self:SetFermenting( false )
	self.AllIngridients = false
	self:SetAllTogether( 0 )
	self.DistTouched = false
	self.Strength = yb.settings.health.FermBarrel

	self:SetTextFont( "YeastFont" )

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

	self:SetAllTogether( self.SugarInside / 1000 + self.YeastInside + self.WaterInside )

	if self.AllIngridients == true then

		local shakingspeed = self:GetVelocity():Length()

		if self.ShakeProgress < 100 && self.Shaked == false then

			if shakingspeed > self.MinShakeSpeed && shakingspeed < self.MaxShakeSpeed then

				self.ShakeProgress = self.ShakeProgress + math.random(1,4)

				self:EmitSound("ambient/levels/canals/toxic_slime_sizzle4.wav", 50, 200, 0.8)

				if self.ShakeProgress > 99 then

					self.ShakeProgress = 100

					self:SetFermenting( true )
					self.timer = CurTime()
					self.Shaked = true

				end

			end

		end

		self:SetProgress( self.ShakeProgress )

		-----

		if CurTime() > self.timer + self.interval && self.Shaked == true then

			self.Fermented = true
			self:SetFermenting( false )

		end

		-----

		if self.Shaked == false then

			if self.ShakeProgress < 1 then

				self:SetProgressText( yb.language.Shakeit )

			elseif self.ShakeProgress > 0 && self.ShakeProgress < 100 then

				self:SetProgressText( yb.language.Progress..": "..self.ShakeProgress.."%" )

			end

			self:SetTextFont( "IngFont" )

		else

			self.FermProgress = math.floor( ( ( self.interval - ( ( self.timer + self.interval ) - CurTime() ) ) / self.interval ) * 100 )

			if self.FermProgress < 100 then

				self:SetProgressText( yb.language.Fermentation..": "..self.FermProgress.."%" )

				if CurTime() > self.SoundTime + 0.7 then

					self:EmitSound( "ambient/levels/canals/toxic_slime_sizzle2.wav", 50, 200, 0.5 )

					self.SoundTime = CurTime()

				end

			else

				self:SetProgressText( yb.language.FermentationDone )

			end

			self:SetTextFont( "FermFont" )

		end

	else

		self:SetTextFont( "FermFont" )

		self:SetProgressText( yb.language.Addingredients )

		if self.SugarInside > 0 && self.YeastInside > 0 && self.WaterInside > 0 then

			self.AllIngridients = true

		end

	end

end

function ENT:OnRemove()

	if self.DistTouched == true then

		self.distent.BarrelAdded = false

	end

end

function ENT:Touch( e )

	if e:GetClass() == "ent_sugar_500" or e:GetClass() == "ent_sugar_1000" or e:GetClass() == "ent_yeast" or e:GetClass() == "ent_water" then

		if self.ShakeProgress < 1 then

			if self.SugarInside < 10000 then

				self.SugarInside = self.SugarInside + e.SugarAmount
				e.SugarAmount = 0

			end

			if self.YeastInside < 40 then

				self.YeastInside = self.YeastInside + e.YeastAmount
				e.YeastAmount = 0

			end

			if self.WaterInside < 100 then
				
				self.WaterInside = self.WaterInside + e.WaterAmount
				e.WaterAmount = 0

			end

			self:SetSugar(self.SugarInside)
			self:SetYeast(self.YeastInside)
			self:SetWater(self.WaterInside)

		end

	end

	if e:GetClass() == "ent_distiller" then

		self.DistTouched = true
		self.distent = e

	end

end