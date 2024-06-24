--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_crowbar.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Crowbar"
ENT.SWEP = "wep_jack_hmcd_crowbar"
ENT.ImpactSound = "Weapon_Crowbar.Melee_HitWorld"
ENT.Model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
ENT.Mass = 25
ENT.NoHolster = true

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:SelectWeapon(self.SWEP)
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end