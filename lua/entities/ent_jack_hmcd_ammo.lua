--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_ammo.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Ammo"
ENT.ImpactSound = "physics/metal/weapon_impact_soft1.wav"
ENT.PickupSound = "snd_jack_hmcd_ammobox.wav"

ENT.Skins = {
	["AlyxGun"] = "models/hmcd_ammobox_22",
	["Pistol"] = "models/hmcd_ammobox_9",
	["357"] = "models/hmcd_ammobox_38",
	["Buckshot"] = "models/hmcd_ammobox_12",
	["AR2"] = "models/hmcd_ammobox_792",
	["SMG1"] = "models/hmcd_ammobox_556",
	["AirboatGun"] = "models/hmcd_ammobox_nails",
	["StriderMinigun"] = "models/ammo76251/smg",
	["SniperRound"] = "models/ammo76239/smg",
	["SniperPenetratedRound"] = "models/defcon/taser/taser"
}

ENT.Numbers = {
	["AlyxGun"] = 150,
	["Pistol"] = 50,
	["357"] = 50,
	["AirboatGun"] = 40,
	["Buckshot"] = 30,
	["AR2"] = 30,
	["SMG1"] = 30,
	["XBowBolt"] = 20,
	["StriderMinigun"] = 30,
	["SniperRound"] = 30,
	["RPG_Round"] = 1,
	["MP5_Grenade"] = 1,
	["HelicopterGun"] = 30,
	["Gravity"] = 30,
	["Thumper"] = 20,
	["9mmRound"] = 50,
	["Hornet"] = 30,
	["SniperPenetratedRound"] = 5,
	["CombineCannon"] = 5
}

ENT.Models = {
	["StriderMinigun"] = "models/items/ammo_76251.mdl",
	["XBowBolt"] = "models/items/ammo/ammo_arrow_box.mdl",
	["HelicopterGun"] = "models/4630_ammobox.mdl",
	["SniperRound"] = "models/items/ammo_76239.mdl",
	["Gravity"] = "models/items/combine_rifle_cartridge01.mdl",
	["Thumper"] = "models/items/crossbowrounds.mdl",
	["MP5_Grenade"] = "models/items/combine_rifle_ammo01.mdl",
	["9mmRound"] = "models/ammo/beanbag9_ammo.mdl",
	["Hornet"] = "models/ammo/beanbag12_ammo.mdl",
	["SniperPenetratedRound"] = "models/ammo/taser_ammo.mdl",
	["CombineCannon"] = "models/eu_homicide/145ammobox.mdl",
	["RPG_Round"] = "models/weapons/tfa_ins2/w_rpg7_projectile.mdl"
}

if SERVER then
	function ENT:Initialize()
		--if(self.AmmoType=="XBowBolt")then
		--self:DropArrows()
		--return
		--end
		if not self.AmmoType then
			self.AmmoType = "Pistol"
		end

		self.Entity:SetModel(self.Models[self.AmmoType] or "models/props_lab/box01a.mdl")

		if self.Skins[self.AmmoType] ~= nil then
			self.Entity:SetMaterial(self.Skins[self.AmmoType])
		end

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
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
		local Arrows = {}

		for i = 1, math.ceil(math.random(1, 40) ^ math.Rand(0, 1)) do
			local Arrow = ents.Create("ent_jack_hmcd_arrow")
			Arrow.HmcdSpawned = true
			Arrow:SetPos(self:GetPos() + VectorRand())
			Arrow:SetAngles(self:GetAngles())
			Arrow:Spawn()
			Arrow:Activate()
			Arrows[i] = Arrow
		end

		for key, arrow in pairs(Arrows) do
			for k, other in pairs(Arrows) do
				if not (other == arrow) then
					constraint.Weld(arrow, other, 0, 0, 5000, true, false)
				end
			end
		end

		self:Remove()
	end

	function ENT:PickUp(ply)
		if not self.Rounds then
			self:Fill()
		end

		ply:GiveAmmo(self.Rounds, self.AmmoType, true)
		local Pitch = 100

		if self.AmmoType == "AR2" then
			Pitch = 80
		elseif self.AmmoType == "Buckshoit" then
			Pitch = 70
		end

		self:EmitSound(self.PickupSound, 65, Pitch)
		self:Remove()
	end

	function ENT:Fill()
		self.Rounds = math.ceil(math.random(1, self.Numbers[self.AmmoType]) ^ math.Rand(0, 1)) -- random between 1 and NUM, heavily weighted toward the lower numbers
	end
elseif CLIENT then
end
--