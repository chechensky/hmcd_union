--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_melee_base.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]
if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
elseif CLIENT then
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 80
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	killicon.AddFont("wep_jack_hmcd_axe", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

	function SWEP:Initialize()
	end

	--wat
	function SWEP:DrawViewModel()
		return false
	end

	function SWEP:DrawWorldModel()
		self:DrawModel()
	end

	function SWEP:DrawHUD()
	end
end

--
SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/weapons/j_knife_t.mdl"
SWEP.WorldModel = "models/props/cs_militia/axe.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_axe")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Melee Base"
SWEP.Instructions = "This is a typical woodcutter's axe with a sharp steel head. Murder the innocent like the a true psycopath.\n\nLMB to swing.\nCan also bust down doors and destroy fortifications."
SWEP.Author = "кет"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 900
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HomicideSWEP = true
SWEP.DangerLevel = 65
SWEP.DrawDelay = 0
SWEP.BreakDoorChance = 3

function SWEP:SetupDataTables()
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
	if self:GetOwner():IsSprinting() then return end

	if not IsFirstTimePredicted() and SERVER then
		if not self.ViewAttackAnimDelay then
			self:DoBFSAnimation(self.AttackAnim)
		else
			timer.Simple(self.ViewAttackAnimDelay, function()
				if IsValid(self) and IsValid(self:GetOwner():GetActiveWeapon()) and self:GetOwner():GetActiveWeapon() == self then
					self:DoBFSAnimation(self.AttackAnim)
				end
			end)
		end

		self:GetOwner():GetViewModel():SetPlaybackRate(self.AttackPlayback or 1)

		return
	end

	if self.WooshBeforeHit and self.WooshSound then
		sound.Play(self.WooshSound[1], self:GetOwner():GetPos(), self.WooshSound[2], math.random(self.WooshSound[3][1], self.WooshSound[3][2]))
	end

	if SERVER then
		self:DoBFSAnimation(self.IdleAnim)
	end

	self:SetNextPrimaryFire(CurTime() + self.AttackDelay)
	self:SetNextSecondaryFire(CurTime() + self.AttackDelay)

	if self.PrehitViewPunch then
		if self.PrehitViewPunchDelay then
			timer.Simple(self.PrehitViewPunchDelay, function()
				if IsValid(self) and IsValid(self:GetOwner():GetActiveWeapon()) and self:GetOwner():GetActiveWeapon() == self then
					self:GetOwner():ViewPunch(self.PrehitViewPunch)
				end
			end)
		else
			self:GetOwner():ViewPunch(self.PrehitViewPunch)
		end
	end

	if self.AttackAnimDelay then
		timer.Simple(self.AttackAnimDelay, function()
			if IsValid(self) and IsValid(self:GetOwner():GetActiveWeapon()) and self:GetOwner():GetActiveWeapon() == self then
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			end
		end)
	else
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end

	if SERVER then
		if not self.ViewAttackAnimDelay then
			self:UpdateNextIdle()
			self:DoBFSAnimation(self.AttackAnim)
		else
			timer.Simple(self.ViewAttackAnimDelay, function()
				if IsValid(self) and IsValid(self:GetOwner():GetActiveWeapon()) and self:GetOwner():GetActiveWeapon() == self then
					self:DoBFSAnimation(self.AttackAnim)
					self:GetOwner():GetViewModel():SetPlaybackRate(self.AttackPlayback or 1)
				end
			end)
		end

		self.NextAttackFront = CurTime() + self.AttackFrontDelay
	end

	self:GetOwner():GetViewModel():SetPlaybackRate(self.AttackPlayback or 1)
end

function SWEP:Deploy()
	self.NextAttackFront = nil

	if not IsFirstTimePredicted() then
		self:DoBFSAnimation(self.DrawAnim)

		if self.DrawPlayback then
			self:GetOwner():GetViewModel():SetPlaybackRate(self.DrawPlayback or 1)
		end

		return
	end

	if self.DownAmt then
		self.DownAmt = 20
	end

	if self.Hidden then
		self.Hidden = 2
	end

	self:DoBFSAnimation(self.DrawAnim)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.DrawPlayback or 1)

	if self.CanUpdateIdle then
		self.NextIdle = CurTime() + self:GetOwner():GetViewModel():SequenceDuration() / self:GetOwner():GetViewModel():GetPlaybackRate()
	end

	self:SetNextPrimaryFire(CurTime() + self.DrawDelay)

	if SERVER and self.DrawSound then
		sound.Play(self.DrawSound[1], self:GetPos(), self.DrawSound[2], math.random(self.DrawSound[3][1], self.DrawSound[3][2]))
	end

	return true
end

function SWEP:SecondaryAttack()
	if self.DamageType == DMG_SLASH then
		self:RemoveTape()
	end
end

function SWEP:Think()
	local Time = CurTime()

	if self.NextAttackFront and self.NextAttackFront < Time then
		SuppressHostEvents(NULL)
		self:AttackFront()
		SuppressHostEvents(self:GetOwner())
	end

	if self:GetOwner():KeyDown(IN_ATTACK) and self:GetOwner():KeyDown(IN_RELOAD) and self.NextAttackTypeSwitch and self.NextAttackTypeSwitch < Time then
		self.NextAttackTypeSwitch = Time + 2

		if not self.MaxMinStabDamage then
			if self.AttackType == "Blunt" then
				self.AttackType = "Stab"
				self:SetAttackType(true)
				self.MinDamage = self.MaxMinSlashDamage[1]
				self.MaxDamage = self.MaxMinSlashDamage[2]
				self.DamageType = DMG_SLASH
			else
				self.AttackType = "Blunt"
				self:SetAttackType(false)
				self.MinDamage = self.MaxMinBluntDamage[1]
				self.MaxDamage = self.MaxMinBluntDamage[2]
				self.DamageType = DMG_CLUB
			end
		else
			if self.AttackType == "Slash" then
				self.AttackType = "Stab"
				self:SetAttackType(true)
				self.MinDamage = self.MaxMinStabDamage[1]
				self.MaxDamage = self.MaxMinStabDamage[2]
				self.ReachDistance = self.ReachDistance + 10
				self.HoldType = "knife"

				self.SoftImpactSounds = {
					{
						"snd_jack_hmcd_knifestab.wav", 0, 50, {110, 120}
					}
				}
			else
				self.AttackType = "Slash"
				self:SetAttackType(false)
				self.MinDamage = self.MaxMinSlashDamage[1]
				self.MaxDamage = self.MaxMinSlashDamage[2]
				self.ReachDistance = self.ReachDistance - 10
				self.HoldType = "normal"

				self.SoftImpactSounds = {
					{
						"snd_jack_hmcd_slash.wav", 0, 60, {90, 110}
					}
				}
			end
		end

		self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Attack type switched to " .. string.lower(tostring(self.AttackType)))
	end

	if self.CanUpdateIdle and SERVER then
		if self.NextIdle < Time then
			self:DoBFSAnimation(self.IdleAnim)
			self:UpdateNextIdle()
		end
	end

	if self.FistCanAttack and self.FistCanAttack < Time then
		self.FistCanAttack = nil
		--self:SendWeaponAnim( ACT_VM_IDLE )
		self.IdleTime = Time + 0.1
	end

	if self.FistHit and self.FistHit < Time then
		self.FistHit = nil
		--self:AttackTrace()
	end

	if SERVER then
		if self.UntieTime then
			if self.UntieTime < Time then
				self.UntieTime = nil
				self.UntieEntity.TiedBehind = false
				self.UntieEntity.TiedFront = false

				if self.UntieEntity.handcuffs then
					self.UntieEntity.handcuffs:Remove()

					timer.Simple(.1, function()
						if IsValid(self.UntieEntity) then
							self.UntieEntity.MovedHands = false
						end
					end)
				end

				if self.UntieEntity:IsPlayer() then
					net.Start("hmcd_cuffed")
					net.WriteBool(false)
					net.Send(self.UntieEntity)
					self.UntieEntity:ManipulateBoneAngles(self.UntieEntity:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(0, 0, 0))
					self.UntieEntity:ManipulateBoneAngles(self.UntieEntity:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0, 0, 0))
					self.UntieEntity:ManipulateBoneAngles(self.UntieEntity:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 0))
					self.UntieEntity:ManipulateBoneAngles(self.UntieEntity:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(0, 0, 0))
					self.UntieEntity:ManipulateBoneAngles(self.UntieEntity:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, 0))
					self.UntieEntity:ManipulateBoneAngles(self.UntieEntity:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(0, 0, 0))
				end
			end

			local tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * self.ReachDistance, {self:GetOwner()})

			if not self.UntieEntity or tr.HitPos:DistToSqr(self.UntieEntity:GetBonePosition(self.UntieEntity:LookupBone("ValveBiped.Bip01_R_Hand"))) >= 25 then
				if IsValid(self.UntieEntity) then
					self.UntieEntity:StopSound("tapetear.mp3")
				end

				self.UntieTime = nil
				self.UntieEntity = nil
				self:SetNextPrimaryFire(Time + .5)
				self:SetNextSecondaryFire(Time + .5)
			end
		end

		if self.CutTime then
			if self.CutTime < Time then
				self.CutConstraint:Remove()
				self.CutConstraint = nil
				self.CutEntity = nil
				self.CutEntityPos = nil
				self.CutEntityPhys = nil
				self.CutTime = nil
			end

			local tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * self.ReachDistance, {self:GetOwner()})

			local distEnt = self.CutEntityPhys or self.CutEntity

			if not distEnt or tr.HitPos:DistToSqr(distEnt:LocalToWorld(self.CutEntityPos)) > 100 then
				if IsValid(self.CutEntity) then
					self.CutEntity:StopSound("tapetear.mp3")
				end

				self.CutTime = nil
				self.CutEntity = nil
				self.CutEntityPos = nil
				self.CutEntityPhys = nil
				self.CutConstraint = nil
				self:SetNextPrimaryFire(Time + .5)
				self:SetNextSecondaryFire(Time + .5)
			end
		end

		if self.DoorCutTime then
			if self.DoorCutTime < Time then
				table.remove(self.DoorCutEntity.Tapes, self.DoorTapeNum)

				if #self.DoorCutEntity.Tapes == 0 and not ((self.DoorCutEntity.Nails and #self.DoorCutEntity.Nails > 0) or self.DoorCutEntity.OriginallyLocked) then
					self.DoorCutEntity:Fire("unlock", "", 0)
				end

				self.DoorTapeNum = nil
				self.DoorCutEntity = nil
				self.DoorCutTime = nil
			end

			local tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * self.ReachDistance, {self:GetOwner()})

			if not (self.DoorCutEntity == tr.Entity) then
				if IsValid(self.DoorCutEntity) then
					self.DoorCutEntity:StopSound("tapetear.mp3")
				end

				self.DoorCutTime = nil
				self.DoorCutEntity = nil
				self.DoorTapeNum = nil
				self:SetNextPrimaryFire(Time + .5)
				self:SetNextSecondaryFire(Time + .5)
			end
		end

		local HoldType = self.HoldType

		if self:GetOwner():KeyDown(IN_SPEED) and self.RunHoldType then
			HoldType = self.RunHoldType
		else
			if (self.NextDownTime and self.NextDownTime > Time) and not (self.AttackType == "Stab") then
				HoldType = "melee"
			end
		end

		self:SetHoldType(HoldType)
	end
end

function SWEP:CanBackStab(ent)
	if not ent:IsPlayer() then return false end
	local TrueVec = (self:GetOwner():GetPos() - ent:GetPos()):GetNormalized()
	local LookVec = ent:GetAimVector()
	local DotProduct = LookVec:DotProduct(TrueVec)
	local ApproachAngle = -math.deg(math.asin(DotProduct)) + 90
	local RelSpeed = (ent:GetPhysicsObject():GetVelocity() - self:GetOwner():GetVelocity()):Length()

	if (ApproachAngle <= 120) or (RelSpeed > 100) then
		return false
	else
		return true
	end
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self.NextIdle = CurTime() + vm:SequenceDuration()
end

function SWEP:Holster(wep)
	if SERVER then
		if IsValid(self.UntieEntity) then
			self.UntieEntity:StopSound("tapetear.mp3")
		end

		if IsValid(self.CutEntity) then
			self.CutEntity:StopSound("tapetear.mp3")
		end
	end

	return true
end

function SWEP:OnRemove()
	if SERVER then
		if IsValid(self.UntieEntity) then
			self.UntieEntity:StopSound("tapetear.mp3")
		end

		if IsValid(self.CutEntity) then
			self.CutEntity:StopSound("tapetear.mp3")
		end
	end
end

function SWEP:RemoveTape()
	if CLIENT then return end
	local Ent, HitPos, HitNorm, Hitbox = HMCD_WhomILookinAt(self:GetOwner(), .35, self.ReachDistance)

	if IsValid(Ent) then
		local entity = Ent

		if Ent:LookupBone("ValveBiped.Bip01_R_Hand") then
			local pos = Ent:GetBonePosition(Ent:LookupBone("ValveBiped.Bip01_R_Hand"))

			if (entity.TiedBehind or entity.TiedFront) and pos:DistToSqr(HitPos) < 25 then
				entity:EmitSound("tapetear.mp3", 60, math.random(90, 110))
				self.UntieTime = CurTime() + 3.5
				self.UntieEntity = entity
				self:SetNextPrimaryFire(CurTime() + 3.5)
				self:SetNextSecondaryFire(CurTime() + 3.5)

				return
			end
		end

		for i, info in pairs(constraint.FindConstraints(Ent, "Rope")) do
			if not info.isNail and info.isTape then
				local pos = info.Entity[1].LPos
				local dist = HitPos:DistToSqr(Ent:LocalToWorld(pos))

				if dist > 100000 then
					dist = HitPos:DistToSqr(Ent:LocalToWorld(info.Entity[2].LPos))
					pos = info.Entity[2].LPos
				end

				if dist < 100 then
					Ent:EmitSound("tapetear.mp3", 60, math.random(90, 110))
					self.CutTime = CurTime() + 3.5
					self.CutEntity = Ent
					self.CutEntityPos = pos
					self.CutConstraint = info.Constraint
					self:SetNextSecondaryFire(CurTime() + 3.5)
					self:SetNextPrimaryFire(CurTime() + 3.5)
					break
				end
			end
		end

		for i, info in pairs(constraint.FindConstraints(Ent, "Weld")) do
			if not info.isNail and info.isTape then
				local ent, bone = info.Entity[1].Entity, info.Entity[1].Bone

				if not ent:IsRagdoll() then
					ent = info.Entity[2].Entity
				end

				if bone == 0 then
					bone = info.Entity[2].Bone
				end

				local pos = ent:GetPhysicsObjectNum(bone):GetPos()
				local dist = HitPos:DistToSqr(pos)

				if dist < 100 then
					Ent:EmitSound("tapetear.mp3", 60, math.random(90, 110))
					self.CutTime = CurTime() + 3.5
					self.CutEntity = Ent
					self.CutEntityPhys = ent:GetPhysicsObjectNum(bone)
					self.CutEntityPos = self.CutEntityPhys:WorldToLocal(pos)
					self.CutConstraint = info.Constraint
					self:SetNextSecondaryFire(CurTime() + 3.5)
					self:SetNextPrimaryFire(CurTime() + 3.5)

					return
				end
			end
		end

		if Ent.Tapes then
			for i, pos in pairs(Ent.Tapes) do
				local position = Ent:LocalToWorld(pos)

				if position:DistToSqr(HitPos) < 100 and self:GetOwner():VisibleVec(position) then
					Ent:EmitSound("tapetear.mp3", 60, math.random(90, 110))
					self.DoorCutTime = CurTime() + 3.5
					self.DoorCutEntity = Ent
					self.DoorTapeNum = i
					self:SetNextSecondaryFire(CurTime() + 3.5)
					self:SetNextPrimaryFire(CurTime() + 3.5)
					break
				end
			end
		end
	end
end

local ZombTypes = {
	["npc_zombie"] = true,
	["npc_zombie_torso"] = true,
	["npc_fastzombie"] = true,
	["npc_fastzombie_torso"] = true,
	["npc_poisonzombie"] = true,
	["npc_zombine"] = true
}

local bloodColors = {
	[-1] = "Blood",
	[0] = "Blood",
	[1] = "YellowBlood",
	[2] = "YellowBlood",
	[3] = "ManhackSparks",
	[4] = "YellowBlood",
	[5] = "YellowBlood",
	[6] = "YellowBlood"
}

function SWEP:AttackFront()
	if CLIENT then return end
	if IsValid(self:GetOwner().fakeragdoll) then return end
	self.NextAttackFront = nil

	if self.ViewPunch then
		if self.ViewPunchDelay then
			timer.Simple(self.ViewPunchDelay, function()
				if IsValid(self) and IsValid(self:GetOwner():GetActiveWeapon()) and self:GetOwner():GetActiveWeapon() == self then
					self:GetOwner():ViewPunch(self.ViewPunch)
				end
			end)
		else
			self:GetOwner():ViewPunch(self.ViewPunch)
		end
	end

	self:GetOwner():LagCompensation(true)
	local Ent, HitPos, HitNorm, Hitbox = HMCD_WhomILookinAt(self:GetOwner(), .4, self.ReachDistance)
	local AimVec, Mul = self:GetOwner():GetAimVector(), 1

	if self.WooshSound then
		sound.Play(self.WooshSound[1], self:GetOwner():GetPos(), self.WooshSound[2], math.random(self.WooshSound[3][1], self.WooshSound[3][2]))
	end

	if IsValid(Ent) or (Ent and Ent.IsWorld and Ent:IsWorld()) then
		local owner = Ent

		if Ent:GetClass() == "prop_ragdoll" then
			local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 80, {self:GetOwner()})
			util.Decal("Blood", HitPos + HitNorm, HitPos - HitNorm)
			local edata = EffectData()
			edata:SetStart(self:GetOwner():GetShootPos())
			edata:SetOrigin(HitPos)
			edata:SetNormal(HitNorm)

			edata:SetEntity(Ent)
			util.Effect("BloodImpact", edata, true, true)
			for i, snd in pairs(self.SoftImpactSounds) do
				sound.Play(snd[1], HitPos + Vector(0,0,0))
			end
		end

		if self.BackStabMul and self:CanBackStab(Ent) then
			Mul = self.BackStabMul
		end

		local DamageAmt = math.random(self.MinDamage, self.MaxDamage)
		DamageAmt = DamageAmt * Mul * self:GetOwner():GetViewModel():GetPlaybackRate() / (self.AttackPlayback or 1)
		local Dam = DamageInfo()
		Dam:SetAttacker(self:GetOwner())
		Dam:SetInflictor(self.Weapon)
		Dam:SetDamage(DamageAmt / 2)
		Dam:SetDamageForce(AimVec * Mul / self.DamageForceDiv)
		Dam:SetDamageType(self.DamageType)
		Dam:SetDamagePosition(HitPos)
		local blocking = self.DamageType ~= DMG_SLASH and Ent:IsPlayer() and IsValid(Ent:GetActiveWeapon()) and Ent:GetActiveWeapon().GetBlocking and Ent:GetActiveWeapon():GetBlocking()

		if blocking then
			local pos, ang = Ent:GetBonePosition(Ent:LookupBone("ValveBiped.Bip01_R_Hand"))
			ang:RotateAroundAxis(ang:Right(), 90)
			blocking = util.IntersectRayWithOBB(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * self.ReachDistance, pos + ang:Right() * 5, ang, Vector(-10, -10, -7), Vector(10, 10, 7)) ~= nil

			if blocking then
				local pos_l = Ent:GetBonePosition(Ent:LookupBone("ValveBiped.Bip01_L_Hand"))
				local pos_r = Ent:GetBonePosition(Ent:LookupBone("ValveBiped.Bip01_L_Hand"))
				local startpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 3

				if startpos:DistToSqr(pos_l) > startpos:DistToSqr(pos_r) then
					Hitbox = HITGROUP_RIGHTARM
				else
					Hitbox = HITGROUP_LEFTARM
				end
			end
		end

		if owner:IsPlayer() or owner:IsRagdoll() or owner:IsNPC() then
			GAMEMODE:ScalePlayerDamage(owner, Hitbox, Dam)
		end

		Dam:SetDamage(math.Clamp(Dam:GetDamage(), 0, DamageAmt))

		if owner:IsNPC() then
			Dam:ScaleDamage(4)
		end

		local SelfForce = self.Force

		if self:IsEntSoft(Ent) then
			if self.Poisoned and owner:IsPlayer() then
				HMCD_Poison(owner, self:GetOwner(), "Curare")
				self.Poisoned = false
			end

			SelfForce = SelfForce / 5

			if Dam:GetDamage() > 1 and not blocking then
				if self.SoftImpactSounds then
					for i, snd in pairs(self.SoftImpactSounds) do
						sound.Play(snd[1], HitPos + vector_up * snd[2], snd[3], math.random(snd[4][1], snd[4][2]))
					end
				elseif self.PlayHitSound then
					self:PlayHitSound()
				end
			else
				if blocking then
					if self.SoftImpactSounds then
						for i, snd in pairs(self.SoftImpactSounds) do
							sound.Play(snd[1], HitPos + vector_up * snd[2], snd[3], math.random(snd[4][1], snd[4][2]))
						end
					elseif self.PlayHitSound then
						self:PlayHitSound()
					end

					Mul = Mul * 0.2
				elseif self.HardImpactSounds then
					for i, snd in pairs(self.HardImpactSounds) do
						sound.Play(snd[1], HitPos + vector_up * snd[2], snd[3], math.random(snd[4][1], snd[4][2]))
					end
				elseif self.PlayHitObjectSound then
					self:PlayHitObjectSound()
				end
			end

			if Dam:GetDamageType() == DMG_SLASH and Dam:GetDamage() > 1 then
				util.Decal("Blood", HitPos + HitNorm, HitPos - HitNorm)
				local edata = EffectData()
				edata:SetStart(self:GetOwner():GetShootPos())
				edata:SetOrigin(HitPos)
				edata:SetNormal(HitNorm)
				local bloodColor = Ent:GetInternalVariable("m_bloodColor") or 0

				if not ZombTypes[Ent:GetClass()] then
					edata:SetColor(bloodColor)
				else
					bloodColor = 0
				end

				edata:SetEntity(Ent)
				util.Effect("BloodImpact", edata, true, true)

				timer.Simple(.05, function()
					if IsValid(self) then
						for i = 1, self.BloodDecals do
							local BloodTr = util.QuickTrace(HitPos - AimVec * 10, AimVec * 100 + VectorRand() * 25, {self, self:GetOwner()})

							if BloodTr.Hit then
								util.Decal(bloodColors[bloodColor], BloodTr.HitPos + BloodTr.HitNormal, BloodTr.HitPos - BloodTr.HitNormal)
							end
						end
					end
				end)

				if self.Infected and Ent.BloodLevel then
					local mul = 2

					if mul > 0 then
						if owner.AddBacteria then
							local bacteriaAdd = 45 * mul

							if self:GetOwner():GetNWString("Class") == "fast" then
								bacteriaAdd = 25 * mul
							end

							owner:AddBacteria(bacteriaAdd, CurTime())
						else
							owner.Infected = true
						end
					end
				end

				if ZombTypes[Ent:GetClass()] then
					self.Infected = true
				end
			end
		else
			if self.HardImpactSounds then
				for i, snd in pairs(self.HardImpactSounds) do
					sound.Play(snd[1], HitPos + vector_up * snd[2], snd[3], math.random(snd[4][1], snd[4][2]))
				end
			elseif self.PlayHitObjectSound then
				self:PlayHitObjectSound()
			end
		end

		if self.UniversalSound then
			sound.Play(self.UniversalSound[1], HitPos + vector_up * self.UniversalSound[2], self.UniversalSound[3], math.random(self.UniversalSound[4][1], self.UniversalSound[4][2]))
		end

		Ent:TakeDamageInfo(Dam)
		local Phys = Ent:GetPhysicsObject()

		if IsValid(Phys) then
			if Ent:IsPlayer() then
				Ent:SetVelocity(-Ent:GetVelocity() / 5)
			end

			Phys:ApplyForceOffset(AimVec * self.ForceOffset * Mul, HitPos)
			self:GetOwner():SetVelocity(-AimVec * SelfForce / 50)
		end

		if (Ent:GetClass() == "func_breakable_surf") and self.DamageType == DMG_CLUB then
			Ent:Fire("break", "", 0)
		end

		if self.CanBreakDoors then
			if IsValid(Ent) and HMCD_IsDoor(Ent) and not (Ent:GetNoDraw() or Ent.Unbreakable) then
				if math.random(1, self.BreakDoorChance) == 1 then
					HMCD_BlastThatDoor(Ent, (Ent:GetPos() - self:GetPos()):GetNormalized() * 100)
				end
			elseif Ent:GetClass() == "func_breakable" then
				if math.random(1, self.BreakDoorChance) == 1 then
					Ent:Fire("break", "", 0)
				end
			end

			if math.random(1, self.BreakDoorChance) == 2 then
				local Constraints = constraint.FindConstraints(Ent, "Rope")

				if Constraints then
					local Const = table.Random(Constraints)

					if Const and Const.Constraint then
						Const.Constraint:Remove()
						sound.Play("Wood_Furniture.Break", Ent:GetPos(), 60, 100)
					end
				end
			end
		end
	else
		if self.PlayMissSound then
			self:PlayMissSound()
		end
	end

	self:GetOwner():LagCompensation(false)

	if self:GetClass() == "wep_jack_hmcd_ram" then
		timer.Simple(.443, function()
			self:DoBFSAnimation("idle")
		end)
	end
end

function SWEP:Reload()
end

--
function SWEP:Holster(wep)
	if self.Armed then
		return false
	else
		return true
	end
end

function SWEP:DoBFSAnimation(anim)
	if self:GetOwner() and self:GetOwner().GetViewModel then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
		self.NextIdle = CurTime() + vm:SequenceDuration() * vm:GetPlaybackRate()
	end
end

function SWEP:IsEntSoft(ent)
	return ent:IsNPC() or ent:IsPlayer() or ent.fleshy
end

function SWEP:OnDrop()
	if self.CommandDroppable then
		local Ent = ents.Create(self.ENT)
		Ent.HmcdSpawned = self.HmcdSpawned
		Ent:SetPos(self:GetPos())
		Ent:SetAngles(self:GetAngles())
		Ent.Poisoned = self.Poisoned

		if self:GetClass() == "wep_jack_hmcd_firextinguisher" then
			Ent.SprayAmount = self:GetAmount()
		end

		Ent.Infected = self.Infected
		Ent:Spawn()
		Ent:Activate()
		Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
		self:Remove()
	end
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .4, 0, 20)
		else
			DownAmt = math.Clamp(DownAmt - .4, 0, 20)
		end

		ang:RotateAroundAxis(ang:Forward(), 10)

		return pos + ang:Up() * 0 - ang:Forward() * (DownAmt - 10) - ang:Up() * DownAmt + ang:Right() * 3, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() - Ang:Up() * 7)
				Ang:RotateAroundAxis(Ang:Forward(), 90)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/props/cs_militia/axe.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			self.DatWorldModel:SetModelScale(1, 0)
		end
	end
end