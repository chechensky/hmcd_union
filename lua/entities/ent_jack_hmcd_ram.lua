--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_ram.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Battering Ram"
ENT.SWEP = "wep_jack_hmcd_ram"
ENT.ImpactSound = "physics/body/body_medium_impact_soft5.wav"
ENT.SecondSound = "physics/metal/metal_canister_impact_hard3.wav"
ENT.Model = "models/weapons/custom/w_batram.mdl"
ENT.Mass = 25

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:SelectWeapon(SWEP)
			self:Remove()
		end
	end
end