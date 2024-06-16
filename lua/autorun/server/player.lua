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
				ply:AddGesture(48)
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

concommand.Add("wagner", function(ply)
	ply:SetModel("models/knyaje pack/sso_politepeople/sso_politepeople.mdl")
end)

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
	ply:SetNWBool("Spectating",false)
	ply:SetNWInt("SpectateMode", 0)
	ply:SetNWEntity("SelectPlayer", Entity(-1))
	ply.Equipment = {}
	ply.lasthitgroup = nil
	ply.capsicum = 0
	ply.MurdererIdentityHidden = false
	ply.overdose = 0
	ply.cant_eat = false
	ply.LastAttacker = nil
	ply.heartstop = false
	ply.pain = 0
	ply.pain_add = 0

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
	hook_run("Identity", ply)
	---------------------------------
end)

hook.Add("PlayerSpawn", "VarsIS", function(ply) 
	ply:SetTeam(1) 
	hook_run("Vars Player", ply)
end)

hook.Add("PlayerDeath", "VarsD", function(ply)
	ply:SetTeam(1)
	hook_run("Vars Player", ply)
end)

local atts_simplified={
	[HMCD_PISTOLSUPP]="Suppressor",
	[HMCD_RIFLESUPP]="Suppressor",
	[HMCD_SHOTGUNSUPP]="Suppressor",
	[HMCD_LASERSMALL]="Laser",
	[HMCD_LASERBIG]="Laser",
	[HMCD_KOBRA]="Sight",
	[HMCD_AIMPOINT]="Sight2",
	[HMCD_EOTECH]="Sight3",
	[HMCD_PBS]="Suppressor",
	[HMCD_OSPREY]="Suppressor"
}

concommand.Add("hmcd_attachrequest",function(ply,cmd,args)
	local attachment=math.Round(args[1])
	local wep=ply:GetActiveWeapon()
	if wep:GetNWBool(atts_simplified[attachment]) then
		if ply.Equipment[HMCD_EquipmentNames[attachment]] then ply:PrintMessage(HUD_PRINTTALK, "You already have this attachment!") return end
		wep:SetNWBool(atts_simplified[attachment],false)
		ply.Equipment[HMCD_EquipmentNames[attachment]]=true
		net.Start("hmcd_equipment")
		net.WriteInt(attachment,6)
		net.WriteBit(true)
		net.Send(ply)
	else
		if attachment==HMCD_LASERBIG and (wep:GetNWBool("Sight") or wep:GetNWBool("Sight2") or wep:GetNWBool("Sight3")) and not(wep.MultipleRIS) then
			ply:PrintMessage(HUD_PRINTTALK, "You can't apply this attachment! There isn't enough space!")
			return
		end
		if (attachment==HMCD_EOTECH or attachment==HMCD_KOBRA or attachment==HMCD_AIMPOINT) and wep:GetNWBool("Laser") and not(wep.MultipleRIS) then
			ply:PrintMessage(HUD_PRINTTALK, "You can't apply this attachment! There isn't enough space!")
			return
		end
		if (attachment==HMCD_KOBRA or attachment==HMCD_AIMPOINT or attachment==HMCD_EOTECH) and (wep:GetNWBool("Sight") or wep:GetNWBool("Sight2") or wep:GetNWBool("Sight3")) then
			ply:PrintMessage(HUD_PRINTTALK, "You already have a sight attached!")
			return
		end
		if wep:GetClass() == "wep_jack_hmcd_akm" and attachment==HMCD_KOBRA or attachment==HMCD_AIMPOINT or attachment==HMCD_EOTECH then
			wep:SetNWBool("Rail", true)
		end
		wep:SetNWBool(atts_simplified[attachment],true)
		ply.Equipment[HMCD_EquipmentNames[attachment]]=false
		net.Start("hmcd_equipment")
		net.WriteInt(attachment,6)
		net.WriteBit(false)
		net.Send(ply)
	end
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