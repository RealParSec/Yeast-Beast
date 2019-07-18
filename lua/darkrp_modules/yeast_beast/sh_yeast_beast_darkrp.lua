TEAM_YB_HOOCHMAKER = DarkRP.createJob("Hooch Maker", {
	color = Color(0, 128, 255, 255),
	model = {
		"models/player/hostage/hostage_04.mdl",
		"models/player/hostage/hostage_01.mdl"},
	description = [[Make hooch. Get drunk. Have fun. Wake up... Where the f*** am I?]],
	weapons = {},
	command = "hoochmaker",
	max = 5,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Other"
})

DarkRP.createCategory{
    name = "Hooch Stuff",
    categorises = "entities",
    startExpanded = true,
    color = Color( (255 + 142 + 0) / 3, (255 + 118 + 164) / 3, (255 + 61 + 201) / 3, 255),
    canSee = function(ply)
		return (ply:Team() == TEAM_YB_HOOCHMAKER)
	end,
    sortOrder = 90,
}

DarkRP.createEntity("Fermentation Barrel", {
	ent = "ent_fermbarrel",
	model = "models/props_c17/oildrum001.mdl",
	price = 500,
	max = 2,
	cmd = "buyybfermbarrel",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})

DarkRP.createEntity("Sugar", {
	ent = "ent_sugar_1000",
	model = "models/props_junk/garbage_bag001a.mdl",
	price = 200,
	max = 10,
	cmd = "buyybsugar",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})

DarkRP.createEntity("Water", {
	ent = "ent_water",
	model = "models/props_junk/garbage_plasticbottle003a.mdl",
	price = 100,
	max = 10,
	cmd = "buyybwater",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})

DarkRP.createEntity("Yeast", {
	ent = "ent_yeast",
	model = "models/props_lab/box01a.mdl",
	price = 150,
	max = 10,
	cmd = "buyybyeast",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})

DarkRP.createEntity("Distiller", {
	ent = "ent_distiller",
	model = "models/props_wasteland/kitchen_stove002a.mdl",
	price = 1000,
	max = 1,
	cmd = "buyybdistiller",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})

DarkRP.createEntity("Heat Stand", {
	ent = "ent_heatstand",
	model = "models/props_junk/wood_pallet001a.mdl",
	price = 1200,
	max = 1,
	cmd = "buyybheatstand",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})

DarkRP.createEntity("Pipes", {
	ent = "ent_pipes",
	model = "models/props_junk/cardboard_box003a.mdl",
	price = 500,
	max = 1,
	cmd = "buyybpipes",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})

DarkRP.createEntity("Gas Tank", {
	ent = "ent_gastank",
	model = "models/props_c17/canister01a.mdl",
	price = 300,
	max = 2,
	cmd = "buyybgastank",
	category = "Hooch Stuff",
	allowed = {TEAM_YB_HOOCHMAKER}
})