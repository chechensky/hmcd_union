--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_handcuffs.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Handcuffs"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/spy/w_handcuffs.mdl"

ENT.PhysicsBox = {Vector(-10, -10, -10), Vector(10, 10, 10)}

ENT.CollisionBounds = {Vector(-10, -10, -10), Vector(10, 10, 10)}

if SERVER then
	function ENT:PickUp(ply)
		local wep = ply:GetWeapon("wep_jack_hmcd_handcuffs")

		if IsValid(wep) then
			wep:SetAmount(wep:GetAmount() + 1)
			self:EmitSound("physics/metal/weapon_impact_soft3.wav", 65, 100)
		else
			ply:Give("wep_jack_hmcd_handcuffs")
		end

		self:Remove()
	end
end