--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_fooddrink.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Food"
ENT.SWEP = "wep_jack_hmcd_fooddrink"
ENT.ImpactSound = "snd_jack_hmcd_foodbounce.wav"
ENT.Infectable = true

local FoodModels = {"models/foodnhouseholditems/mcdburgerbox.mdl", "models/foodnhouseholditems/chipsfritos.mdl", "models/foodnhouseholditems/chipslays5.mdl", "models/foodnhouseholditems/chipslays3.mdl", "models/foodnhouseholditems/mcdfrenchfries.mdl", "models/jordfood/prongleclosedfilledgreen.mdl", "models/foodnhouseholditems/mcddrink.mdl", "models/foodnhouseholditems/juicesmall.mdl", "models/jorddrink/7upcan01a.mdl", "models/jorddrink/barqcan1a.mdl", "models/jorddrink/cozcan01a.mdl", "models/jorddrink/crucan01a.mdl", "models/jorddrink/dewcan01a.mdl", "models/jorddrink/foscan01a.mdl", "models/jorddrink/heican01a.mdl", "models/jorddrink/mongcan1a.mdl", "models/jorddrink/pepcan01a.mdl", "models/jorddrink/redcan01a.mdl", "models/jorddrink/sprcan01a.mdl"}

if SERVER then
	function ENT:Initialize()
		if not self.RandomModel then
			self.RandomModel = table.Random(FoodModels)
		end

		if table.KeyFromValue(FoodModels, self.RandomModel) > 6 then
			self.Drink = true
		else
			self.Drink = false
		end

		self.Entity:SetModel(self.RandomModel)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(10)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:PickUp(ply)
		local SWEP, Mod, Jrink = self.SWEP, self.RandomModel, self.Drink

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound(self.ImpactSound, 60, 110)
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP):SetRandomModel(Mod)
			ply:GetWeapon(SWEP).Drink = Jrink
			ply:GetWeapon(SWEP).Poisoned = self.Poisoned
			ply:GetWeapon(SWEP).Poisoner = self.Poisoner
			ply:GetWeapon(SWEP).Infected = self.Infected
			ply:SelectWeapon(SWEP)
			self:Remove()
		else
			ply:PickupObject(self)
		end
	end
elseif CLIENT then
end
--