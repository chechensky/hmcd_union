--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_breachcharge.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Grenade"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.NextBeep = 0

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_combine/combine_mine01.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(true)
		self.NextTime = 3
		self.TickAmount = 0
		self.Allowed = false

		timer.Simple(3, function()
			self.Allowed = true
		end)

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then
			phys:Wake()
			phys:SetMass(5)
		end
		--self.Detonated=false
		--self.Armed=false
		--self.Rigged=false
	end

	function ENT:Use(ply)
	end

	--
	function ENT:Think()
		if self.NextBeep < CurTime() and self.Allowed then
			self.NextBeep = CurTime() + self.NextTime
			self:EmitSound("npc/turret_floor/ping.wav")
			self.TickAmount = self.TickAmount + 1

			if self.TickAmount >= 3 then
				self.NextTime = 0.2
			end

			if self.TickAmount == 7 then
				self:Detonate()
			end
		end

		self:NextThink(CurTime() + .01)

		return true
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
				HMCD_BlastThatDoor(ent, (ent:GetPos() - self:GetPos()):GetNormalized() * 750)
			end
		end

		util.Effect("explosion", Foom, true, true)
		local Flash = EffectData()
		Flash:SetOrigin(Pos)
		Flash:SetScale(2)
		util.Effect("eff_jack_hmcd_dlight", Flash, true, true)

		timer.Simple(.01, function()
			self:EmitSound("snd_jack_hmcd_explosion_debris.mp3", 85, math.random(90, 110))
			self:EmitSound("m67/m67_detonate_far_dist_0" .. math.random(1, 3) .. ".wav", 140, 100)
			self:EmitSound("snd_jack_hmcd_debris.mp3", 85, math.random(90, 110))

			for i = 0, 10 do
				local Tr = util.QuickTrace(Pos, VectorRand() * math.random(10, 150), {self})

				if Tr.Hit then
					util.Decal("Scorch", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
				end
			end
		end)

		timer.Simple(.02, function()
			--self:EmitSound("m67/m67_detonate_0"..math.random(1,3)..".wav",Pos,80,100)
			self:EmitSound("m67/m67_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
			self:EmitSound("m67/m67_detonate_0" .. math.random(1, 3) .. ".wav", 80, 100)
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
			Shrap:SetDamage(55)
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
	local redglow, trans = Material("sprites/redglow1"), Material("models/hands/hands_color")

	function ENT:Initialize()
		self.NextTime = 3
		self.material = trans
		self.Amount = 0

		timer.Simple(3, function()
			self.Allowed = true
		end)
	end

	function ENT:Draw()
		local Mat = Matrix()
		Mat:Scale(Vector(.42, .42, .42))
		self:EnableMatrix("RenderMultiply", Mat)
		self:DrawModel()
		if not self.Allowed then return end
		local pos, white, ang = self:GetPos(), Color(255, 255, 255, 255), self:GetAngles()

		if self.NextBeep < CurTime() then
			self.material = redglow
			self.Amount = self.Amount + 1
			self.NextBeep = CurTime() + self.NextTime

			if self.Amount >= 3 then
				self.NextTime = 0.2
			end

			timer.Simple(.1, function()
				self.material = trans
			end)
		end

		cam.Start3D()
		render.SetMaterial(self.material)
		render.DrawSprite(pos + ang:Up() * 5.3 + ang:Right() * 0, 10, 10, white)
		cam.End3D()
	end

	function ENT:Think()
	end

	--
	function ENT:OnRemove()
	end
end
--