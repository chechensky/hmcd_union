--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_bandage.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Bandage"
ENT.SWEP = "wep_jack_hmcd_bandage"
ENT.ImpactSound = "physics/body/body_medium_impact_soft5.wav"
ENT.Model = "models/bandages.mdl"
ENT.Material = "models/nh2_bdg/bandages.mdl"
ENT.Scale = .8
ENT.Mass = 10
ENT.Infectable = true

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound(self.ImpactSound, 60, 110)
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:GetWeapon(self.SWEP).Infected = self.Infected
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end