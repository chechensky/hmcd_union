--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_grenade.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Grenade"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Grenade = true
ENT.SWEP = "wep_jack_hmcd_grenade"

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Beeping")
	self:NetworkVar("Float", 1, "NextTime")
end

if SERVER then
	local combineNums = {
		[1] = "one",
		[2] = "two",
		[3] = "three",
		[4] = "four",
		[5] = "five",
		[6] = "six",
		[7] = "seven",
		[8] = "eight",
		[9] = "niner",
		[10] = "ten"
	}

	local grenadePhrases = {
		[1] = {
			[1] = "name",
			[2] = "num",
			[3] = "npc/combine_soldier/vo/extractoraway.wav"
		},
		[2] = {
			[1] = "name",
			[2] = "num",
			[3] = "npc/combine_soldier/vo/extractorislive.wav"
		},
		[3] = {
			[1] = "name",
			[2] = "num",
			[3] = "npc/combine_soldier/vo/flush.wav",
			[4] = "npc/combine_soldier/vo/sharpzone.wav"
		},
		[4] = {
			[1] = "name",
			[2] = "num",
			[3] = "npc/combine_soldier/vo/extractoraway.wav",
			[4] = "npc/combine_soldier/vo/sharpzone.wav"
		},
		[5] = {
			[0] = "npc/combine_soldier/vo/six.wav",
			[1] = "npc/combine_soldier/vo/five.wav",
			[2] = "npc/combine_soldier/vo/four.wav",
			[3] = "npc/combine_soldier/vo/three.wav",
			[4] = "npc/combine_soldier/vo/two.wav",
			[5] = "npc/combine_soldier/vo/one.wav",
			[6] = "npc/combine_soldier/vo/flash.wav",
			[7] = "npc/combine_soldier/vo/flash.wav",
			[8] = "npc/combine_soldier/vo/flash.wav"
		}
	}

	function ENT:Initialize()
		if self.Armed then
			self:SetModel("models/weapons/w_npcnade.mdl")
		else
			self:SetModel("models/weapons/w_grenade.mdl")
		end

		self.IsLoot = not self.Armed
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(self.CollisionGroup or COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		self.NextBeep = self:GetBeeping()
		self.NextTime = self:GetNextTime()
		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
		end

		if self.Owner.Role == "combine" and self.Owner:GetNWString("Class") ~= "cp" and (not self.Owner.NextTaunt or self.Owner.NextTaunt < CurTime()) then
			local Timer1 = 0
			local RandSound = math.random(1, 5)
			local taunt = ""
			local NumberSound = "npc/combine_soldier/vo/" .. combineNums[self.Owner.CombineNumber] .. ".wav"
			self.Owner:EmitSound("npc/combine_soldier/vo/on" .. math.random(1, 4) .. ".wav")
			local Name = self.Owner.SquadName or GAMEMODE.Name1

			if self.Owner.Leader then
				Name = "npc/combine_soldier/vo/leader.wav"
			end

			if RandSound ~= 5 then
				for i, word in ipairs(grenadePhrases[RandSound]) do
					if word == "name" then
						if Timer1 ~= 0 then
							timer.Simple(Timer1, function()
								self.Owner:EmitSound(Name)
							end)
						else
							self.Owner:EmitSound(Name)
						end

						Timer1 = Timer1 + SoundDuration(Name)
					elseif word == "num" then
						if Timer1 ~= 0 then
							timer.Simple(Timer1, function()
								self.Owner:EmitSound(NumberSound)
							end)
						else
							self.Owner:EmitSound(NumberSound)
						end

						Timer1 = Timer1 + SoundDuration(NumberSound)
					else
						if Timer1 ~= 0 then
							timer.Simple(Timer1, function()
								self.Owner:EmitSound(word)
							end)
						else
							self.Owner:EmitSound(word)
						end

						Timer1 = Timer1 + SoundDuration(word)
					end
				end
			else
				local list = grenadePhrases[5]

				for i = self.TickAmount, 8 do
					local t = 0.5

					if i >= 6 then
						t = 0.2
					end

					if Timer1 ~= 0 then
						timer.Simple(Timer1, function()
							self.Owner:EmitSound(list[i])
						end)
					else
						self.Owner:EmitSound(list[i])
					end

					Timer1 = Timer1 + t
				end
			end

			self.Owner.NextTaunt = CurTime() + Timer1

			timer.Simple(Timer1, function()
				if IsValid(self) then
					self.Owner:EmitSound("npc/combine_soldier/vo/off" .. math.random(1, 6) .. ".wav")
				end
			end)
		end
	end

	function ENT:Use(ply)
		if not self.Armed then
			if ply:HasWeapon(self.SWEP) then
				local swep = ply:GetWeapon(self.SWEP)
				swep:SetAmount(swep:GetAmount() + 1)
			else
				local swep = ply:Give(self.SWEP)
				swep:SetAmount(1)
			end

			self:EmitSound("Grenade.ImpactHard")
			self:Remove()
		end
	end

	function ENT:Think()
		if self.Armed then
			local Time = CurTime()

			if self.NextBeep < Time then
				self.NextBeep = Time + self.NextTime
				self:EmitSound("weapons/grenade/tick1.wav")
				self.NextTime = self.NextTime / 2

				if self.NextTime < 0.3 then
					self.NextTime = 0.3
				end

				self.TickAmount = self.TickAmount + 1

				if self.TickAmount == 6 then
					self:Detonate()
				end
			end

			self:NextThink(Time + .01)

			return true
		end
	end

	function ENT:Arm()
		if self.Armed then return end
		self.Armed = true
		constraint.RemoveAll(self)

		if not self.SpawnedSpoon then
			sound.Play("weapons/m67/m67_spooneject.wav", self:GetPos(), 65, 100)
			local Spoon = ents.Create("prop_physics")
			Spoon.HmcdSpawned = self.HmcdSpawned
			Spoon:SetModel("models/codww2/equipment/mk,ii hand grenade spoon.mdl")
			Spoon:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			Spoon:SetPos(self:GetPos() + VectorRand())
			Spoon:SetAngles(self:GetAngles())
			Spoon:SetMaterial("models/shiny")
			Spoon:SetColor(Color(50, 40, 0))
			Spoon.Huy = false
			Spoon:Spawn()
			Spoon:Activate()
		end
		--Spoon:GetPhysicsObject():SetMaterial("metal_bouncy")
		--Spoon:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity()+VectorRand()*1)
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
			self:EmitSound("snd_jack_hmcd_explosion_debris.mp3", 85, math.random(90, 110))
			self:EmitSound("ied/ied_detonate_dist_02.wav", 140, 100)
			self:EmitSound("snd_jack_hmcd_debris.mp3", 85, math.random(90, 110))

			for i = 1, 120 do
				local Tr = util.QuickTrace(Pos, VectorRand() * math.random(10, 150), {self})

				local bullet = {}
				bullet.Num = 1
				bullet.Src = Pos
				bullet.Dir = VectorRand()
				bullet.Spread = 0
				bullet.Tracer = 0
				bullet.Force = .6
				bullet.Damage = 80
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

			if not IsValid(Attacker) then
				Attacker = game.GetWorld()
			end

			util.BlastDamage(self, Attacker, Pos, 150, 50)
		end)

		timer.Simple(.05, function()
			if not IsValid(Attacker) then
				Attacker = game.GetWorld()
			end

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
		if data.DeltaTime > .1 then
			self:EmitSound("Grenade.ImpactHard")
			self:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity() * .9)
		end
	end

	function ENT:StartTouch(ply)
	end
	--
elseif CLIENT then
	function ENT:Initialize()
		self.NextTime = self:GetNextTime()
		self.material = Material("models/hands/hands_color")
		self.NextBeep = self:GetBeeping()
		self.Armed = self:GetModel() == "models/weapons/w_npcnade.mdl"
		self.IsLoot = not self.Armed
	end

	function ENT:Draw()
		self:DrawModel()

		if self.Armed then
			local pos, white, ang = self:GetPos(), Color(255, 255, 255, 255), self:GetAngles()

			if self.NextBeep < CurTime() then
				self.material = Material("sprites/redglow1")
				self.NextBeep = CurTime() + self.NextTime
				self.NextTime = self.NextTime - self.NextTime / 2

				if self.NextTime < 0.3 then
					self.NextTime = 0.3
				end

				timer.Simple(.1, function()
					self.material = Material("models/hands/hands_color")
				end)
			end

			cam.Start3D()
			render.SetMaterial(self.material)
			render.DrawSprite(pos + ang:Up() * 4 + ang:Right() * -0.6 + ang:Forward() * -0.6, 3, 3, white)
			cam.End3D()
		end
	end

	function ENT:Think()
	end

	--
	function ENT:OnRemove()
	end
end
--