--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_healthvial.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Health Vial"
ENT.ImpactSound = "Plastic_Box.ImpactHard"
ENT.Model = "models/healthvial.mdl"
ENT.Mass = 25

if SERVER then
	function ENT:PickUp(ply)
		if ply.Role == "freeman" then
			ply:EmitSound("items/smallmedkit1.wav")
			ply.HEVJuice = ply.HEVJuice + 250
			self:Remove()
		else
			ply:PickupObject(self)
		end
	end
end