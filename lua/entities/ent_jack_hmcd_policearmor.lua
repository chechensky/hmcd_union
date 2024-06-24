--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_policearmor.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_eq_base"
ENT.ImpactSound = "physics/body/body_medium_impact_soft5.wav"
ENT.Model = "models/eu_homicide/armor_prop.mdl"
ENT.EquipmentNum = HMCD_POLARMOR
ENT.Armor = "PoliceVest"
ENT.ArmorType = "Bodyvest"
ENT.Mass = 20

ENT.UseFunc = function(ent, ply)
	if ply.Role == "police" or ply.Role == "riotpolice" then
		ply:SetBodygroup(5, 1)
	end
end