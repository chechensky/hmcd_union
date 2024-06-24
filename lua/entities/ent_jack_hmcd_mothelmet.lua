--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_mothelmet.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_eq_base"
ENT.PrintName = "Motorcycle Helmet"
ENT.ImpactSound = "physics/body/body_medium_impact_soft5.wav"
ENT.Model = "models/dean/gtaiv/helmet.mdl"

ENT.Skins = {0, 1, 3, 7, 11, 14}

ENT.Spawnable = true
ENT.EquipmentNum = HMCD_MOTHELMET
ENT.Armor = "Motorcycle"
ENT.ArmorType = "Helmet"

if SERVER then
	function ENT:UseFunc(ply)
		ply:SetNWInt("Helmet_Color", self:GetSkin())
	end
end