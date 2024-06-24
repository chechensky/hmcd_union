--[[File Path:   gamemodes/homicide/entities/entities/ent_ins2rpgrocket1/shared.lua

--]]
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Author = "Spy"
ENT.Spawnable = false
ENT.AdminSpawnable = false

if CLIENT then
	killicon.Add("ent_ins2rpgrocket", "vgui/inventory/weapon_rpg7", Color(255, 80, 0, 0))
end