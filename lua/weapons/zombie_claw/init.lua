AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("ai_translations.lua")
SWEP.testtimer = false
include('shared.lua')
SWEP.IsCloaked = false
SWEP.Weight = 30
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.timer = false
SWEP.NextFireTimer = false
SWEP.FailedBlinkTimer = false
SWEP.HmcdSpawned = true

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")

	if IsValid(self:GetOwner()) then
		self:GetOwner():Fire("GagEnable")
		self:Proficiency()
		hook.Add("Think", self, self.onThink)
	end
end

function SWEP:onThink()
	if not IsValid(self) or not IsValid(self:GetOwner()) then return end
	self:GetOwner():ClearCondition(13)
	self:GetOwner():ClearCondition(17)
	self:GetOwner():ClearCondition(18)
	self:GetOwner():ClearCondition(20)
	self:GetOwner():ClearCondition(48)
	self:GetOwner():ClearCondition(42)
	self:GetOwner():ClearCondition(45)

	if IsValid(self:GetOwner().inftyp) then
		self:GetOwner():SetNoDraw(true)
		self:GetOwner().inftyp:SetMaterial(self:GetOwner():GetMaterial())
	end

	if self.NextFireTimer == false and self:GetOwner():GetEnemy() then
		self:NextFire()
	end
end

function SWEP:NextFire()
	if not self:IsValid() or not self:GetOwner():IsValid() then return end
	if self:GetOwner():IsCurrentSchedule(SCHED_CHASE_ENEMY) then return end
	self.NextFireTimer = true
	self:Chase_Enemy()
	local randomtimer = math.Rand(0.5, 0.8)

	timer.Simple(randomtimer, function()
		self.NextFireTimer = false
	end)
end

function SWEP:Proficiency()
	timer.Simple(0.5, function()
		if not self:IsValid() or not self:GetOwner():IsValid() then return end
		self:GetOwner():SetCurrentWeaponProficiency(4)
		self:GetOwner():CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
		self:GetOwner():CapabilitiesRemove(CAP_WEAPON_MELEE_ATTACK1)
		self:GetOwner():CapabilitiesRemove(CAP_INNATE_MELEE_ATTACK1)
	end)
end

function SWEP:GetCapabilities()
	return bit.bor(CAP_WEAPON_MELEE_ATTACK1)
end

AccessorFunc(SWEP, "fNPCMinBurst", "NPCMinBurst")
AccessorFunc(SWEP, "fNPCMaxBurst", "NPCMaxBurst")
AccessorFunc(SWEP, "fNPCFireRate", "NPCFireRate")
AccessorFunc(SWEP, "fNPCMinRestTime", "NPCMinRest")
AccessorFunc(SWEP, "fNPCMaxRestTime", "NPCMaxRest")

function SWEP:OnDrop()
	self:Remove()
	hook.Remove("Think", self, self.onThink)
end

function SWEP:Chase_Enemy()
	if not self:IsValid() or not self:GetOwner():IsValid() then return end
	if self:GetOwner():IsCurrentSchedule(SCHED_MELEE_ATTACK1) then return end

	if self:GetOwner():GetEnemy():GetPos():DistToSqr(self:GetPos()) > 3600 then
		if not self:GetOwner().LastEnemy or self:GetOwner().LastEnemy ~= self:GetOwner():GetEnemy() then
			self:GetOwner().LastEnemy = self:GetOwner():GetEnemy()
		end

		local lastpostr = util.QuickTrace(self:GetPos(), self:GetOwner():GetEnemyLastKnownPos(self:GetOwner().LastEnemy) - self:GetPos(), {self, self:GetOwner()})

		if IsValid(lastpostr.Entity) and HMCD_IsDoor(lastpostr.Entity) then
			self:GetOwner():SetSchedule(SCHED_MELEE_ATTACK1)
			self:NPCShoot_Primary()
			self:GetOwner().BreakingDoor = true

			return
		end

		self:GetOwner().BreakingDoor = false
		self:GetOwner():SetLastPosition(self:GetOwner():GetEnemy():GetPos())

		if self:GetOwner():IsUnreachable(self:GetOwner():GetEnemy()) then
			if self:GetOwner():IsMoving() == false then
				--print("Moving around")
				local trace = util.TraceLine({
					start = self:GetOwner():GetPos(),
					endpos = self:GetOwner():EyePos() + self:GetOwner():GetAimVector() * 100,
					filter = ents.FindByClass("npc_*")
				})

				if IsValid(trace.Entity) then
					self:GetOwner():SetLastPosition(trace.HitPos)
				else
					self:GetOwner():SetLastPosition(self:GetOwner():GetPos() + VectorRand() * 200)
				end

				if self:GetOwner().BACrippled == true then
					self:GetOwner():SetSchedule(SCHED_FORCED_GO)
				else
					self:GetOwner():SetSchedule(SCHED_FORCED_GO_RUN)
				end

				self:GetOwner():UpdateEnemyMemory(self:GetOwner():GetEnemy(), self:GetOwner():GetEnemy():GetPos())
			end
		else
			if self:GetOwner():GetPos():DistToSqr(self:GetOwner():GetEnemy():GetPos()) > 250000 then
				self:GetOwner():SetLastPosition(self:GetOwner():GetEnemy():GetPos() + VectorRand() * 200)

				if not self:GetOwner():IsMoving() then
					if self:GetOwner().BACrippled == true then
						self:GetOwner():SetSchedule(SCHED_FORCED_GO)
					else
						self:GetOwner():SetSchedule(SCHED_FORCED_GO_RUN)
					end
				end
			else
				if self:GetOwner():GetCurrentSchedule() == SCHED_FORCED_GO_RUN then
					self:GetOwner():SetLastPosition(self:GetOwner():GetEnemy():GetPos())
					self:GetOwner():ClearSchedule()
				end

				if self:GetOwner().BACrippled == true then
					if self:GetOwner().goalPos == nil or self:GetOwner():GetEnemy():GetPos() ~= self:GetOwner().goalPos then
						self:GetOwner().goalPos = self:GetOwner():GetEnemy():GetPos()
						self:GetOwner():SetLastPosition(self:GetOwner().goalPos)
						self:GetOwner():SetSchedule(SCHED_FORCED_GO)
					end
				else
					self:GetOwner():SetSchedule(SCHED_CHASE_ENEMY)
				end
			end
		end
	end

	local trace = util.TraceLine({
		start = self:GetOwner():GetPos(),
		endpos = self:GetOwner():EyePos() + self:GetOwner():GetAimVector() * 40,
		filter = ents.FindByClass("npc_*")
	})

	if self.CooldownTimer == false then
		if self:GetOwner():GetEnemy():GetPos():DistToSqr(self:GetPos()) <= 3600 and self:GetOwner().IsClimbing == false then
			self:GetOwner():SetSchedule(SCHED_MELEE_ATTACK1)
			self:NPCShoot_Primary()
		elseif trace.Hit and trace.HitWorld == false and not trace.Entity:IsRagdoll() then
			self:GetOwner():SetSchedule(SCHED_MELEE_ATTACK1)
			self:NPCShoot_Primary()
		end
	end
end

function SWEP:NPCShoot_Primary()
	if not self:IsValid() or not self:GetOwner():IsValid() then return end
	if not self:GetOwner():GetEnemy() then return end
	self.CooldownTimer = true
	local seqtimer = 0.4

	timer.Simple(seqtimer, function()
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end
		if not self:IsValid() or not self:GetOwner():IsValid() then return end

		if self:GetOwner():IsCurrentSchedule(SCHED_MELEE_ATTACK1) or self:GetOwner().BreakingDoor then
			self:PrimaryAttack()
		end

		self.CooldownTimer = false
	end)
end