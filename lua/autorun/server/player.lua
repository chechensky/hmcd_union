local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")
local hook_run = hook.Run
util.AddNetworkString("hmcd_equipment")

Male_Names={
	"Tumbochka",
	"Coder ZCity",
	"Fred",
	"Matthew",
	"Nikita",
	"Buyanov",
	"Alfredo",
	"Chonahui",
	"BoSvin"
}
Female_Names={
	"Mary",
	"Patricia",
	"Linda",
	"Barbara",
	"Elizabeth",
	"Jennifer",
	"Shalava",
	"DuraEbannaya",
	"Leah",
	"Penny",
	"Kay",
	"Priscilla",
	"Naomi",
	"Carole",
	"Brandy",
	"Olga",
	"Billie",
	"Dianne",
	"Tracey",
	"Leona",
	"Jenny",
	"Felicia",
	"Sonia",
	"Miriam",
	"Velma",
	"Becky",
	"Bobbie",
	"Violet",
	"Kristina",
	"Makayla",
	"Misty",
	"Mae",
	"Shelly",
	"Daisy",
	"Ramona",
	"Sherri",
	"Erika",
	"Katrina",
	"Claire"
}

-- functions meta

function PlayerMeta:Cough()
	if self.ModelSex == "male" then
		self:EmitSound("snd_jack_hmcd_cough_male.wav", 55, 80, 1, CHAN_AUTO)
	else
		self:EmitSound("snd_jack_hmcd_cough_female.wav", 55, 80, 1, CHAN_AUTO)
	end
end

function EntityMeta:IsUsingValidModel()
	local Mod = string.lower(self:GetModel())
	for key, maud in pairs(Models_Customize) do
		local ValidModel = string.lower(player_manager.TranslatePlayerModel(maud))
		if ValidModel == Mod then return true end
	end

	return false
end

function EntityMeta:SetClothing(outfit)
	self:SetMaterial()
	self:SetSubMaterial()
	if not outfit then return end
	if not self:IsUsingValidModel() then return end
	self:SetSubMaterial(self.ClothingMatIndex, "models/humans/" .. self.ModelSex .. "/group01/" .. outfit)
	self.ClothingType = outfit
end

function EntityMeta:GenerateClothes()
	local Type = table.Random(Clothes_Customize)
	if self.CustomClothes then
		Type = self.CustomClothes
	end

	self:SetSubMaterial()
	timer.Simple(
		.2,
		function()
			if IsValid(self) then
				self:SetClothing(Type)
			end
		end
	)
end

function EntityMeta:GenerateColor()
	local vec = Vector(math.Rand(0, 1), math.Rand(0, 1), math.Rand(0, 1))
	local Avg = (vec.x + vec.y + vec.z) / 3
	vec.x = Lerp(.2, vec.x, Avg)
	vec.y = Lerp(.2, vec.y, Avg)
	vec.z = Lerp(.2, vec.z, Avg)
	if self.CustomColor then
		vec = self.CustomColor
	end

	self:SetPlayerColor(vec)
end

function EntityMeta:SetAccessory(acc)
	if not acc then return end
	self.Accessory = acc
	local ent, sex = self, self.ModelSex
	timer.Simple(
		1,
		function()
			net.Start("accessory")
			net.WriteEntity(ent)
			net.WriteString(sex)
			net.WriteString(acc)
			net.Send(player.GetAll())
		end
	)
end

function EntityMeta:GenerateAccessories()
	local AccTable=table.GetKeys(AccessoryList)
	table.insert(AccTable,"eyeglasses") -- eyeglasses are the most common accessory
	table.insert(AccTable,"eyeglasses")
	table.insert(AccTable,"nerd glasses")
	local AccessoryName=table.Random(AccTable)
	if(math.random(1,3)==2)then AccessoryName="none" end
	if(self.CustomAccessory)then AccessoryName=self.CustomAccessory end
	self:SetAccessory(AccessoryName)
end

function EntityMeta:GenerateName()
	local Name=(self.ModelSex == "male") and table.Random(Male_Names) or table.Random(Female_Names)
	if self.CustomName then Name=self.CustomName end
	
	self:SetNWString("Character_Name", Name)
end

---------------------------------------------

hook.Add("PlayerSay", "DropWeapon", function(ply,text)
	if string.lower(text) == "*drop" then
        if !ply.fake then
			if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() != "wep_jack_hmcd_hands" and ply:GetActiveWeapon().PinOut != true then
				ply:DropWeapon()
				ply:ViewPunch(Angle(5,0,0))
				ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
            	return ""
			end
        else
            if IsValid(ply.wep) then
                if IsValid(ply.WepCons) then
                    ply.WepCons:Remove()
                    ply.WepCons=nil
                end
                if IsValid(ply.WepCons2) then
                    ply.WepCons2:Remove()
                    ply.WepCons2=nil
                end
                ply.wep.canpickup=true
                ply.wep:SetOwner()
                ply.wep.curweapon=ply.curweapon
                ply.Info.Weapons[ply.Info.ActiveWeapon].Clip1 = ply.wep.Clip
                ply:StripWeapon(ply.Info.ActiveWeapon)
                ply.Info.Weapons[ply.Info.ActiveWeapon]=nil
				ply.wep:Remove()
                ply.wep=nil
                ply.Info.ActiveWeapon=nil
                ply.Info.ActiveWeapon2=nil
                ply:SetActiveWeapon(nil)
                ply.FakeShooting=false
            end
            return ""
        end
	end
end)

concommand.Add("wagner", function(ply) --СВОСВОСВОСВО ZZZZZZZZZZZZZVVVVVVVVVVVV
    ply:SetMaterial("")
    for i = 0, 9 do
        ply:SetSubMaterial(i, "")
    end
	ply:SetModel("models/knyaje pack/sso_politepeople/sso_politepeople.mdl")
	ply:SetBodyGroups("010111111")
    --тут надо убрать (ресетнуть) акссесуар.
end)

concommand.Add("azov", function(ply) --свинота
    ply:SetMaterial("")
    for i = 0, 9 do
        ply:SetSubMaterial(i, "")
    end
	ply:SetModel("models/player/azov.mdl")
	ply:SetBodyGroups("122320000211") --да кстати, я не умею пользоваться там таблицами бодигрупп (ну или че там) короче говно тут, надо переделать и выставить все правильно.
    --тут надо убрать (ресетнуть) акссесуар.
end)

-- козявка пиздец ты ебанутый конча

concommand.Add("attach", function(ply,cmd,args)
	if !ply:IsAdmin() then return end
	if args[1] == "" then return end
	ply:GetActiveWeapon():SetNWBool(args[1], true)
end)

concommand.Add("unattach", function(ply,cmd,args)
	if !ply:IsAdmin() then return end
	ply:GetActiveWeapon():SetNWBool(args[1],false)
	ply:GetActiveWeapon().DrawnAttachments[args[1]] = ""
end)

local util_PCM = util.PrecacheModel

hook.Add("Identity", "IDGive", function(ply)

	timer.Simple(.2, function()

	local cl_playermodel, playerModel = ply:GetInfo("cl_playermodel"), table.Random(PlayerModels)
	cl_playermodel = playerModel.model
	local modelname = player_manager.TranslatePlayerModel(cl_playermodel)
	if ply.CustomModel then
		for key, maudhayle in pairs(PlayerModels) do
			if maudhayle.model == ply.CustomModel then
				playerModel = maudhayle
				break
			end
		end
	end
	cl_playermodel = playerModel.model
	local modelname = player_manager.TranslatePlayerModel(cl_playermodel)
	util_PCM(modelname)
	ply:SetModel(modelname)
	ply.ModelSex = playerModel.sex
	ply.ClothingMatIndex = playerModel.clothes
	ply:SetClothing("none")
	ply:SetBodygroup(1, 1)
	ply:SetBodygroup(2, math.random(0, 1))
	ply:SetBodygroup(3, math.random(0, 1))
	ply:SetBodygroup(4, math.random(0, 1))
	ply:SetBodygroup(5, math.random(0, 1))
    ply:GenerateClothes()
	ply:GenerateColor()
	ply:GenerateAccessories()
	ply:GenerateName()
	--ply:ManipulateBonePosition(ply:LookupBone("ValveBiped.Bip01_Spine2"), Vector((ply.Rost) or 0,0,0))

	end)
end)

hook.Add("Vars Player", "VarsS", function(ply)	-- Alive give
	if PLYSPAWN_OVERRIDE then return end

	timer.Simple(.1, function()
		ply:Give("wep_jack_hmcd_hands") 
	end)

	if !ply.LifeID then ply.LifeID = 0 end
	ply.LifeID = ply.LifeID + 1

	---------------------------------

	-- Anatomy

	-- Base Vars
	ply:SetNWBool("Breath", true)
	ply.Blood = 5200
	ply:SetNWFloat("Stamina_Arm", 50)
	ply.stamina = {
		['leg']=50
	}
	ply.staminaNext = 0
	ply.stamina_sound = false
	ply:StopSound("player/breathe1.wav")

	ply.BleedOuts = {
		["right_hand"] = 0,
		["left_hand"] = 0,

		["left_leg"] = 0,
		["right_leg"] = 0,

		["stomach"] = 0,
		["chest"] = 0
	}
	ply.Wounds = {
		["right_hand"] = 0,
		["left_hand"] = 0,

		["left_leg"] = 0,
		["right_leg"] = 0,

		["stomach"] = 0,
		["chest"] = 0
	}
	ply.Mics = {
		["Players"] = {},
		["Ents"] = {}
	}

	ply.temp = "Warm"
	ply:SetNWInt("SpectateMode", 0)
	ply:SetNWEntity("SelectPlayer", Entity(-1))
	ply.Equipment = {}
	ply.lasthitgroup = nil
	ply.capsicum = 0
	ply.MurdererIdentityHidden = false
	ply.overdose = 0
	ply.cant_eat = false
	ply.heartstop = false
	ply.pain = 0
	ply.pain_add = 0
	ply:SetNWString("Helmet", "")
	ply:SetNWString("Bodyvest", "")
	ply:SetNWString("Mask", "")

	ply.IsBleeding = false
	ply.o2 = 1
	ply.Otrub = false
	ply:ConCommand("soundfade 0 1")
	ply.sprint = false

	ply.stamina_sound = false

	ply.ArteryThink = 0

	ply.in_handcuff = false
	ply.pulse = 70
	ply.bullet_force = 0

	ply.adrenaline = 0
	ply.adrenaline_use = 0

	ply.Guilt_Sentence = nil
	ply.mutejaw = false
	ply.msgLeftArm = 0
	ply.msgRightArm = 0
	ply.msgLeftLeg = 0
	ply.msgRightLeg = 0

	-- adrenaline not experience:
	-- head
	ply.ane_neck = false
	ply.ane_jdis = false
	ply.ane_jaw = false
	-- legs
	ply.ane_rl = false
	ply.ane_ll = false
	-- arms
	ply.ane_ra = false
	ply.ane_la = false

	ply:SetNWBool("Headcrab", false)
	timer.Remove("HeadCrabEbashit"..ply:EntIndex())

	-- THink wokrs

	ply.pulseStart = 0
	ply.bloodNext = 0

	-- Anatomy Vars

	ply.Hit = {
		['lungs']=false,
		['liver']=false,
		['stomach']=false,
		['intestines']=false,
		['heart']=false,

		['neck_artery']=false,
		['rl_artery']=false,
		['ll_artery']=false,
		['rh_artery']=false,
		['rl_artery']=false,

		['spine']=false,

		['trahea']=false
	}

	ply.Bones = {
		['LeftArm']=1,
		['RightArm']=1,
		['LeftLeg']=1,
		['RightLeg']=1,
		['Jaw']=1
	}
	-- guilt sys
	if ply:GetNWInt("Guilt", 0) > 0 then
		ply:SetNWInt("Guilt", ply:GetNWInt("Guilt", 0) - math.random(1, 20))
	end

	if ply:GetNWInt("Guilt") < 0 then ply:SetNWInt("Guilt", 0) end

	timer.Simple(.3, function() ply:ChatPrint("You guilt: " .. ply:GetPData("U_Guilt", 0) .. "%") end)

	--
	hook_run("Identity", ply)
	---------------------------------
end)

hook.Add("PlayerSpawn", "VarsIS", function(ply) 
	ply:SetTeam(1) 
	ply.LastAttacker = nil
	ply:SetNWBool("Spectating",false)
	hook_run("Vars Player", ply)
end)

hook.Add("PlayerDeath", "VarsD", function(ply)
	ply:SetTeam(1)
	hook_run("Vars Player", ply)
end)

hook.Add("PlayerSay", "OtrubNoChat", function(ply)
	if ply.Otrub or ply.mutejaw then
		return ""
	end
end)

hook.Add("PlayerCanHearPlayersVoice", "OtrubNoVoice", function(list, talk)
	if talk.Otrub or talk.mutejaw then
		return false,false
	end
end)