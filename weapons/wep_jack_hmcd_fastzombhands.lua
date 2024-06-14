if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
else
	SWEP.PrintName = "Fast Zombie Hands"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 80
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_zombhands")
	SWEP.BounceWeaponIcon = false
end

SWEP.SwayScale = 3
SWEP.BobScale = 3
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "These are your zombified hands. They're no energy sword, but they still pack a wallop.\n\nLMB to clobber.\nRMB while in mid-air and facing a wall to cling to it."
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.HoldType = "normal"
SWEP.ViewModel = Model("models/zombie/v_fza.mdl")
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.AttackSlowDown = .1
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
SWEP.NextAnim = 0
SWEP.NextClimbSound = 0
SWEP.Category="HMCD: Union - WTF"
SWEP.Rate = 1
SWEP.Base = "wep_jack_hmcd_melee_base"
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 4500
SWEP.DangerLevel = 100

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextIdle")
end

function SWEP:PreDrawViewModel(vm, wep, ply)
end

--vm:SetMaterial("engine/occlusionproxy") -- Hide that view model with hacky material
function SWEP:Initialize()
	self:SetNextIdle(CurTime() + 5)
	self:SetHoldType(self.HoldType)
	self:SetClimbing(false)
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + .1)

	return true
end

function SWEP:Holster()
	self:OnRemove()

	return true
end

function SWEP:CanPrimaryAttack()
	return true
end

function SWEP:PlayHitSound()
	self:GetOwner():EmitSound("npc/fast_zombie/claw_strike" .. math.random(1, 3) .. ".wav")
end

function SWEP:PlayHitObjectSound()
	self:GetOwner():EmitSound("npc/fast_zombie/claw_strike" .. math.random(1, 3) .. ".wav")
end

function SWEP:PlayMissSound()
	self:GetOwner():EmitSound("npc/fast_zombie/claw_miss" .. math.random(1, 2) .. ".wav")
end

function SWEP:PlayAttackSound()
	self:GetOwner():EmitSound("npc/zombie/zo_attack" .. math.random(2) .. ".wav")
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_voice_idle" .. math.random(14) .. ".wav")
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_alert" .. math.random(3) .. ".wav")
end

function SWEP:SecondaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.25)
	self:SetNextSecondaryFire(CurTime() + 0.5)

	if self:GetClimbSurface() and not self:NearGround() then
		self:StartClimbing()
	end
end

function SWEP:StartClimbing()
	if self:GetClimbing() then return end
	self:SetClimbing(true)
	self:SetNextSecondaryFire(CurTime() + 0.5)
end

function SWEP:StopClimbing()
	if not self:GetClimbing() then return end
	self:SetClimbing(false)
	self:SetNextSecondaryFire(CurTime())
end

function SWEP:SetClimbing(climbing)
	self:SetDTBool(1, climbing)
end

function SWEP:GetClimbing()
	return self:GetDTBool(1)
end

SWEP.IsClimbing = SWEP.GetClimbing

function SWEP:OnRemove()
	if IsValid(self:GetOwner()) and CLIENT and self:GetOwner():IsPlayer() then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			vm:SetMaterial("")
		end
	end
end

local meta = FindMetaTable("Player")

local climbtrace = {
	mask = MASK_SOLID_BRUSHONLY,
	mins = Vector(-5, -5, -5),
	maxs = Vector(5, 5, 5)
}

function SWEP:GetClimbSurface()
	local owner = self:GetOwner()
	local fwd = owner:SyncAngles():Forward()
	local up = owner:GetUp()
	local pos = owner:GetPos()
	local height = owner:OBBMaxs().z
	local tr
	local ha

	for i = 5, height, 5 do
		if not tr or not tr.Hit then
			climbtrace.start = pos + up * i
			climbtrace.endpos = climbtrace.start + fwd * 36
			tr = util.TraceHull(climbtrace)
			ha = i
			if tr.Hit and not tr.HitSky then break end
		end
	end

	if tr.Hit and not tr.HitSky then
		climbtrace.start = pos + up * ha --tr.HitPos + tr.HitNormal
		climbtrace.endpos = climbtrace.start + owner:SyncAngles():Up() * (height - ha)
		local tr2 = util.TraceHull(climbtrace)
		if tr2.Hit and not tr2.HitSky then return tr2 end

		return tr
	end
end

function SWEP:NearGround()
	return util.QuickTrace(self:GetPos() + vector_up * -20, -vector_up * -20, {self}).Hit
end

function meta:SyncAngles()
	local ang = self:EyeAngles()
	ang.pitch = 0
	ang.roll = 0

	return ang
end

meta.GetAngles = meta.SyncAngles

function SWEP:PlayClimbSound()
	self:EmitSound("player/footsteps/metalgrate" .. math.random(4) .. ".wav")
end

function SWEP:Think()
	local HoldType = "fist"
	local Time = CurTime()
	local owner = self:GetOwner()
	local seq = owner:SelectWeightedSequence(ACT_ZOMBIE_CLIMB_UP)
	local rate = 0
	local vel = self:GetOwner():GetVelocity()
	local speed = vel:LengthSqr()

	if self:GetNextIdle() < Time then
		self:SendWeaponAnim(ACT_VM_IDLE)
		self:UpdateNextIdle()
	end

	if SERVER then
		self:SetHoldType(HoldType)
	end

	if self:GetClimbing() then
		--self:GetOwner():DoAnimationEvent(ACT_ZOMBIE_CLIMB_UP)
		if self:GetClimbSurface() and owner:KeyDown(IN_ATTACK2) then
			if CurTime() >= self.NextClimbSound and IsFirstTimePredicted() then
				local speed = owner:GetVelocity():LengthSqr()

				if speed >= 2500 then
					if speed >= 12000 then
						self.NextClimbSound = CurTime() + 0.25
					else
						self.NextClimbSound = CurTime() + 0.8
					end

					self:PlayClimbSound()
				end
			end

			if CurTime() >= self.NextAnim then
				self.NextAnim = CurTime() + self:GetOwner():SequenceDuration(seq)
			end
		else
			self:StopClimbing()
		end
	end

	self:Move(self:GetOwner())
end

function SWEP:PrimaryAttack()
	local side = ACT_VM_HITCENTER

	if math.random(1, 2) == 1 then
		side = ACT_VM_SECONDARYATTACK
	end

	if not IsFirstTimePredicted() then
		self:SendWeaponAnim(side)

		return
	end

	local DamMul = 1

	if self:GetOwner():KeyDown(IN_SPEED) then
		DamMul = .25
	end

	self:GetOwner():ViewPunch(Angle(0, 0, math.random(-2, 2)))
	self:SendWeaponAnim(side)
	self:UpdateNextIdle()
	self:GetOwner():DoAttackEvent()
	self:GetOwner():GetViewModel():SetPlaybackRate(1.5)

	if SERVER then
		timer.Simple(.35, function()
			if IsValid(self) then
				self:AttackFront()
			end
		end)
	end

	self:SetNextPrimaryFire(CurTime() + .3)
	self:SetNextSecondaryFire(CurTime() + 0.5)
end

SWEP.MinDamage = 5
SWEP.MaxDamage = 7
SWEP.DamageType = DMG_SLASH
SWEP.Force = 50
SWEP.BloodDecals = 1
SWEP.CanBreakDoors = true
SWEP.BreakDoorChance = 10
local NextReload = 0

function SWEP:Reload()
end

function SWEP:DrawWorldModel()
end

-- no, do nothing
function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration())
end

function SWEP:IsEntSoft(ent)
	return ent:IsNPC() or ent:IsPlayer() or (ent:GetClass() == "prop_ragdoll" and ent.fleshy)
end

local climblerp = 0

if CLIENT then
	local BlockAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		BlockAmt = math.Clamp(BlockAmt - FrameTime() * 1.5, 0, 1)
		pos = pos - ang:Up() * 15 * BlockAmt
		ang:RotateAroundAxis(ang:Right(), BlockAmt * 60)
		climblerp = math.Approach(climblerp, self:IsClimbing() and 1 or 0, FrameTime() * ((climblerp + 1) ^ 3))
		ang:RotateAroundAxis(ang:Right(), 64 * climblerp)

		if climblerp > 0 then
			pos = pos + -8 * climblerp * ang:Up() + -12 * climblerp * ang:Forward()
		end

		return pos, ang
	end
end

function SWEP:Move(mv)
	if self:GetClimbing() and not self:NearGround() then
		mv:SetMaxSpeed(0)
		--mv:SetMaxClientSpeed(0)
		local owner = self:GetOwner()
		local tr = self:GetClimbSurface()
		local angs = owner:SyncAngles()
		local dir = tr and tr.Hit and (tr.HitNormal.z <= -0.5 and (angs:Forward() * -1) or math.abs(tr.HitNormal.z) < 0.75 and tr.HitNormal:Angle():Up()) or Vector(0, 0, 1)
		local vel = Vector(0, 0, 4)

		if owner:KeyDown(IN_FORWARD) then
			owner:SetGroundEntity(nil)
			vel = vel + dir * 250 --160
		end

		if owner:KeyDown(IN_BACK) then
			vel = vel + dir * -250 ---160
		end

		if vel.z == 4 then
			if owner:KeyDown(IN_MOVERIGHT) then
				vel = vel + angs:Right() * 100 --60
			end

			if owner:KeyDown(IN_MOVELEFT) then
				vel = vel + angs:Right() * -100 ---60
			end
		end

		mv:SetLocalVelocity(vel)

		return true
	end
end