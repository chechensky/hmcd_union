--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_makarychmag.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "8-Round Makarych Magazine"
ENT.ImpactSound = "weapon_impact_soft" .. math.random(1, 3) .. ".wav"
ENT.MurdererLoot = true

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel("models/weapons/tfa_ins2/upgrades/a_magazine_pm_8_phys.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:SetMass(1)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:PickUp(ply)
		ply:PickupObject(self)
	end
elseif CLIENT then
end
--