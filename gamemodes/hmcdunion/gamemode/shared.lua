DeriveGamemode("sandbox")

GM.Name = "Homicide: Union"
GM.Author = "checha+Mannytko+Nab+quezkaly"
GM.Email = "N/A"
GM.Website = "N/A"
GM.TeamBased = true

include("loader.lua")

GM.papkago("hmcdunion/gamemode/gm/")

function GM:CreateTeams()
	team.SetUp(1,"White",Color(255,255,255))
	team.SetUp(2,"Black",Color(0,0,0))
	team.SetUp(3,"Gray",Color(149,149,149))
end

blood_drop = {
	"blood/drop1.wav",
	"blood/drop2.wav",
	"blood/drop3.wav",
	"blood/drop4.wav"
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