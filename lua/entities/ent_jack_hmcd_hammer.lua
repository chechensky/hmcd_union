--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_hammer.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Claw Hammer"
ENT.SWEP = "wep_jack_hmcd_hammer"
ENT.ImpactSound = "physics/metal/metal_solid_impact_soft1.wav"
ENT.Model = "models/weapons/w_jjife_t.mdl"
ENT.Mass = 10
ENT.Infectable = true

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			self:EmitSound(self.ImpactSound, 60, 100)
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP).Infected = self.Infected

			if self.GameSpawned then
				ply:GiveAmmo(3, "AirboatGun", true)
			end

			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end