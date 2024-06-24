--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_binocular.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Binoculars"
ENT.SWEP = "wep_jack_hmcd_binocular"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/w_binocularsbp.mdl"

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if ply:HasWeapon(self.SWEP) then
			ply:PickupObject(self)
		else
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			self:Remove()
			ply:SelectWeapon(SWEP)
		end
	end
end