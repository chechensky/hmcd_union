--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_cleaver.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Butcher Knife"
ENT.SWEP = "wep_jack_hmcd_cleaver"
ENT.ImpactSound = "physics/metal/metal_solid_impact_soft1.wav"
ENT.Model = "models/weapons/tfa_nmrih/w_me_cleaver.mdl"
ENT.Mass = 15
ENT.Infectable = true

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP).Poisoned = self.Poisoned
			ply:GetWeapon(SWEP).Infected = self.Infected
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end