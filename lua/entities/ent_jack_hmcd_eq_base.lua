--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_eq_base.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Aimpoint CompM2 Sight"
ENT.ImpactSound = "physics/metal/weapon_impact_soft3.wav"
ENT.Model = "models/weapons/tfa_ins2/upgrades/phy_optic_aimpoint.mdl"
ENT.EquipmentNum = HMCD_AIMPOINT
ENT.IsLoot = true

local forbiddenItems = {
	["combine"] = {
		["Maglite ML300LX-S3CC6L Flashlight"] = true,
		["Advanced Combat Helmet"] = true
	},
	["freeman"] = {
		["Advanced Combat Helmet"] = true,
		["Level IIIA Armor"] = true
	},
	["rebel"] = {
		["Level IIIA Armor"] = "wt"
	}
}

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel(self.Model)

		if self.Material then
			self.Entity:SetMaterial(self.Material)
		end

		if self.Color then
			self.Entity:SetColor(self.Color)
		end

		if self.Skins then
			self.Entity:SetSkin(table.Random(self.Skins))
		end

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			local mass = self.Mass or 15
			phys:SetMass(mass)
			phys:Wake()
			phys:EnableMotion(true)
		end
	end

	function ENT:Use(ply)
		if not ply.Equipment then
			ply.Equipment = {}
		end

		if (not ply.Equipment[HMCD_EquipmentNames[self.EquipmentNum]]) and not (forbiddenItems[ply.Role] and forbiddenItems[ply.Role][HMCD_EquipmentNames[self.EquipmentNum]] and forbiddenItems[ply.Role][HMCD_EquipmentNames[self.EquipmentNum]] ~= ply:GetNWString("Class")) then
			ply.Equipment[14] = true

			if self.Armor then
				if ply:GetNWString(self.ArmorType) ~= "" then
					for bigName, name in pairs(HMCD_ArmorNames[self.ArmorType]) do
						if name == ply:GetNWString(self.ArmorType) then
							local ind = table.KeyFromValue(HMCD_EquipmentNames, bigName)
							ply.Equipment[bigName] = nil
							net.Start("hmcd_equipment")
							net.WriteInt(ind, 6)
							net.WriteBit(false)
							net.Send(ply)
							local Armor = ents.Create(HMCD_EquipmentClasses[ind])
							Armor:SetPos(ply:GetShootPos() + ply:GetAimVector() * 20)
							Armor.HmcdSpawned = true
							Armor:Spawn()
							Armor:Activate()
							Armor:GetPhysicsObject():SetVelocity(ply:GetVelocity())

							if HMCD_EquipmentClasses[ind] == "ent_jack_hmcd_mothelmet" then
								Armor:SetSkin(ply:GetNWInt("Helmet_Color"))
							end

							break
						end
					end
				end

				ply:SetNWString(self.ArmorType, self.Armor)
				sound.Play("snd_jack_hmcd_disguise.wav", ply:GetPos(), 65, 80)
			else
				self:EmitSound(self.ImpactSound, 65, 100)
			end

			if self.UseFunc then
				self:UseFunc(ply)
			end

			self:Remove()
		end
	end
elseif CLIENT then
end
--