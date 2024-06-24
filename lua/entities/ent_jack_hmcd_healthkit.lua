--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_healthkit.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Health Kit"
ENT.ImpactSound = "Plastic_Box.ImpactHard"
ENT.Model = "models/items/healthkit.mdl"
ENT.Mass = 25

if SERVER then
	function ENT:PickUp(ply)
		if ply.Role == "freeman" then
			ply:EmitSound("items/smallmedkit1.wav")
			ply.HEVJuice = ply.HEVJuice + 500
			self:Remove()
		else
			ply:PickupObject(self)
		end
	end
end