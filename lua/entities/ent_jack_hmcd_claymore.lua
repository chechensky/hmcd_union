--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_claymore.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.SWEP = "wep_jack_hmcd_claymore"
ENT.Detonated = false
ENT.Model = "models/hoff/weapons/seal6_claymore/w_claymore.mdl"
ENT.Mass = 10

if SERVER then
	function ENT:Think()
		if self.Rigged then
			local pos = self:GetPos()
			local ang = Angle(self:GetAngles().x, self:GetAngles().y, self:GetAngles().z) + Angle(0, -90, 0)
			local tracedata = {}
			tracedata.start = pos
			tracedata.endpos = self:GetPos() + self:GetRight() * -100
			tracedata.filter = self
			local trace = util.TraceLine(tracedata)
			local pos1 = self:GetPos()
			local ang1 = Angle(self:GetAngles().x, self:GetAngles().y, self:GetAngles().z) + Angle(0, -90, 0)
			local tracedata1 = {}
			tracedata1.start = pos1
			tracedata1.endpos = self:GetPos() + self:GetRight() * -50 + self:GetForward() * 20 + Vector(0, 0, 11)
			tracedata1.filter = self
			local trace1 = util.TraceLine(tracedata1)
			local pos2 = self:GetPos()
			local ang2 = Angle(self:GetAngles().x, self:GetAngles().y, self:GetAngles().z) + Angle(0, -90, 0)
			local tracedata2 = {}
			tracedata2.start = pos2
			tracedata2.endpos = self:GetPos() + self:GetRight() * -50 + self:GetForward() * -20 + Vector(0, 0, 11)
			tracedata2.filter = self
			local trace2 = util.TraceLine(tracedata2)

			if trace2.HitNonWorld or trace1.HitNonWorld or trace.HitNonWorld then
				target2 = trace2.Entity
				target1 = trace1.Entity
				target = trace.Entity

				if target1:IsValid() then
					if target1 ~= self.ClayOwner and target1:GetClass() ~= "worldspawn" and (target1:GetPhysicsObject():GetVelocity() - self:GetPhysicsObject():GetVelocity()):LengthSqr() > 10 and self.Rigged then
						self:Detonate()
					end
				end

				if target:IsValid() then
					if target ~= self.ClayOwner and target:GetClass() ~= "worldspawn" and (target:GetPhysicsObject():GetVelocity() - self:GetPhysicsObject():GetVelocity()):LengthSqr() > 10 and self.Rigged then
						self:Detonate()
					end
				end

				if target2:IsValid() then
					if target2 ~= self.ClayOwner and target2:GetClass() ~= "worldspawn" and (target2:GetPhysicsObject():GetVelocity() - self:GetPhysicsObject():GetVelocity()):LengthSqr() > 10 and self.Rigged then
						self:Detonate()
					end
				end
			end
		end

		self:NextThink(CurTime() + 0.001)

		return true
	end

	function ENT:PickUp(ply)
		if self.Armed then return end
		local SWEP = self.SWEP

		if not ply:HasWeapon(self.SWEP) then
			self:EmitSound("Grenade.ImpactHard", 60, 90)
			ply:Give(self.SWEP)
			ply:GetWeapon(self.SWEP).HmcdSpawned = self.HmcdSpawned
			self:Remove()
			ply:SelectWeapon(SWEP)
		else
			ply:PickupObject(self)
		end
	end

	function ENT:OnTakeDamage(dmg)
		if dmg:IsDamageType(2) or dmg:IsDamageType(536870912) then
			self.Rigged = false
			self.Armed = true
			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		end
	end

	function ENT:Arm()
		if self.Armed then return end
		self.Armed = true
		constraint.RemoveAll(self)

		if self.Rigged then
			self.DetTime = CurTime() + 1
		else
			self.DetTime = CurTime() + math.Rand(3, 4)
		end
	end

	function ENT:NearGround()
		return util.QuickTrace(self:GetPos() + vector_up * 10, -vector_up * 50, {self}).Hit
	end

	function ENT:Detonate()
		if self.Detonated then return end
		self.Detonated = true
		local Pos, Ground, Attacker = self:LocalToWorld(self:OBBCenter()) + Vector(0, 0, 5), self:NearGround(), self.Owner

		if Ground then
			ParticleEffect("pcf_jack_groundsplode_small3", Pos, vector_up:Angle())
		else
			ParticleEffect("pcf_jack_airsplode_small3", Pos, VectorRand():Angle())
		end

		local Foom = EffectData()
		Foom:SetOrigin(Pos)
		util.Effect("explosion", Foom, true, true)
		local Flash = EffectData()
		Flash:SetOrigin(Pos)
		Flash:SetScale(2)
		util.Effect("eff_jack_hmcd_dlight", Flash, true, true)

		timer.Simple(.01, function()
			sound.Play("snd_jack_hmcd_explosion_debris.mp3", Pos, 85, math.random(90, 110))
			sound.Play("ied/ied_detonate_dist_02.wav", Pos - vector_up, 140, 100)
			sound.Play("snd_jack_hmcd_debris.mp3", Pos + vector_up, 85, math.random(90, 110))

			for i = 0, 10 do
				local Tr = util.QuickTrace(Pos, VectorRand() * math.random(10, 150), {self})

				if Tr.Hit then
					util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
				end
			end
		end)

		timer.Simple(.02, function()
			sound.Play("ied/ied_detonate_0" .. math.random(1, 3) .. ".wav", Pos, 80, 100)
			sound.Play("ied/ied_detonate_0" .. math.random(1, 3) .. ".wav", Pos + vector_up, 80, 100)
			sound.Play("ied/ied_detonate_0" .. math.random(1, 3) .. ".wav", Pos - vector_up, 80, 100)
		end)

		timer.Simple(.03, function()
			local Poof = EffectData()
			Poof:SetOrigin(Pos)
			Poof:SetScale(.7)
			Poof:SetNormal(-self:GetAngles():Right())
			util.Effect("eff_jack_hmcd_shrapnel", Poof, true, true)
		end)

		timer.Simple(.04, function()
			local shake = ents.Create("env_shake")
			shake.HmcdSpawned = self.HmcdSpawned
			shake:SetPos(Pos)
			shake:SetKeyValue("amplitude", tostring(100))
			shake:SetKeyValue("radius", tostring(200))
			shake:SetKeyValue("duration", tostring(1))
			shake:SetKeyValue("frequency", tostring(200))
			shake:SetKeyValue("spawnflags", bit.bor(4, 8, 16))
			shake:Spawn()
			shake:Activate()
			shake:Fire("StartShake", "", 0)
			SafeRemoveEntityDelayed(shake, 2) -- don't clutter up the world
			local shake2 = ents.Create("env_shake")
			shake2.HmcdSpawned = self.HmcdSpawned
			shake2:SetPos(Pos)
			shake2:SetKeyValue("amplitude", tostring(100))
			shake2:SetKeyValue("radius", tostring(400))
			shake2:SetKeyValue("duration", tostring(1))
			shake2:SetKeyValue("frequency", tostring(200))
			shake2:SetKeyValue("spawnflags", bit.bor(4))
			shake2:Spawn()
			shake2:Activate()
			shake2:Fire("StartShake", "", 0)
			SafeRemoveEntityDelayed(shake2, 2) -- don't clutter up the world
			util.BlastDamage(self, Attacker, Pos, 150, 20)
		end)

		timer.Simple(.05, function()
			for i = 1, 200 do
				local bullet = {}
				bullet.Attacker = self.Owner
				bullet.Damage = 6
				bullet.Force = 5
				bullet.Num = 5
				bullet.Tracer = 0
				bullet.TracerName = ""
				bullet.AmmoType = "Buckshot"
				bullet.Spread = Vector(0.5, 0.5, 0)
				bullet.Dir = -self:GetAngles():Right()
				bullet.Src = self:GetPos() + Vector(0, 0, 10)
				self:FireBullets(bullet)
			end
		end)

		timer.Simple(.1, function()
			SafeRemoveEntity(self)

			for key, rag in pairs(ents.FindInSphere(Pos, 750)) do
				if (rag:GetClass() == "prop_ragdoll") or rag:IsPlayer() then
					for i = 1, 20 do
						local Tr = util.TraceLine({
							start = Pos,
							endpos = rag:GetPos() + VectorRand() * 50
						})

						if Tr.Hit and (Tr.Entity == rag) then
							util.Decal("Blood", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
						end
					end
				end
			end
		end)
	end
end