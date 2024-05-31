local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")
local hook_run = hook.Run

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

local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")
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
			net.Start("lutiiikol")
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
			if ply:GetActiveWeapon():GetClass() != "wep_jack_hmcd_hands" then
				ply:DropWeapon()
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

concommand.Add("attach", function(ply,cmd,args)
	if !ply:IsAdmin() then return end
	ply:GetActiveWeapon():SetNWBool(args[1],true)
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
	ply:ManipulateBonePosition(ply:LookupBone("ValveBiped.Bip01_Spine2"), Vector((ply.Rost) or 0,0,0))

	end)
end)

hook.Add("Vars Player", "VarsS", function(ply)
	-- Alive give
	if PLYSPAWN_OVERRIDE then return end

	timer.Simple(.1, function()
		ply:Give("wep_jack_hmcd_hands") 
	end)

	if !ply.LifeID then ply.LifeID = 0 end
	ply.LifeID = ply.LifeID + 1

	---------------------------------

	-- Anatomy

	-- Base Vars

	ply.Blood = 5200
	ply:SetNWFloat("Stamina_Arm", 50)
	ply.stamina = {
		['leg']=50
	}
	ply.dmginfo = {
		['LastAttacker']=nil,
		['LastDMGPosition']=Vector(),
		['LastDMGWeaponName']=nil
	}
	ply.stamina_sound = false
	ply:StopSound("player/breathe1.wav")
	ply.Bleed = 0
	ply.pain = 0
	ply.IsBleeding = false
	ply.o2 = 1
	ply.Otrub = false
	ply:ConCommand("soundfade 0 1")
	ply.holdbreath = false
	ply.sprint = false

	ply.stamina_sound = false

	ply.pulse = 70
	ply.bullet_force = 0

	ply.adrenaline = 0
	ply.adrenaline_use = 0

	ply.msgLeftArm = 0
	ply.msgRightArm = 0
	ply.msgLeftLeg = 0
	ply.msgRightLeg = 0

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

hook.Add("PlayerSpawn", "VarsIS", function(ply) ply:SetTeam(1) hook_run("Vars Player", ply) end)

hook.Add("PlayerDeath", "VarsD", function(ply)
	ply:SetTeam(1)
	hook_run("Vars Player", ply)
end)

hook.Add("PlayerTick", "Glaza", function (ply)
    ply:SetEyeTarget(ply:GetEyeTrace().HitPos)
end)

hook.Add( "PlayerFootstep", "CustomFootstep", function( ply, pos, foot, sound, volume, rf )
	if ply:IsSprinting() and foot == 0 then
		ply:ViewPunch(Angle((ply.Bones["LeftLeg"] < 1 and 3) or 1,0,0))
	elseif ply:IsSprinting() and foot == 1 then
		ply:ViewPunch(Angle((ply.Bones["RightLeg"] < 1 and 3) or 1,0,0))
	end
end)