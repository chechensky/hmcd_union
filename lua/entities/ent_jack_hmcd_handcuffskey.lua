--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_handcuffskey.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Handcuffs Key"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/eu_homicide/handcuff_keys.mdl"
ENT.SWEP = "wep_jack_hmcd_handcuffskey"

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			self:EmitSound(self.ImpactSound, 60, 100)
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP).Poisoned = self.Poisoned
			ply:GetWeapon(SWEP).Poisoner = self.Poisoner
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end