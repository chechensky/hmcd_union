AddCSLuaFile("shared.lua")
include("shared.lua")

local models = {"models/bloocobalt/citizens/male_02.mdl", "models/bloocobalt/citizens/male_03.mdl", "models/bloocobalt/citizens/male_04.mdl", "models/bloocobalt/citizens/male_05.mdl", "models/bloocobalt/citizens/male_06.mdl", "models/bloocobalt/citizens/male_07.mdl", "models/bloocobalt/citizens/male_08.mdl", "models/bloocobalt/citizens/male_09.mdl", "models/bloocobalt/citizens/male_10.mdl", "models/bloocobalt/citizens/female_01.mdl", "models/bloocobalt/citizens/female_02.mdl", "models/bloocobalt/citizens/female_03.mdl", "models/bloocobalt/citizens/female_04.mdl", "models/bloocobalt/citizens/female_06.mdl", "models/bloocobalt/citizens/female_07.mdl", "models/bloocobalt/citizens/female_02_b.mdl", "models/bloocobalt/citizens/female_03_b.mdl", "models/bloocobalt/citizens/female_04_b.mdl", "models/bloocobalt/citizens/female_06_b.mdl", "models/bloocobalt/citizens/female_07_b.mdl"}

local ModelNames = {
	["models/player/group01/female_01.mdl"] = 2,
	["models/player/group01/female_02.mdl"] = 3,
	["models/player/group01/female_03.mdl"] = 3,
	["models/player/group01/female_04.mdl"] = 1,
	["models/player/group01/female_05.mdl"] = 4,
	["models/player/group01/female_06.mdl"] = 2,
	["models/player/group01/male_01.mdl"] = 3,
	["models/player/group01/male_02.mdl"] = 2,
	["models/player/group01/male_03.mdl"] = 4,
	["models/player/group01/male_04.mdl"] = 4,
	["models/player/group01/male_05.mdl"] = 4,
	["models/player/group01/male_06.mdl"] = 4,
	["models/player/group01/male_07.mdl"] = 4,
	["models/player/group01/male_08.mdl"] = 0,
	["models/player/group01/male_09.mdl"] = 2
}

function ENT:SpawnFunction(ply, tr)
	if not tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	self.Spawn_angles = ply:GetAngles()
	self.Spawn_angles.pitch = 0
	self.Spawn_angles.roll = 0
	self.Spawn_angles.yaw = self.Spawn_angles.yaw + 180
	local ent = ents.Create("npc_type_zero")
	ent:SetKeyValue("disableshadows", "1")
	ent:SetPos(SpawnPos)
	ent:SetAngles(self.Spawn_angles)
	ent:SetModel("")
	ent:SetColor(255, 255, 255, 0)
	ent:Spawn()
	ent:Activate()

	return ent
end

function IsFemale(model)
	return string.find(model, "female") ~= nil or string.find(model, "mossman") ~= nil or string.find(model, "alyx") ~= nil or string.find(model, "policefem") ~= nil
end

function ENT:Initialize()
	self.typezero = ents.Create("npc_citizen")
	self.typezero.HmcdSpawned = true
	self:SetModel("models/shells/shell_12gauge.mdl")
	self:SetNoDraw(true)
	self.typezero:SetPos(self:GetPos())
	self.typezero:SetAngles(self:GetAngles())
	self.typezero:SetKeyValue("spawnflags", "8192" + "1048576" + "2" + "1024" + "512" + "16384" + "256")
	self.typezero:SetKeyValue("squadname", "BioAchi")
	self.typezero:SetKeyValue("citizentype", "3")
	self.typezero:SetKeyValue("expressiontype", "0")
	self.typezero:Give("zombie_claw")
	self.typezero:Fire("SetReadinessPanic")
	self.typezero:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
	self.typezero:CapabilitiesAdd(CAP_OPEN_DOORS)
	self.typezero:CapabilitiesAdd(CAP_AUTO_DOORS)
	self.typezero:SetPlayerColor(self:GetOwner():GetPlayerColor())
	--self.typezero:SetColor(Color(255,190,190))
	self.typezero:Spawn()
	self.typezero:Activate()
	self.typezero:SetName("Type Zero")
	self.typezero:Fire("disableweaponpickup", "", 0)

	self.typezero.VJ_NPC_Class = {"CLASS_ZOMBIE"}

	if IsValid(self.typezero) then
		self.typezero:SetHealth(100)
		self.typezero:SetMaxHealth(115)

		if self.BAInfectedSpawn == nil then
			--if #models > 0 then
			--self.typezero:SetModel("models/bazombies/hand_fix_ba.mdl")
			--self.typezero:SetNoDraw(true)
			--self.typezero:DrawShadow(false)
			--else
			self.typezero:SetModel(string.Replace(self:GetOwner():GetModel(), "player", "humans"))
			--	end
			self.typezero:SetName("Type Zero")
			self.typezero:SetColor(Color(172, 211, 231))
		end

		self.CanWalk = true
		self.typezero.SpecialDamageBio = true
		self.typezero.ZombieBA = true
		self.typezero.BAnoRagdoll = true
		self.typezero.BaDMGmul1 = true
		self.typezero.MaxEff = math.random(15, 30)
		self.typezero.ApearEff = math.random(80, 100)
		self.typezero.H = self.typezero:GetMaxHealth() * .15
		self.typezero.LHH = self.typezero:GetMaxHealth() * .15
		self.typezero.RHH = self.typezero:GetMaxHealth() * .15
		self.ForgetTargetMax = math.random(73, 97)
		self.ForgetTarget = 0
		self.typezero:SetBystanderName(" ")
		self.typezero:SetTrigger(true)
		self.typezero.ClothingMatIndex = self:GetOwner().ClothingMatIndex
		self.typezero:SetSubMaterial(ModelNames[self:GetOwner():GetModel()], self:GetOwner():GetSubMaterial(self.typezero.ClothingMatIndex))
		self.typezero.ModelSex = self:GetOwner().ModelSex
		self.typezero:SetAccessory(self:GetOwner().Accessory)
		self.typezero:SetHeadArmor(self:GetOwner().HeadArmor)
		self.typezero:SetChestArmor(self:GetOwner().ChestArmor)
		self.typezero.BearTrap = self:GetOwner().BearTrap
		self.typezero.ClothingType = self:GetOwner().ClothingType

		if IsValid(self.typezero:GetActiveWeapon()) then
			self.typezero.Weapon = self.typezero:GetActiveWeapon()
			self.typezero.Weapon:SetNoDraw(true)
		end
	end
end

function ENT:Patroll(ent)
	if IsValid(ent) then
		if ent:GetEnemy() then
			self.Patrolling = false
		else
			self.Patrolling = true
		end

		if self.Patrolling == true and self.EatAnim == nil and self.EatingNow == nil and self.CanWalk == true and not ent:IsCurrentSchedule(SCHED_IDLE_WANDER) then
			ent:SetSchedule(SCHED_IDLE_WANDER)
			ent:Fire("StopPatrolling")
		end
	end
end

function ENT:NPCMemory(ent)
	if IsValid(ent) then
		local MyTarget = ent:GetEnemy()

		if IsValid(MyTarget) then
			if ((not ent:IsUnreachable(MyTarget)) and ent:Visible(MyTarget)) and self.DontReset == nil then
				self.DontReset = true
				self.ForgetTarget = 0
				-- print("I got Ya :D (reset): "..self.ForgetTarget)
			elseif ent:IsUnreachable(MyTarget) and ent:Visible(MyTarget) then
				self.DontReset = nil
				self.ForgetTarget = self.ForgetTarget + 1
			elseif ((MyTarget:IsPlayer() and MyTarget:GetVelocity():Length() > 0) or (MyTarget:IsNPC() and MyTarget:IsMoving())) and ent:IsUnreachable(MyTarget) and (not ent:Visible(MyTarget)) then
				-- print("I can't get to You, but I can see You (+1): "..self.ForgetTarget)
				self.DontReset = nil
				self.ForgetTarget = self.ForgetTarget + 2
			elseif ((MyTarget:IsPlayer() and MyTarget:GetVelocity():Length() > 0) or (MyTarget:IsNPC() and MyTarget:IsMoving())) and (not ent:IsUnreachable(MyTarget)) and (not ent:Visible(MyTarget)) then
				-- print("I can't get to You and I can't see You, but I still belive that You are there (+2): "..self.ForgetTarget)
				self.DontReset = nil
				self.ForgetTarget = self.ForgetTarget + 2
			elseif ((MyTarget:IsPlayer() and MyTarget:GetVelocity():Length() <= 0) or (MyTarget:IsNPC() and not MyTarget:IsMoving())) and (not ent:IsUnreachable(MyTarget)) and (not ent:Visible(MyTarget)) then
				--print("I can get to You, I can't see You, but I can hear You (+2): "..self.ForgetTarget)
				self.DontReset = nil
				self.ForgetTarget = self.ForgetTarget + 3
			elseif not IsValid(MyTarget) or (MyTarget:IsPlayer() and MyTarget:Alive() == false) then
				--print("Now You're hiding... Ya Pussy (+3): "..self.ForgetTarget)
				self.DontReset = nil
				--print("I just don't care anymore.")
				ent:ClearEnemyMemory()
				ent:ClearSchedule()
				self.ForgetTarget = 0
			end
		end

		if self.ForgetTarget >= self.ForgetTargetMax then
			--print("I just don't care anymore.")
			ent:ClearEnemyMemory()
			ent:ClearSchedule()
			self.ForgetTarget = 0
			self.DontReset = nil
		end
	end
end

function ENT:EmitSounds(ent)
	if IsValid(ent) and not ent:IsOnFire() and ent:Health() > 0 then
		local MyDinner = ent:GetEnemy()

		-- if (!ent:IsMoving()) and (!IsValid(MyDinner)) and self.IdleAnim == nil and self.EatAnim == nil then
		-- self.IdleAnim = true
		-- ent:PlayScene("scenes/idle_anim.vcd")
		-- timer.Simple(2, function()
		-- self.IdleAnim = nil
		-- end)
		-- end
		if IsValid(MyDinner) and ent:Visible(MyDinner) and self.Alerted == nil then
			self.Alerted = true
			self.Idling = nil
			self.Angry = true
			ent:EmitSound("npc/zombie/zombie_alert" .. math.random(3) .. ".wav")
		elseif IsValid(MyDinner) and (not ent:Visible(MyDinner)) and self.Alerted == nil then
			self.Alerted = true
			self.Idling = nil
			self.Angry = true
			ent:EmitSound("npc/zombie/zombie_alert" .. math.random(3) .. ".wav")
		elseif (not IsValid(MyDinner)) and not ent.IsBreakingDoor then
			self.Alerted = nil
			self.Idling = true
			self.Angry = nil
		end

		if self.Angry == true and self.CanAngrySound == nil then
			self.CanAngrySound = true

			timer.Simple(math.random(1.5, 2), function()
				self.CanAngrySound = nil
				if not IsValid(ent) or not IsValid(ent:GetEnemy()) or not IsValid(MyDinner) or ent:Health() <= 0 then return end

				if ent:Visible(MyDinner) then
				else --ent:EmitSound("npc/zombie/zombie_voice_idle"..math.random(14)..".wav")
				end
			end)
			--ent:EmitSound("npc/zombie/zombie_alert"..math.random(3)..".wav")
		end

		if self.Idling == true and self.CanIdleSound == nil then
			self.CanIdleSound = true
			ent:EmitSound("npc/zombie/zombie_voice_idle" .. math.random(14) .. ".wav")

			timer.Simple(math.random(4, 6), function()
				self.CanIdleSound = nil
			end)
		end
	end
end

function ENT:Relations(ent)
	if IsValid(ent) then
		for _, enemy in pairs(ents.GetAll()) do
			if enemy:IsPlayer() or enemy:IsNPC() then
				if enemy:IsPlayer() and not enemy:Alive() then
					ent:AddEntityRelationship(enemy, D_LI, 0)
				elseif enemy.ZombieBA == true then
					ent:AddEntityRelationship(enemy, D_LI, 0)
				elseif enemy.Faction ~= nil and enemy.Faction == 3 then
					ent:AddEntityRelationship(enemy, D_LI, 0)
				else
					ent:AddEntityRelationship(enemy, D_HT, 0)
				end
			end

			if enemy:IsNPC() then
				if enemy.ZombieBA == true or enemy:GetClass() == "npc_zombie" or enemy:GetClass() == "npc_zombine" or enemy:GetClass() == "npc_fastzombie" or enemy:GetClass() == "npc_poisonzombie" or enemy:GetClass() == "npc_zombie_torso" or enemy:GetClass() == "npc_headcrab_black" or enemy:GetClass() == "npc_headcrab" or enemy:GetClass() == "npc_fastzombie_torso" or enemy:GetClass() == "npc_headcrab_fast" or enemy:GetClass() == "npc_headcrab_poison" then
					enemy:AddEntityRelationship(ent, D_LI, 0)
				elseif enemy.VJ_NPC_Class ~= nil then
					if table.HasValue(enemy.VJ_NPC_Class, "CLASS_ZOMBIE") then
						enemy:AddEntityRelationship(ent, D_LI, 0)
						ent:AddEntityRelationship(enemy, D_LI, 0)
					else
						enemy:AddEntityRelationship(ent, D_HT, 0)
						ent:AddEntityRelationship(enemy, D_HT, 0)
					end

					if enemy:GetEnemy() == nil and enemy:Visible(ent) then
						enemy:SetEnemy(ent)
					end
				else
					enemy:AddEntityRelationship(ent, D_HT, 0)
				end
			end
		end
	end
end

function ENT:Drowning(ent)
	if IsValid(ent) then
		if ent:WaterLevel() >= 2.8 and self.Drown == nil then
			self.Drown = true
			local droani = ents.Create("ba_drown_anim")

			if IsValid(droani) then
				droani:SetPos(ent:GetPos() + Vector(0, 0, -8))
				droani:SetAngles(ent:GetAngles())
				droani:SetOwner(ent)
				droani.body = true

				if not IsValid(ent.inftyp) then
					droani.Model = ent:GetModel()
					droani.Skin = ent:GetSkin()
					droani.Material = ent:GetMaterial()
					droani.Color = ent:GetColor()
					droani.Body1 = ent:GetBodygroup(1)
					droani.Body2 = ent:GetBodygroup(2)
					droani.Body3 = ent:GetBodygroup(3)
					droani.Body4 = ent:GetBodygroup(4)
					droani.Body5 = ent:GetBodygroup(5)
					droani.Body6 = ent:GetBodygroup(6)
					droani.Body7 = ent:GetBodygroup(7)
					droani.Body8 = ent:GetBodygroup(8)
					droani.Body9 = ent:GetBodygroup(9)
					SafeRemoveEntityDelayed(ent, 0.01)
				elseif IsValid(ent.inftyp) then
					droani.Model = ent.inftyp:GetModel()
					droani.Skin = ent.inftyp:GetSkin()
					droani.Material = ent.inftyp:GetMaterial()
					droani.Color = ent.inftyp:GetColor()
					droani.Body1 = ent.inftyp:GetBodygroup(1)
					droani.Body2 = ent.inftyp:GetBodygroup(2)
					droani.Body3 = ent.inftyp:GetBodygroup(3)
					droani.Body4 = ent.inftyp:GetBodygroup(4)
					droani.Body5 = ent.inftyp:GetBodygroup(5)
					droani.Body6 = ent.inftyp:GetBodygroup(6)
					droani.Body7 = ent.inftyp:GetBodygroup(7)
					droani.Body8 = ent.inftyp:GetBodygroup(8)
					droani.Body9 = ent.inftyp:GetBodygroup(9)
					SafeRemoveEntityDelayed(ent.inftyp, 0.01)
					SafeRemoveEntityDelayed(ent, 0.01)
				end

				droani:Spawn()

				if ent.HitInHead == true then
					droani.HitInHead = true
				end

				if ent.HitInLArm == true then
					droani.HitInLArm = true
				end

				if ent.HitInRArm == true then
					droani.HitInRArm = true
				end

				local watereff = EffectData()
				watereff:SetEntity(ent)
				watereff:SetOrigin(ent:GetPos())
				watereff:SetNormal(ent:GetPos())
				util.Effect("waterripple", watereff)
			end
		end
	end
end

function ENT:Infect(victim)
	if not victim.Infected then
		local LifeID = victim.LifeID
		victim.Infected = true
		victim.InfectionStarted = false

		if not timer.Exists(tostring(victim) .. "InfectionTimer") then
			timer.Create(tostring(victim) .. "InfectionTimer", math.random(45, 60), 1, function()
				net.Start("hmcd_infected")
				net.WriteEntity(victim)
				net.WriteBit(victim.Infected)
				net.WriteBit(victim.InfectionStarted)
				net.Send(victim)

				timer.Simple(128, function()
					if IsValid(victim) and victim:Alive() then
						if victim.LifeID == LifeID then
							if victim.fake then
								victim:KillSilent()
								victim.fake = false
							else
								victim:Kill()
							end
						end
					end
				end)
			end)
		end
	else
		if timer.Exists(tostring(victim) .. "InfectionTimer") then
			timer.Adjust(tostring(victim) .. "InfectionTimer", timer.TimeLeft(tostring(victim) .. "InfectionTimer") / 1.5, nil, nil)
		end
	end
end

function ENT:CorpseEating(ent)
	if IsValid(ent) and self.typezero:Health() > 0 and not self.typezero:IsCurrentSchedule(SCHED_CHASE_ENEMY) then
		if self.EatAnim == nil then
			self.EatingNow = nil
		end

		local arr = ents.FindByClass("prop_ragdoll")

		for _, eat in pairs(arr) do
			if ent:GetPos():Distance(eat:GetPos()) <= 500 and ent:Visible(eat) and eat.BAinfbody == nil and not eat.ZombieCorpse then
				if not eat:LookupBone("ValveBiped.Bip01_Head1") then
				else
					if ent:GetPos():Distance(eat:GetPos()) <= 60 and ent:Health() < ent:GetMaxHealth() and self.EatAnim == nil then
						if eat.InfFood == nil then
							eat.InfFood = true
							local phys = eat:GetPhysicsObject()
							local physCount = eat:GetPhysicsObjectCount()

							for num = 0, physCount - 1 do
								eat:SetCollisionGroup(COLLISION_GROUP_WEAPON)
							end
						end

						ent:PlayScene("scenes/eat_corpse.vcd")
						self.EatAnim = true
						ent:StopMoving()

						timer.Simple(5, function()
							self.EatAnim = nil
						end)
					elseif ent:GetPos():Distance(eat:GetPos()) > 60 or ent:Health() >= ent:GetMaxHealth() or ent:GetEnemy() then
						self.EatingNow = nil
						self.EatAnim = nil
					end

					if self.EatAnim == true then
						if not ent:IsCurrentSchedule(SCHED_TARGET_FACE) then
							ent:SetTarget(eat)
							ent:SetSchedule(SCHED_TARGET_FACE)
						end

						local ang = (eat:GetPos() - ent:GetPos()):Angle()
						local ang2 = ent:GetAngles()
						ent:SetAngles(Angle(ang2.p, ang.y, ang2.r))
					end

					if self.EatAnim == true and self.LeatEffect == nil then
						self.LeatEffect = true

						for i = 0, 50 do
							local Name = string.lower(ent:GetBoneName(i))

							if string.find(Name, "l_hand") then
								if self.Leat == nil then
									self.Leat = true
									local eateff = EffectData()
									eateff:SetEntity(ent)
									eateff:SetOrigin(ent:GetBonePosition(i))
									eateff:SetNormal(ent:GetBonePosition(i))
									util.Effect("BloodImpact", eateff)
									ent:EmitSound("physics/flesh/flesh_squishy_impact_hard" .. math.random(1, 4) .. ".wav")
									local blooddrop1 = ents.Create("ba_gib")

									if IsValid(blooddrop1) then
										blooddrop1:SetPos(eat:GetPos())
										blooddrop1:SetOwner(eat)
										blooddrop1:SetNoDraw(true)
										blooddrop1:Spawn()
										local phys = blooddrop1:GetPhysicsObject()
										phys:SetVelocity(eat:GetUp() * math.random(80, 180) + eat:GetRight() * math.random(-60, 60) + eat:GetForward() * math.random(-60, 60))
										phys:AddAngleVelocity(Vector(math.random(-800, 800), math.random(-800, 800), math.random(-800, 800)))
									end

									local givehp = math.min(ent:GetMaxHealth() - ent:Health(), math.random(1, 2))
									ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + givehp))
								end
							end
						end

						timer.Simple(math.random(0.7, 0.9), function()
							self.LeatEffect = nil
							self.Leat = nil
						end)
					end

					if self.EatAnim == true and self.ReatEffect == nil then
						self.ReatEffect = true

						for i = 0, 50 do
							local Name = string.lower(ent:GetBoneName(i))

							if string.find(Name, "r_hand") then
								if self.Reat == nil then
									self.Reat = true
									local eateff = EffectData()
									eateff:SetEntity(ent)
									eateff:SetOrigin(ent:GetBonePosition(i))
									eateff:SetNormal(ent:GetBonePosition(i))
									util.Effect("BloodImpact", eateff)
									ent:EmitSound("GibSound.BA")
									local givehp = math.min(ent:GetMaxHealth() - ent:Health(), math.random(1, 2))
									ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + givehp))
								end
							end
						end

						timer.Simple(math.random(0.7, 0.9), function()
							self.ReatEffect = nil
							self.Reat = nil
						end)
					end

					if ent:GetEnemy() == nil and ent:GetPos():Distance(eat:GetPos()) > 60 and ent:GetPos():Distance(eat:GetPos()) <= 500 and ent:Health() < ent:GetMaxHealth() and not ent:IsCurrentSchedule(SCHED_CHASE_ENEMY) then
						self.EatingNow = true
						self.DontGoForFood = nil
						ent:SetLastPosition(eat:GetPos())
						ent:SetSchedule(SCHED_FORCED_GO)
					elseif ent:GetEnemy() and self.DontGoForFood == nil then
						self.DontGoForFood = true
						ent:StopMoving()
					end
				end
			end
		end
	end
end

function ENT:Climbing(ent)
	if ent.IsClimbing == nil then
		ent.IsClimbing = false
	end

	if ent.CanClimbSound == nil then
		ent.CanClimbSound = true
	end

	if ent:IsOnGround() then
		ent:Fire("SetReadinessPanic")
	else
		ent:Fire("SetReadinessLow")
	end

	if GetConVar("ai_disabled"):GetBool() or ent.HitInRArm == true or ent.HitInLArm == true or ent.EatingNow == true or ent:IsMoving() == true then return end
	local enemy = ent:GetEnemy()

	if enemy == nil then
		enemy = ent:GetTarget()

		if enemy == nil or not enemy:IsRagdoll() then
			enemy = nil
		end
	end

	local aim = ent:EyePos() + (ent:GetAimVector() * 80)

	local trace = util.TraceLine({
		start = ent:GetPos(),
		endpos = Vector(aim.x, aim.y, ent:GetPos().z + 50)
	})

	if ent.IsClimbing == true or (IsValid(enemy) and ent:GetPos().z + 100 < enemy:GetPos().z) then
		-- local dummy = ents.Create("prop_physics")
		-- dummy:SetPos(trace.HitPos)
		-- dummy:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
		-- timer.Simple(2,function()
		-- 	dummy:Remove()
		-- end)
		if IsValid(trace.Entity) and trace.Entity:GetClass() == "prop_physics" and trace.Entity:Health() == 0 and trace.Entity:GetPhysicsObject():GetMass() < ent:GetPhysicsObject():GetMass() * 2 then return end

		if trace.HitWorld or (IsValid(trace.Entity) and not trace.Entity:IsNPC() and not trace.Entity:IsPlayer() and not trace.Entity:IsRagdoll()) then
			if ent.CanClimbSound == true then
				ent.CanClimbSound = false
				ent:EmitSound("InfectedGrab.BA")

				timer.Simple(.4, function()
					ent.CanClimbSound = true
				end)
			end

			ent.IsClimbing = true
			ent:SetSchedule(SCHED_TARGET_FACE)
			ent:SetSequence(ACT_CLIMB_UP)
			ent:SetLocalVelocity(ent:GetAimVector() * 30 + Vector(0, 0, 120))
		elseif ent.IsClimbing == true then
			ent.IsClimbing = false
			ent:SetLocalVelocity(ent:GetAimVector() * 30 + Vector(0, 0, 200))

			timer.Simple(.2, function()
				if not IsValid(ent) then return end
				ent:SetLocalVelocity(ent:GetAimVector() * 150 + Vector(0, 0, 100))
			end)
		end
	end

	trace = util.TraceLine({
		start = ent:GetPos() + Vector(0, 0, 70),
		endpos = Vector(aim.x, aim.y, ent:GetPos().z - 20),
		filter = table.Add(ents.FindByClass("npc_*"), player.GetAll()),
	})

	local trace2 = util.TraceLine({
		start = ent:GetPos() + Vector(0, 0, 70),
		endpos = Vector(aim.x, aim.y, ent:GetPos().z - 800),
		filter = table.Add(ents.FindByClass("npc_*"), player.GetAll()),
	})

	if not trace.Hit and trace2.Hit and ent:IsOnGround() and IsValid(enemy) and ent:GetPos().z >= enemy:GetPos().z then
		ent:SelectWeightedSequence(ACT_GLIDE)
		ent:SetLocalVelocity(ent:GetAimVector() * 10 + Vector(0, 0, 100))

		timer.Simple(.2, function()
			if not IsValid(ent) then return end
			ent:SetLocalVelocity(ent:GetAimVector() * 150 + Vector(0, 0, 100))
		end)
	end
end

function ENT:Think()
	if IsValid(self.typezero) then
		if GetConVar("ai_disabled"):GetBool() then return end
		self:NPCMemory(self.typezero)
		self:CorpseEating(self.typezero)
		self:Relations(self.typezero)
		self:Drowning(self.typezero)
		self:Patroll(self.typezero)
		self:EmitSounds(self.typezero)
		self:Climbing(self.typezero)

		if self.typezero:IsOnFire() and (not self.typezero.NextMoanSound or self.typezero.NextMoanSound < CurTime()) then
			local Rand = math.random(1, 4)

			if self.typezero.CurMoanSound then
				self.typezero:StopSound(self.typezero.CurMoanSound)
			end

			self.typezero:EmitSound("npc/zombie/moan_loop" .. Rand .. ".wav")
			self.typezero.CurMoanSound = "npc/zombie/moan_loop" .. Rand .. ".wav"
			self.typezero.NextMoanSound = CurTime() + SoundDuration("npc/zombie/moan_loop" .. Rand .. ".wav")
		elseif not self.typezero:IsOnFire() then
			if self.typezero.CurMoanSound then
				self.typezero:StopSound(self.typezero.CurMoanSound)
			end
		end
	elseif not IsValid(self.typezero) or self.typezero:Health() <= 0 then
		if IsValid(self.typezero) then
			self.typezero:stopsound(self.typezero.CurMoanSound)
			self.typezero:StopSound("InfectedAlertSee.BA")
			self.typezero:StopSound("InfectedAlertCantSee.BA")
			self.typezero:StopSound("InfectedIdleA.BA")
			self.typezero:StopSound("InfectedIdleB.BA")
			self.typezero:StopSound("InfectedIdleC.BA")
			self.typezero:StopSound("InfectedAngry.BA")
			self.typezero:StopSound("InfectedAlertSeeFemale.BA")
			self.typezero:StopSound("InfectedAlertCantSeeFemale.BA")
			self.typezero:StopSound("InfectedAngryFemale.BA")
		end

		self:Remove()
	end
end

function ENT:OnTakeDamage()
end

function ENT:OnRemove()
	if IsValid(self.typezero) then
		self.typezero:StopSound("InfectedAlertSee.BA")
		self.typezero:StopSound("InfectedAlertCantSee.BA")
		self.typezero:StopSound("InfectedIdleA.BA")
		self.typezero:StopSound("InfectedIdleB.BA")
		self.typezero:StopSound("InfectedIdleC.BA")
		self.typezero:StopSound("InfectedAngry.BA")
		self.typezero:StopSound("InfectedAlertSeeFemale.BA")
		self.typezero:StopSound("InfectedAlertCantSeeFemale.BA")
		self.typezero:StopSound("InfectedAngryFemale.BA")
		self.typezero:Remove()
	end
end

function ENT:RenderOverride()
	if IsValid(self.typezero) then
		if not IsValid(self.typezero.inftyp) then
			self:DrawModel()
		end
	end
end