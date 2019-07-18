include( "shared.lua" )

local timershit = CurTime()

math.randomseed( os.time() )

surface.CreateFont( "DistillerFont", {
	font = "Arial", 
	extended = false,
	size = 30,
	weight = 900,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function ENT:Draw()

	sound.Add( {
		name = "gasfiresound",
		channel = CHAN_STATIC,
		volume = 0.25,
		level = 50,
		pitch = { 95, 110 },
		sound = "ambient/gas/steam2.wav"
	} )

	self:DrawModel()

	if self:GetAddBarrel() == true then

		self.BarrelString = yb.language.Nobarrel

	else

		self.BarrelString = yb.language.Distillingbarrel

	end

	local dis = LocalPlayer():GetPos():Distance(self:GetPos())

	local FadeAlpha = 255 + yb.settings.ScreenFadeDist - dis

	local FadeAlphaH = 255 + yb.settings.ScreenFadeDist - dis

	if FadeAlphaH > 230 then

		FadeAlphaH = 230

	end

		if CurTime() > timershit + 0.1 && self:GetDisti() == true then

			self.funnelsmoke = ParticleEmitter( self:LocalToWorld( Vector(0,0,0) ) )

			local smokie = self.funnelsmoke:Add( "sprites/flamelet2",self:LocalToWorld( Vector( 0, -48, 17 ) ) )
			smokie:SetVelocity( Vector( 0, 0, 10 ) )
			smokie:SetStartSize( math.random(5, 7) )
			smokie:SetEndSize( 2 )
			smokie:SetRoll( 100 )
			smokie:SetColor( (255 + 142 + 0) / 3, (255 + 118 + 164) / 3, (255 + 61 + 201) / 3 )
			smokie:SetGravity( Vector( 0,0,10 ) )
			smokie:SetAirResistance( 100 )
			smokie:SetDieTime( 1 )
			smokie:SetStartAlpha( 255 )
			smokie:SetEndAlpha( 255 )

			timershit = CurTime()

			self:EmitSound( "gasfiresound" )	

		end

		if self:GetDisti() == false then

			self:StopSound( "gasfiresound" )

		end

	if dis < 255 + yb.settings.ScreenFadeDist then

		cam.Start3D2D( self:LocalToWorld( Vector( 16, -14.5, 73.7 ) ), self:LocalToWorldAngles( Angle( 0, 90, 90 ) ), 0.1 )

			draw.RoundedBox( 10, 0, 0, 280, 250, Color( 0, 0, 0, FadeAlphaH ) )
			draw.RoundedBox( 10, 10, 10, 260, 40, Color( 25, 25, 25, FadeAlpha ) )
			draw.RoundedBox( 10, 12, 12, self:GetGasAmount() * (254/1500), 36, Color( 178, 142, 0, FadeAlpha ) )

			draw.SimpleText( yb.language.Gas..": "..self:GetGasAmount().." ml", "DistillerFont", 14, 30, Color( 200, 200, 200, FadeAlpha ), 0, 1 )

			draw.SimpleText( self.BarrelString, "DistillerFont", 14, 80, Color( 200, 200, 200, FadeAlpha ), 0, 1 )

		cam.End3D2D()

	end

end