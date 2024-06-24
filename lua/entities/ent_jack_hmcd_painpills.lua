--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_painpills.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Pain Pills"
ENT.SWEP = "wep_jack_hmcd_painpills"
ENT.ImpactSound = "snd_jack_hmcd_pillsbounce.wav"
ENT.Model = "models/w_models/weapons/w_eq_painpills.mdl"
ENT.Mass = 5

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