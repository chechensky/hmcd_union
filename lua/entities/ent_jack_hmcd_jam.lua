--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_jam.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.SWEP = "wep_jack_hmcd_jam"
ENT.Model = "models/props_junk/wood_pallet001a_chunka1.mdl"
ENT.Scale = .5
ENT.Mass = 10

if SERVER then
	function ENT:PickUp(ply)
		if self.Blocking then
			self:UnBlock()
			self:EmitSound("Wood_Plank.ImpactHard")
		else
			self:UnBlock()
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			ply:SelectWeapon(self.SWEP)
			self:Remove()
		end
	end

	function ENT:Think()
		if self.Blocking then
			for key, door in pairs(self.Doors) do
				if not IsValid(door) then
					self:UnBlock()
					break
				end

				door:Fire("lock", "", 0)
			end

			if not IsValid(self.Constraint) then
				self:UnBlock()
				self:EmitSound("Wood_Plank.ImpactSoft")
			end
		end

		self:NextThink(CurTime() + .1)

		return true
	end

	function ENT:UnBlock()
		if self.Blocking then
			self.Blocking = false

			for key, door in pairs(self.Doors) do
				if IsValid(door) and not self.DoorLocked then
					door:Fire("unlock", "", 0)
				end
			end

			self.Doors = {}
			self:EmitSound("Wood_Plank.ImpactSoft")
			self:EmitSound("Flesh.ImpactSoft")
			constraint.RemoveAll(self)
		end
	end

	function ENT:Block(doors)
		if not self.Blocking then
			self.Blocking = true
			self.Doors = doors
			self.Constraint = constraint.Weld(self.Doors[1], self, 0, 0, 3000, true, false)
			self.Constraint.PickupAble = true
			self:EmitSound("Wood_Plank.ImpactSoft")
			self:EmitSound("Flesh.ImpactSoft")
			self:EmitSound("Wood_Plank.ImpactSoft")
			self:Think()
		end
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.DeltaTime > .1 then
			self:EmitSound("Wood_Plank.ImpactSoft")
			self:EmitSound("Flesh.ImpactSoft")
		end
	end

	function ENT:StartTouch(ply)
	end
	--
end