include( "shared.lua" )

math.randomseed(os.time())

local smoothedall = 0

surface.CreateFont( "IngFont", {
	font = "Arial", 
	extended = false,
	size = 25,
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

surface.CreateFont( "FermFont", {
	font = "Arial", 
	extended = false,
	size = 21,
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

function ENT:Initialize()

	self.timer = CurTime()
	self.funnelsmoke = ParticleEmitter( self:LocalToWorld( Vector(0,0,0) ) )

end

function ENT:Draw()

	if CurTime() > self.timer + 0.1 && self:GetFermenting() == true then

		local smokie = self.funnelsmoke:Add( "particle/smokesprites_0009",self:LocalToWorld( Vector( 9.78, 0, 47.5 ) ) )
		smokie:SetVelocity( Vector( 0, 0, 10 ) )
		smokie:SetStartSize( 2 )
		smokie:SetEndSize( math.random(10, 30) )
		smokie:SetRoll( 100 )
		smokie:SetColor( (255 + 142 + 0) / 3, (255 + 118 + 164) / 3, (255 + 61 + 201) / 3 )
		smokie:SetGravity( Vector( 0,0,10 ) )
		smokie:SetAirResistance( 100 )
		smokie:SetDieTime( 5 )
		smokie:SetStartAlpha( 50 )
		smokie:SetEndAlpha( 0 )

		self.timer = CurTime()

	end

	smoothedall = Lerp( 10 * FrameTime(), smoothedall, self:GetAllTogether() * 422 / ( 10 + 40 + 100 ) )

	self:DrawModel()

	local dis = LocalPlayer():GetPos():Distance(self:GetPos())

	local FadeAlpha = 255 + yb.settings.ScreenFadeDist - dis

	local FadeAlphaH = 255 + yb.settings.ScreenFadeDist - dis

	if FadeAlphaH > 230 then

		FadeAlphaH = 230

	end


	if dis < 255 + yb.settings.ScreenFadeDist then

		cam.Start3D2D( self:LocalToWorld( Vector( 14.2, -10, -1.75 ) ) + self:GetUp()*33, self:LocalToWorldAngles( Angle( 0, 90, 90 ) ), 0.1 )

			draw.RoundedBox( 10, 0, 0, 200, 175, Color( 0, 0, 0, FadeAlphaH ) )
			draw.RoundedBox( 5, 10, 10, 180, 50, Color( 25, 25, 25, FadeAlpha ) )
			draw.RoundedBox( 5, 12, 12, 1.76 * self:GetProgress(), 46, Color( 142, 118, 61, FadeAlpha ) )
			draw.SimpleText( self:GetProgressText(), self:GetTextFont(), 14, 35, Color( 255, 255, 255, FadeAlpha ), 0, 1 )

			draw.RoundedBox( 5, 10, 70, 180, 95, Color( 25, 25, 25, FadeAlpha ) )
			draw.SimpleText( yb.language.Sugar.." - "..self:GetSugar().." g", "IngFont", 15, 70, Color( 255, 255, 255, FadeAlpha ), 0, 0 )
			draw.SimpleText( yb.language.Yeast.." - "..self:GetYeast().." dag", "IngFont", 15, 105, Color( 142, 118, 61, FadeAlpha ), 0, 0 )
			draw.SimpleText( yb.language.Water.." - "..self:GetWater().." L", "IngFont", 15, 140, Color( 0, 164, 201, FadeAlpha ), 0, 0 )

		cam.End3D2D()

		cam.Start3D2D( self:LocalToWorld( Vector( -3, -14.5, -32 ) ) + self:GetUp()*33, self:LocalToWorldAngles( Angle( -90, 0, 90 ) ), 0.1 )

			draw.RoundedBox( 10, 0, 0, 430, 60, Color( 0, 0, 0, FadeAlphaH ) )
			draw.RoundedBox( 10, 4, 4, smoothedall , 52, Color( (255 + 142 + 0) / 3, (255 + 118 + 164) / 3, (255 + 61 + 201) / 3, FadeAlpha ) )

		cam.End3D2D()

	end

end