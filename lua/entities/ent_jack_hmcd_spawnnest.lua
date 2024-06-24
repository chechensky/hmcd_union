--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_spawnnest.lua

--]]
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Bear Trap"
ENT.SWEP = "wep_jack_hmcd_beartrap"
ENT.Model = "models/barnacle.mdl"
ENT.Tall = 0

if SERVER then
	function ENT:Initialize()
		self.Entity:SetModel(self.Model)
		self:PhysicsInitBox(Vector(-15, -15, 0), Vector(15, 15, 30))
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()

		if phys:IsValid() then
			phys:SetMaterial("flesh")
			phys:EnableMotion(false)
		end

		self:SetHealth(100)
		self:SetMaxHealth(100)
		self:SetModelScale(1.45, 0)
		self:ManipulateBonePosition(10, Vector(-25, 0, 0))
		self:SetSubMaterial(0, "models/flesh")
		self:SetSubMaterial(1, "engine/occlusionproxy")
		self:SetSubMaterial(2, "engine/occlusionproxy")

		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() - vector_up * 48,
			mask = MASK_PLAYERSOLID,
			filter = self
		})

		local nestang = tr.HitNormal:Angle()
		nestang:RotateAroundAxis(nestang:Right(), 90)
		self:SetPos(tr.HitPos)
		self:SetAngles(nestang)
		self.fleshy = true
		self.NextZombieSpawn = 0
		self.SpawnTime = CurTime()
	end

	function ENT:OnTakeDamage(dmginfo)
		local attacker = dmginfo:GetAttacker()
		if IsValid(attacker) and attacker.Role == "Traitor" then return end
		self:SetHealth(self:Health() - dmginfo:GetDamage())
		local effData = EffectData()
		effData:SetOrigin(self:GetPos())
		effData:SetNormal(Vector(0, 0, 1))
		effData:SetScale(6)
		effData:SetFlags(3)
		effData:SetColor(0)
		effData:SetEntity(self)
		util.Effect("bloodspray", effData)

		if self:Health() <= 0 then
			self:Explode()
		else
			self:EmitSound("physics/flesh/flesh_squishy_impact_hard" .. math.random(1, 4) .. ".wav", 70)
		end
	end

	function ENT:Explode()
		local effData = EffectData()
		effData:SetOrigin(self:GetPos())
		effData:SetNormal(Vector(0, 0, 1))
		effData:SetScale(6)
		effData:SetFlags(3)
		effData:SetColor(0)
		effData:SetEntity(self)
		util.Effect("bloodspray", effData)

		for i = 1, 20 do
			effData:SetNormal(VectorRand())
			effData:SetOrigin(self:GetPos())
			util.Effect("eff_jack_hmcd_blobgib", effData)
		end

		util.Decal("Blood", self:GetPos() + VectorRand() * 15, self:GetPos() - vector_up * 500, self)
		self:EmitSound("physics/flesh/flesh_bloody_break.wav", 70)

		for i, ent in pairs(ents.FindInSphere(self:GetPos(), 100)) do
			if ent:IsPlayer() and ent:Alive() then
				local watchingEnt = ent

				if IsValid(ent.fakeragdoll) then
					watchingEnt = ent.fakeragdoll
				end

				if watchingEnt:Visible(self) and (ent.Bleedout > 0 or ent:GetNWString("Mask") ~= "Gas Mask") then
					if ent.Bleedout > 0 and GAMEMODE.ZombieMutations["Blood"] then
						ent:AddBacteria(45, CurTime())
					end

					if ent:GetNWString("Mask") ~= "Gas Mask" and GAMEMODE.ZombieMutations["Air"] then
						ent:AddBacteria(45, CurTime() - 101)
					end
				end
			end
		end

		if GAMEMODE.ZombieMutations["Air"] then
			for x = -0.5, 0.5, 0.5 do
				for y = -0.5, 0.5, 0.5 do
					for z = -0.5, 0.5, 0.5 do
						local vec = Vector(x, y, z)

						table.insert(GAMEMODE.ZombieGas, {self:GetPos() + Vector(0, 0, 30) + vec * math.Rand(10, 15), CurTime(), vec * 130 + Vector(0, 0, 10)})
					end
				end
			end
		end

		self:Remove()
	end

	local function findBone(ent, name)
		local bone = ent:LookupBone(name)
		if bone then return ent:GetPhysicsObjectNum(ent:TranslateBoneToPhysBone(bone)) end
	end

	function ENT:SpawnZombie(ply, fast)
		if CurTime() - self.SpawnTime <= 5 or self.NextZombieSpawn > CurTime() then return end
		local zombNum = self:GetNWInt("1_zombs")

		if zombNum > 0 then
			self:SetNWInt("1_zombs", zombNum - 1)
		end

		self.NextZombieSpawn = CurTime() + 5
		self:EmitSound("physics/body/body_medium_break" .. math.random(2, 4) .. ".wav", 70)
		local rag = ents.Create("prop_ragdoll")
		rag:SetPos(self:GetPos() - Vector(0, 0, 30))
		rag:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

		if fast then
			rag:SetModel("models/player/zombie_fast.mdl")
		else
			rag:SetModel("models/player/zombie_classic.mdl")
			local mul = GAMEMODE.ZombieMutations["Shambler"] or 0

			if mul > 0 then
				for i = 31, 43 do
					rag:ManipulateBonePosition(i, Vector(mul, 0, 0))
					ply:ManipulateBonePosition(i, Vector(mul, 0, 0))
				end
			end
		end

		rag.fleshy = true
		rag:Spawn()
		rag:Activate()
		rag.foot_l = findBone(rag, "ValveBiped.Bip01_L_Foot") or rag:GetPhysicsObject()
		rag.foot_r = findBone(rag, "ValveBiped.Bip01_R_Foot") or rag:GetPhysicsObject()
		rag.fist_l = findBone(rag, "ValveBiped.Bip01_L_Hand") or rag:GetPhysicsObject()
		rag.fist_r = findBone(rag, "ValveBiped.Bip01_R_Hand") or rag:GetPhysicsObject()
		rag.thigh_l = findBone(rag, "ValveBiped.Bip01_L_Thigh") or rag:GetPhysicsObject()
		rag.thigh_r = findBone(rag, "ValveBiped.Bip01_R_Thigh") or rag:GetPhysicsObject()
		rag.head = rag:GetPhysicsObjectNum(1)
		rag.NextGrab_L = 0
		rag.NextGrab_R = 0
		ply:UnCSpectate()
		ply:Spawn()

		if fast then
			ply:Give("wep_jack_hmcd_zombhandsfast")
			ply:SelectWeapon("wep_jack_hmcd_zombhandsfast")
		else
			ply:Give("wep_jack_hmcd_zombhands")
			ply:SelectWeapon("wep_jack_hmcd_zombhands")
		end

		ply.fake = true
		ply.Role = "Traitor"
		ply:GiveLoadout()
		rag:SetPlayerColor(ply:GetPlayerColor())
		ply:SetModel(rag:GetModel())
		net.Start("hmcd_role")
		net.WriteString(ply:SteamID())
		net.WriteString(ply.Role)
		net.Send(player.GetAll())
		ply.HomePos = rag:GetPos()
		ply.fakeragdoll = rag
		ply:SetNWEntity("Fake", rag)
		ply:SetNWEntity("DeathRagdoll", rag)
		rag:SetNWEntity("RagdollOwner", ply)
		ply:Spectate(OBS_MODE_CHASE)
		ply:SpectateEntity(rag)
		ply:SetObserverMode(OBS_MODE_NONE)
		ply:SetParent(rag)
		ply:SetNWString("Bodyvest", "")
		ply:SetNWString("Helmet", "")
		ply:SetNWString("Mask", "")
		local mul = 1

		if not fast then
			ply:SetWalkSpeed(50)
			ply:SetMaxSpeed(50)
			ply:SetRunSpeed(50)
			ply:SetJumpPower(150)
			ply:SetSlowWalkSpeed(50)

			if ply:GetNWString("Class") ~= "" then
				ply:SetNWString("Class", "")
			end
		else
			ply.NextInvoluntaryEvent = nil
			ply:SetNWString("Class", "fast")
			ply.SideSpeedDiv = 8
			ply.SpeedMul = .5
			ply.MaxHealth = 25
			ply:SetMaxHealth(25)
			ply:SetHealth(25)
			mul = 0.3
		end

		ply.LastStepPos = ply:GetPos()
		ply.NextStandUp = CurTime() + 3
		local boneCount = rag:GetPhysicsObjectCount()
		local ind = rag:EntIndex()

		hook.Add("Think", ind .. "Moving", function()
			if not (IsValid(rag) and IsValid(self)) then
				hook.Remove("Think", ind .. "Moving")

				return
			end

			local phys = rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone("ValveBiped.Bip01_L_Clavicle")))
			phys:SetPos(phys:GetPos() + Vector(0, 0, 6 * mul))

			if phys:GetPos().z - self:GetPos().z > 90 * math.Clamp(self:Health() / self:GetMaxHealth(), 0.001, 1) then
				hook.Remove("Think", ind .. "Moving")
				rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				local vec = VectorRand() * 10000
				vec.z = 0
				phys:ApplyForceCenter(vec)
			end
		end)
	end
else
	function ENT:Initialize()
		self.SpawnTime = CurTime()
		self.AmbientSound = CreateSound(self, "ambient/levels/citadel/citadel_drone_loop5.wav")
	end

	function ENT:OnRemove()
		self.AmbientSound:Stop()
	end

	function ENT:Think()
		self.Tall = math.Approach(self.Tall, math.Clamp(self:Health() / self:GetMaxHealth(), 0.001, 1) * math.min((CurTime() - self.SpawnTime) / 10, 1), FrameTime())
		local a = math.abs(math.sin(CurTime())) ^ 3
		local hscale = 1 + a * 0.04
		self:ManipulateBoneScale(0, Vector(hscale * 1.1, hscale * 1.1 + 0.05, hscale * 1.1 + 0.02 * self.Tall))
		self:ManipulateBoneScale(1, Vector(hscale * 1.1, hscale * 1.1 + 0.05, hscale * 1.1 + 0.02 * self.Tall))
		self:ManipulateBonePosition(1, Vector(-25 + self.Tall * 25, 0, 0))
		self.AmbientSound:PlayEx(0.6, 100 + CurTime() % 1)
	end

	local fast = Material("vgui/zombie/fast")

	function ENT:Draw()
		self:DrawModel()

		if LocalPlayer().ZombieMaster then
			if LocalPlayer():GetEyeTrace().Entity == self then
				LocalPlayer().Nest = self
				local pos, ang = self:GetPos(), self:GetAngles()
				local eyeAng = LocalPlayer():EyeAngles()
				eyeAng:RotateAroundAxis(eyeAng:Right(), 90)
				eyeAng:RotateAroundAxis(eyeAng:Up(), -90)
				local scale = .1
				cam.Start3D2D(pos + ang:Up() * -60 * self.Tall, eyeAng, scale)
				surface.SetDrawColor(Color(55, 55, 55, 255))
				surface.DrawRect(-7 / scale, -8 / scale, 14 / scale, 16 / scale)
				surface.SetDrawColor(Color(25, 25, 25, 255))
				surface.DrawRect(-6 / scale, -7 / scale, 12 / scale, 14 / scale)
				surface.SetDrawColor(Color(15, 15, 15, 255))
				surface.DrawRect(-5 / scale, -5 / scale, 10 / scale, 10 / scale)
				surface.SetDrawColor(color_white)
				surface.SetMaterial(fast)
				surface.DrawTexturedRect(-5 / scale, -5 / scale, 10 / scale, 10 / scale)
				surface.SetFont("MersText1")
				local zombNum = self:GetNWInt("1_zombs")
				local textWidth, textHeight = surface.GetTextSize(zombNum)
				draw.SimpleText("40 Pts.", "MersText1", -2 / scale, 5 / scale)
				draw.SimpleText("1", "ScoreboardPlayer", 3.75 / scale, 2.5 / scale)
				draw.SimpleText(zombNum, "ScoreboardPlayer", (0.25 - zombNum * 0.15) / scale, -1.5 / scale)
				cam.End3D2D()
			elseif LocalPlayer().Nest then
				LocalPlayer().Nest = nil
			end
		end
	end
end