--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_knife.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "SOG M37 Seal Pup"
ENT.SWEP = "wep_jack_hmcd_knife"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Infectable = true

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel("models/weapons/w_knife_t.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(25)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP).Infected = self.Infected
			ply:SelectWeapon(self.SWEP)
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
elseif CLIENT then
end
--