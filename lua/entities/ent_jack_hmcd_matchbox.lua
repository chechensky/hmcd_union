--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_matchbox.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Match Box"
ENT.SWEP = "wep_jack_hmcd_matchbox"
ENT.ImpactSound = "Wood.ImpactSoft"
ENT.Model = "models/weapons/gleb/w_firematch.mdl"
ENT.Mass = 5

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(self.SWEP):SetAmount(self.Matches or 5)
			ply:SelectWeapon(self.SWEP)
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end