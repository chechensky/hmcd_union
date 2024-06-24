--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_leadpipe.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Lead Pipe"
ENT.SWEP = "wep_jack_hmcd_leadpipe"
ENT.ImpactSound = "physics/metal/metal_solid_impact_soft1.wav"
ENT.Model = "models/weapons/tfa_nmrih/w_pipe_lead.mdl"
ENT.Mass = 25

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