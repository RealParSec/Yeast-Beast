ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Distiller"
ENT.Author = "Jewson"
ENT.Category = "Yeast Beast"
ENT.Contact = "GitHub"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "GasAmount" )
	self:NetworkVar( "Bool", 1, "AddBarrel" )
	self:NetworkVar( "Bool", 2, "Disti" )

end