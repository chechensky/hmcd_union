--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_medkit.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "First-Aid Kit"
ENT.SWEP = "wep_jack_hmcd_medkit"
ENT.ImpactSound = "physics/body/body_medium_impact_soft5.wav"
ENT.Model = "models/w_models/weapons/w_eq_medkit.mdl"
ENT.Mass = 10
ENT.Infectable = true

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound(self.ImpactSound, 60, 90)
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(self.SWEP):SetAmount(self.Amount or 1)
			ply:GetWeapon(self.SWEP).Infected = self.Infected
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end