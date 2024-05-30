AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName		= "Ammo"
ENT.ImpactSound="physics/metal/weapon_impact_soft1.wav"
ENT.SWEPS={
	["AlyxGun"]={"wep_jack_hmcd_suppressed"},
	["Pistol"]={"wep_jack_hmcd_pistol","wep_jack_hmcd_smallpistol","wep_jack_hmcd_mp5"},
	["357"]={"wep_jack_hmcd_revolver"},
	["Buckshot"]={"wep_jack_hmcd_shotgun","wep_jack_hmcd_dbarrel"},
	["AR2"]={"wep_jack_hmcd_rifle","wep_jack_hmcd_suppressedrifle"},
	["SMG1"]={"wep_jack_hmcd_assaultrifle","wep_jack_hmcd_aresshrike"},
	["AirboatGun"]={"wep_jack_hmcd_hammer"},
	["StriderMinigun"]={"wep_jack_hmcd_sr25"},
	["SniperRound"]={"wep_jack_hmcd_akm"},
	["RPG_Round"]={"wep_jack_hmcd_rpg"},
	["HelicopterGun"]={"wep_jack_hmcd_mp7"},
	["XBowBolt"]={"wep_jack_hmcd_bow"},
	["Gravity"]={"wep_jack_hmcd_ar2"},
	["MP5_Grenade"]={"wep_jack_hmcd_ar2"},
	["Thumper"]={"wep_jack_hmcd_crossbow"},
	["9mmRound"]={"wep_jack_hmcd_makarych"},
	["Hornet"]={"wep_jack_hmcd_remington"},
	["SniperPenetratedRound"]={"wep_jack_hmcd_taser"}
}
ENT.Skins={
	["AlyxGun"]="models/hmcd_ammobox_22",
	["Pistol"]="models/hmcd_ammobox_9",
	["357"]="models/hmcd_ammobox_38",
	["Buckshot"]="models/hmcd_ammobox_12",
	["AR2"]="models/hmcd_ammobox_792",
	["SMG1"]="models/hmcd_ammobox_556",
	["AirboatGun"]="models/hmcd_ammobox_nails",
	["StriderMinigun"]="models/ammo76251/smg",
	["SniperRound"]="models/ammo76239/smg",
	["SniperPenetratedRound"]="models/defcon/taser/taser"
}
ENT.Numbers={
	["AlyxGun"]=150,
	["Pistol"]=50,
	["357"]=50,
	["AirboatGun"]=40,
	["Buckshot"]=30,
	["AR2"]=30,
	["SMG1"]=30,
	["XBowBolt"]=20,
	["StriderMinigun"]=30,
	["SniperRound"]=30,
	["RPG_Round"]=1,
	["MP5_Grenade"]=1,
	["HelicopterGun"]=30,
	["Gravity"]=30,
	["Thumper"]=20,
	["9mmRound"]=50,
	["Hornet"]=30,
	["SniperPenetratedRound"]=5
}
ENT.Models={
	["StriderMinigun"]="models/items/ammo_76251.mdl",
	["XBowBolt"]="models/items/ammo/ammo_arrow_box.mdl",
	["HelicopterGun"]="models/4630_ammobox.mdl",
	["SniperRound"]="models/items/ammo_76239.mdl",
	["Gravity"]="models/items/combine_rifle_cartridge01.mdl",
	["Thumper"]="models/items/crossbowrounds.mdl",
	["MP5_Grenade"]="models/items/combine_rifle_ammo01.mdl",
	["9mmRound"]="models/ammo/beanbag9_ammo.mdl",
	["Hornet"]="models/ammo/beanbag12_ammo.mdl",
	["SniperPenetratedRound"]="models/ammo/taser_ammo.mdl"
}
if(SERVER)then
	function ENT:Initialize()
		--if(self.AmmoType=="XBowBolt")then
			--self:DropArrows()
			--return
		--end
		if(self.AmmoType=="RPG_Round")then
			self:DropRocket()
			return
		end
		if not(self.AmmoType)then self.AmmoType="Pistol" end
		if self.Models[self.AmmoType]!=nil then
			self.Entity:SetModel(self.Models[self.AmmoType])
		else
			self.Entity:SetModel("models/props_lab/box01a.mdl")
		end
		if self.Skins[self.AmmoType]!=nil then
			self.Entity:SetMaterial(self.Skins[self.AmmoType])
		end
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetMass(15)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end
	function ENT:BecomeArrows()
		local Arrows={}
		for i=1,math.ceil(math.random(1,40)^math.Rand(0,1)) do
			local Arrow=ents.Create("ent_jack_hmcd_arrow")
			Arrow.HmcdSpawned=true
			Arrow:SetPos(self:GetPos()+VectorRand())
			Arrow:SetAngles(self:GetAngles())
			Arrow:Spawn()
			Arrow:Activate()
			Arrows[i]=Arrow
		end
		for key,arrow in pairs(Arrows)do
			for k,other in pairs(Arrows)do
				if not(other==arrow)then constraint.Weld(arrow,other,0,0,5000,true,false) end
			end
		end
		self:Remove()
	end
	function ENT:DropArrows()
		local Arrows={}
		for i=1,Amount do
			local Arrow=ents.Create("ent_jack_hmcd_arrow")
			Arrow.HmcdSpawned=true
			Arrow:SetPos(self:GetPos()+VectorRand())
			Arrow:SetAngles(self:GetAngles())
			Arrow:Spawn()
			Arrow:Activate()
			Arrows[i]=Arrow
		end
		for key,arrow in pairs(Arrows)do
			for k,other in pairs(Arrows)do
				if not(other==arrow)then constraint.Weld(arrow,other,0,0,5000,true,false) end
			end
		end
		self:Remove()
	end
	function ENT:DropRocket()
		local Arrows={}
		for i=1,Amount do
			local Arrow=ents.Create("ent_jack_hmcd_rocket")
			Arrow.HmcdSpawned=true
			Arrow:SetPos(self:GetPos()+VectorRand())
			Arrow:SetAngles(self:GetAngles())
			Arrow:Spawn()
			Arrow:Activate()
			Arrows[i]=Arrow
		end
		for key,arrow in pairs(Arrows)do
			for k,other in pairs(Arrows)do
				if not(other==arrow)then constraint.Weld(arrow,other,0,0,5000,true,false) end
			end
		end
		self:Remove()
	end
	function ENT:PickUp(ply)
		if not(self.Rounds)then self:Fill() end
		local Wep=nil
		for key,wepon in pairs(self.SWEPS[self.AmmoType])do Wep=wepon end
		if(Wep)then
			ply:GiveAmmo(self.Rounds,self.AmmoType,true)
			local Pitch=100
			if(self.AmmoType=="AR2")then Pitch=80 elseif(self.AmmoType=="Buckshoit")then Pitch=70 end
			self:EmitSound("snd_jack_hmcd_ammobox.wav",65,Pitch)
			self:Remove()
		else
			if not(self.AmmoType=="AlyxGun")then ply:PickupObject(self) end -- murderer can plausibly deny that he's able to pick up .22
		end
	end
	function ENT:Fill()
		self.Rounds=math.ceil(math.random(1,self.Numbers[self.AmmoType])^math.Rand(0,1)) -- random between 1 and NUM, heavily weighted toward the lower numbers
	end
elseif(CLIENT)then
	--
end