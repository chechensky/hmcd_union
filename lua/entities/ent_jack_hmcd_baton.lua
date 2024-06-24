--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_baton.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Police Baton"
ENT.SWEP = "wep_jack_hmcd_baton"
ENT.ImpactSound = "Flesh.ImpactSoft"
ENT.Model = "models/police_baton/w_police_baton.mdl"
ENT.Mass = 15

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			self:EmitSound(self.ImpactSound, 60, 100)
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end