--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_hands.lua
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
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
else
	SWEP.PrintName = "Hands"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 75
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_hands")
	SWEP.BounceWeaponIcon = false
	local HandTex, ClosedTex = surface.GetTextureID("vgui/hud/hmcd_hand"), surface.GetTextureID("vgui/hud/hmcd_closedhand")

	function SWEP:DrawHUD()
		local owner = self:GetOwner()
		local Fake = owner:GetNWEntity("Ragdoll")
		if self:GetFists() then return end
		local Tr = util.QuickTrace(owner:GetShootPos(), owner:GetAimVector() * self.ReachDistance, {owner})

		if Tr.Hit then
			if self:CanPickup(Tr.Entity) then
				local Size = math.Clamp(1 - ((Tr.HitPos - owner:GetShootPos()):Length() / self.ReachDistance) ^ 2, .2, 1)

				if owner:KeyDown(IN_ATTACK2) then
					surface.SetTexture(ClosedTex)
				else
					surface.SetTexture(HandTex)
				end

				surface.SetDrawColor(Color(255, 255, 255, 255 * Size))
				surface.DrawTexturedRect(ScrW() / 2 - (64 * Size), ScrH() / 2 - (64 * Size), 128 * Size, 128 * Size)
			end
		end
	end
end

SWEP.Category = "HMCD: Union - Other"
SWEP.SwayScale = 3
SWEP.BobScale = 3
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "спиздили с кэтс хомисайда" -- Ниче не было
SWEP.DrawWeaponInfoBox = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType = "normal"
SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/props_junk/cardboard_box004a.mdl"
SWEP.AttackSlowDown = .5
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.ReachDistance = 60
SWEP.HomicideSWEP = true
SWEP.NextPulseCheck = 0
SWEP.NextPump = 0
SWEP.DangerLevel = 0
SWEP.NotLoot = true
SWEP.UseHands = true

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextIdle")
	self:NetworkVar("Bool", 2, "Fists")
	self:NetworkVar("Float", 1, "NextDown")
	self:NetworkVar("Bool", 3, "Blocking")
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self:GetOwner().in_handcuff then return end

	vm:SetMaterial("engine/occlusionproxy")
end

function SWEP:Initialize()
	self:SetNextIdle(CurTime() + 5)
	self:SetNextDown(CurTime() + 5)
	self:SetHoldType(self.HoldType)
	self:SetFists(false)
	self:SetBlocking(false)
	self.staminashand = false
end

function SWEP:Deploy()
	if self:GetOwner().in_handcuff then return false end
	if not IsFirstTimePredicted() then
		self:DoBFSAnimation("fists_draw")
		self:GetOwner():GetViewModel():SetPlaybackRate(.1)

		return
	end

	self:SetNextPrimaryFire(CurTime() + .1)
	self:SetFists(false)
	self.DangerLevel = 0
	self:SetNextDown(CurTime())
	self:DoBFSAnimation("fists_draw")

	return true
end

function SWEP:Holster()
	self:OnRemove()

	return true
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner().in_handcuff then return false end
	return true
end

local pickupWhiteList = {
	["prop_ragdoll"] = true,
	["prop_physics"] = true,
	["prop_physics_multiplayer"] = true,
	["func_physbox"] = true
}

function SWEP:CanPickup(ent)
	if self:GetOwner().Lost then return false end
	if string.find(ent:GetModel(), "zombie") ~= nil then return false end
	if ent:IsNPC() then return false end
	if self:GetOwner():GetGroundEntity() == ent then return false end
	if ent.IsLoot then return true end
	local class = ent:GetClass()
	if pickupWhiteList[class] then return true end

	return false
end

function SWEP:SecondaryAttack()
	if self:GetOwner().in_handcuff then return end
	if not IsFirstTimePredicted() then return end
	if self:GetFists() then return end

	if SERVER then
		self:SetCarrying()
		local tr = self:GetOwner():GetEyeTraceNoCursor()

		if IsValid(tr.Entity) and self:CanPickup(tr.Entity) and not tr.Entity:IsPlayer() then
			local Dist = (self:GetOwner():GetShootPos() - tr.HitPos):Length()

			if Dist < self.ReachDistance then

				sound.Play("Flesh.ImpactSoft", self:GetOwner():GetShootPos(), 65, math.random(90, 110))
				self:SetCarrying(tr.Entity, tr.PhysicsBone, tr.HitPos, Dist)
				tr.Entity.Touched = true
				self:ApplyForce()
			end
		elseif IsValid(tr.Entity) and tr.Entity:IsPlayer() then
			local Dist = (self:GetOwner():GetShootPos() - tr.HitPos):Length()

			if Dist < self.ReachDistance then
				sound.Play("Flesh.ImpactSoft", self:GetOwner():GetShootPos(), 65, math.random(90, 110))
				self:GetOwner():SetVelocity(self:GetOwner():GetAimVector() * 20)
				tr.Entity:SetVelocity(-self:GetOwner():GetAimVector() * 50)
				self:SetNextSecondaryFire(CurTime() + .25)
			end
		end
	end
end

function SWEP:ApplyForce()
	local target = self:GetOwner():GetAimVector() * self.CarryDist + self:GetOwner():GetShootPos()
	local phys = self.CarryEnt:GetPhysicsObjectNum(self.CarryBone)

	if IsValid(phys) then
		local TargetPos = phys:GetPos()

		if self.CarryPos then
			TargetPos = self.CarryEnt:LocalToWorld(self.CarryPos)
		end

		local vec = target - TargetPos
		local len, mul = vec:Length(), self.CarryEnt:GetPhysicsObject():GetMass()

		if (len > self.ReachDistance) or (mul > 170) then
			self:SetCarrying()

			return
		end

		if self.CarryEnt:GetClass() == "prop_ragdoll" then
			mul = mul

			if self.LightBone then
				mul = mul / 6
			end
		end

		vec:Normalize()
		local avec, velo = vec * len, phys:GetVelocity() - self:GetOwner():GetVelocity()
		local CounterDir, CounterAmt = velo:GetNormalized(), velo:Length()

		if self.CarryPos then
			phys:ApplyForceOffset((avec - velo / 2) * mul, self.CarryEnt:LocalToWorld(self.CarryPos))
		else
			phys:ApplyForceCenter((avec - velo / 2) * mul)
		end

		phys:ApplyForceCenter(Vector(0, 0, mul))
		phys:AddAngleVelocity(-phys:GetAngleVelocity() / 10)
	end
end

function SWEP:OnRemove()
	if IsValid(self:GetOwner()) and CLIENT and self:GetOwner():IsPlayer() then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			vm:SetMaterial("")
		end
	end
end

local handBones = {
	["swat_male"] = {11, 13},
	["military"] = {11, 13},
	["monolithservers/mpd"] = {11, 13},
	["gordon_freeman"] = {10, 7}
}

function SWEP:SetCarrying(ent, bone, pos, dist)
	if IsValid(ent) then
		self.CarryEnt = ent
		self.CarryEnt.Carrier = self:GetOwner()
		self.CarryBone = bone
		self.CarryDist = dist

		local hands = {5, 7}

		local mod = self.CarryEnt:GetModel()

		for i, info in pairs(handBones) do
			if string.find(mod, i) then
				hands = info
				break
			end
		end

		self.LightBone = ent:GetPhysicsObjectNum(bone):GetMass() < 3
		self.HandBones = hands

		if not (ent:GetClass() == "prop_ragdoll") then
			self.CarryPos = ent:WorldToLocal(pos)
		else
			self.CarryPos = nil
		end

		ent.LastCarrier = self:GetOwner()
	else
		if IsValid(self.CarryEnt) then
			self.CarryEnt.Carrier = nil
		end

		self.CarryEnt = nil
		self.CarryBone = nil
		self.CarryPos = nil
		self.CarryDist = nil
	end
end
function SWEP:CheckStatus(ply)
	if CLIENT then return end
	if self.NextPulseCheck >= CurTime() then return end
	local owner = RagdollOwner(ply)
	self.NextPulseCheck = CurTime() + 1
	self:GetOwner():PrintMessage(HUD_PRINTTALK, "Body is " .. self.CarryEnt.temp)
	self:GetOwner():PrintMessage(HUD_PRINTTALK, "Eyes is " .. (self.CarryEnt.eye == true and "open") or "close")
	if self.CarryEnt.temp == "Cold" then
		self.CarryEnt.canaccept_dead = true
	end
end

function SWEP:CheckPulse(ply)
	if CLIENT then return end
	if self.NextPulseCheck >= CurTime() then return end
	local owner = RagdollOwner(ply)
	local name = self.CarryEnt:GetNWString("Character_Name") or ""
	self.NextPulseCheck = CurTime() + 1

	if not IsValid(owner) then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, "" .. name .. " has no pulse.")
		self.CarryEnt.canaccept_dead = true

		return
	end

	if not owner:Alive() then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, "" .. name .. " has no pulse.")
		self.CarryEnt.canaccept_dead = true
		return
	end
	if owner.heartstop then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, "" .. name .. " has no pulse.")
		self.CarryEnt.canaccept_dead = true

		return
	end

	local pulse
	pulse = owner.pulse
	if pulse >= 60 and pulse <= 90 then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, "" .. name .. " has a normal pulse.")

		return
	elseif pulse < 60 then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, "" .. name .. " has a low pulse.")

		return
	elseif pulse > 90 and pulse < 120 then
		self:GetOwner():PrintMessage(HUD_PRINTTALK, "" .. name .. " has a strong pulse.")

		return
	else
		self:GetOwner():PrintMessage(HUD_PRINTTALK, "" .. name .. " has a very strong pulse.")

		return
	end
end

function SWEP:Think()
	if self:GetOwner().in_handcuff then return end
	if IsValid(self:GetOwner()) and self:GetOwner():KeyDown(IN_ATTACK2) and not self:GetFists() then
		if IsValid(self.CarryEnt) and not (IsValid(self:GetOwner():GetGroundEntity()) and self:GetOwner():GetGroundEntity() == self.CarryEnt) then
			self:ApplyForce()
		end
	elseif self.CarryEnt then
		self:SetCarrying()
	end

	if self:GetFists() and self:GetOwner():KeyDown(IN_ATTACK2) then
		self:SetNextPrimaryFire(CurTime() + .1)
		self:SetBlocking(true)
	else
		self:SetBlocking(false)
	end

	local HoldType = "fist"

	if self:GetFists() then
		HoldType = "fist"
		local Time = CurTime()

		if self:GetNextIdle() < Time then
			self:DoBFSAnimation("fists_idle_0" .. math.random(1, 2))
			self:UpdateNextIdle()
		end

		if self:GetBlocking() then
			self:SetNextDown(Time + 1)
			HoldType = "camera"
		end

		if (self:GetNextDown() < Time) or self:GetOwner():KeyDown(IN_SPEED) then
			self:SetNextDown(Time + 1)
			self:SetFists(false)
			self.DangerLevel = 0
			self:SetBlocking(false)
		end
	else
		HoldType = "normal"
		self:DoBFSAnimation("fists_draw")
	end

	if IsValid(self.CarryEnt) or self.CarryEnt then
		HoldType = "magic"
	end

	if self:GetOwner():KeyDown(IN_SPEED) then
		HoldType = "normal"
	end
	if SERVER then
		if self.CarryEnt != nil then
			local bone = self.CarryEnt:TranslatePhysBoneToBone(self.CarryBone)
			local Lhand = self.CarryEnt:LookupBone("ValveBiped.Bip01_L_Hand")
			local Rhand = self.CarryEnt:LookupBone("ValveBiped.Bip01_R_Hand")

			local Lprhand = self.CarryEnt:LookupBone("ValveBiped.Bip01_L_Forearm")
			local Rprhand = self.CarryEnt:LookupBone("ValveBiped.Bip01_R_Forearm")
			if self:GetOwner():KeyDown(IN_RELOAD) and (bone == Lhand or bone == Rhand or bone == Lprhand or bone == Rprhand) then
				self:CheckPulse(self.CarryEnt)
			end
			if fs and self:GetOwner():KeyDown(IN_RELOAD) then
				self:CheckStatus(self.CarryEnt)
			end
		end
		self:SetHoldType(HoldType)
	end
end

function SWEP:PrimaryAttack()
	if self:GetOwner().in_handcuff then return end
	local vehicle = self:GetOwner():GetVehicle()
	if IsValid(vehicle) and IsValid(vehicle:GetParent()) and vehicle:GetParent().Base == "lunasflightschool_basescript_heli" then return end

	if self:GetOwner():KeyDown(IN_ATTACK2) then
		if IsValid(self.CarryEnt) then
			local owner = RagdollOwner(self.CarryEnt)

			if IsValid(self.CarryEnt) and IsValid(owner) and owner.DrownTime then
				local Tr = util.QuickTrace(self.CarryEnt:GetPos(), vector_up * -10, {self.CarryEnt, self:GetOwner()})

				if not self.CarryEnt.NextPump then
					self.CarryEnt.NextPump = 0
				end

				if Tr.Hit and self.CarryEnt.NextPump < CurTime() then
					local phys = self.CarryEnt:GetPhysicsObjectNum(self.CarryBone)

					if not self.CarryEnt.Pumps then
						self.CarryEnt.Pumps = 0
						self.CarryEnt.PumpsRequired = math.random(20, 30)
					end

					self.CarryEnt.Pumps = self.CarryEnt.Pumps + 1
					phys:ApplyForceCenter(Vector(0, 0, -5000))

					if self.CarryEnt.Pumps >= self.CarryEnt.PumpsRequired and not ((owner.DigestedContents["RightLung_BloodLevel"] or 0) + (owner.DigestedContents["LeftLung_BloodLevel"] or 0) == 90) then
						owner.DrownTime = nil
						owner.HeartAttack = nil
						owner.NextAgonalMoan = nil

						if owner:CanWakeUp() then
							owner:SetUnconscious(false)
						end

						self.CarryEnt.Pumps = nil
						self.CarryEnt.PumpsRequired = nil
					end

					self.CarryEnt.NextPump = CurTime() + 0.5
				end
			end
		end

		return
	end
	local sideright = math.random(1, 1.2)
	local side = "fists_left"

	if sideright == 1 then
		side = "fists_right"
	end

	self:SetNextDown(CurTime() + 7)

	if not self:GetFists() then
		self:SetFists(true)
		self.DangerLevel = 40
		self:DoBFSAnimation("fists_draw")
		self:SetNextPrimaryFire(CurTime() + .35)

		return
	end
	if self:GetOwner():GetNWFloat("Stamina_Arm", 50) < 5 and self.staminashand == false then self.staminashand = true self:GetOwner():ChatPrint("Arm stamina is small.") end
	if self:GetOwner():GetNWFloat("Stamina_Arm", 50) < 5 then return end
	if self:GetBlocking() then return end

	if not IsFirstTimePredicted() then
		self:DoBFSAnimation(side)
		self:GetOwner():GetViewModel():SetPlaybackRate(1.25)

		return
	end

	self:GetOwner():ViewPunch(Angle(0, 0, math.random(-0.2, 0.5)))
	self:DoBFSAnimation(side)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	local ply = self:GetOwner()
	local finalspeed
	finalspeed = ply:GetNWFloat("Stamina_Arm", 50) / 50
	if ply:GetNWFloat("RightArm", 1) < 0.5 then finalspeed = finalspeed - 0.5 end
	if ply:GetNWFloat("LeftArm", 1) < 0.5 then finalspeed = finalspeed - 0.5 end
	print(finalspeed)
	self:GetOwner():GetViewModel():SetPlaybackRate(0.25 + finalspeed)
	self:UpdateNextIdle()
	sound.Play("weapons/slam/throw.wav", self:GetPos(), 65, math.random(90, 110))
	if SERVER then
		self:GetOwner():ViewPunch(Angle(0, 0, math.random(-2, 2)))

		timer.Simple(.075, function()
			if IsValid(self) then
				self:AttackFront()
			end
		end)
	end
	if ply:GetNWFloat("RightArm", 1) < 0.5 and ply:GetNWFloat("LeftArm", 1) < 0.5 then
		self:SetNextPrimaryFire(CurTime() + 2)
	elseif ply:GetNWFloat("RightArm", 1) < 0.5 or ply:GetNWFloat("LeftArm", 1) < 0.5 then
		self:SetNextPrimaryFire(CurTime() + 1)
	else
		self:SetNextPrimaryFire(CurTime()+.35+(ply:GetNWFloat("Stamina_Arm", 50)/500))
	end
	self:SetNextSecondaryFire(CurTime() + .35)
end

function SWEP:AttackFront()
	if self:GetOwner().in_handcuff then return end
	if self:GetOwner():GetNWFloat("Stamina_Arm", 50) < 5 then self:GetOwner():GetNWFloat("Stamina_Arm", 0) return end
	self.staminashand = true
	local ms = math.random(0.8, 2)
	self:GetOwner():SetNWFloat("Stamina_Arm", self:GetOwner():GetNWFloat("Stamina_Arm", 0) - ms)
	if CLIENT then return end
	self:GetOwner():LagCompensation(true)
	local Ent, HitPos, HitNorm, Hitbox = HMCD_WhomILookinAt(self:GetOwner(), .3, 55)
	local AimVec = self:GetOwner():GetAimVector()

	if IsValid(Ent) or (Ent and Ent.IsWorld and Ent:IsWorld()) then
		local owner = Ent

		if Ent:GetClass() == "prop_ragdoll" then
			local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * self.ReachDistance, {self:GetOwner()})

		end

		local SelfForce, Mul = 125, 1

		if self:IsEntSoft(Ent) then
			SelfForce = 25

			if Ent:IsPlayer() and IsValid(Ent:GetActiveWeapon()) and Ent:GetActiveWeapon().GetBlocking and Ent:GetActiveWeapon():GetBlocking() then
				local pos, ang = Ent:GetBonePosition(Ent:LookupBone("ValveBiped.Bip01_R_Hand"))
				ang:RotateAroundAxis(ang:Right(), 90)

				if util.IntersectRayWithOBB(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * self.ReachDistance, pos + ang:Right() * 5, ang, Vector(-10, -10, -7), Vector(10, 10, 7)) ~= nil then
					sound.Play("Flesh.ImpactSoft", HitPos, 65, math.random(90, 110))
					Mul = Mul * 0.2
					local pos_l = Ent:GetBonePosition(Ent:LookupBone("ValveBiped.Bip01_L_Hand"))
					local startpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 3
				else
					sound.Play("Flesh.ImpactHard", HitPos, 65, math.random(90, 110))
				end
			else
				sound.Play("Flesh.ImpactHard", HitPos, 65, math.random(90, 110))
			end
		else
			sound.Play("Flesh.ImpactSoft", HitPos, 65, math.random(90, 110))
		end

		local DamageAmt = math.random(2, 4)
		local Dam = DamageInfo()
		Dam:SetAttacker(self:GetOwner())
		Dam:SetInflictor(self.Weapon)
		Dam:SetDamage(DamageAmt * Mul)
		Dam:SetDamageForce(AimVec * Mul ^ 1.2 / 2)
		Dam:SetDamageType(DMG_CLUB)
		Dam:SetDamagePosition(HitPos)

		if owner:IsPlayer() or owner:IsRagdoll() or owner:IsNPC() then
		end

		Dam:SetDamage(math.Clamp(Dam:GetDamage(), 0, DamageAmt))
		Ent:TakeDamageInfo(Dam)
		local Phys = Ent:GetPhysicsObject()

		if IsValid(Phys) then
			if Ent:IsPlayer() then
				Ent:SetVelocity(AimVec * SelfForce * 1.5)
			end

			Phys:ApplyForceOffset(AimVec * 5000 * Mul, HitPos)
			self:GetOwner():SetVelocity(AimVec * SelfForce * .8)
		end	

		if SERVER then	
			if Ent.HP == nil then
				Ent.HP = 100
			end
			if Ent:GetClass() == "func_breakable_surf" then
				Ent.HP = Ent.HP - Dam:GetDamage() * 4
				print(Ent.HP)
				if Ent.HP <= 0 then
					Ent:Fire("break", "", 0)
					if SERVER then
						if Ent:GetMaterialType() == MAT_GLASS then
							self:GetOwner().Bleed = self:GetOwner().Bleed + 40
						else
							self:GetOwner().Bleed = self:GetOwner().Bleed + 15
						end
					end
				end
			end
		end
	end

	self:GetOwner():LagCompensation(false)
end

function SWEP:Reload()
	if not IsFirstTimePredicted() then return end
	self:SetFists(false)
	self.DangerLevel = 0
	self:SetBlocking(false)
end

function SWEP:DrawWorldModel()
end

-- no, do nothing
function SWEP:DoBFSAnimation(anim)
	local vm = self:GetOwner():GetViewModel()

	if IsValid(vm) then
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	end
end

function SWEP:UpdateNextIdle()
	if self:GetOwner().in_handcuff then return end
	local vm = self:GetOwner():GetViewModel()

	if IsValid(self) and IsValid(vm) then
		self:SetNextIdle(CurTime() + vm:SequenceDuration())
	end
end

function SWEP:IsEntSoft(ent)
	return ent:IsNPC() or ent:IsPlayer() or (ent:IsRagdoll() and ent.fleshy)
end

if CLIENT then
	local BlockAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetBlocking() then
			BlockAmt = math.Clamp(BlockAmt + FrameTime() * 1.5, 0, 1)
		else
			BlockAmt = math.Clamp(BlockAmt - FrameTime() * 1.5, 0, 1)
		end

		pos = pos - ang:Up() * 15 * BlockAmt
		ang:RotateAroundAxis(ang:Right(), BlockAmt * 60)

		return pos, ang
	end
end