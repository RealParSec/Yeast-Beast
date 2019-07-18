ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Barrel of Hooch"
ENT.Author = "Jewson"
ENT.Category = "Yeast Beast"
ENT.Contact = "GitHub"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "Quality")

end