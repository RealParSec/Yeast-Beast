ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Fermentation Barrel"
ENT.Author = "Jewson"
ENT.Category = "Yeast Beast"
ENT.Contact = "GitHub"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()

	self:NetworkVar( "String", 0, "ProgressText" )
	self:NetworkVar( "Int", 1, "Progress" )
	self:NetworkVar( "String", 2, "TextFont")
	self:NetworkVar( "Int", 3, "Sugar" )
	self:NetworkVar( "Int", 4, "Yeast" )
	self:NetworkVar( "Bool", 5, "Fermenting")
	self:NetworkVar( "Int", 6, "Water" )
	self:NetworkVar( "Int", 7, "AllTogether" )
end
