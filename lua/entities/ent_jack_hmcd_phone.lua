--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_phone.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Phone"
ENT.SWEP = "wep_jack_hmcd_phone"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/lt_c/tech/cellphone.mdl"
ENT.Skin = 1
ENT.Mass = 10

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel(self.Model)
		self.Entity:SetSkin(self.Skin)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(self.Mass)
			phys:Wake()
			phys:EnableMotion(true)
		end

		if GAMEMODE.Mode == "Strange" then
			self:Break()
		end
	end

	function ENT:PickUp(ply)
		if self.Broken then return end
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound(self.ImpactSound, 60, 110)
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end

	function ENT:PhysicsCollide(data, ent)
		if data.DeltaTime > .1 then
			self:EmitSound(self.ImpactSound, math.Clamp(data.Speed / 3, 20, 65), math.random(100, 120))
		end

		if (data.Speed > 500) and not self.GameSpawned then
			if not self.Broken then
				self:Break()
				--SafeRemoveEntityDelayed(self,10)
			end
		end
	end

	function ENT:Break()
		if not self.Broken then
			self.Broken = true
			self:SetSkin(10)
		end
	end

	function ENT:OnTakeDamage(dmg)
		self:Break()
	end
end