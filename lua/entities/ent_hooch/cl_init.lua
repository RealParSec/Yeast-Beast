include( "shared.lua" )

surface.CreateFont( "HoochFont", {
	font = "Arial", 
	extended = false,
	size = 60,
	weight = 900,
	blursize = 1,
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

surface.CreateFont( "HoochFont2", {
	font = "Arial", 
	extended = false,
	size = 20,
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

	self:DrawModel()

	local dis = LocalPlayer():GetPos():Distance(self:GetPos())

	local FadeAlpha = 255 + yb.settings.ScreenFadeDist - dis

	local FadeAlphaH = 255 + yb.settings.ScreenFadeDist - dis

	if FadeAlphaH > 230 then

		FadeAlphaH = 230

	end

	if dis < 255 + yb.settings.ScreenFadeDist then

		cam.Start3D2D( self:LocalToWorld( Vector( 16, -9, 5 ) ), self:LocalToWorldAngles( Angle( 0, 90, 90 ) ), 0.1 )

			draw.RoundedBox( 5, 0, 0, 180, 100, Color( 0, 0, 0, FadeAlphaH ) )
			draw.SimpleText( yb.language.Hooch, "HoochFont", 90, 0, Color( (255 + 142 + 0) / 3, (255 + 118 + 164) / 3, (255 + 61 + 201) / 3, FadeAlpha ), 1, 0 )
			draw.SimpleText( yb.language.Quality..": "..self:GetQuality().."%", "HoochFont2", 90, 80, Color( (255 + 142 + 0) / 3, (255 + 118 + 164) / 3, (255 + 61 + 201) / 3, FadeAlpha ), 1, 1 )

		cam.End3D2D()

	end

end