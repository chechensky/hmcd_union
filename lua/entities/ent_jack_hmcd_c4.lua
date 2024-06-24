--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_c4.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "C4 Charge"
ENT.Model = "models/weapons/w_c4_ins.mdl"

if SERVER then
	function ENT:PickUp(ply)
		local wep = ply:GetWeapon("wep_jack_hmcd_c4")

		if IsValid(wep) then
			wep:SetAmount(wep:GetAmount() + 1)
			self:EmitSound("physics/metal/weapon_impact_soft3.wav", 65, 100)
		else
			ply:Give("wep_jack_hmcd_c4")
			ply:SelectWeapon("wep_jack_hmcd_c4")
		end

		self:Remove()
	end
end