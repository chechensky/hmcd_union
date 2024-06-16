DeriveGamemode("sandbox")

GM.Name = "Homicide: Union"
GM.Author = "checha+Mannytko+Nab+quezkaly"
GM.Email = "N/A"
GM.Website = "N/A"
GM.TeamBased = true

-- checha gm ints!!!

GM.RoundName = "homicide"
GM.RoundNext = "homicide"
GM.RoundType = 2
GM.RoundState = 2
GM.Version = "0.0.1"
GM.Traitor = nil
GM.MVP = nil

-- round types hmcd
-- 1 = Standart
-- 2 = State of Emergency
-- 3 = Jihad
-- 4 = Wild West
-- 5 = Gun Free Zone

include("loader.lua")

GM.papkago("hmcdunion/gamemode/gm/")

function GM:CreateTeams()
	team.SetUp(1,"Players",Color(57,62,213))
	team.SetUp(2,"Spectators",Color(149,149,149))
end

blood_drop = {
	"blood/drop1.wav",
	"blood/drop2.wav",
	"blood/drop3.wav",
	"blood/drop4.wav"
}

Rounds = {
	"homicide",
	"sandbox",
	"hl2",
	"dm"
}

HMCD_REMOVEEQUIPMENT=-1
HMCD_ARMOR3A=1
HMCD_ARMOR3=2
HMCD_ACH=3
HMCD_GASMASK=4
HMCD_FLASHLIGHT=5
HMCD_PISTOLSUPP=6
HMCD_RIFLESUPP=7
HMCD_SHOTGUNSUPP=8
HMCD_LASERSMALL=9
HMCD_LASERBIG=10
HMCD_AIMPOINT=11
HMCD_EOTECH=12
HMCD_KOBRA=13
HMCD_PBS=14
HMCD_OSPREY=15
HMCD_BALLISTICMASK=16
HMCD_NVG=17
HMCD_MOTHELMET=18
HMCD_EquipmentNames = {
	[1] = "Level IIIA Armor",
	[2] = "Level III Armor",
	[3] = "Advanced Combat Helmet",
	[4] = "M40 Gas Mask",
	[5] = "Maglite ML300LX-S3CC6L Flashlight",
	[6] = "Cobra M2 Suppressor",
	[7] = "Hybrid 46 Suppressor",
	[8] = "Salvo 12 Suppressor",
	[9] = "Marcool JG5 Laser Sight",
	[10] = "AN/PEQ-15 Laser Sight",
	[11] = "Aimpoint CompM2 Sight",
	[12] = "EOTech 552.A65 Sight",
	[13] = "Kobra Sight",
	[14] = "PBS-1 Suppressor",
	[15] = "Osprey 45 Suppressor",
	[16] = "Ballistic Mask",
	[17] = "Ground Panoramic Night Vision Goggles",
	[18] = "Bell Bullitt Motorcycle Helmet"
}

HMCD_HelpRole = {
	["Traitor"] = "KILL'EM ALL!",
	["Bystander"] = "You innocent, just find traitor and kill him.",
	["Gunman"] = "You have a gun, kill traitor in your party."
}

RoundsNormalise = {
	["homicide"] = "Homicide",
	["sandbox"] = "Sandbox",
	["hl2"] = "Half Life 2 - Deathmatch",
	["dm"] = "Deathmatch",
	["svo"] = "Special Military Operation"
}

HMCD_Loadout = {
	["Traitor"] = {
		["1"] = {
			"ent_jack_hmcd_knife",
			"ent_jack_hmcd_shuriken",
			"ent_jack_hmcd_poisonneedle",
			"ent_jack_hmcd_poisonpowder",
			"ent_jack_hmcd_ied",
			"ent_jack_hmcd_oldgrenade",
			"ent_jack_hmcd_smokebomb",
			"ent_jack_hmcd_fakepistol",
			"ent_jack_hmcd_adrenaline",
			"ent_jack_hmcd_jam",
			"ent_jack_hmcd_poisonliquid",
			"ent_jack_hmcd_poisongoo",
			"ent_jack_hmcd_poisoncanister",
			"ent_jack_hmcd_mask",
			"ent_jack_hmcd_beartrap"
		}
	},
}

HMCD_RoundsTypeNormalise = {
	[0] = "",
	[1] = "Standart",
	[2] = "State of Emergency",
	[3] = "Jihad",
	[4] = "Wild West",
	[5] = "Gun-Free-Zone Mode"
}

HMCD_RoundStartSound = {
	[1]="snd_jack_hmcd_halloween.mp3",
	[2]="snd_jack_hmcd_disaster.mp3",
	[3]="snd_mann_islam.mp3",
	[4]="snd_jack_hmcd_wildwest.mp3",
	[5]="unknownsound.mp3"
}

RoundStartSound = {
	["dm"]="snd_jack_hmcd_deathmatch.mp3",
	["hl2"]="hl2mode1.wav"
}

Clothes_Customize={
	"normal",
	"casual",
	"formal",
	"young",
	"cold",
	"striped",
	"plaid",
	"none"
}

NormaliseKonech = {
	["left_hand"] = "Left arm",
	["left_leg"] = "Left leg",
	["right_hand"] = "Right arm",
	["right_leg"] = "Right leg",
	["stomach"] = "Stomach",
	["chest"] = "Chest"
}

Models_Customize={
	"male01",
	"male02",
	"male03",
	"male04",
	"male05",
	"male06",
	"male07",
	"male08",
	"male09",
	"female01",
	"female02",
	"female03",
	"female04",
	"female05",
	"female06"
}

PlayerModels = {}
function addModel(model, sex, clothes)
	local t = {}
	t.model = model
	t.sex = sex
	t.clothes = clothes
	table.insert(PlayerModels, t)
end

addModel("male01", "male", 3)
addModel("male02", "male", 2)
addModel("male03", "male", 4)
addModel("male04", "male", 4)
addModel("male05", "male", 4)
addModel("male06", "male", 0)
addModel("male07", "male", 4)
addModel("male08", "male", 0)
addModel("male09", "male", 2)
addModel("female01", "female", 2)
addModel("female02", "female", 3)
addModel("female03", "female", 3)
addModel("female04", "female", 1)
addModel("female05", "female", 2)
addModel("female06","female", 4)

AccessoryList={
	["Пусто"]={},
	["Очки"]={"models/captainbigbutt/skeyler/accessories/glasses01.mdl","ValveBiped.Bip01_Head1",{Vector(2.1,3,0),Angle(0,-70,-90),.9},{Vector(2.75,2,0),Angle(0,-70,-90),.8},false,0},
	["Солнцезащитные очки"]={"models/captainbigbutt/skeyler/accessories/glasses02.mdl","ValveBiped.Bip01_Head1",{Vector(2.9,2.2,0),Angle(0,-70,-90),.9},{Vector(3.5,1.25,0),Angle(0,-70,-90),.8},false,0},
	["Большие Солнцезащитные Очки"]={"models/captainbigbutt/skeyler/accessories/glasses04.mdl","ValveBiped.Bip01_Head1",{Vector(3.25,2.4,0),Angle(0,-70,-90),.9},{Vector(3.5,1.25,0),Angle(0,-70,-90),.8},false,0},
	["Очки Авиаторы"]={"models/gmod_tower/aviators.mdl","ValveBiped.Bip01_Head1",{Vector(2.2,2.9,0),Angle(0,-75,-90),.9},{Vector(2.8,1.9,0),Angle(0,-75,-90),.85},false,0},
	["Очки Ботана"]={"models/gmod_tower/klienerglasses.mdl","ValveBiped.Bip01_Head1",{Vector(2.6,2.9,0),Angle(0,-75,-90),1},{Vector(2.6,2.3,0),Angle(0,-80,-90),.9},false,0},
	["Наушники"]={"models/gmod_tower/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(.5,3,0),Angle(0,-90,-90),.9},{Vector(1,2.3,0),Angle(0,-90,-90),.8},false,0},
	["Бейсболка"]={"models/gmod_tower/jaseballcap.mdl","ValveBiped.Bip01_Head1",{Vector(.05,5.1,0),Angle(0,-75,-90),1.125},{Vector(0,4.2,0),Angle(0,-75,-90),1.1},true,0},
	["Шляпа"]={"models/captainbigbutt/skeyler/hats/fedora.mdl","ValveBiped.Bip01_Head1",{Vector(.25,5.5,0),Angle(0,-75,-90),.7},{Vector(0,4.8,0),Angle(0,-75,-90),.65},true,0},
	["Ковбойская шляпа"]={"models/captainbigbutt/skeyler/hats/cowboyhat.mdl","ValveBiped.Bip01_Head1",{Vector(.3,6,0),Angle(0,-70,-90),.75},{Vector(.25,5.6,0),Angle(0,-75,-90),.7},true,0},
	["Соломенная шляпа"]={"models/captainbigbutt/skeyler/hats/strawhat.mdl","ValveBiped.Bip01_Head1",{Vector(.75,5,0),Angle(0,-75,-90),.85},{Vector(.5,4.5,0),Angle(0,-75,-90),.75},true,0},
	["Солнцезащитная шляпа"]={"models/captainbigbutt/skeyler/hats/sunhat.mdl","ValveBiped.Bip01_Head1",{Vector(-1.5,3.5,0),Angle(0,-75,-90),.8},{Vector(-1.5,3,0),Angle(0,-75,-90),.75},true,0},
	["Побрякушки"]={"models/captainbigbutt/skeyler/hats/zhat.mdl","ValveBiped.Bip01_Head1",{Vector(.7,3.75,.3),Angle(0,-75,-90),.75},{Vector(.3,3,.25),Angle(0,-75,-90),.75},true,0},
	["Цилиндр"]={"models/player/items/humans/top_hat.mdl","ValveBiped.Bip01_Head1",{Vector(2,-1,0),Angle(0,-80,-90),1.025},{Vector(2,-1,0),Angle(0,-80,-90),.95},true,0},
	["Рюкзак"]={"models/makka12/bag/jag.mdl","ValveBiped.Bip01_Spine4",{Vector(0,-3,0),Angle(0,90,90),.7},{Vector(.5,-3,0),Angle(0,90,90),.6},false,0},
	["Кошелек"]={"models/props_c17/BriefCase001a.mdl","ValveBiped.Bip01_Spine1",{Vector(-3,-10,7),Angle(0,90,90),.6},{Vector(-3,-10,7),Angle(0,90,90),.6},false,0},
	-- gen 2
	["Серая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,0},
	["Светло-серая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,2},
	["Белая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,3},
	["Зелёная кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,4},
	["Тёмно-зелёная кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,5},
	["Коричневая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,6},
	["Синяя кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,7},

	["Бандана"]={"models/modified/bandana.mdl","ValveBiped.Bip01_Head1",{Vector(1.1,-1.2,0),Angle(0,-75,-90),1},{Vector(1,-1.5,0),Angle(0,-80,-90),.9},false,0},

	["Белый шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,0},
	["Серый шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,1},
	["Черный шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,2},
	["Синий шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,3},
	["Красный шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,4},
	["Зелёный шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,5},
	["Розовый шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,6},

	["Красные наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,0},
	["Розовые наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,1},
	["Зелёные наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,2},
	["Жёлтые наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,3},

	["Серая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,0},
	["Черная шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,1},
	["Белая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,2},
	["Бежевая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,3},
	["Бордовая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,5},
	["Синяя шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,7},

	["Полосатая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,0},
	["Голубая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,1},
	["Фиолетовая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,2},
	["Белая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,3},
	["Серая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,4},

	["Большой красный рюкзак"]={"models/modified/backpack_1.mdl","ValveBiped.Bip01_Spine4",{Vector(-2,-8,0),Angle(0,90,90),1},{Vector(-2,-8,0),Angle(0,90,90),.9},false,0},
	["Большой серый рюкзак"]={"models/modified/backpack_1.mdl","ValveBiped.Bip01_Spine4",{Vector(-2,-8,0),Angle(0,90,90),1},{Vector(-2,-8,0),Angle(0,90,90),.9},false,1},

	["Обычный Рюкзак"]={"models/modified/backpack_3.mdl","ValveBiped.Bip01_Spine4",{Vector(-3,-6,0),Angle(0,90,90),.9},{Vector(-3,-6,0),Angle(0,90,90),.8},false,0},
	["Серый рюкзак"]={"models/modified/backpack_3.mdl","ValveBiped.Bip01_Spine4",{Vector(-3,-6,0),Angle(0,90,90),.9},{Vector(-3,-6,0),Angle(0,90,90),.8},false,1}
}

AccessoryListWithoutEmpty={
	["Очки"]={"models/captainbigbutt/skeyler/accessories/glasses01.mdl","ValveBiped.Bip01_Head1",{Vector(2.1,3,0),Angle(0,-70,-90),.9},{Vector(2.75,2,0),Angle(0,-70,-90),.8},false,0},
	["Солнцезащитные очки"]={"models/captainbigbutt/skeyler/accessories/glasses02.mdl","ValveBiped.Bip01_Head1",{Vector(2.9,2.2,0),Angle(0,-70,-90),.9},{Vector(3.5,1.25,0),Angle(0,-70,-90),.8},false,0},
	["Большие Солнцезащитные Очки"]={"models/captainbigbutt/skeyler/accessories/glasses04.mdl","ValveBiped.Bip01_Head1",{Vector(3.25,2.4,0),Angle(0,-70,-90),.9},{Vector(3.5,1.25,0),Angle(0,-70,-90),.8},false,0},
	["Очки Авиаторы"]={"models/gmod_tower/aviators.mdl","ValveBiped.Bip01_Head1",{Vector(2.2,2.9,0),Angle(0,-75,-90),.9},{Vector(2.8,1.9,0),Angle(0,-75,-90),.85},false,0},
	["Очки Ботана"]={"models/gmod_tower/klienerglasses.mdl","ValveBiped.Bip01_Head1",{Vector(2.6,2.9,0),Angle(0,-75,-90),1},{Vector(2.6,2.3,0),Angle(0,-80,-90),.9},false,0},
	["Наушники"]={"models/gmod_tower/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(.5,3,0),Angle(0,-90,-90),.9},{Vector(1,2.3,0),Angle(0,-90,-90),.8},false,0},
	["Бейсболка"]={"models/gmod_tower/jaseballcap.mdl","ValveBiped.Bip01_Head1",{Vector(.05,5.1,0),Angle(0,-75,-90),1.125},{Vector(0,4.2,0),Angle(0,-75,-90),1.1},true,0},
	["Шляпа"]={"models/captainbigbutt/skeyler/hats/fedora.mdl","ValveBiped.Bip01_Head1",{Vector(.25,5.5,0),Angle(0,-75,-90),.7},{Vector(0,4.8,0),Angle(0,-75,-90),.65},true,0},
	["Ковбойская шляпа"]={"models/captainbigbutt/skeyler/hats/cowboyhat.mdl","ValveBiped.Bip01_Head1",{Vector(.3,6,0),Angle(0,-70,-90),.75},{Vector(.25,5.6,0),Angle(0,-75,-90),.7},true,0},
	["Соломенная шляпа"]={"models/captainbigbutt/skeyler/hats/strawhat.mdl","ValveBiped.Bip01_Head1",{Vector(.75,5,0),Angle(0,-75,-90),.85},{Vector(.5,4.5,0),Angle(0,-75,-90),.75},true,0},
	["Солнцезащитная шляпа"]={"models/captainbigbutt/skeyler/hats/sunhat.mdl","ValveBiped.Bip01_Head1",{Vector(-1.5,3.5,0),Angle(0,-75,-90),.8},{Vector(-1.5,3,0),Angle(0,-75,-90),.75},true,0},
	["Побрякушки"]={"models/captainbigbutt/skeyler/hats/zhat.mdl","ValveBiped.Bip01_Head1",{Vector(.7,3.75,.3),Angle(0,-75,-90),.75},{Vector(.3,3,.25),Angle(0,-75,-90),.75},true,0},
	["Цилиндр"]={"models/player/items/humans/top_hat.mdl","ValveBiped.Bip01_Head1",{Vector(2,-1,0),Angle(0,-80,-90),1.025},{Vector(2,-1,0),Angle(0,-80,-90),.95},true,0},
	["Рюкзак"]={"models/makka12/bag/jag.mdl","ValveBiped.Bip01_Spine4",{Vector(0,-3,0),Angle(0,90,90),.7},{Vector(.5,-3,0),Angle(0,90,90),.6},false,0},
	["Кошелек"]={"models/props_c17/BriefCase001a.mdl","ValveBiped.Bip01_Spine1",{Vector(-3,-10,7),Angle(0,90,90),.6},{Vector(-3,-10,7),Angle(0,90,90),.6},false,0},
	-- gen 2
	["Серая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,0},
	["Светло-серая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,2},
	["Белая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,3},
	["Зелёная кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,4},
	["Тёмно-зелёная кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,5},
	["Коричневая кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,6},
	["Синяя кепка"]={"models/modified/hat07.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4.5,.2),Angle(0,-75,-90),1},{Vector(0,4.5,0),Angle(0,-75,-90),.95},true,7},

	["Бандана"]={"models/modified/bandana.mdl","ValveBiped.Bip01_Head1",{Vector(1.1,-1.2,0),Angle(0,-75,-90),1},{Vector(1,-1.5,0),Angle(0,-80,-90),.9},false,0},

	["Белый шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,0},
	["Серый шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,1},
	["Черный шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,2},
	["Синий шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,3},
	["Красный шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,4},
	["Зелёный шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,5},
	["Розовый шарф"]={"models/sal/acc/fix/scarf01.mdl","ValveBiped.Bip01_Spine4",{Vector(-10,-17,0),Angle(0,70,90),1},{Vector(-9,-19.5,0),Angle(0,70,90),1},false,6},

	["Красные наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,0},
	["Розовые наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,1},
	["Зелёные наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,2},
	["Жёлтые наушники"]={"models/modified/headphones.mdl","ValveBiped.Bip01_Head1",{Vector(1,2.5,0),Angle(0,-90,-90),.9},{Vector(1,2,0),Angle(0,-90,-90),.9},false,3},

	["Серая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,0},
	["Черная шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,1},
	["Белая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,2},
	["Бежевая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,3},
	["Бордовая шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,5},
	["Синяя шляпа"]={"models/modified/hat01_fix.mdl","ValveBiped.Bip01_Head1",{Vector(-.1,4.1,0),Angle(0,-75,-90),.9},{Vector(-.5,4,0),Angle(0,-75,-90),.9},true,7},

	["Полосатая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,0},
	["Голубая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,1},
	["Фиолетовая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,2},
	["Белая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,3},
	["Серая шапочка"]={"models/modified/hat03.mdl","ValveBiped.Bip01_Head1",{Vector(.1,4,0),Angle(0,-75,-90),1},{Vector(-.2,3.5,0),Angle(0,-75,-90),1},true,4},

	["Большой красный рюкзак"]={"models/modified/backpack_1.mdl","ValveBiped.Bip01_Spine4",{Vector(-2,-8,0),Angle(0,90,90),1},{Vector(-2,-8,0),Angle(0,90,90),.9},false,0},
	["Большой серый рюкзак"]={"models/modified/backpack_1.mdl","ValveBiped.Bip01_Spine4",{Vector(-2,-8,0),Angle(0,90,90),1},{Vector(-2,-8,0),Angle(0,90,90),.9},false,1},

	["Обычный Рюкзак"]={"models/modified/backpack_3.mdl","ValveBiped.Bip01_Spine4",{Vector(-3,-6,0),Angle(0,90,90),.9},{Vector(-3,-6,0),Angle(0,90,90),.8},false,0},
	["Серый рюкзак"]={"models/modified/backpack_3.mdl","ValveBiped.Bip01_Spine4",{Vector(-3,-6,0),Angle(0,90,90),.9},{Vector(-3,-6,0),Angle(0,90,90),.8},false,1}
}

HMCD_AmmoWeights={
	["AlyxGun"]=4,
	["Pistol"]=12,
	["HelicopterGun"]=30,
	["357"]=15,
	["AirboatGun"]=3,
	["Buckshot"]=60,
	["AR2"]=50,
	["MP5_Grenade"]=60,
	["SMG1"]=18,
	["Gravity"]=18,
	["SniperRound"]=20,
	["XBowBolt"]=22,
	["Thumper"]=26,
	["StriderMinigun"]=20,
	["RPG_Round"]=150,
	["9mmRound"]=8,
	["Hornet"]=30,
	["SniperPenetratedRound"]=20
}

HMCD_AmmoNames={
	["AlyxGun"]="5.7x16mm (.22 long rifle)",
	["Pistol"]="9x19mm (9mm luger/parabellum)",
	["357"]="9x29mmR (.38 special)",
	["SMG1"]="5.56x45mm (.223 remington)",
	["Buckshot"]="18.5x70mmR (12 gauge shotshell)",
	["AR2"]="7x57mm (7mm mauser)",
	["XBowBolt"]="6x735mm broadhead hunting arrow",
	["AirboatGun"]="2x89mm Carpentry Nail",
	["RPG_Round"]="40mm Rocket",
	["StriderMinigun"]="7.62x51 NATO",
	["HelicopterGun"]="4.6x30mm",
	["SniperRound"]="7.62x39mm",
	["Gravity"]="Pulse Slug",
	["Thumper"]="300mm Rebar",
	["MP5_Grenade"]="Energy Ball",
	["SniperPenetratedRound"]="X26 Taser Cartridge",
	["9mmRound"]="9×22mm P.A.",
	["Hornet"]="Flexible Baton Round"
}

Box_Models = {
	"models/props_c17/FurnitureDrawer001a.mdl",
	"models/props_c17/FurnitureDresser001a.mdl",
	"models/props_c17/FurnitureDrawer003a.mdl",
	"models/props_c17/FurnitureCupboard001a.mdl",
	"models/props_c17/shelfunit01a.mdl",
	"models/props_junk/cardboard_box002a_gib01.mdl",
	"models/props_junk/cardboard_box002a.mdl",
	"models/props_junk/cardboard_box001b.mdl",
	"models/props_junk/cardboard_box001a_gib01.mdl",
	"models/props_junk/cardboard_box002b.mdl",
	"models/props_junk/cardboard_box003a.mdl",
	"models/props_junk/cardboard_box003a_gib01.mdl",
	"models/props_junk/cardboard_box003b_gib01.mdl",
	"models/props_junk/cardboard_box004a.mdl",
	"models/props_junk/cardboard_box004a_gib01.mdl",
	"models/props_junk/wood_crate001a.mdl",
	"models/props_junk/wood_crate001a_damaged.mdl",
	"models/props_junk/wood_crate002a.mdl"
}

HeavyBox_Models = {
	"models/props_junk/wood_crate002a.mdl",
	"models/props_c17/FurnitureDresser001a.mdl",
	"models/props_c17/FurnitureDrawer003a.mdl"
}

Box_Drop = {
	"ent_jack_hmcd_ammo",
	"ent_jack_hmcd_fooddrinkbig",
	"ent_jack_hmcd_fooddrink",
	"ent_jack_hmcd_ptrd",
	"ent_jack_hmcd_adrenaline",
	"ent_jack_hmcd_medkit",
	"ent_jack_hmcd_bandagebig",
	"ent_jack_hmcd_morphine",
	"ent_jack_hmcd_painpills",
	"ent_jack_hmcd_bandage",
	"ent_jack_hmcd_baseballbat",
	"ent_jack_hmcd_brick",
	"ent_jack_hmcd_cleaver",
	"ent_jack_hmcd_hammer",
	"ent_jack_hmcd_pocketknife",
	"ent_jack_hmcd_crowbar",
	"ent_jack_hmcd_hatchet",
	"ent_jack_hmcd_leadpipe",
	"ent_jack_hmcd_axe",
	"ent_jack_hmcd_smallpistol",
	"ent_jack_hmcd_ducttape",
	"ent_jack_hmcd_oldgrenade_dm",
	"ent_jack_hmcd_glock17",
	"ent_jack_hmcd_revolver",
	"ent_jack_hmcd_rifle",
	"ent_jack_hmcd_sr25",
	"ent_jack_hmcd_mp7",
	"ent_jack_hmcd_shotgun",
	"ent_jack_hmcd_dbarrel",
	"ent_jack_hmcd_remington",
	"ent_jack_hmcd_bugbait"
}

HeavyBox_Drop = {
	"ent_jack_hmcd_ptrd",
	"ent_jack_hmcd_adrenaline",
	"ent_jack_hmcd_medkit",
	"ent_jack_hmcd_oldgrenade_dm",
	"ent_jack_hmcd_glock17",
	"ent_jack_hmcd_revolver",
	"ent_jack_hmcd_rifle",
	"ent_jack_hmcd_sr25",
	"ent_jack_hmcd_mp7",
	"ent_jack_hmcd_shotgun",
	"ent_jack_hmcd_dbarrel",
	"ent_jack_hmcd_remington"
}

AmmoType_Drop = {
	"AirboatGun",
	"AlyxGun",
	"357",
	"Pistol",
	"Buckshot",
	"AR2",
	"SMG1",
	"XBowBolt",
	"AirboatGun"
}
local sights={
    [1]=Material( "models/weapons/tfa_ins2/optics/kobra_dot", "noclamp nocull smooth"),
    [2]=Material( "models/weapons/tfa_ins2/optics/eotech_reticule", "noclamp nocull smooth"),
    [3]=Material( "scope/aimpoint", "noclamp nocull smooth"),
	[4]=Material( "scope/aimpoint", "noclamp nocull smooth")
}

local sightRight = {
	["wep_jack_hmcd_mp7"] = {
		[1] = 20,
		[2] = 0,
		[3] = 0
	},
	["wep_jack_hmcd_glock17"] = {
		[4] = -5
	}
}

local sightUp = {
	["wep_jack_hmcd_akm"] = {
		[1] = -100,
		[2] = -120,
		[3] = -100
	},
	["wep_jack_hmcd_glock17"] = {
		[4] = -20
	}
}

local size = {
	[1] = 230,
	[2] = 200,
	[3] = 600,
	[4] = 350
}

function GM:DrawScopeDot(wep, sightnum, model,vm)
    if IsValid(wep) and wep.ScopeDotAngle then


    	model.sight3 = Material("models/weapons/tfa_ins2/optics/eotech_lense")
    	model.sight3:SetTexture("$basetexture","empty")

    	model.sight2 = Material("models/weapons/tfa_ins2/optics/aimpoint_lense")
    	model.sight2:SetTexture("$basetexture","empty")

        local material = sights[sightnum]
        if IsValid(model) then
    		render.UpdateScreenEffectTexture()
    		render.ClearStencil()
    		render.SetStencilEnable(true)
    		render.SetStencilCompareFunction(STENCIL_ALWAYS)
    		render.SetStencilPassOperation(STENCIL_REPLACE)
    		render.SetStencilFailOperation(STENCIL_KEEP)
    		render.SetStencilZFailOperation(STENCIL_REPLACE)

            render.SetBlend(0)

			render.SetStencilReferenceValue(56)

            model:DrawModel()

            render.SetBlend(1)
    		render.SetStencilPassOperation(STENCIL_KEEP)
    		render.SetStencilCompareFunction(STENCIL_EQUAL)

        end
        render.SetMaterial(material)
		local sight_upped
		if sightUp[wep:GetClass()] then
			sight_upped = sightUp[wep:GetClass()][sightnum]
		else
			sight_upped = 0
		end

		local sight_righited
		if sightRight[wep:GetClass()] then
			sight_righited = sightRight[wep:GetClass()][sightnum]
		else
			sight_righited = 0
		end
		local size = size[sightnum]

		local pos = LocalPlayer():EyePos()
        local up = model:GetAngles():Up()
        local right = model:GetAngles():Right()
		pos = pos + model:GetAngles():Forward() * 4200 + model:GetAngles():Up() * sight_upped + model:GetAngles():Right() * sight_righited

        render.DrawQuad(pos + (up * size / 2) - (right * size / 2), pos + (up * size / 2) + (right * size / 2), pos - (up * size / 2) + (right * size / 2), pos - (up * size / 2) - (right * size / 2), Color(255,255,255,255))

    	render.SetStencilEnable(false)
    end
end