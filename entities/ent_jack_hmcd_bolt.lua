AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Arrow"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""

local LocationalMuls = {
	[HITGROUP_GENERIC] = 4,
	[HITGROUP_HEAD] = 10,
	[HITGROUP_CHEST] = 3,
	[HITGROUP_STOMACH] = 2.5,
	[HITGROUP_LEFTARM] = 1,
	[HITGROUP_RIGHTARM] = 1,
	[HITGROUP_LEFTLEG] = 1,
	[HITGROUP_RIGHTLEG] = 1,
	[HITGROUP_GEAR] = 1
}

if SERVER then
	function ENT:PenetratedOrRicochet(initialTrace)
		if self:GetPhysicsObject():GetVelocity():Length() < 100 then return false, false, nil end
		local AVec, IPos, TNorm, SMul = initialTrace.Normal, initialTrace.HitPos, initialTrace.HitNormal, HMCD_SurfaceHardness[initialTrace.MatType]

		if not SMul then
			SMul = .5
		end

		local ApproachAngle = -math.deg(math.asin(TNorm:DotProduct(AVec)))
		local MaxRicAngle = 30 * SMul

		-- all the way through
		if ApproachAngle > (MaxRicAngle * 1.25) then
			local MaxDist, SearchPos, SearchDist, Penetrated = (40 / SMul) * .15, IPos, 5, false

			while (not Penetrated) and (SearchDist < MaxDist) do
				SearchPos = IPos + AVec * SearchDist
				local PeneTrace = util.QuickTrace(SearchPos, -AVec * SearchDist)

				if (not PeneTrace.StartSolid) and PeneTrace.Hit then
					Penetrated = true

					return true, false, nil
				else
					SearchDist = SearchDist + 5
				end
			end
		elseif ApproachAngle < (MaxRicAngle * .75) then
			local NewVec = AVec:Angle()
			NewVec:RotateAroundAxis(TNorm, 180)
			local AngDiffNormal = math.deg(math.acos(NewVec:Forward():Dot(TNorm))) - 90
			NewVec:RotateAroundAxis(NewVec:Right(), AngDiffNormal * .7)
			NewVec = NewVec:Forward()

			return false, true, NewVec
		end

		return false, false, nil
	end

	function ENT:Initialize()
		self:SetModel("models/crossbow_bolt.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(CONTINUOUS_USE)
		self:DrawShadow(true)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
			phys:EnableDrag(false)
		end

		self.HitSomething = false
		self.Thinks = 0
		self.FireTime = CurTime()
		self.Launched = false
		self.Thought = false
	end

	function ENT:Use(ply)
		return
	end

	function ENT:PhysicsUpdate()
		if self.Fired and not self.HitSomething and not self.Launched then
			self.Launched = true
			self:GetPhysicsObject():SetVelocity(self.InitialVel + self.InitialDir * 3500)
		end

		if not self.Thought then
			self.Thought = true
			self:Think()
		end
	end

	local hitgroupstobones = {
		[1] = 10,
		[2] = 1,
		[3] = 0,
		[4] = 4,
		[5] = 6,
		[6] = 12,
		[7] = 9
	}

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

					if Tr.Entity:IsPlayer() or Tr.Entity:GetClass() == "prop_ragdoll" or Tr.Entity:IsNPC() then
						sound.Play("weapons/crossbow/bolt_skewer1.wav", Tr.HitPos, 70, 100)
					end
				end

				local Dmg = DamageInfo()
				Dmg:SetDamage(40 * DMul)
				Dmg:SetDamageType(DMG_SLASH)
				Dmg:SetDamagePosition(Tr.HitPos)
				Dmg:SetAttacker(self:GetOwner())
				Dmg:SetInflictor(self)
				Dmg:SetDamageForce(self:GetPhysicsObject():GetVelocity())
				Tr.Entity:TakeDamageInfo(Dmg)
				local penetrate, ricochet, vec = self:PenetratedOrRicochet(Tr)

				self:FireBullets({
					Src = self:GetPos(),
					Dir = Dir,
					Damage = 1,
					Attacker = self:GetOwner(),
					Spread = vector_origin,
					Num = 1
				})

				if self.Poisoned and Tr.Entity:IsPlayer() then
					HMCD_Poison(Tr.Entity, self:GetOwner())
					self.Poisoned = false
				end

				util.Decal("Impact.Metal", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)

				if not Break then
					sound.Play("Flesh.BulletImpact", Tr.HitPos, 60, 100)
					self:SetPos(Tr.HitPos - Dir)

					if Tr.Entity:IsPlayer() or Tr.Entity:IsNPC() then
						self:SetParent(Tr.Entity)

						if Tr.Entity:IsPlayer() then
							table.insert(Tr.Entity.Bolts, {self, Tr.HitGroup, Tr.Entity:WorldToLocal(self:GetPos()), Tr.Entity:WorldToLocalAngles(self:GetAngles())})
						end
					else
						if not (penetrate or ricochet) then
							self:SetPos(self:GetPos() + self:GetAngles():Forward() * -10)
							local bone = 0

							if hitgroupstobones[Tr.HitGroup] ~= nil then
								bone = hitgroupstobones[Tr.HitGroup]
							end

							if bone ~= 0 then
								self:SetPos(Tr.Entity:GetPhysicsObjectNum(bone):GetPos())
								self:SetParentPhysNum(bone)
							else
								if not IsValid(Tr.Entity) or Tr.Entity:GetClass() == "worldspawn" then
									constraint.Weld(self, Tr.Entity, 0, 0, 0, true, false)
								else
									self:SetParent(Tr.Entity)
								end
							end
						elseif penetrate then
							self:SetPos(self:GetPos() + self:GetAngles():Forward() * -30)
							self.InitialDir = Dir * (1 - HMCD_SurfaceHardness[Tr.MatType])
							self.HitSomething = false
							self.Thinks = 0
						else
							sound.Play("weapons/crossbow/hit1.wav", Tr.HitPos, 70, math.random(90, 100))
							local foundpos = Tr.HitPos

							local checkpos = {
								[1] = {10, 0, 0},
								[2] = {-10, 0, 0},
								[3] = {0, 10, 0},
								[4] = {0, -10, 0},
								[5] = {0, 0, 10},
								[6] = {0, 0, -10}
							}

							for i = 1, 6 do
								local tracecheck = util.QuickTrace(Tr.HitPos, self:GetAngles():Right() * checkpos[i][1] + self:GetAngles():Forward() * checkpos[i][2] + self:GetAngles():Up() * checkpos[i][3], {self})

								if not tracecheck.Hit then
									foundpos = foundpos + self:GetAngles():Right() * checkpos[i][1] + self:GetAngles():Forward() * checkpos[i][2] + self:GetAngles():Up() * checkpos[i][3]
								end
							end

							self:SetPos(foundpos)
							self.InitialDir = -vec
							self.HitSomething = false
							self.Thinks = 0
						end
					end

					if not (penetrate or ricochet) or (Tr.Entity:IsPlayer() or Tr.Entity:IsNPC()) then
						self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
					end
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
		self:DrawModel()
	end

	function ENT:Think()
	end

	--
	function ENT:OnRemove()
	end
end
--