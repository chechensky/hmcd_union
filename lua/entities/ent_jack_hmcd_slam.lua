--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_slam.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "M4 SLAM"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.NextBeep = 0
ENT.Safe = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/weapons/w_slam.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		self:SetBodygroup(0, 1)
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
		end

		timer.Simple(3, function()
			self.Safe = false
		end)
		--self.Detonated=false
		--self.Armed=false
		--self.Rigged=false
	end

	function ENT:Use(ply)
	end

	--
	function ENT:OnTakeDamage(dmg)
		if dmg:IsDamageType(2) or dmg:IsDamageType(536870912) then
			self.Broken = true
			self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

			if IsValid(self.Constraint) then
				self.Constraint:Remove()
			end
		end
	end

	function ENT:Think()
		if IsValid(self:LaserTouch().Entity) and (self:LaserTouch().Entity:GetClass() ~= "worldspawn") and self.Safe == false and (self:LaserTouch().Entity:GetPhysicsObject():GetVelocity() - self:GetPhysicsObject():GetVelocity()):LengthSqr() > 10 and not self.Broken then
			self:Detonate()
		end

		self:NextThink(CurTime() + .01)

		return true
	end

	function ENT:LaserTouch()
		return util.QuickTrace(self:GetPos(), self:GetAngles():Up() * 200, {self})
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

		for key, ent in pairs(ents.FindInSphere(Pos, 75)) do
			if (ent ~= self) and (ent:GetClass() == "func_breakable") and ent:CanSee(Pos) then
				ent:Fire("break", "", 0)
			elseif (ent ~= self) and (ent:GetClass() == "func_physbox") then
				constraint.RemoveAll(ent)
			elseif (ent ~= self) and HMCD_IsDoor(ent) and not ent:GetNoDraw() and ent:CanSee(Pos) then
				HMCD_BlastThatDoor(ent, (ent:GetPos() - self:GetPos()):GetNormalized() * 1000)
			end
		end

		util.Effect("explosion", Foom, true, true)
		local Flash = EffectData()
		Flash:SetOrigin(Pos)
		Flash:SetScale(2)
		util.Effect("eff_jack_hmcd_dlight", Flash, true, true)

		timer.Simple(.01, function()
			sound.Play("snd_jack_hmcd_explosion_debris.mp3", Pos, 85, math.random(90, 110))
			sound.Play("m67/m67_detonate_far_dist_0" .. math.random(1, 3) .. ".wav", Pos - vector_up, 140, 100)
			sound.Play("snd_jack_hmcd_debris.mp3", Pos + vector_up, 85, math.random(90, 110))
			local core = {}
			core.Num = 1
			core.Src = Pos
			core.Dir = (self:LaserTouch().HitPos - self:GetPos()):GetNormalized()
			core.Spread = 0
			core.Tracer = 0
			core.Force = .6
			core.Damage = 1300
			core.HullSize = 10.5
			core.AmmoType = "Buckshot"
			self:FireBullets(core)

			for i = 1, 50 do
				local shrapnel = {}
				shrapnel.Num = 1
				shrapnel.Src = Pos
				shrapnel.Dir = VectorRand()
				shrapnel.Spread = 0
				shrapnel.Tracer = 0
				shrapnel.Force = .6
				shrapnel.Damage = 140
				shrapnel.AmmoType = "Buckshot"
				self:FireBullets(shrapnel)
			end
		end)

		timer.Simple(.02, function()
			--sound.Play("m67/m67_detonate_0"..math.random(1,3)..".wav",Pos,80,100)
			sound.Play("m67/m67_detonate_0" .. math.random(1, 3) .. ".wav", Pos + vector_up, 80, 100)
			sound.Play("m67/m67_detonate_0" .. math.random(1, 3) .. ".wav", Pos - vector_up, 80, 100)
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
			util.BlastDamage(self, Attacker, Pos, 150, 50)
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
			Shrap:SetDamage(100)
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

	function ENT:PhysicsCollide(data, physobj)
	end

	--
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