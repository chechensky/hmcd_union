--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_brick.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.SWEP = "wep_jack_hmcd_brick"
ENT.HitSomething = false
ENT.Thinks = 0
ENT.HitGroup = nil
ENT.Model = "models/weapons/w_brick.mdl"
ENT.Mass = 10

local LocationalMuls = {
	[HITGROUP_GENERIC] = 1,
	[HITGROUP_HEAD] = 5,
	[HITGROUP_CHEST] = 3,
	[HITGROUP_STOMACH] = 4,
	[HITGROUP_LEFTARM] = .2,
	[HITGROUP_RIGHTARM] = .2,
	[HITGROUP_LEFTLEG] = .2,
	[HITGROUP_RIGHTLEG] = .2,
	[HITGROUP_GEAR] = .1
}

if SERVER then
	function ENT:PickUp(ply)
		if self.Armed then return end
		if GAMEMODE.ZOMBIE and ply.Murderer then return end
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound("Concrete.ImpactHard", 60, 90)
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end

	function ENT:Think()
		if self.Armed and not self.HitSomething then
			local Dir, Tab = self:GetPhysicsObject():GetVelocity():GetNormalized(), {self}

			if Dir:Length() < 10 then
				Dir = self.InitialDir
			end

			if self.Thinks < 100 then
				Tab = {self, self.Owner}

				self.Thinks = self.Thinks + 1
			end

			local Tr = util.QuickTrace(self:GetPos(), Dir * 500, Tab)

			if Tr.Hit then
				self.HitSomething = true
			end

			local hitgroup = Tr.HitGroup

			if Tr.PhysicsBone ~= 0 then
				hitgroup = HMCD_GetRagdollHitgroup(Tr.Entity, Tr.PhysicsBone)
			end

			local owner = Tr.Entity

			if owner:IsPlayer() and owner:Alive() then
				owner.pain_add = owner.pain_add + 8 * LocationalMuls[hitgroup]
			end

			timer.Simple(.25, function()
				if IsValid(self) then
					self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				end
			end)

			self.Armed = false
		end

		self:NextThink(CurTime() + .01)

		return true
	end

	function ENT:Throw()
		self.Armed = true
	end

	function ENT:StartTouch(ply)
	end
	--
elseif CLIENT then
	function ENT:Initialize()
	end

	--
	function ENT:Draw()
		self:DrawModel()
	end

	function ENT:Think()
	end

	--
	function ENT:OnRemove()
	end
end
--