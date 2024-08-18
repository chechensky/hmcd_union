if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
	SWEP.Primary.Ammo = SWEP.AmmoType
else
	killicon.AddFont("wep_jack_hmcd_smallpistol", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_smallpistol")
	SWEP.BounceWeaponIcon = false
	SWEP.Primary.Ammo = SWEP.AmmoType
end

game.AddParticles("particles/pcfs_jack_muzzleflashes.pcf")
game.AddParticles("particles/swb_muzzle.pcf")
game.AddParticles("particles/pcfs_jack_explosions_incendiary2.pcf")
game.AddParticles("particles/pcfs_jack_explosions_small3.pcf")
SWEP.IconTexture = "vgui/wep_jack_hmcd_smallpistol"
SWEP.Base = "weapon_base"
SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.TPIK = false
SWEP.DrawAmmo = false
SWEP.vbwActive = true
SWEP.vbw = 1
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 80
SWEP.ViewModel = "models/weapons/gleb/c_px4.mdl"
SWEP.WorldModel = "models/weapons/w_matt_mattpx4v1.mdl"
SWEP.HoldType = "pistol"
SWEP.BobScale = 1.5
SWEP.SwayScale = 1.5
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Primary.Sound = "snd_jack_hmcd_smp_close.wav"
SWEP.Primary.Damage = 30
SWEP.Primary.NumShots = 1
SWEP.Primary.Recoil = 5
SWEP.Primary.Cone = 1
SWEP.Primary.Delay = 3
SWEP.Primary.ClipSize = 11
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.Primary.Tracer = 1
SWEP.Primary.Force = 420
SWEP.rt_s = 512
SWEP.Primary.TakeAmmoPerBullet = false
SWEP.Primary.Automatic = false
SWEP.Secondary.Sound = ""
SWEP.Secondary.Damage = 10
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Recoil = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.Delay = 0.25
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Tracer = -1
SWEP.Secondary.Force = 5
SWEP.Secondary.TakeAmmoPerBullet = false
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.BarrelMustSmoke = false
SWEP.AimTime = 3
SWEP.BearTime = 3
SWEP.SprintPos = Vector(-4, 0, -10)
SWEP.SprintAng = Angle(80, 0, 0)
SWEP.AimPos = Vector(2.05, 0, 1.45)
SWEP.AltAimPos = Vector(1.95, -3, .5)
SWEP.Alt = 0
SWEP.DeathDroppable = false
SWEP.CanAmmoShow = true
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.ENT = "ent_jack_hmcd_smallpistol"
SWEP.MuzzleSmoke = false
SWEP.Damage = 30
SWEP.EjectType = "auto"
SWEP.ShellType = "ShellEject"
SWEP.MuzzleEffect = "pcf_jack_mf_spistol"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.ReloadTime = 3
SWEP.ReloadRate = .6
SWEP.ReloadSound = ""
--SWEP.CloseFireSound="snd_jack_hmcd_smp_close.wav"
--SWEP.FarFireSound="snd_jack_hmcd_smp_far.wav"
SWEP.CloseFireSound = "m9/m9_fp.wav"
SWEP.FarFireSound = "m9/m9_dist.wav"
SWEP.HipHoldType = "revolver"
SWEP.AimHoldType = "revolver"
SWEP.DownHoldType = "normal"
SWEP.BarrelLength = 1
SWEP.HandlingPitch = 100
SWEP.TriggerDelay = .15
SWEP.CycleTime = .025
SWEP.Recoil = 1
SWEP.Supersonic = true
SWEP.Accuracy = .99
SWEP.Spread = 0
SWEP.NumProjectiles = 1
SWEP.ShotPitch = 100
SWEP.VReloadTime = 0
SWEP.HipFireInaccuracy = .25
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.LastFire = 0
SWEP.FireAnim = "shoot1"
SWEP.DrawAnim = "draw"
SWEP.ReloadAnim = "reload"
SWEP.ReloadInterrupted = false
SWEP.HomicideSWEP = true
SWEP.Holster = false
SWEP.ShellEffect = "eff_jack_hmcd_919"
SWEP.NextBipodTime = 0
SWEP.BipodDeployed = false
SWEP.BipodSensitivity = {
	x = -0.3,
	z = 0.3,
	p = 0.1,
	r = 0.1
}

SWEP.ShellDelay = 0
SWEP.ShellAttachment = 2
SWEP.ReloadMul = 1
SWEP.MagPos = {10, -30, 0}
SWEP.MagDelay = .7
SWEP.MuzzlePos = {0, 0, 0}
SWEP.SmokeEffect = "pcf_jack_mf_barrelsmoke"
SWEP.DrawRate = .5
SWEP.ReloadAdd = 1
SWEP.DangerLevel = 90
SWEP.BulletVelocity = 360
SWEP.PreviousBodygroups = {}
SWEP.SuicideTime = 5
SWEP.SuicideType = "Pistol"
SWEP.DrawnAttachments = {}
SWEP.WDrawnAttachments = {}
SWEP.SprintAddMul = 300
SWEP.SuicideAddMul = 300
SWEP.AimAddMul = 300
SWEP.AimPerc = 0
SWEP.SprintingWeapon = 0
SWEP.SuicideAmt = 0
SWEP.BipodAmt = 0
SWEP.FrontBlockedPerc = 0
SWEP.FrontBlocked = 0
SWEP.InertiaScale = 1
SWEP.Temper = 0

function SWEP:Shell()
	if self.ShellEffect == "" then return end
	if not IsValid(self:GetOwner()) then return end
	if not IsFirstTimePredicted() or not self:GetOwner():Alive() then return end
	local effectdata = EffectData()
	effectdata:SetEntity(self.Weapon)
	effectdata:SetNormal(self:GetOwner():GetAimVector())
	effectdata:SetAttachment(self.ShellAttachment)
	util.Effect(self.ShellEffect, effectdata)
	if self.ShellEffect2 then util.Effect(self.ShellEffect2, effectdata) end
end

function SWEP:ShellReload()
	if self.ShellEffectReload == "" then return end
	if not IsValid(self:GetOwner()) then return end
	if not IsFirstTimePredicted() or not self:GetOwner():Alive() then return end
	local effectdata = EffectData()
	local ent = self.Weapon
	if IsValid(self:GetOwner().wep) then
		ent = self:GetOwner().wep
		local ang = ent:GetAngles()
		effectdata:SetOrigin(ent:GetPos() + ang:Forward() * ent.BulletEjectPos[1] + ang:Right() * ent.BulletEjectPos[2] + ang:Up() * ent.BulletEjectPos[3])
	end

	effectdata:SetEntity(ent)
	effectdata:SetNormal(self:GetOwner():GetAimVector())
	effectdata:SetAttachment(self.ShellAttachment)
	util.Effect(self.ShellEffectReload, effectdata)
end

local npcAim = {
	["npc_combine_s"] = WEAPON_PROFICIENCY_PERFECT,
	["npc_metropolice"] = WEAPON_PROFICIENCY_VERY_GOOD,
	["npc_citizen"] = WEAPON_PROFICIENCY_VERY_GOOD
}

function SWEP:Initialize()
	self.NextFrontBlockCheckTime = CurTime()
	if not self:GetOwner():IsNPC() then
		self:SetHoldType(self.HipHoldType)
	else
		self:SetHoldType(self.AimHoldType)
	end

	self:SetReady(true)
	self:SetSuiciding(false)
	self:SetLaserEnabled(false)
	if self.CustomColor then self:SetColor(self.CustomColor) end
	self.Primary.Ammo = self.AmmoType
	self:SetReloading(false)
	timer.Simple(.1, function() if IsValid(self) then self:EnforceHolsterRules(self) end end)
	if self:GetOwner():IsNPC() and SERVER then
		self.NPCAltFireTime = CurTime() + math.random(30, 60)
		self:GetOwner().Elite = self:GetOwner():GetModel() == "models/combine_super_soldier.mdl"
		if npcAim[self:GetOwner():GetClass()] then
			timer.Simple(0, function()
				if IsValid(self) then
					self.RoundsInMag = self:Clip1()
					self:GetOwner():SetCurrentWeaponProficiency(npcAim[self:GetOwner():GetClass()])
				end
			end)
		end

		if self.NPCAnims then self.ActivityTranslateAI = self.NPCAnims end
		hook.Add("Think", self, function()
			if IsValid(self:GetOwner()) then
				local enemy = self:GetOwner():GetEnemy()
				if IsValid(enemy) then
					local body
					if enemy.GetRagdollEntity then body = enemy:GetRagdollEntity() end
					if IsValid(body) then
						local ang = (body:GetPos() - self:GetOwner():GetPos()):Angle()
						ang.r = 0
						ang.p = 0
						self:GetOwner():SetAngles(ang)
						if not self.Reloading and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 and self:GetOwner():Visible(body) then
							self:SetAnimation(PLAYER_ATTACK1)
							self:PrimaryAttack()
							local delay = self.TriggerDelay * 2
							if self:Clip1() == 0 then delay = self.ReloadTime end
							self:SetNextPrimaryFire(CurTime() + delay)
						end
					end

					if enemy.TFALean and math.abs(enemy.TFALean) > .9 then
						if self:GetOwner():VisibleVec(enemy:GetShootPos()) then
							local posnormal = (enemy:GetPos() - self:GetOwner():EyePos()):GetNormalized()
							local aimvector = self:GetOwner():EyeAngles():Forward()
							local DotProduct = aimvector:DotProduct(posnormal)
							local ApproachAngle = -math.deg(math.asin(DotProduct)) + 90
							if ApproachAngle <= 60 then
								local ang = (enemy:GetShootPos() - self:GetOwner():GetPos()):Angle()
								ang.r = 0
								ang.p = 0
								self:GetOwner():SetAngles(ang)
								if not self.Reloading and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 then
									self:SetAnimation(PLAYER_ATTACK1)
									self:PrimaryAttack()
									local delay = self.TriggerDelay * 2
									if self:Clip1() == 0 then delay = self.ReloadTime end
									self:SetNextPrimaryFire(CurTime() + delay)
								end
							end
						end
					end
				else
					for i, ply in player.Iterator() do
						if ply.TFALean and math.abs(ply.TFALean) > .9 and ply:Alive() and self:GetOwner():Disposition(ply) == D_HT then
							if self:GetOwner():VisibleVec(ply:GetShootPos()) then
								local posnormal = (ply:GetPos() - self:GetOwner():EyePos()):GetNormalized()
								local aimvector = self:GetOwner():EyeAngles():Forward()
								local DotProduct = aimvector:DotProduct(posnormal)
								local ApproachAngle = -math.deg(math.asin(DotProduct)) + 90
								if ApproachAngle <= 60 then
									local ang = (ply:GetShootPos() - self:GetOwner():GetPos()):Angle()
									ang.r = 0
									ang.p = 0
									self:GetOwner():SetAngles(ang)
									if not self.Reloading and self:GetNextPrimaryFire() <= CurTime() and self:Clip1() > 0 then
										self:SetAnimation(PLAYER_ATTACK1)
										self:PrimaryAttack()
										local delay = self.TriggerDelay * 2
										if self:Clip1() == 0 then delay = self.ReloadTime end
										self:SetNextPrimaryFire(CurTime() + delay)
									end

									self:GetOwner():UpdateEnemyMemory(ply, ply:GetShootPos())
									break
								end
							end
						end
					end
				end
			end

			if not self.Reloading and self:GetOwner().GetActivity and self:GetOwner():GetActivity() == ACT_RELOAD then
				self.Reloading = true
				self.RoundsInMag = nil
				if self.ReloadSounds then
					local TacticalReload = self:Clip1() > 0
					local mul = 1
					if self:GetOwner():GetCurrentWeaponProficiency() > 2 then mul = 0.5 end
					for i, sound in pairs(self.ReloadSounds) do
						timer.Simple(self.ReloadSounds[i][2] * mul, function()
							if IsValid(self) and self.NextReload and IsValid(self:GetOwner()) and (self.ReloadSounds[i][3] == "Both" or (self.ReloadSounds[i][3] == "EmptyOnly" and not TacticalReload) or (self.ReloadSounds[i][3] == "FullOnly" and TacticalReload)) then
								self.Weapon:EmitSound(self.ReloadSounds[i][1], 65, 100)
								lastSound = self.ReloadSounds[i][1]
							end
						end)
					end
				elseif self.ReloadSound and not self.Reloading then
					self.Weapon:EmitSound(self.ReloadSound, 65, 100)
				end

				local dur = self:GetOwner():SequenceDuration(self:GetOwner():SelectWeightedSequence(ACT_RELOAD))
				if dur < 0.2 then dur = self:GetOwner():SequenceDuration(self:GetOwner():SelectWeightedSequence(self.ReloadSequence or ACT_RELOAD_SMG1)) end
				timer.Simple(dur, function() if IsValid(self) then self.Reloading = false end end)
			end
		end)
	end
	timer.Simple(.1,function()
		if IsValid(self) then
			self:EnforceHolsterRules(self)
		end
	end)
end

function SWEP:PreDrawViewModel()
	local vm = self:GetOwner():GetViewModel()
	if self:GetClass() == "wep_jack_hmcd_ar2" then
		if (self:GetOwner():KeyDown(IN_ATTACK) and self:Clip1() > 0 and self:GetReady() == true and self.SprintingWeapon < 10 and not self.FrontallyBlocked and not (self:GetOwner():KeyDown(IN_USE) and not (self:GetOwner():GetAmmoCount(self.AltAmmoType) > 0))) or self.NextAltFireTime >= CurTime() then
			vm:SetSkin(1)
		else
			vm:SetSkin(0)
		end
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Ready")
	self:NetworkVar("Bool", 1, "Reloading")
	self:NetworkVar("Bool", 2, "Suiciding")
	self:NetworkVar("Bool", 3, "LaserEnabled")
end

function SWEP:AltFire()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local EnergyBall = ents.Create("ent_jack_hmcd_energyball")
	EnergyBall.HmcdSpawned = self.HmcdSpawned
	EnergyBall:SetAngles(VectorRand():Angle())
	local pos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector()
	EnergyBall:SetPos(pos)
	EnergyBall.Owner = self:GetOwner()
	EnergyBall.Safe = true
	EnergyBall:Spawn()
	EnergyBall:Activate()
	EnergyBall:GetPhysicsObject():SetVelocity(self:GetOwner():GetAimVector() * 700)
	self:GetOwner():SetLagCompensated(false)
end
function SWEP:PrimaryAttack()
	self.ReloadInterrupted = true
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	if not self:GetReady() then return end
	if self.SprintingWeapon > 10 then return end
	if self.Reloading then return end
	if self:GetClass() == "wep_jack_hmcd_ar2" and ((self:GetOwner().KeyDown and self:GetOwner():KeyDown(IN_USE)) or (self:GetOwner().Elite and self.NPCAltFireTime < CurTime())) and self.NextAltFireTime < CurTime() then
		if not self:GetOwner().Elite then
			if not (self:GetOwner():GetAmmoCount(self.AltAmmoType) > 0) then
				self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
				self:SetNextPrimaryFire(CurTime() + 0.1)
				return
			end

			self:GetOwner():RemoveAmmo(1, self.AltAmmoType)
			self:DoBFSAnimation("shake")
			ParticleEffectAttach("precharge_fire", PATTACH_POINT_FOLLOW, self:GetOwner():GetViewModel(), 1)
		else
			self.NPCAltFireTime = CurTime() + math.random(30, 60)
		end

		self.NextAltFireTime = CurTime() + 2
		self:EmitSound("weapons/ar2/ar2_charge.wav", 55, 100)
		timer.Simple(0.75, function()
			if IsValid(self) then
				self:DoBFSAnimation("IR_fire2")
				self:EmitSound("weapons/ar2/ar2_secondary_fire.wav", 55, 100)
			end
		end)

		timer.Simple(1.5, function() if IsValid(self) then self:GetOwner():EmitSound("weapons/ar2/ar2_boltpull.wav", 55, 100) end end)
		timer.Simple(0.8, function()
			if IsValid(self) then
				self:AltFire()
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			end
		end)
		return
	end

	if self.NextAltFireTime and self.NextAltFireTime > CurTime() then return end
	if not (IsFirstTimePredicted() or self.Primary.Automatic) then
		if (self:Clip1() == 1) and self.LastFireAnim then
			if not (self.AimPerc > 99) or not self.LastIronFireAnim then
				self:DoBFSAnimation(self.LastFireAnim)
			else
				self:DoBFSAnimation(self.LastIronFireAnim)
			end
		elseif (self:Clip1() == 2) and self.MidEmptyFireAnim then
			if not (self.AimPerc > 99) or not self.MidEmptyIronFireAnim then
				self:DoBFSAnimation(self.MidEmptyFireAnim)
			else
				self:DoBFSAnimation(self.MidEmptyIronFireAnim)
			end
		elseif self:Clip1() > 0 then
			if not (self.AimPerc > 99) or not self.IronFireAnim then
				self:DoBFSAnimation(self.FireAnim)
			else
				self:DoBFSAnimation(self.IronFireAnim)
			end
		end

		if self.CockAnim and self.CockAnimDelay then
			timer.Simple(self.CockAnimDelay, function()
				if self and self:GetOwner() and self:GetOwner():GetActiveWeapon() == self then
					if not (self.AimPerc > 99) or not self.IronCockAnim then
						self:DoBFSAnimation(self.CockAnim)
					else
						self:DoBFSAnimation(self.IronCockAnim)
					end
				end
			end)
		end
		return
	end

	if SERVER and (self:Clip1() == 1 or self:Clip1() == math.Round(self.Primary.ClipSize / 4)) and (string.find(self:GetOwner():GetModel(), "combine") or string.find(self:GetOwner():GetModel(), "police")) then
		local snd = "npc/metropolice/vo/backmeupimout.wav"
		if self:Clip1() > 1 then snd = "npc/metropolice/vo/runninglowonverdicts.wav" end
		self:GetOwner().tauntsound = snd
		self:GetOwner():EmitSound(snd)
		self:GetOwner().NextTaunt = CurTime() + SoundDuration(snd)
		local BeepTime = SoundDuration(snd)
		self:GetOwner().NextTaunt = CurTime() + BeepTime
		self:GetOwner():EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav")
		local owner = self:GetOwner()
		timer.Simple(BeepTime, function() if IsValid(owner) and owner:Alive() then owner:EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav") end end)
	end

	self.CurrentDamage = self.Damage
	self.LastFire = CurTime()
	if self.AnimRandomiser and self.AnimRandomiser == true then self:RandomIronFireAnim() end
	if not (self:Clip1() > 0) then
		if self.NextFireTime then
			if self.NextFireTime < CurTime() then
				self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
				self.NextFireTime = CurTime() + 0.5
			end
		else
			self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
		end

		if CLIENT then self:GetOwner().AmmoShow = CurTime() + 2 end
		return
	end

	local suppressed = self:GetNWBool("Suppressor")
	local WaterMul = 1
	local Hippy = self.HipFireInaccuracy
	if self:GetOwner():WaterLevel() >= 3 then WaterMul = .5 end
	local dmgAmt, InAcc = self.Damage * WaterMul, 1 - self.Accuracy
	if not (self.AimPerc > 99 or (self:GetNWBool("Laser") and self:GetNWBool("LaserStatus", false)) or self.BipodAmt > 99 or self:GetOwner():IsNPC()) then InAcc = InAcc + Hippy end
	local ang = self:GetOwner():GetAimVector():Angle()
	local dirMul = 1
	if self.ViewModelFlip then dirMul = -1 end
	local Right, Up, Forward = ang:Right(), ang:Up(), ang:Forward()
	ang:RotateAroundAxis(Right, self.SprintAng.p * self.FrontBlockedPerc)
	ang:RotateAroundAxis(Up, self.SprintAng.y * self.FrontBlockedPerc * dirMul)
	ang:RotateAroundAxis(Forward, self.SprintAng.r * self.FrontBlockedPerc * dirMul)
	local BulletTraj = (ang:Forward() + VectorRand() * InAcc):GetNormalized()
	local bullet = {}
	bullet.Num = self.NumProjectiles
	if self.BipodAmt == 100 then
		local offset = self.BipodAimOffset
		local bipodPos, bipodAng = self:GetNWVector("BipodPos") + Vector(0, 0, self.BipodOffset), self:GetOwner():EyeAngles()
		bullet.Src = bipodPos + bipodAng:Forward() * offset[1] + bipodAng:Right() * offset[2] + bipodAng:Up() * offset[3]
		bullet.Dir = BulletTraj
	elseif self.SuicideAmt == 0 then
		bullet.Src = self:GetOwner():GetShootPos()
		bullet.Dir = BulletTraj
	else
		local posHand = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
		local posHead = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_Head1"))
		bullet.Src = posHand + (posHead - posHand):GetNormalized() * 5
		bullet.Dir = (posHead - posHand):GetNormalized()
		if self.SuicideAmt > 90 then
			local tr = util.QuickTrace(bullet.Src, bullet.Dir * 100, {self:GetOwner()})
			util.Decal("Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			local edata = EffectData()
			edata:SetStart(posHead)
			edata:SetOrigin(posHead)
			edata:SetNormal(posHead)
			edata:SetEntity(self:GetOwner())
			util.Effect("BloodImpact", edata, true, true)
			if SERVER then self:GetOwner():Kill() end
		end
	end

	dev = GetConVar("developer")
	--local vm = self:GetOwner():GetViewModel()
	--bullet.Dir = (vm:GetAngles():Forward()*self.BulletDir[1]+vm:GetAngles():Right()*self.BulletDir[2]+vm:GetAngles():Up()*self.BulletDir[3]+VectorRand()*InAcc):GetNormalized()
	bullet.Spread = Vector(self.Spread, self.Spread, 0)
	bullet.Tracer = 0
	bullet.Force = dmgAmt / 10
	bullet.Damage = dmgAmt / 4
	bullet.Callback = function(ply, tr, dmgInfo)
		self:BulletCallbackFunc(dmgAmt, ply, tr, dmgAmt, false, true, false)
		--[[if CLIENT then 
			local modifierEndPos = tr.HitPos + tr.Normal * 30
			hook.Add("PostDrawOpaqueRenderables", "Shoot", function()
				if dev:GetInt() >= 2 and ply:IsAdmin() then
					render.SetMaterial(Material("effects/flashlight/tech"))
					render.DrawLine(tr.StartPos, modifierEndPos, Color(255,255,255,255), true) 

            		render.DrawWireframeBox(tr.HitPos, Angle(0, 0, 0), Vector(-2, -2, -2), Vector(3, 3, 3), Color(255, 0, 0, 255), true)
					render.DrawWireframeBox(modifierEndPos, Angle(0, 0, 0), Vector(-2, -2, -2), Vector(3, 3, 3), Color(255, 0, 0, 255), true)
				end
			end)
		end]]
		--
	end

	if self.AltPrimaryFire then
		self:AltPrimaryFire()
	else
		self:GetOwner():FireBullets(bullet)
		if self.ShellDelay > 0 then
			timer.Simple(self.ShellDelay, function() if IsValid(self) then self:Shell() end end)
		else
			self:Shell()
		end
	end

	if self.Supersonic then self:BallisticSnap(BulletTraj) end
	if (self:Clip1() == 1) and self.LastFireAnim then
		if not (self.AimPerc > 99) or not self.LastIronFireAnim then
			self:DoBFSAnimation(self.LastFireAnim)
		else
			self:DoBFSAnimation(self.LastIronFireAnim)
		end
	elseif (self:Clip1() == 2) and self.MidEmptyFireAnim then
		if not (self.AimPerc > 99) or not self.MidEmptyIronFireAnim then
			self:DoBFSAnimation(self.MidEmptyFireAnim)
		else
			self:DoBFSAnimation(self.MidEmptyIronFireAnim)
		end
	elseif self:Clip1() > 0 then
		if not (self.AimPerc > 99) or not self.IronFireAnim then
			self:DoBFSAnimation(self.FireAnim)
		else
			self:DoBFSAnimation(self.IronFireAnim)
		end
	end

	if self.CockAnim and self.CockAnimDelay then
		timer.Simple(self.CockAnimDelay, function()
			if self:GetOwner():GetActiveWeapon() == self then
				if not (self.AimPerc > 99) or not self.IronCockAnim then
					self:DoBFSAnimation(self.CockAnim)
				else
					self:DoBFSAnimation(self.IronCockAnim)
				end
			end
		end)
	end

	if self.FireAnimRate and self:GetOwner().GetViewModel then
		self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimRate)
		if self:GetClass() == "wep_jack_hmcd_combinesniper" then timer.Simple(.015, function() if IsValid(self) then self:GetOwner():GetViewModel():SetPlaybackRate(1) end end) end
	end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	local Pitch = self.ShotPitch * math.Rand(.9, 1.1)
	if self:GetClass() == "wep_jack_hmcd_taser" then Pitch = 100 end
	if SERVER then
		local Dist = 75
		if suppressed and self.SuppressedFireSound then
			self:GetOwner():EmitSound(self.SuppressedFireSound)
		else
			self:GetOwner():EmitSound(self.CloseFireSound, Dist, Pitch)
			self:GetOwner():EmitSound(self.FarFireSound, Dist * 2, Pitch)
			if self.ExtraFireSound then sound.Play(self.ExtraFireSound, self:GetOwner():GetShootPos() + VectorRand(), Dist - 5, Pitch) end
		end

		if self.CycleType == "manual" then timer.Simple(.1, function() if IsValid(self) and IsValid(self:GetOwner()) then self:EmitSound(self.CycleSound, 55, 100) end end) end
	end

	if self.MuzzleEffect ~= "" then
		local eff = self.MuzzleEffect
		if suppressed then eff = self.MuzzleEffectSuppressed end
		if CLIENT then
			local info = self.MuzzleInfo
			if info then
				local vm = self:GetOwner():GetViewModel()
				local pos, ang = vm:GetBonePosition(vm:LookupBone(info.Bone))
				if info.reverseangle then ang.r = -ang.r end
				ParticleEffect(eff, pos + ang:Forward() * info.Offset[1] + ang:Right() * info.Offset[2] + ang:Up() * info.Offset[3], self:GetOwner():EyeAngles(), self)
			end
		end

		if SERVER then
			local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
			local position = pos + ang:Forward() * self.MuzzlePos[1] + ang:Up() * self.MuzzlePos[2] + ang:Right() * self.MuzzlePos[3]
			if suppressed then position = position + ang:Forward() * 6 end
			ParticleEffect(eff, position, ang, self)
		end
	end

	self.BarrelMustSmoke = true
	local Ang, Rec = self:GetOwner():EyeAngles(), self.Recoil * 3
	if self:GetNWBool("Suppressor") then Rec = Rec * .5 end
	if not self:GetOwner():IsOnGround() then Rec = Rec * 2 end
	if self.BipodAmt == 100 then Rec = Rec * .01 end
	if Rec >= 10 then
		if SERVER then
			self:GetOwner().lastRagdollEndTime = nil
			self:TakePrimaryAmmo(1)
			self:GetOwner():ConCommand("fake")
			timer.Simple(0.3, function() if IsValid(self:GetOwner():GetNWEntity("Ragdoll")) then self:GetOwner():GetNWEntity("Ragdoll"):GetPhysicsObject():SetVelocity(-self:GetOwner():GetAimVector() * 500) end end)
			return
		end
	else
		local Ang,Rec=self.Owner:EyeAngles(),self.Recoil
		if self:GetNWBool("Suppressor") then Rec=.5 end
		if self:GetOwner():GetNWFloat("RightArm", 1) < 0.85 then Rec=Rec*1.5 end
		if self:GetOwner():GetNWFloat("LeftArm", 1) < 0.85 then Rec=Rec*5 end
		local RecoilY=math.Rand(.015,.03)*Rec
		local RecoilX=math.Rand(-.03,.05)*Rec
		if (SERVER and game.SinglePlayer()) or CLIENT then
			self.Owner:SetEyeAngles((Ang:Forward()+RecoilY*Ang:Up()+Ang:Right()*RecoilX):Angle())
		end
		if self.Owner:OnGround() then self.Owner:SetVelocity(-self.Owner:GetAimVector()*10) end
		self.Owner:ViewPunch(Angle(RecoilY*-100*self.Recoil,RecoilX*-100*self.Recoil,0))
		if self:GetOwner():IsPlayer() then
		else
			if not self.BurstFire then
				self.BurstFire = true
				local rand = math.random(1, 6)
				for i = 1, rand do
					timer.Simple(self.TriggerDelay * i * 2, function()
						if IsValid(self) and self:GetNextPrimaryFire() <= CurTime() and not self.Reloading then
							self:SetAnimation(PLAYER_ATTACK1)
							self:PrimaryAttack()
							if i == rand then self.BurstFire = nil end
						end
					end)
				end
			end

			if not self.RoundsInMag then self.RoundsInMag = self:Clip1() end
			self.RoundsInMag = self.RoundsInMag - 1
		end
	end

	self:TakePrimaryAmmo(1)
	local Extra = 0
	if self:GetOwner():WaterLevel() >= 3 then Extra = 1 end
	self:SetNextPrimaryFire(CurTime() + self.TriggerDelay + self.CycleTime + Extra)
end

function SWEP:BarrelSmoke()
	local ent = self:GetOwner():GetViewModel()
	local ent2 = self.WorldModel
	if self:LookupAttachment("muzzle") then ParticleEffectAttach("pcf_jack_mf_barrelsmoke", PATTACH_POINT_FOLLOW, self, self:LookupAttachment("muzzle")) end
	if ent then
		for i = 1, math.random(1, 3) do
			if self:GetAttachment(1) then local effect = ParticleEffectAttach(self.SmokeEffect, PATTACH_POINT_FOLLOW, ent, 1) end
		end
	end
end

function SWEP:SecondaryAttack()
end

local nextBipodCheck = 0
local primaryShoot = 0
function SWEP:Think()
	local Time = CurTime()
	local ply = self:GetOwner()
	self:EnforceFrontBlock()
	if self:GetClass() == "wep_jack_hmcd_m249" and SERVER then
		local vm = self:GetOwner():GetViewModel()
		local curBodygroup = vm:GetBodygroup(1)
		if self:Clip1() < 17 and not self.NextReload and curBodygroup ~= self:Clip1() then vm:SetBodygroup(1, self:Clip1()) end
		if self:Clip1() > 16 and not self.NextReload and curBodygroup ~= 16 then vm:SetBodygroup(1, 16) end
	end

	if self.BarrelMustSmoke then
		if self:GetClass() == "wep_jack_hmcd_m249" and math.random(1, 5) ~= 3 then return end
		self:BarrelSmoke()
		self.BarrelMustSmoke = false
	end

	local ply = self:GetOwner()
	if nextBipodCheck < Time then
		nextBipodCheck = Time + 0.1
		if self.BipodEntity then
			if not IsValid(self.BipodEntity) then
				self:ToggleBipods()
			else
				local entFound = false
				for i, ent in pairs(ents.FindInSphere(self.BipodPos, 25)) do
					if ent == self.BipodEntity then
						entFound = true
						break
					end
				end

				if not entFound then self:ToggleBipods() end
			end
		end

		if self.BipodPos then if math.abs(self.BipodPos.z - self:GetOwner():EyePos().z) > 25 then self:ToggleBipods() end end
	end

	if SERVER then
		if self.NextReload and self.NextReload < Time then
			self.NextReload = nil
			if IsValid(self) and IsValid(self:GetOwner()) then
				if self.SetRocketGone then
					self:SetRocketGone(false)
					if IsValid(self:GetOwner().wep) then self:GetOwner().wep:SetBodygroup(1, 0) end
				end

				self:SetReady(true)
				local Missing, Have = self.Primary.ClipSize - self:Clip1(), self:GetOwner():GetAmmoCount(self.Primary.Ammo)
				if Missing <= Have then
					if self:Clip1() <= 0 and not self.NoBulletInChamber then
						self:GetOwner():RemoveAmmo(Missing - 1, self.Primary.Ammo)
						self:SetClip1(self.Primary.ClipSize - 1)
					else
						self:GetOwner():RemoveAmmo(Missing, self.Primary.Ammo)
						self:SetClip1(self.Primary.ClipSize)
					end
				elseif Missing > Have then
					self:SetClip1(self:Clip1() + Have)
					self:GetOwner():RemoveAmmo(Have, self.Primary.Ammo)
				end

				if IsValid(self:GetOwner().wep) then
					self:GetOwner().wep.RoundsInMag = self:Clip1()
					self:GetOwner().wep.Reloading = false
				end
			end
		end

		if (self.ReloadType == "individual") and self:GetReloading() then
			if self.VReloadTime < Time then
				if (self:Clip1() < self.Primary.ClipSize) and (self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0) and not self.ReloadInterrupted then
					self:SetClip1(self:Clip1() + 1)
					self:GetOwner():RemoveAmmo(1, self.Primary.Ammo)
					self:StallAnimation(self.StallAnim, self.StallTime)
					timer.Simple(.01, function() self:ReadyAfterAnim(self.LoadAnim) end)
					if self.ReloadSoundDelay then
						timer.Simple(self.ReloadSoundDelay, function() if IsValid(self) then sound.Play(self.ReloadSound, self:GetOwner():GetShootPos(), 55, 100) end end)
					else
						sound.Play(self.ReloadSound, self:GetOwner():GetShootPos(), 55, 100)
					end
				else
					self:SetReloading(false)
					self:ReadyAfterAnim(self.LoadFinishAnim)
					timer.Simple(.25, function() if (IsValid(self) and IsValid(self:GetOwner())) and self.CycleSound and not self.NoCocking then self:EmitSound(self.CycleSound, 55, 90) end end)
					timer.Simple(.5, function()
						if IsValid(self) and IsValid(self:GetOwner()) then
							self:SetReady(true)
							if IsValid(self:GetOwner().wep) then
								self:GetOwner().wep.RoundsInMag = self:Clip1()
								self:GetOwner().wep.Reloading = false
							end
						end
					end)
				end
			end
		end
		local HoldType = self.HipHoldType
		if self:GetOwner():KeyDown(IN_SPEED) or self:GetSuiciding() or self.FrontBlockedPerc > 0.1 then
			HoldType = self.DownHoldType
		elseif (self.AimPerc > 50) and not self:GetOwner():Crouching() then
			HoldType = self.AimHoldType
		else
			HoldType = self.HipHoldType
		end

		self:SetHoldType(HoldType)
	end

	local InAttack, InSpeed = self.InAttack or self:GetOwner():KeyDown(IN_ATTACK2), self.InSprint or self:GetOwner():KeyDown(IN_SPEED)
	local ready = self:GetReady()
	local AimPerc = self.AimPerc
	local Reloading, Sprinting, Blocked = self.Reloading, self.SprintingWeapon, tobool(self.FrontBlocked or 0)
	local AimChanged = IsChanged(InAttack, "aimin", self) and (not self.NextAimChange or self.NextAimChange < Time)
	local SprintChanged = IsChanged(InSpeed, "sprint", self) and (not self.NextSprintChange or self.NextSprintChange < Time) or IsChanged(self:GetReady(), "ready", self)
	local BlockedChanged = IsChanged(Blocked, "frontblocked", self)
	local DeployTimeChanged = self.DeployTime ~= nil and IsChanged(self.DeployTime <= Time, "deploy", self)
	local Cycling = self.Cycling or false
	local GroundChanged = IsChanged(self:GetOwner():OnGround(), "grounded", self)
	self.changed = GroundChanged or BlockedChanged or DeployTimeChanged or IsChanged(self.Reloading, "reload", self) or IsChanged(Cycling, "cycling", self)
	--Long as duck
	if AimChanged or SprintChanged or self.changed then
		if AimChanged or GroundChanged or BlockedChanged then
			self.NextAimChange = Time + 0.2
			self.AimStartTime = Time
		end

		if SprintChanged then
			self.NextSprintChange = Time + 0.2
			self.SprintStartTime = Time
			self.AimStartTime = Time
		end

		self.SprintOnChange = self.SprintingWeapon or 0
		self.AimingOnChange = self.AimPerc or 0
		self.changed = false
	end

	self.changed = IsChanged(self:GetSuiciding(), "suiciding", self)
	if self.changed then
		self.SuicideStartTime = Time
		self.SuicideOnChange = self.SuicideAmt or 0
		self.changed = false
	end

	local bipodPos = self:GetNWVector("BipodPos")
	if IsChanged(bipodPos, "bipod", self) then
		self.BipodStartTime = Time
		self.BipodOnChange = self.BipodAmt or 0
		if bipodPos ~= Vector() then
			self.BipodAngle = self:GetOwner():EyeAngles()
		else
			self.BipodAngle = nil
		end
	end

	local Suiciding = self:GetSuiciding()
	local AimDiff = Time - self.AimStartTime
	if AimDiff > 0 then
		if InAttack and not Reloading and not Blocked and not Cycling and not Suiciding and Sprinting < 100 and not InSpeed and self:GetOwner():OnGround() then
			if not (AimPerc >= 100) then self.AimPerc = math.Clamp(AimDiff * self.AimAddMul, 0, 100) end
		elseif not (AimPerc <= 0) then
			self.AimPerc = math.Clamp(self.AimingOnChange - AimDiff * self.AimAddMul, 0, 100)
		end
	end

	local SprintDiff = Time - self.SprintStartTime
	if SprintDiff > 0 then
		if InSpeed and not (Reloading or Cycling or Suiciding) and ready then
			if Sprinting ~= 100 then
				local diff = SprintDiff
				if self.FrontBlockedPerc and self.FrontBlockedPerc > diff then diff = self.FrontBlockedPerc end
				self.SprintingWeapon = math.Clamp(diff * self.SprintAddMul, 0, 100)
			end
		elseif Sprinting ~= 0 then
			self.SprintingWeapon = math.Clamp(self.SprintOnChange - SprintDiff * self.SprintAddMul, 0, 100)
		end
	end

	local SuicideDiff = Time - self.SuicideStartTime
	if Suiciding then
		local mul = self.SuicideAddMul
		if self:GetOwner():GetNWBool("GhostSuiciding") then mul = mul * .1 end
		self.SuicideAmt = math.Clamp(SuicideDiff * mul, 0, 100)
	else
		self.SuicideAmt = math.Clamp(self.SuicideOnChange - SuicideDiff * self.SuicideAddMul, 0, 100)
	end

	if self.BipodUsable then
		local BipodDiff = Time - self.BipodStartTime
		if bipodPos ~= Vector() then
			self.BipodAmt = math.Clamp(BipodDiff * 150, 0, 100)
		else
			self.BipodAmt = 0
		end
	end
end

function SWEP:RandomIronFireAnim()
	local Rand = math.random(97, 102)
	local RandLetter = string.char(tostring(Rand))
	self.IronFireAnim = "iron_fire_" .. RandLetter
end

function SWEP:Reload()
	self.ReloadInterrupted = false
	if not IsFirstTimePredicted() then return end
	if not (IsValid(self) and IsValid(self:GetOwner())) then return end
	if not self:GetReady() then return end
	if self.SprintingWeapon > 0 then return end
	if self.SuicideAmt > 0 then return end
	if CLIENT then self:GetOwner().AmmoShow = CurTime() + 2 end
	--print(self:GetOwner():GetAmmoCount("AR2"))
	if (self:Clip1() < self.Primary.ClipSize) and (self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0) then
		local TacticalReload = self:Clip1() > 0
		if self:GetClass() == "wep_jack_hmcd_dbarrel" then TacticalReload = self:Clip1() >= 1 or self:GetOwner():GetAmmoCount("Buckshot") == 1 end
		self:SetReady(false)
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
		local Mul = 1
		local ReloadAdd = 0
		if not TacticalReload then ReloadAdd = self.ReloadAdd end
		local ReloadTime = (self.ReloadTime + ReloadAdd) * Mul
		if self:GetClass() == "wep_jack_hmcd_revolver" then
			timer.Simple(self.MagDelay, function()
				if IsValid(self) then
					for i = 1, self.Primary.ClipSize - self:Clip1() do
						self:ShellReload()
					end
				end
			end)
		elseif self:GetClass() == "wep_jack_hmcd_dbarrel" then
			timer.Simple(self.MagDelay, function()
				if IsValid(self) then
					local amt = 1
					if not TacticalReload then amt = 2 end
					for i = 1, amt do
						self:ShellReload()
					end
				end
			end)
		elseif self.ShellEffectReload then
			timer.Simple(self.MagDelay * Mul, function() if IsValid(self) then self:ShellReload() end end)
		end

		if (self:Clip1() < 2 or self:GetClass() == "wep_jack_hmcd_rifle") and self.MagEntity then
			if SERVER then
				timer.Simple(self.MagDelay * Mul, function()
					local Mag = ents.Create(self.MagEntity)
					Mag.HmcdSpawned = self.HmcdSpawned
					Mag:SetAngles(VectorRand():Angle())
					if IsValid(self:GetOwner().fakeragdoll) then
						Mag:SetPos(self:GetOwner().fakeragdoll:GetBonePosition(self:GetOwner().fakeragdoll:LookupBone("ValveBiped.Bip01_R_Hand")))
					else
						Mag:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetForward() * self.MagPos[1] + self:GetOwner():GetUp() * self.MagPos[2] + self:GetOwner():GetRight() * self.MagPos[3])
					end

					Mag.Owner = self:GetOwner()
					Mag:Spawn()
					Mag:Activate()
				end)
			end
		end

		if SERVER then
			if IsValid(self:GetOwner().wep) then self:GetOwner().wep.Reloading = true end
			if self.ReloadSounds then
				for i, sound in pairs(self.ReloadSounds) do
					timer.Simple(self.ReloadSounds[i][2] * Mul, function() if IsValid(self) and self.NextReload and self:GetOwner():GetActiveWeapon() == self and (self.ReloadSounds[i][3] == "Both" or (self.ReloadSounds[i][3] == "EmptyOnly" and not TacticalReload) or (self.ReloadSounds[i][3] == "FullOnly" and TacticalReload)) then self.Weapon:EmitSound(self.ReloadSounds[i][1], 65, 100) end end)
				end
			end

			if self:GetClass() == "wep_jack_hmcd_crossbow" then timer.Simple(3.2 * Mul, function() if IsValid(self) then self:GetOwner():GetViewModel():SetSkin(1) end end) end
		end

		if (self.ReloadType == "clip") or (self.ReloadType == "magazine") then
			if (self:Clip1() == 1) and self.MidEmptyReloadAnim then
				self:DoBFSAnimation(self.MidEmptyReloadAnim)
			elseif TacticalReload and self.TacticalReloadAnim then
				self:DoBFSAnimation(self.TacticalReloadAnim)
			elseif self.BipodAmt > 99 and self.BipodReloadAnim then
				self:DoBFSAnimation(self.BipodReloadAnim)
			else
				self:DoBFSAnimation(self.ReloadAnim)
			end

			self:GetOwner():GetViewModel():SetPlaybackRate(self.ReloadRate / Mul)
			self.Weapon:EmitSound(self.ReloadSound, 65, 100)
			if SERVER then self.NextReload = CurTime() + ReloadTime end
		elseif self.ReloadType == "individual" then
			self:SetReloading(true)
			self:ReadyAfterAnim(self.StartReloadAnim)
		end
	end
end

function SWEP:ReadyAfterAnim(anim)
	self:DoBFSAnimation(anim)
	local mul = 1
	local reloadRate = self.ReloadRate * mul
	self:GetOwner():GetViewModel():SetPlaybackRate(reloadRate)
	local Time = (self:GetOwner():GetViewModel():SequenceDuration() / reloadRate) + .01
	self.VReloadTime = CurTime() + Time
end

function SWEP:Deploy()
	self.AimPerc = 0
	self.SprintingWeapon = 0
	self.SuicideAmt = 0
	self.BipodAmt = 0
	self:SetSuiciding(false)
	if self.Bodygroups and SERVER then
		local vm = self:GetOwner():GetViewModel()
		for i, bgroup in pairs(self.Bodygroups) do
			self.PreviousBodygroups[i] = vm:GetBodygroup(i)
			vm:SetBodygroup(i, bgroup)
		end
	end

	if self:GetOwner().GetViewModel and IsValid(self:GetOwner():GetViewModel()) then self:GetOwner():GetViewModel():SetSkin(0) end
	if self:GetOwner().DamagedArms and self.HolsterSlot == 1 then self:GetOwner():DropWeapon(self) end
	if IsValid(self) and IsValid(self:GetOwner()) then
		if not IsFirstTimePredicted() then
			self:DoBFSAnimation(self.DrawAnim)
			self:GetOwner():GetViewModel():SetPlaybackRate(.1)
			return
		end

		if self:Clip1() > 0 then
			self:DoBFSAnimation(self.DrawAnim)
			if self:GetClass() == "wep_jack_hmcd_crossbow" then self:GetOwner():GetViewModel():SetSkin(1) end
		elseif self.DrawAnimEmpty then
			self:DoBFSAnimation(self.DrawAnimEmpty)
			if self:GetClass() == "wep_jack_hmcd_crossbow" then self:GetOwner():GetViewModel():SetSkin(0) end
		end

		if self:GetOwner().GetViewModel then self:GetOwner():GetViewModel():SetPlaybackRate(self.DrawRate) end
		self:SetReady(false)
		if not self.SilentDeploy then self:EmitSound("snd_jack_hmcd_pistoldraw.wav", self.DeployVolume or 70, self.HandlingPitch) end
		self:EnforceHolsterRules(self)
		timer.Simple(1.5, function() if IsValid(self) then self:SetReady(true) end end)
		return true
	end
end

function SWEP:EnforceHolsterRules(newWep)
	timer.Stop(tostring(self.Owner).."ReloadTimer")
	if(CLIENT)then return end
	if not(newWep==self)then return end -- only enforce rules for us
	for key,wep in pairs(self.Owner:GetWeapons())do
		if((wep.HolsterSlot)and(self.HolsterSlot)and(wep.HolsterSlot==self.HolsterSlot)and not(wep==self))then -- conflict
			self.Owner:DropWeapon(wep)
		end
	end
end

function SWEP:StallAnimation(anim, time)
	self:DoBFSAnimation(anim)
	self.VReloadTime = self.VReloadTime + .1
	self:GetOwner():GetViewModel():SetPlaybackRate(.1)
end

function SWEP:DoBFSAnimation(anim)
	if self:GetOwner() and self:GetOwner().GetViewModel then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	end
end

function SWEP:Holster(newWep)
	if self:GetOwner():GetNWBool("GhostSuiciding") then return false end
	if self:GetClass() == "wep_jack_hmcd_ar2" then if self:GetOwner().GetViewModel and IsValid(self:GetOwner():GetViewModel()) then self:GetOwner():GetViewModel():SetSkin(0) end end
	for i, bgroup in pairs(self.PreviousBodygroups) do
		if IsValid(self:GetOwner():GetViewModel()) then self:GetOwner():GetViewModel():SetBodygroup(i, bgroup) end
	end
    for i = 0, self:GetOwner():GetBoneCount() - 1 do
        self:GetOwner():ManipulateBonePosition(i, Vector(0, 0, 0))
        self:GetOwner():ManipulateBoneAngles(i, Angle(0, 0, 0))
    end
	self:SetNWVector("BipodPos", Vector())
	self.BipodPos = nil
	self.BipodEntity = nil
	self.PreviousBodygroups = {}
	self:EnforceHolsterRules(newWep)
	self:CleanLaser()
	self:SetReloading(false)
	self:SetReady(false)
	if self:GetSuiciding() then self:GetOwner():SetDSP(0) end
	return true
end

function SWEP:OnRemove()
	--
	return true
end

function SWEP:OnRestore()
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
	if not self.FirstOwner then self.FirstOwner = self:GetOwner() end
end

SWEP.BlockOnChange = 0
SWEP.FrontBlockTime = 0
function SWEP:EnforceFrontBlock()
	local ShootVec, Ang, ShootPos = self:GetOwner():GetAimVector(), self:GetOwner():GetAngles(), self:GetOwner():GetShootPos()
	local OverallLength = self.BarrelLength
	if self:GetNWBool("Suppressor") then OverallLength = OverallLength + 3 end
	ShootPos = ShootPos + ShootVec * 15
	local trace = util.TraceLine({
		start = ShootPos - Ang:Forward() * 5,
		endpos = ShootPos + (ShootVec * OverallLength) + Ang:Forward() * 15,
		filter = self:GetOwner()
	})

	if trace.Hit and self.BipodAmt < 1 then
		if trace.StartSolid then trace.Fraction = 0 end
		if self.FrontBlocked == 0 then self.FrontBlockTime = CurTime() end
		self.FrontBlocked = 1
		self.FrontBlockedPerc = math.Clamp((CurTime() - self.FrontBlockTime) * self.SprintAddMul / 100, 0, 1 - trace.Fraction)
	else
		if self.FrontBlocked == 1 then
			self.FrontBlockTime = CurTime()
			self.BlockOnChange = self.FrontBlockedPerc
		end

		self.FrontBlocked = 0
		self.FrontBlockedPerc = math.Clamp(self.BlockOnChange - (CurTime() - self.FrontBlockTime) * self.SprintAddMul / 100, 0, 1)
	end
end

function SWEP:OnDrop()
	if self:GetSuiciding() and IsValid(self:GetOwner()) then self:GetOwner():SetDSP(0) end
	self.NextReload = nil
	local Ent = ents.Create(self.ENT)
	if IsValid(Ent) then
		Ent.HmcdSpawned = self.HmcdSpawned
		Ent:SetPos(self:GetPos())
		Ent:SetAngles(self:GetAngles())
		if self.Attachments and self.Attachments["Owner"] then
			for attachment, info in pairs(self.Attachments["Owner"]) do
				Ent:SetNWBool(attachment, self:GetNWBool(attachment))
			end
		end

		Ent:Spawn()
		Ent:Activate()
		Ent.RoundsInMag = self.RoundsInMag or self:Clip1()
		if IsValid(Ent:GetPhysicsObject()) then
			Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
		end
	end
	self:Remove()
end

function SWEP:BallisticSnap(traj)
	if CLIENT then return end
	if not self.Supersonic then return end
	if self.NumProjectiles > 1 then return end
	local Src = self:GetOwner():GetShootPos()
	local TrDat = {
		start = Src,
		endpos = Src + traj * 20000,
		filter = {self:GetOwner()}
	}

	local Tr, EndPos = util.TraceLine(TrDat), Src + traj * 20000
	if Tr.Hit or Tr.HitSky then EndPos = Tr.HitPos end
	local Dist = (EndPos - Src):Length()
	if Dist > 1000 then
		for i = 1, math.floor(Dist / 500) do
			local SoundSrc = Src + traj * i * 500
			for key, ply in player.Iterator() do
				if not (ply == self:GetOwner()) then
					local PlyPos = ply:GetPos()
					if (PlyPos - SoundSrc):Length() < 1000 then
						local Snd = "snd_jack_hmcd_bc_" .. math.random(1, 7) .. ".wav"
						local Pitch = math.random(90, 110)
						sound.Play(Snd, ply:GetShootPos(), 50, Pitch)
					end
				end
			end
		end
	end
end

function SWEP:ToggleBipods()
	if self.BipodUsable and SERVER then
		if not self.BipodPos then
			if (self.NextBipodTime and self.NextBipodTime > CurTime()) or self.FrontBlockedPerc > 0.1 then return end
			for i = 0.5, 1.5, 0.25 do
				local tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * self.BarrelLength * i, {self:GetOwner()})
				if tr.Hit then return end
				tr = util.QuickTrace(tr.HitPos, -vector_up * 20, {self:GetOwner()})
				if tr.Hit and self:GetOwner():GetShootPos().z - tr.HitPos.z <= 25 then
					local vec = tr.HitPos
					vec.x = math.Round(vec.x)
					vec.y = math.Round(vec.y)
					vec.z = math.Round(vec.z)
					self:SetNWVector("BipodPos", vec)
					self.BipodStartTime = CurTime()
					self.BipodPos = vec
					if self.NextReload then
						self.NextReload = nil
						self:SetReady(true)
					end

					if IsValid(tr.Entity) then self.BipodEntity = tr.Entity end
					if self.BipodPlaceAnim then
						if not (self.BipodPlaceAnimEmpty and self:Clip1() == 0) then
							self:DoBFSAnimation(self.BipodPlaceAnim)
						else
							self:DoBFSAnimation(self.BipodPlaceAnimEmpty)
						end
					end

					if self.BipodFireAnim then
						local temp = self.BipodFireAnim
						self.BipodFireAnim = self.FireAnim
						self.FireAnim = temp
					end

					if self.BipodIronFireAnim then
						local temp = self.BipodIronFireAnim
						self.BipodIronFireAnim = self.IronFireAnim
						self.IronFireAnim = temp
					end

					if self.BipodReloadRate then
						local temp = self.BipodReloadRate
						self.BipodReloadRate = self.ReloadRate
						self.ReloadRate = temp
					end

					if self.BipodReloadSounds then
						local temp = self.BipodReloadSounds
						self.BipodReloadSounds = self.ReloadSounds
						self.ReloadSounds = temp
					end

					if self.BipodDeploySound then timer.Simple(self.BipodDeploySound[1], function() self:GetOwner():EmitSound(self.BipodDeploySound[2], 55, 100) end) end
					self:SetNextPrimaryFire(CurTime() + 1.25)
					break
				end
			end
		else
			self.NextBipodTime = CurTime() + 1.75
			self:SetNWVector("BipodPos", Vector())
			self.BipodStartTime = CurTime()
			self.BipodPos = nil
			self.BipodEntity = nil
			if self.NextReload then
				self.NextReload = nil
				self:SetReady(true)
			end

			if self.BipodRemoveAnim then
				if not (self.BipodRemoveAnimEmpty and self:Clip1() == 0) then
					self:DoBFSAnimation(self.BipodRemoveAnim)
				else
					self:DoBFSAnimation(self.BipodRemoveAnimEmpty)
				end
			end

			if self.BipodFireAnim then
				local temp = self.BipodFireAnim
				self.BipodFireAnim = self.FireAnim
				self.FireAnim = temp
			end

			if self.BipodIronFireAnim then
				local temp = self.BipodIronFireAnim
				self.BipodIronFireAnim = self.IronFireAnim
				self.IronFireAnim = temp
			end

			if self.BipodReloadRate then
				local temp = self.BipodReloadRate
				self.BipodReloadRate = self.ReloadRate
				self.ReloadRate = temp
			end

			if self.BipodReloadSounds then
				local temp = self.BipodReloadSounds
				self.BipodReloadSounds = self.ReloadSounds
				self.ReloadSounds = temp
			end

			if self.BipodRemoveSound then timer.Simple(self.BipodRemoveSound[1], function() if IsValid(self) then self:GetOwner():EmitSound(self.BipodRemoveSound[2], 55, 100) end end) end
			self:SetNextPrimaryFire(CurTime() + 1.25)
		end
	end
end

if CLIENT then
	local LastAimGotten = 0
	local LastSuicideGotten = 0
	local LastSprintGotten = 0
	local LastBipodGotten = 0
	local LastBipodPos = Vector(0, 0, 0)
	local LastAngGotten = Angle(0, 0, 0)

	function SWEP:GetViewModelPosition(pos, ang)
		if LocalPlayer() ~= self:GetOwner() then self:Think() end
		local FrontBlocked = self.FrontBlocked or 0
		local FrontBlockedPerc = self.FrontBlockedPerc or 0
		local Sprint = math.Clamp(self.SprintingWeapon / 100, 0, 1)
		local AimGotten = Lerp(.05, LastAimGotten, self.AimPerc / 100)
		LastAimGotten = AimGotten
		local Bipod = Lerp(.05, LastBipodGotten, self.BipodAmt / 100)
		LastBipodGotten = Bipod
		local Aim = AimGotten
		local SuicideGotten = Lerp(.05, LastSuicideGotten, self.SuicideAmt / 100)
		LastSuicideGotten = SuicideGotten
		local Suicide = SuicideGotten
		local Up, Forward, Right = ang:Up(), ang:Forward(), ang:Right()
		local SprintGotten = Lerp(.05, LastSprintGotten, (self.SprintingWeapon / 100) * (1 - FrontBlocked * (1 - Sprint)) + FrontBlockedPerc * (1 - Sprint))
		LastSprintGotten = SprintGotten
		local Sprint = SprintGotten
		if self.InertiaScale ~= 0 then
			if oldAng == nil then oldAng = ang end
			if angDiff == nil then angDiff = Angle(0, 0, 0) end
			local sensitivity, strength = self.CarryWeight / 714, self.CarryWeight / 300
			angDiff = LerpAngle(math.Clamp(FrameTime(), 0, 1), angDiff, ang - oldAng)
			oldAng = ang
			ang = ang - angDiff * sensitivity * -0.4
			self.AngleWeapon = ang
		end

		ang:RotateAroundAxis(Right, self.SprintAng.p * Sprint)
		ang:RotateAroundAxis(Up, self.SprintAng.y * Sprint)
		ang:RotateAroundAxis(Forward, self.SprintAng.r * Sprint)
		if self.SuicideAng then
			ang:RotateAroundAxis(ang:Right(), self.SuicideAng.p * Suicide)
			ang:RotateAroundAxis(ang:Up(), self.SuicideAng.y * Suicide)
			ang:RotateAroundAxis(ang:Forward(), self.SuicideAng.r * Suicide)
		end

		if self.AimAng then
			ang:RotateAroundAxis(Right, self.AimAng.p * Aim)
			ang:RotateAroundAxis(Up, self.AimAng.y * Aim)
			ang:RotateAroundAxis(Forward, self.AimAng.r * Aim)
		end

		local kposAdd = Vector(0, 0, 0)
		if self:GetNWBool("Suppressor") and self.SuicideSuppr then kposAdd = self.SuicideSuppr end
		local aimPos = self.AttAimPos or self.AimPos
		if Bipod > 0.1 then aimPos = Vector(0, 0, 0) end
		local npos = LerpVector(Aim, Vector(0, 0, 0), aimPos)
		local spos = LerpVector(Sprint, Vector(0, 0, 0), self.SprintPos)
		local kpos = LerpVector(Suicide, Vector(0, 0, 0), (self.SuicidePos or Vector(0, 0, 0)) + kposAdd)
		local curbipodPos = self:GetNWVector("BipodPos")
		local bipodPos = LerpVector(Bipod, Vector(0, 0, 0), LastBipodPos + Vector(0, 0, self.BipodOffset) - self:GetOwner():GetAimVector() * self.BarrelLength - pos)
		if curbipodPos ~= Vector() then
			LastBipodPos = curbipodPos
			self.CurVmPos = pos + Right * (npos[1] + spos[1] + kpos[1]) + Forward * (npos[2] + spos[2] + kpos[2]) + Up * (npos[3] + spos[3] + kpos[3]) + bipodPos
			self.CurVmAng = ang
		end
		return pos + Right * (npos[1] + spos[1] + kpos[1]) + Forward * (npos[2] + spos[2] + kpos[2]) + Up * (npos[3] + spos[3] + kpos[3]) + bipodPos, ang
	end

	-- тут была старая система прицельных сеток

	function SWEP:FireAnimationEvent(pos, ang, event, name)
		return true
	end
	-- I do all this, bitch
end

local laserline = Material("cable/smoke")
local laserdot = Material("effects/tfalaserdot")
SWEP.LaserDistance = 6000
SWEP.LaserFOV = 1.5
SWEP.LaserColor = Color(255, 0, 0, 255)
function SWEP:DrawLaser()
	if not IsValid(self.Owner) then return end
	local pos, ang = self.WDrawnAttachments["Laser"]:GetPos(), self.WDrawnAttachments["Laser"]:GetAngles()

	if self.WDrawnAttachments["Laser"]:GetModel() == "models/cw2/attachments/anpeq15.mdl" then
		ang:RotateAroundAxis(ang:Right(), 180)
	end

	local ply = self.Owner

	if not IsValid(ply.HMCDLaserDot) then
		local lamp = ProjectedTexture()
		ply.HMCDLaserDot = lamp
		lamp:SetTexture(laserdot:GetString("$basetexture"))
		lamp:SetFarZ(self.LaserDistance) -- How far the light should shine
		lamp:SetFOV(self.LaserFOV)
		lamp:SetPos(pos)
		lamp:SetAngles(ang)
		lamp:SetBrightness(15)
		lamp:SetNearZ(1)
		lamp:SetEnableShadows(false)
		lamp:Update()
		self.LastLaserUpdate = CurTime()
		local entIndex = ply:EntIndex()

		hook.Add("Think", "Laserdot_" .. entIndex, function()
			if not (IsValid(ply) and IsValid(lamp) and IsValid(self) and self.LastLaserUpdate) then
				hook.Remove("Think", "Laserdot_" .. entIndex)
			end

			if self.LastLaserUpdate and self.LastLaserUpdate + 0.1 < CurTime() then
				lamp:Remove()
			end
		end)
	end

	local lamp = ply.HMCDLaserDot

	if IsValid(lamp) then
		ang:RotateAroundAxis(ang:Forward(), math.Rand(-180, 180))
		lamp:SetPos(pos)
		lamp:SetAngles(ang)
		lamp:SetColor(self.LaserColor)
		lamp:SetFOV(self.LaserFOV * math.Rand(0.9, 1.1))
		lamp:Update()
		self.LastLaserUpdate = CurTime()
	end
end

function SWEP:CleanLaser()
	local own = self:GetOwner()

	if IsValid(own) and IsValid(own.HMCDLaserDot) then
		own.HMCDLaserDot:Remove()
	end
end