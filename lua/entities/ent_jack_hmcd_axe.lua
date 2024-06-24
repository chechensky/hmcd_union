--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_axe.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Axe"
ENT.SWEP = "wep_jack_hmcd_axe"
ENT.ImpactSound = "physics/wood/wood_plank_impact_soft1.wav"
ENT.MurdererLoot = true
ENT.Mass = 25
ENT.Model = "models/props/cs_militia/axe.mdl"
ENT.Infectable = true
ENT.NoHolster = true

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(SWEP).Poisoned = self.Poisoned
			ply:GetWeapon(SWEP).Infected = self.Infected
			ply:SelectWeapon(SWEP)
			self:Remove()
			ply:SelectWeapon(SWEP)
		end
	end
end