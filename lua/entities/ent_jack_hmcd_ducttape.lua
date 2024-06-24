--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_ducttape.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Duct Tape"
ENT.SWEP = "wep_jack_hmcd_ducttape"
ENT.ImpactSound = "physics/body/body_medium_impact_soft5.wav"
ENT.Model = "models/props_phx/wheels/drugster_front.mdl"
ENT.Material = "models/shiny"
ENT.Color = Color(100, 100, 100, 255)
ENT.Scale = .2
ENT.Mass = 10

if SERVER then
	function ENT:PickUp(ply)
		local SWEP = self.SWEP

		if not ply:HasWeapon(SWEP) then
			self:EmitSound(self.ImpactSound, 60, 100)
			ply:Give(SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned

			if self.TapeAmount then
				ply:GetWeapon(SWEP).TapeAmount = self.TapeAmount
			end

			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end
end