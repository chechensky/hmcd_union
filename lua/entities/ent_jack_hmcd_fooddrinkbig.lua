--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_fooddrinkbig.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Food"
ENT.SWEP = "wep_jack_hmcd_fooddrinkbig"
ENT.ImpactSound = "snd_jack_hmcd_foodbounce.wav"
ENT.Infectable = true

local FoodModels = {"models/foodnhouseholditems/applejacks.mdl", "models/foodnhouseholditems/cheerios.mdl", "models/foodnhouseholditems/kellogscornflakes.mdl", "models/foodnhouseholditems/miniwheats.mdl", "models/foodnhouseholditems/bagette.mdl", "models/jordfood/atun.mdl", "models/jordfood/cakes.mdl", "models/jordfood/can.mdl", "models/jordfood/canned_burger.mdl", "models/jordfood/capncrunch.mdl", "models/jordfood/chili.mdl", "models/jordfood/girlscout_cookies.mdl", "models/foodnhouseholditems/cola.mdl", "models/foodnhouseholditems/juice.mdl", "models/foodnhouseholditems/milk.mdl", "models/foodnhouseholditems/cola.mdl", "models/jorddrink/the_bottle_of_water.mdl"}

if SERVER then
	function ENT:Initialize()
		if not self.RandomModel then
			self.RandomModel = table.Random(FoodModels)
		end

		if table.KeyFromValue(FoodModels, self.RandomModel) > 12 then
			self.Drink = true
		else
			self.Drink = false
		end

		self.Entity:SetModel(self.RandomModel)
		self:SetModelScale(1.1, 0)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(20)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:PickUp(ply)
		local SWEP, Mod, Jrink = self.SWEP, self.RandomModel, self.Drink

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound(self.ImpactSound, 60, 90)
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