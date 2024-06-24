--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_npc_pistol.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]
AddCSLuaFile()
SWEP.Spawnable = false
SWEP.Author = "Jackarunda"
SWEP.Base = "weapon_base"
SWEP.Purpose = "The answer? Use a gun. An' if that don't work, use more gun."
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = 10
SWEP.Secondary.DefaultClip = 10
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.ViewModelFOV = 75
SWEP.Primary.Automatic = false
SWEP.NextChaseTime = 0
SWEP.MagSize = 10
SWEP.MuzzleEffect = "pcf_jack_mf_spistol"
SWEP.MaxRange = 1000
SWEP.AltRate = 30
SWEP.FireRate = .1
SWEP.CloseFireSound = "hndg_beretta92fs/beretta92_fire1.wav"
--SWEP.FarFireSound="snd_jack_hmcd_smp_far.wav"
--SWEP.CloseFireSound="m9/m9_fp.wav"
SWEP.FarFireSound = "m9/m9_dist.wav"
SWEP.ReloadSound = "snd_jack_hmcd_npcp_reload.wav"
SWEP.HomicideNPCSWEP = true
-------------------
AccessorFunc(SWEP, "fNPCMinBurst", "NPCMinBurst")
AccessorFunc(SWEP, "fNPCMaxBurst", "NPCMaxBurst")
AccessorFunc(SWEP, "fNPCFireRate", "NPCFireRate")
AccessorFunc(SWEP, "fNPCMinRestTime", "NPCMinRest")
AccessorFunc(SWEP, "fNPCMaxRestTime", "NPCMaxRest")

function SWEP:SetupWeaponHoldTypeForAI(t)
	self.ActivityTranslateAI = {}
	self.ActivityTranslateAI[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_PISTOL
	self.ActivityTranslateAI[ACT_RELOAD] = ACT_RELOAD_PISTOL
	self.ActivityTranslateAI[ACT_IDLE] = ACT_IDLE_PISTOL
	self.ActivityTranslateAI[ACT_IDLE_ANGRY] = ACT_RANGE_ATTACK_PISTOL
	self.ActivityTranslateAI[ACT_WALK] = ACT_WALK_PISTOL
	self.ActivityTranslateAI[ACT_IDLE_RELAXED] = ACT_IDLE_RELAXED
	self.ActivityTranslateAI[ACT_IDLE_STIMULATED] = ACT_IDLE_STIMULATED
	self.ActivityTranslateAI[ACT_IDLE_AGITATED] = ACT_IDLE_ANGRY_PISTOL
	self.ActivityTranslateAI[ACT_WALK_RELAXED] = ACT_WALK_RELAXED
	self.ActivityTranslateAI[ACT_WALK_STIMULATED] = ACT_WALK_STIMULATED
	self.ActivityTranslateAI[ACT_WALK_AGITATED] = ACT_WALK_AIM_PISTOL
	self.ActivityTranslateAI[ACT_RUN_RELAXED] = ACT_RUN_RELAXED
	self.ActivityTranslateAI[ACT_RUN_STIMULATED] = ACT_RUN_STIMULATED
	self.ActivityTranslateAI[ACT_RUN_AGITATED] = ACT_RUN_AIM_PISTOL
	self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] = ACT_IDLE_RELAXED
	self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] = ACT_IDLE_AIM_STIMULATED
	self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] = ACT_IDLE_ANGRY_PISTOL
	self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] = ACT_WALK_RELAXED
	self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] = ACT_WALK_AIM_STIMULATED
	self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] = ACT_WALK_AIM_PISTOL
	self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] = ACT_RUN_RELAXED
	self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] = ACT_RUN_AIM_STIMULATED
	self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] = ACT_RUN_AIM_PISTOL
	self.ActivityTranslateAI[ACT_WALK_AIM] = ACT_WALK_AIM_PISTOL
	self.ActivityTranslateAI[ACT_WALK_CROUCH] = ACT_WALK_CROUCH
	self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] = ACT_WALK_CROUCH_AIM
	self.ActivityTranslateAI[ACT_RUN] = ACT_RUN_PISTOL
	self.ActivityTranslateAI[ACT_RUN_AIM] = ACT_RUN_AIM_PISTOL
	self.ActivityTranslateAI[ACT_RUN_CROUCH] = ACT_RUN_CROUCH
	self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] = ACT_RUN_CROUCH_AIM
	self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] = ACT_GESTURE_RANGE_ATTACK_PISTOL
	self.ActivityTranslateAI[ACT_COVER_LOW] = ACT_COVER_PISTOL_LOW
	self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] = ACT_RANGE_AIM_PISTOL_LOW
	self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_PISTOL_LOW
	self.ActivityTranslateAI[ACT_RELOAD_LOW] = ACT_RELOAD_PISTOL_LOW
	self.ActivityTranslateAI[ACT_GESTURE_RELOAD] = ACT_GESTURE_RELOAD_PISTOL
	self.ActivityTranslateAI[ACT_MELEE_ATTACK1] = ACT_MELEE_ATTACK1
end

function SWEP:SetupDataTables()
end

-- no
function SWEP:Initialize()
	self.NextThinkTime = CurTime() + .01
	self:SetHoldType("pistol")
	self.CurrentAmmo = self.MagSize

	hook.Add("Think", self, function()
		self:Think()
	end)

	self.LastHealth = 150
	self.WanderDirection = VectorRand()
	self.SocialityType = math.random(-1, 1)
	self.NextFireTime = 0
end

function SWEP:GetCapabilities()
	return bit.bor(CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1, CAP_WEAPON_MELEE_ATTACK1, CAP_INNATE_MELEE_ATTACK1)
end

function SWEP:PrimaryAttack()
	if math.random(1, self.AltRate) == 2 then
		self:SecondaryAttack()

		return
	end

	if self.CurrentAmmo > 0 then
		if self.NextFireTime < CurTime() then
			self.NextFireTime = CurTime() + self.FireRate
			self:Fiah()
		end
	else
		self:Reload()
	end
end

function SWEP:Deploy()
	return true
end

function SWEP:Think()
	if not self then return end
	if not IsValid(self) then return end
	if not IsValid(self:GetOwner()) then return end
	if CLIENT then return end
	--JackaPrint(self:GetOwner():GetActivity())
	local Time = CurTime()

	if self.NextThinkTime <= Time then
		self.NextThinkTime = Time + math.Rand(.025, .2)
		local Health = self:GetOwner():Health()

		if Health < self.LastHealth then
			self.LastHealth = Health
			self:GotHurt()
		end

		local BG = self:BadGuy()
		local SelfPos = self:GetOwner():GetPos()
		local Act = self:GetOwner():GetActivity()

		if Act == ACT_IDLE then
			if math.random(1, 25) == 4 then
				if math.random(1, 2) == 2 then
					self:TargetMove()
				else
					self:RandomMove()
				end
			end
		end
	end
end

function SWEP:GotHurt()
	self:RandomMove()
end

function SWEP:RandomMove()
	local SelfPos = self:GetOwner():GetPos()
	local Vec = VectorRand()
	local NewPos = SelfPos + Vec * math.Rand(20, 300)
	self:GetOwner():SetLastPosition(NewPos)

	if math.random(1, 2) == 1 then
		self:GetOwner():SetSchedule(SCHED_FORCED_GO)
	else
		self:GetOwner():SetSchedule(SCHED_FORCED_GO_RUN)
	end
end

function SWEP:TargetMove()
	if not self:BadGuy() then return end

	if math.random(1, 2) == 1 then
		self:GetOwner():SetSchedule(SCHED_CHASE_ENEMY)
	else
		local NewPos = self:BadGuy():GetPos()
		self:GetOwner():SetLastPosition(NewPos)

		if math.random(1, 2) == 1 then
			self:GetOwner():SetSchedule(SCHED_FORCED_GO)
		else
			self:GetOwner():SetSchedule(SCHED_FORCED_GO_RUN)
		end
	end
end

function SWEP:BadGuy()
	local Enem = self:GetOwner():GetEnemy()

	if IsValid(Enem) and (Enem:Health() > 0) then
		return Enem
	else
		return nil
	end
end

function SWEP:Reload()
	self:GetOwner():IdleSound()
	self.CurrentAmmo = self.MagSize
	self:GetOwner():SetSchedule(SCHED_RELOAD)
	self:EmitSound(self.ReloadSound, 70, 100)
end

function SWEP:Fiah()
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	local SelfPos = self:GetOwner():GetPos()
	local PosAng = self:GetAttachment(self:LookupAttachment("muzzle")) --fuck this
	local AimVec = self:GetOwner():GetAimVector()
	local ShootPos = self:GetOwner():GetShootPos()
	local Enem = self:GetOwner():GetEnemy()
	local EnemPos = Enem:BodyTarget(ShootPos)
	local Muzz, AngPos = self.MuzzleEffect, self:GetAttachment(self:LookupAttachment("shell"))
	ParticleEffectAttach(Muzz, PATTACH_POINT_FOLLOW, self, 1)

	if SERVER then
		local effectdata = EffectData()
		effectdata:SetOrigin(AngPos.Pos)
		effectdata:SetAngles(AngPos.Ang)
		effectdata:SetEntity(self:GetOwner())
		util.Effect("ShellEject", effectdata, true, true)
	end

	local Acc = math.Rand(.001, .2)

	if (Enem:GetPhysicsObject():GetVelocity():Length() > 100) or (self:GetOwner():GetPhysicsObject():GetVelocity():Length() > 100) then
		Acc = Acc + .02
	end

	local Vec = (EnemPos - self:GetOwner():GetShootPos()):GetNormalized()
	local BulletTrajectory = (Vec + VectorRand() * Acc):GetNormalized()

	self:FireBullets({
		Src = self:GetOwner():GetShootPos(),
		Dir = BulletTrajectory,
		Tracer = 0,
		Damage = math.random(45, 55),
		Num = 1,
		Attacker = self:GetOwner(),
		Spread = Vector(0, 0, 0)
	})

	local Pitch = math.random(85, 95)
	self:EmitSound(self.CloseFireSound, 70, Pitch)
	sound.Play(self.CloseFireSound, SelfPos, 70, Pitch)
	sound.Play(self.FarFireSound, SelfPos + Vector(0, 0, 1), 160, Pitch)
	self.CurrentAmmo = self.CurrentAmmo - 1
end

function SWEP:SecondaryAttack()
	if self:BadGuy() then
		self:GetOwner():EmitSound("snd_jack_hmcd_cop" .. math.random(1, 3) .. ".wav", 75, math.random(100, 120))
	end
end

function SWEP:OnRemove()
end

--
function SWEP:OnDrop()
	self:Remove()
end

if CLIENT then
	function SWEP:ViewModelDrawn()
	end

	--
	function SWEP:DrawWorldModel()
		self:DrawModel()
	end
end