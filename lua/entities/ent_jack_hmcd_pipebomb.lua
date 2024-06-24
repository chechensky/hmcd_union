--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_pipebomb.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "ent_jack_hmcd_loot_base"
ENT.SWEP = "wep_jack_hmcd_pipebomb"
ENT.NextSparkTime = 0
ENT.NextSoundTime = 0
ENT.Model = "models/w_models/weapons/w_jj_pipebomb.mdl"
ENT.Mass = 10
ENT.Grenade = true

if SERVER then
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

	function ENT:Think()
		if self.Armed and (self.DetTime < CurTime()) then
			self:Detonate()
		elseif self.Armed then
			if self.NextSoundTime < CurTime() and (self:WaterLevel() < 3) then
				self.NextSoundTime = CurTime() + .15
				self:EmitSound("snd_jack_hmcd_flare.wav", 65, math.random(95, 105))
			end

			if self.NextSparkTime < CurTime() and (self:WaterLevel() < 3) then
				self.NextSparkTime = CurTime() + .05
				local Spark = EffectData()
				Spark:SetOrigin(self:GetPos() + self:GetUp() * 7)
				Spark:SetScale(1)
				Spark:SetNormal(self:GetUp())
				util.Effect("eff_jack_hmcd_fuzeburn", Spark, true, true)
			end
		end

		self:NextThink(CurTime() + .01)

		return true
	end

	function ENT:Arm()
		if self.Armed then return end
		if self:WaterLevel() >= 3 then return end
		self.Armed = true
		self.DetTime = CurTime() + math.Rand(2, 3)
		self:SetDTBool(0, true)
	end

	function ENT:NearGround()
		return util.QuickTrace(self:GetPos() + vector_up * 10, -vector_up * 50, {self}).Hit
	end

	function ENT:Detonate()
		if self:WaterLevel() >= 3 then
			self.Armed = false

			return
		end

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
			self:EmitSound("snd_jack_hmcd_explosion_debris.mp3", 85, math.random(90, 110))
			self:EmitSound("ied/ied_detonate_dist_02.wav", 140, 100)
			self:EmitSound("snd_jack_hmcd_debris.mp3", 85, math.random(90, 110))

			for i = 0, 60 do
				local Tr = util.QuickTrace(Pos, VectorRand() * math.random(10, 150), {self})

				local bullet = {}
				bullet.Num = 1
				bullet.Src = Pos
				bullet.Dir = VectorRand()
				bullet.Spread = 0
				bullet.Tracer = 0
				bullet.Force = .6
				bullet.Damage = 60
				bullet.AmmoType = "Buckshot"
				self:FireBullets(bullet)
			end
		end)

		timer.Simple(.02, function()
			self:EmitSound("ied/ied_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
			self:EmitSound("ied/ied_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
			self:EmitSound("ied/ied_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
		end)

		timer.Simple(.03, function()
			local Poof = EffectData()
			Poof:SetOrigin(Pos)
			Poof:SetScale(1)
			Poof:SetNormal(Vector())
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
			util.BlastDamage(self, Attacker, Pos, 100, 50)
		end)

		timer.Simple(.05, function()
			local Shrap = DamageInfo()
			Shrap:SetAttacker(Attacker)

			if IsValid(self) then
				Shrap:SetInflictor(self)
			else
				Shrap:SetInflictor(game.GetWorld())
			end

			Shrap:SetDamageType(DMG_BUCKSHOT)
			Shrap:SetDamage(75)
			util.BlastDamageInfo(Shrap, Pos, 600)
			SafeRemoveEntity(self)
		end)

		timer.Simple(.1, function()
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