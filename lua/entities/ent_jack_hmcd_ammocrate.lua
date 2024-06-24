--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_ammocrate.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.PrintName = "Ammo Crate"

if SERVER then
	local ammoType = {
		["models/items/ammocrate_rockets.mdl"] = {"RPG_Round", 3},
		["models/items/ammocrate_smg1.mdl"] = {"HelicopterGun", 40},
		["models/items/ammocrate_grenade.mdl"] = {
			"wep_jack_hmcd_grenade", 3, isWeapon = true
		},
		["models/items/ammocrate_ar2.mdl"] = {"Gravity", 30}
	}

	function ENT:Initialize()
		self.Entity:SetModel(self.Model)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		self.NextUse = 0
		self:SetBodygroup(1, 1)
	end

	function ENT:PickUp(ply)
		if self.NextUse < CurTime() then
			self.NextUse = CurTime() + 3.5
			self:EmitSound("items/ammocrate_open.wav", 70)
			self:SetSequence(2)

			timer.Simple(.5, function()
				if IsValid(self) and IsValid(ply) and ply:GetPos():DistToSqr(self:GetPos()) < 10000 then
					local info = ammoType[self:GetModel()]

					if info then
						self:SetBodygroup(1, 0)

						if info.isWeapon then
							local wep = ply:GetWeapon(info[1])

							if IsValid(wep) then
								wep:SetAmount(wep:GetAmount() + info[2])
							else
								wep = ply:Give(info[1])
								wep:SetAmount(info[2])
							end
						else
							ply:GiveAmmo(info[2], info[1])
						end
					end
				end

				timer.Simple(2, function()
					if IsValid(self) then
						self:SetSequence(1)
						self:EmitSound("items/ammocrate_close.wav", 70)

						timer.Simple(.5, function()
							if IsValid(self) then
								self:SetBodygroup(1, 1)
							end
						end)
					end
				end)
			end)
		end
	end
end