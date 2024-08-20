--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_fakepistol.lua
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
else
	killicon.AddFont("wep_jack_hmcd_fakepistol", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_fakepistol")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_fakepistol"
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Fake Pistol"
SWEP.Instructions = "This is a black-spraypainted airsoft gun. Use it to trick innocents and lure them to their doom, either by pretending to be the gunman or by dropping it as a bait."
SWEP.Slot = 5
SWEP.SlotPos = 3
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 75
SWEP.ViewModel = "models/weapons/v_pist_jivejevej.mdl"
SWEP.WorldModel = "models/weapons/w_matt_mattpx4v1.mdl"
SWEP.HoldType = "pistol"
--SWEP.CloseFireSound="m9/m9_fp.wav"
SWEP.CloseFireSound = "hndg_beretta92fs/beretta92_fire1.wav"
SWEP.BobScale = 1.5
SWEP.SwayScale = 1.5
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.ShellType = ""
SWEP.FuckedWorldModel = true
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Primary.Sound = ""
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 0
SWEP.Primary.Recoil = 0
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0
SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Tracer = 0
SWEP.Primary.Force = 0
SWEP.Category="HMCD: Union - Other"
SWEP.Primary.TakeAmmoPerBullet = false
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.Primary.ReloadTime = 0
SWEP.ReloadFinishedSound = Sound("Weapon_Crossbow.BoltElectrify")
SWEP.ReloadSound = Sound("Weapon_357.Reload")
SWEP.Secondary.Sound = ""
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 0
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Cone = 0
SWEP.Secondary.Delay = 0
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Tracer = 0
SWEP.Secondary.Force = 0
SWEP.Secondary.TakeAmmoPerBullet = false
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.BarrelMustSmoke = false
SWEP.AimTime = 3
SWEP.BearTime = 3
SWEP.SprintPos = Vector(-4, 0, -10)
SWEP.SprintAng = Angle(80, 0, 0)
SWEP.AimPos = Vector(1.75, 0, 1.22)
SWEP.AltAimPos = Vector(1.75, 0, 1.22)
SWEP.DeathDroppable = false
SWEP.CanAmmoShow = false
SWEP.InitialLoaded = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.HomicideSWEP = true
SWEP.ENT = "ent_jack_hmcd_fakepistol"
SWEP.BarrelLength = 10
SWEP.HolsterSlot = 3
SWEP.SuicidePos = Vector(-7, 4, -16)
SWEP.SuicideAng = Angle(100, -10, -90)
SWEP.SuicideSuppr = Vector(0, 0, -6.5)
SWEP.CarryWeight = 600
SWEP.Damage = 0

SWEP.Attachments = {
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = 1,
				forward = 1
			},
			ang = {
				forward = 180,
				right = 10,
				up = 90
			}
		}
	}
}

SWEP.MuzzleInfo = {
	["Bone"] = "slidey",
	["Offset"] = Vector(0, -30, -3),
	["reverseangle"] = true
}

function SWEP:PrimaryAttack()
	self.ReloadInterrupted = true
	if not self:GetReady() then return end
	if self.SprintingWeapon > 10 then return end

	if not IsFirstTimePredicted() then
		if (self:Clip1() == 1) and self.LastFireAnim then
			self:DoBFSAnimation(self.LastFireAnim)
		elseif self:Clip1() > 0 then
			self:DoBFSAnimation(self.FireAnim)
		end

		return
	end

	self.LastFire = CurTime()

	if not (self:Clip1() > 0) then
		self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)

		if CLIENT then
			self:GetOwner().AmmoShow = CurTime() + 2
		end

		self:SetNextPrimaryFire(CurTime() + self.TriggerDelay + self.CycleTime)
		return
	end

	local WaterMul = 1

	if self:GetOwner():WaterLevel() >= 3 then
		WaterMul = .5
	end

	if (self:Clip1() == 1) and self.LastFireAnim then
		self:DoBFSAnimation(self.LastFireAnim)
	elseif self:Clip1() > 0 then
		self:DoBFSAnimation(self.FireAnim)

		if self.FireAnimRate then
			self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimRate)
		end
	end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	local Pitch = self.ShotPitch * math.Rand(.9, 1.1)

	if SERVER then
		local Dist = 75

		if self.Suppressed then
			Dist = 55
		end

		self:GetOwner():EmitSound(self.CloseFireSound, Dist, Pitch)
		self:GetOwner():EmitSound(self.FarFireSound, Dist * 2, Pitch)

		if self.ExtraFireSound then
			sound.Play(self.ExtraFireSound, self:GetOwner():GetShootPos() + VectorRand(), Dist - 5, Pitch)
		end

		if self.CycleType == "manual" then
			timer.Simple(.1, function()
				if IsValid(self) and IsValid(self:GetOwner()) then
					self:EmitSound(self.CycleSound, 55, 100)
				end
			end)
		end
	end

	local Rightness, Upness = 4, 2
	local Huy = 36

	if CLIENT then
		ParticleEffect(self.MuzzleEffect, self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 20 + self:GetOwner():EyeAngles():Right() * Rightness - self:GetOwner():EyeAngles():Up() * Upness, self:GetOwner():EyeAngles(), self)
	end

	if SERVER then
		local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
		ParticleEffect(self.MuzzleEffect, pos + ang:Forward() * 6.9 - ang:Up() * 2.1 + ang:Right() * 1.6, self:GetOwner():EyeAngles(), self)
	end

	self.BarrelMustSmoke = true

	if SERVER and (self.CycleType == "auto") then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 15 + self:GetOwner():EyeAngles():Right() * Rightness - self:GetOwner():EyeAngles():Up() * Upness)
		effectdata:SetAngles(self:GetOwner():GetRight():Angle())
		effectdata:SetEntity(self:GetOwner())
		util.Effect(self.ShellType, effectdata, true, true)
	elseif SERVER and (self.CycleType == "manual") then
		timer.Simple(.4, function()
			if IsValid(self) and IsValid(self:GetOwner()) then
				local effectdata = EffectData()
				effectdata:SetOrigin(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 15 + self:GetOwner():EyeAngles():Right() * Rightness - self:GetOwner():EyeAngles():Up() * Upness)
				effectdata:SetAngles(self:GetOwner():GetRight():Angle())
				effectdata:SetEntity(self:GetOwner())
				util.Effect(self.ShellType, effectdata, true, true)
			end
		end)
	end

	local Ang = self:GetOwner():EyeAngles()
	local RecoilY = math.Rand(.01, .02) * self.Recoil
	local RecoilX = math.Rand(-.02, .04) * self.Recoil

	if (SERVER and game.SinglePlayer()) or CLIENT then
		self:GetOwner():SetEyeAngles((Ang:Forward() + RecoilY * Ang:Up() + Ang:Right() * RecoilX):Angle())
	end

	if not self:GetOwner():OnGround() then
		self:GetOwner():SetVelocity(-self:GetOwner():GetAimVector() * 10)
	end

	self:GetOwner():ViewPunchReset()
	self:GetOwner():ViewPunch(Angle(RecoilY * -100 * self.Recoil, RecoilX * -100 * self.Recoil, 0))
	self:TakePrimaryAmmo(1)
	local Extra = 0

	if self:GetOwner():WaterLevel() >= 3 then
		Extra = 1
	end

	self:SetNextPrimaryFire(CurTime() + self.TriggerDelay + self.CycleTime + Extra)

	if self.SuicideAmt == 100 then
		if SERVER then
			self:GetOwner():ApplyPain(105)
		end
	end
end

function SWEP:SecondaryAttack()
end

-- wat
function SWEP:Reload()
	self.ReloadInterrupted = false
	if not IsFirstTimePredicted() then return end
	if not (IsValid(self) and IsValid(self:GetOwner())) then return end
	if not self:GetReady() then return end
	if self.SprintingWeapon > 0 then return end

	if CLIENT then
		self:GetOwner().AmmoShow = CurTime() + 2
	end
end