--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_pepperspray.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Pepper Spray"
ENT.SWEP = "wep_jack_hmcd_pepperspray"
ENT.ImpactSound = "snd_jack_hmcd_pillsbounce.wav"
ENT.Model = "models/weapons/custom/pepperspray.mdl"
ENT.Mass = 10

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			self:EmitSound(self.ImpactSound, 60, 100)
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP).Poisoned = self.Poisoned

			if not self.PepperSprayAmount then
				self.PepperSprayAmount = 1000
			end

			ply:GetWeapon(SWEP):SetAmount(self.PepperSprayAmount)
			ply:GetWeapon(SWEP).Poisoner = self.Poisoner
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end