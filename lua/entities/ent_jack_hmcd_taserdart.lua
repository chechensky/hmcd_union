AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Arrow"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

local BreakMats = {MAT_CONCRETE, MAT_GLASS, MAT_METAL, MAT_GRATE}

local LocationalMuls = {
	[HITGROUP_GENERIC] = 1,
	[HITGROUP_HEAD] = 5,
	[HITGROUP_CHEST] = 1.25,
	[HITGROUP_STOMACH] = .5,
	[HITGROUP_LEFTARM] = .2,
	[HITGROUP_RIGHTARM] = .2,
	[HITGROUP_LEFTLEG] = .2,
	[HITGROUP_RIGHTLEG] = .2,
	[HITGROUP_GEAR] = .1
}

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/taser_grapl/taser_grapl.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(CONTINUOUS_USE)
		self:DrawShadow(true)
		self:SetNoDraw(false)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(1)
			phys:EnableDrag(false)
		end

		self.HitSomething = false
		self.Thinks = 0
		self.FireTime = CurTime()
		self.Launched = false
		self.Thought = false
	end

	function ENT:Use(ply)
	end

	--
	function ENT:PhysicsUpdate()
		if self.Fired and not self.HitSomething and not self.Launched then
			self.Launched = true
			self:GetPhysicsObject():SetVelocity(self.InitialVel + self.InitialDir * 200)
		end

		if not self.Thought then
			self.Thought = true
			self:Think()
		end
	end

	function ENT:Think()
		if self.Fired and not self.HitSomething then
			local Dir, Tab = self:GetPhysicsObject():GetVelocity():GetNormalized(), {self}

			if Dir:Length() < 10 then
				Dir = self.InitialDir
			end

			if self.Thinks < 100 then
				Tab = {self, self:GetOwner()}

				self.Thinks = self.Thinks + 1
			end

			local Tr = util.QuickTrace(self:GetPos(), Dir * 500, Tab)

			if Tr.Hit then
				self.HitSomething = true
				local Break, DMul = false, 1

				if Tr.Entity:IsPlayer() or Tr.Entity:IsNPC() then
					if Tr.HitGroup then
						DMul = LocationalMuls[Tr.HitGroup]
					end

					if Tr.Entity:IsPlayer() then
						if Tr.Entity.ChestArmor and (Tr.Entity.ChestArmor == "Level III") and Tr.HitGroup and (Tr.HitGroup == HITGROUP_CHEST) then
							Break = true
							DMul = 0
						end

						if Tr.Entity.HeadArmor and (Tr.Entity.HeadArmor == "ACH") and Tr.HitGroup and (Tr.HitGroup == HITGROUP_HEAD) then
							Break = true
							DMul = 0
						end
					end
				end

				if not Break then
					local Dmg = DamageInfo()
					Dmg:SetDamage(1 * DMul)
					Dmg:SetDamageType(DMG_SHOCK)
					Dmg:SetDamagePosition(Tr.HitPos)
					Dmg:SetAttacker(self:GetOwner())
					Dmg:SetInflictor(self)
					Dmg:SetDamageForce(self:GetPhysicsObject():GetVelocity())
					Tr.Entity:TakeDamageInfo(Dmg)

					self:FireBullets({
						Src = self:GetPos(),
						Dir = Dir,
						Damage = 1,
						Attacker = self:GetOwner(),
						Spread = vector_origin,
						Num = 1
					})
				end

				if self.Poisoned and Tr.Entity:IsPlayer() then
					HMCD_Poison(Tr.Entity, self:GetOwner())
					self.Poisoned = false
				end

				util.Decal("Impact.Metal", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)

				if table.HasValue(BreakMats, Tr.MatType) then
					Break = true
				end

				if not Break then
					sound.Play("Flesh.BulletImpact", Tr.HitPos, 60, 100)
					self:SetPos(Tr.HitPos - Dir)

					if Tr.Entity:IsPlayer() or Tr.Entity:IsNPC() then
						self:SetParent(Tr.Entity)
					else
						constraint.Weld(self, Tr.Entity, 0, 0, 1000, true, false)
					end

					self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				else
					sound.Play("Concrete.BulletImpact", Tr.HitPos, 60, 100)
					SafeRemoveEntity(self)
				end
			end
		end

		self:NextThink(CurTime() + .01)

		return true
	end

	function ENT:PhysicsCollide(data, physobj)
		self.HitSomething = true
	end

	function ENT:StartTouch(ply)
	end
	--
elseif CLIENT then
	function ENT:Initialize()
	end

	--
	function ENT:Draw()
		local Vel = self:GetVelocity()

		if Vel:Length() > 1000 then
			local Ang = Vel:Angle()
			Ang:RotateAroundAxis(Ang:Right(), -90)
			self:SetRenderAngles(Ang)
		end

		self:DrawModel()
	end

	function ENT:Think()
	end

	--
	function ENT:OnRemove()
	end
end
--