if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
else
	killicon.AddFont("wep_jack_hmcd_assaultrifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/cw_doi_flamethrower_american")
end

SWEP.Base = "wep_cat_base"
SWEP.PrintName = "M2 Flamethrower2"
SWEP.Category = "HMCD: Union - WTF"
SWEP.Instructions = "An absurdly powerful weapon, this aluminum/polymer 5.56x45mm semi-automatic home-assembled 30-round-capacity rifle is the quintessence of an armed American citizenry in the early 21st century.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 600
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/v_flame_m2a3.mdl"
SWEP.WorldModel = "models/weapons/w_flame_m2.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 1
SWEP.ViewModelFOV = 80
SWEP.SprintPos = Vector(9, -1, -3)
SWEP.SprintAng = Angle(-20, 60, -40)
SWEP.AimPos = Vector(-2.1, 2, 2)
SWEP.AimAng = Angle(0, -7, 0)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.AltAimPos = Vector(-1.902, -3.2, .13)
SWEP.ReloadTime = 4.25
SWEP.ReloadRate = .6
SWEP.AmmoType = "SMG1"
SWEP.TriggerDelay = .1
SWEP.CycleTime = .05
SWEP.Recoil = .5
SWEP.Supersonic = true
SWEP.Accuracy = .999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_flamethrower"
SWEP.FuckedWorldModel = true
SWEP.DrawAnim = "base_draw"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.CloseFireSound = ""
SWEP.FarFireSound = ""
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.FireAnimRate = 3
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HoldType = "shotgun"
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_mrifle2"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot = 1
SWEP.HolsterPos = Vector(3, -9, -4)
SWEP.HolsterAng = Angle(140, 10, 180)
SWEP.CarryWeight = 4500
SWEP.Primary.Automatic = true

if SERVER then
	util.AddNetworkString('AI_FLAMETHROWER_SHOOT')
end

function SWEP:IndividualThink()
end

--
-------==========================================
function SWEP:ModifiedIgnite(ent, ignitetime)
	ent:Ignite(ignitetime)

	if timer.Exists(tostring(ent) .. "IgniteTimer") then
		timer.Remove(tostring(ent) .. "IgniteTimer")
	end

	timer.Create(tostring(ent) .. "IgniteTimer", ignitetime, 1, function() end)
end

function SWEP:Think()
	--[[local Sprintin,Aimin,AimAmt,SprintAmt=self:GetOwner():KeyDown(IN_SPEED),self:GetOwner():KeyDown(IN_ATTACK2),self:GetAiming(),self:GetSprinting()
		if(((Sprintin)or(self:FrontBlocked()))and(self:GetReady()))then
			self:SetSprinting(math.Clamp(SprintAmt+40*(1/(self.BearTime)),0,100))
			self:SetAiming(math.Clamp(AimAmt-40*(1/(self.AimTime)),0,100))
		elseif((Aimin)and(self:GetOwner():OnGround())and(self.Alt==0)and not((self.CycleType=="manual")and(self.LastFire+.75>CurTime())))then
			self:SetAiming(math.Clamp(AimAmt+20*(1/(self.AimTime)),0,100))
			self:SetSprinting(math.Clamp(SprintAmt-20*(1/(self.BearTime)),0,100))
		else
			self:SetAiming(math.Clamp(AimAmt-40*(1/(self.AimTime)),0,100))
			self:SetSprinting(math.Clamp(SprintAmt-20*(1/(self.BearTime)),0,100))
		end
		local HoldType=self.HipHoldType
		if(SprintAmt>90)then
			HoldType=self.DownHoldType
		elseif((Aimin)and not(self:GetOwner():Crouching()))then
			HoldType=self.AimHoldType
		else
			HoldType=self.HipHoldType
		end]]
	--
	--self:SetHoldType(HoldType)
	self.FireLoopSound = CreateSound(self, 'weapons/flamethrower/flamethrower_loop.wav')

	if self.LastShoot and self.LastShoot > CurTime() and CLIENT then
		local dlight = DynamicLight(LocalPlayer():EntIndex())

		if dlight then
			dlight.pos = self:GetOwner():GetShootPos() + self:GetOwner():EyeAngles():Forward() * 40 + self:GetOwner():EyeAngles():Right() * 4 - self:GetOwner():EyeAngles():Up() * 5
			dlight.r = 255
			dlight.g = 200
			dlight.b = 0

			if self.intenseflamessama == 1 then
				dlight.brightness = 2
			else
				dlight.brightness = 1
			end

			dlight.Decay = 2000
			dlight.Size = 275
			dlight.DieTime = CurTime() + 0.6
		end
	end

	if self.LastShoot and self.LastShoot > CurTime() and self.IsShooting then
		if SERVER then
			net.Start('AI_FLAMETHROWER_SHOOT')
			net.WriteEntity(self)
			net.Send(self:GetOwner())
		end

		if SERVER then
			local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 120, {self:GetOwner()})

			local ent = Tr.Entity

			if IsValid(ent) then
				if (ent:IsPlayer() and ent ~= self:GetOwner()) or ent:IsNPC() or ent:GetClass() == 'prop_physics' or ent:GetClass() == 'prop_ragdoll' and (not ent.NextIgniteTime or ent.NextIgniteTime < CurTime()) then
					local timeleft = 0

					if timer.Exists(tostring(ent) .. "IgniteTimer") then
						timeleft = timer.TimeLeft(tostring(ent) .. "IgniteTimer")
					end

					self:ModifiedIgnite(ent, timeleft + 1)
					ent.NextIgniteTime = CurTime() + 0.5
				end
			end
		end
	end

	if self.LastShoot and self.LastShoot < CurTime() and self.IsShooting then
		if self.FireLoopSound then
			self.FireLoopSound:FadeOut(0.5)

			timer.Simple(0.5, function()
				if IsValid(self) then
					self.FireLoopSound:Stop()
				end
			end)
		end

		self.IsShooting = false
		self:EmitSound('weapons/flamethrower/flamethrower_end.wav')
	end

	-----------------
	if self:GetOwner():InVehicle() then
		self.dt.State = CW_ACTION

		return
	end

	if self.dt.State == CW_HOLSTER_START or self.dt.State == CW_HOLSTER_END then
		if IsValid(self.SwitchWep) then
			if self.HolsterDelay and CurTime() > self.HolsterDelay then
				self.dt.State = CW_HOLSTER_END

				if CLIENT then
					self:GetOwner():ConCommand("use " .. self.SwitchWep:GetClass())
				else
					self:GetOwner():SelectWeapon(self.SwitchWep:GetClass())
				end

				self.HolsterDelay = nil
			end
		else
			self.SwitchWep = nil
		end

		return
	end

	CT = CurTime()

	if CLIENT then
		if self.SubCustomizationCycleTime then
			if UnPredictedCurTime() > self.SubCustomizationCycleTime then
				CustomizableWeaponry.cycleSubCustomization(self)
			end
		end
	end

	if self.HoldToAim then
		if (SP and SERVER) or not SP then
			if self.dt.State == CW_AIMING then
				if not self:GetOwner():OnGround() or 1 >= self:GetOwner():GetWalkSpeed() * self.LoseAimVelocity or not self:GetOwner():KeyDown(IN_ATTACK2) then
					self.dt.State = CW_IDLE
					self:SetNextSecondaryFire(CT + 0.2)
					self:EmitSound("CW_LOWERAIM")
				end
			end
		end
	end

	if self.IndividualThink then
		self:IndividualThink()
	end

	IFTP = IsFirstTimePredicted()

	if CT > self.GlobalDelay then
		wl = self:GetOwner():WaterLevel()

		if self:GetOwner():OnGround() then
			if wl >= 3 and self.HolsterUnderwater then
				if self.ShotgunReloadState == 1 then
					self.ShotgunReloadState = 2
				end

				self.dt.State = CW_ACTION
				self.FromActionToNormalWait = CT + 0.3
			else
				ws = self:GetOwner():GetWalkSpeed()

				if self.dt.State ~= CW_AIMING and self.dt.State ~= CW_CUSTOMIZE then
					if CT > self.FromActionToNormalWait then
						if self.dt.State ~= CW_IDLE then
							self.dt.State = CW_IDLE

							if not self.ReloadDelay then
								self:SetNextPrimaryFire(CT + 0.3)
								self:SetNextSecondaryFire(CT + 0.3)
								self.ReloadWait = CT + 0.3
							end
						end
					end
				end
			end
		else
			if (wl > 1 and self.HolsterUnderwater) or (self:GetOwner():GetMoveType() == MOVETYPE_LADDER and self.HolsterOnLadder) then
				if self.ShotgunReloadState == 1 then
					self.ShotgunReloadState = 2
				end

				self.dt.State = CW_ACTION
				self.FromActionToNormalWait = CT + 0.3
			else
				if CT > self.FromActionToNormalWait then
					if self.dt.State ~= CW_IDLE then
						self.dt.State = CW_IDLE
						self:SetNextPrimaryFire(CT + 0.3)
						self:SetNextSecondaryFire(CT + 0.3)
						self.ReloadWait = CT + 0.3
					end
				end
			end
		end
	end

	if SERVER then
		if self.CurSoundTable then
			local t = self.CurSoundTable[self.CurSoundEntry]

			--[[if CLIENT then
				if CT >= self.SoundTime + t.time / self.SoundSpeed then
					self:EmitSound(t.sound, 70, 100)
					if self.CurSoundTable[self.CurSoundEntry + 1] then
						self.CurSoundEntry = self.CurSoundEntry + 1
					else
						self.CurSoundTable = nil
						self.CurSoundEntry = nil
						self.SoundTime = nil
					end
				end
			else]]
			--
			if CT >= self.SoundTime + t.time / self.SoundSpeed then
				self:EmitSound(t.sound, 70, 100)

				if self.CurSoundTable[self.CurSoundEntry + 1] then
					self.CurSoundEntry = self.CurSoundEntry + 1
				else
					self.CurSoundTable = nil
					self.CurSoundEntry = nil
					self.SoundTime = nil
				end
			end
			--end
		end
	end

	if self.dt.Shots > 0 then
		if not self:GetOwner():KeyDown(IN_ATTACK) then
			if self.BurstAmount and self.BurstAmount > 0 then
				self.dt.Shots = 0
				self:SetNextPrimaryFire(CT + self.FireDelay * self.BurstCooldownMul)
				self.ReloadWait = CT + self.FireDelay * self.BurstCooldownMul
			end
		end
	end

	if not self.ShotgunReload then
		if self.ReloadDelay and CT >= self.ReloadDelay then
			self:finishReload() -- more like finnishReload ;0
		end
	end

	if IFTP then
		--[[SWEP.AimBreathingIntensity = 1
	SWEP.CurBreatheIntensity = 1
	SWEP.BreathLeft = 1
	SWEP.BreathRegenRate = 10
	SWEP.BreathDrainRate = 5
	SWEP.BreathIntensityDrainRate = 10
	SWEP.BreathIntensityRegenRate = 10]]
		--
		if self.ShotgunReloadState == 1 then
			if self:GetOwner():KeyPressed(IN_ATTACK) then
				self.ShotgunReloadState = 2
			end

			if CT > self.ReloadDelay then
				self:sendWeaponAnim("insert")

				if SERVER and not SP then
					self:GetOwner():SetAnimation(PLAYER_RELOAD)
				end

				mag, ammo = self:Clip1(), self:GetOwner():GetAmmoCount(self.Primary.Ammo)

				if SERVER then
					self:SetClip1(mag + 1)
					self:GetOwner():SetAmmo(ammo - 1, self.Primary.Ammo)
				end

				self.ReloadDelay = CT + self.InsertShellTime

				if mag + 1 == self.Primary.ClipSize or ammo - 1 == 0 then
					self.ShotgunReloadState = 2
				end
			end
		elseif self.ShotgunReloadState == 2 then
			if CT > self.ReloadDelay then
				if not self.WasEmpty then
					self:sendWeaponAnim("idle")
					self.ShotgunReloadState = 0
					self:SetNextPrimaryFire(CT + 0.25)
					self:SetNextSecondaryFire(CT + 0.25)
					self.ReloadWait = CT + 0.25
					self.ReloadDelay = nil
				else
					self:sendWeaponAnim("reload_end")
					self.ShotgunReloadState = 0
					self:SetNextPrimaryFire(CT + self.ReloadFinishWait)
					self:SetNextSecondaryFire(CT + self.ReloadFinishWait)
					self.ReloadWait = CT + self.ReloadFinishWait
					self.ReloadDelay = nil
				end
			end
		end
	end

	if SERVER then
		if self.dt.Safe then
			if self.CHoldType ~= self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
				if self.CHoldType ~= self.RunHoldType then
					self:SetHoldType(self.RunHoldType)
					self.CHoldType = self.RunHoldType
				end
			else
				if self.CHoldType ~= self.NormalHoldType then
					self:SetHoldType(self.NormalHoldType)
					self.CHoldType = self.NormalHoldType
				end
			end
		end
	end

	-- if it's SP, then we run it only on the server (otherwise shit gets fucked); if it's MP we predict it
	if (SP and SERVER) or not SP then
		if self.dt.BipodDeployed or self.DeployAngle then
			if not self:CanRestWeapon(self.BipodDeployHeightRequirement) then
				self.dt.BipodDeployed = false
				self.DeployAngle = nil

				if not self.ReloadDelay then
					if CT > self.BipodDelay then
						self:performBipodDelay(self.BipodUndeployTime)
					else
						self.BipodUnDeployPost = true
					end
				else
					self.BipodUnDeployPost = true
				end
			end
		end

		if not self.ReloadDelay then
			if self.BipodUnDeployPost then
				if CT > self.BipodDelay then
					if not self:CanRestWeapon(self.BipodDeployHeightRequirement) then
						self:performBipodDelay(self.BipodUndeployTime)
						self.BipodUnDeployPost = false
					else
						self.dt.BipodDeployed = true
						self:setupBipodVars()
						self.BipodUnDeployPost = false
					end
				end
			end

			if self:GetOwner():KeyPressed(IN_USE) then
				if CT > self.BipodDelay and CT > self.ReloadWait then
					if self.BipodInstalled then
						if self.dt.BipodDeployed then
							self.dt.BipodDeployed = false
							self.DeployAngle = nil
							self:performBipodDelay(self.BipodUndeployTime)
						else
							self.dt.BipodDeployed = self:CanRestWeapon(self.BipodDeployHeightRequirement)

							if self.dt.BipodDeployed then
								self:performBipodDelay(self.BipodDeployTime)
								self:setupBipodVars()
							end
						end
					end
				end
			end
		end
	end
	-----------
end

function SWEP:OnDrop()
	local loopsound = self.FireLoopSound

	if loopsound then
		loopsound:FadeOut(0.5)

		timer.Simple(0.5, function()
			if loopsound then
				loopsound:Stop()
			end
		end)
	end

	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent:Spawn()
	Ent:Activate()
	Ent.RoundsInMag = self:Clip1()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

--++++++++++++++
function SWEP:PrimaryAttack()
	self.ReloadInterrupted = true
	if not self:GetReady() then return end

	--if(self:GetSprinting()>10)then return end
	if not (self:Clip1() > 0) then
		self:EmitSound("snd_jack_hmcd_click.wav", 55, 100)
		self:SetNextPrimaryFire(CurTime() + 0.1)

		if SERVER then
			umsg.Start("HMCD_AmmoShow", self:GetOwner())
			umsg.End()
		end

		return
	end

	if self.noreloadsama == 1 then
		if self.intenseflamessama == 1 then
			if self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 3 then return end
		else
			if self:GetOwner():GetAmmoCount(self.Primary.Ammo) <= 0 then return end
		end
	else
		if not self:CanPrimaryAttack() then return end
	end

	if self:GetOwner():WaterLevel() >= 3 then return end
	self:DoBFSAnimation("base_dryfire")
	ParticleEffect('alien_flamethrower_fire_start', self:GetOwner():GetShootPos() + self:GetOwner():EyeAngles():Forward() * 50 + self:GetOwner():EyeAngles():Right() * 7 - self:GetOwner():EyeAngles():Up() * 15, self:GetOwner():EyeAngles(), self)
	self:EmitSound('weapons/flamethrower/flamethrower_loop.wav')
	--[[if(self:Clip1() % 21) == 0 then
		local Fire=ents.Create("ent_jack_hmcd_fire")
			local Pos = self:LocalToWorld(self:OBBCenter())
			Fire.HmcdSpawned=self.HmcdSpawned
			Fire.Initiator=self:GetOwner()
			Fire.SuperSmall=true
			Fire:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():EyeAngles():Forward() * 200 + self:GetOwner():EyeAngles():Right() * 7 - self:GetOwner():EyeAngles():Up() * 15)
			Fire:Spawn()
			Fire:Activate()
		end]]
	self.IsShooting = true
	self.LastShoot = CurTime() + 0.15

	if self.intenseflamessama == 1 then
		self:TakePrimaryAmmo(4)
	else
		self:TakePrimaryAmmo(1)
	end

	--		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	--		self:SendWeaponAnim( PLAYER_ATTACK1 )
	--		if self.fireAnimFunc then
	--			self:fireAnimFunc()
	--		else
	--			if self.dt.State == CW_AIMING then
	--				if self.ADSFireAnim then
	--					self:playFireAnim()
	--				end
	--			else
	--				self:playFireAnim()
	--			end
	--		end
	--		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:SetNextPrimaryFire(CurTime() + 0.08)
end

-------==========================================
function SWEP:DrawWorldModel()
	if IsValid(self:GetOwner()) then
		if self.FuckedWorldModel then
			if not self.WModel then
				self.WModel = ClientsideModel(self.WorldModel)
				self.WModel:SetPos(self:GetOwner():GetPos())
				self.WModel:SetParent(self:GetOwner())
				self.WModel:SetNoDraw(true)
			else
				local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

				if pos and ang then
					self.WModel:SetRenderOrigin(pos + ang:Right() + ang:Up())
					ang:RotateAroundAxis(ang:Forward(), 180)
					ang:RotateAroundAxis(ang:Right(), 10)
					self.WModel:SetRenderAngles(ang)
					self.WModel:DrawModel()
				end
			end
		else
			self:DrawModel()
		end
	end
end