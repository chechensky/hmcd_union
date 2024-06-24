--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_m249.lua
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
	killicon.AddFont("wep_jack_hmcd_assaultrifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/inventory/weapon_m249")
end

SWEP.IconTexture = "vgui/inventory/weapon_m249"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "M249"
SWEP.Instructions = "This is a gas-operated, air-cooled, belt-fed, automatic weapon that fires 5.56x45mm rounds.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.DefaultClip = 200
SWEP.Primary.ClipSize = 200
SWEP.ViewModel = "models/weapons/v_m249.mdl"
SWEP.WorldModel = "models/weapons/w_m249.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 90
SWEP.ViewModelFOV = 80
SWEP.Primary.Automatic = true
SWEP.SprintPos = Vector(9, -1, -3)
SWEP.SprintAng = Angle(-20, 60, -40)
SWEP.AimPos = Vector(-2.05, -2, 0.95)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.AltAimPos = Vector(-1.902, -3.2, .13)
SWEP.ReloadTime = 17.5
SWEP.ReloadRate = 1
SWEP.UseHands = true
SWEP.ReloadSound = "snd_jack_hmcd_arreload.wav"
SWEP.AmmoType = "SMG1"
SWEP.TriggerDelay = .059
SWEP.CycleTime = 0
SWEP.Recoil = .5
SWEP.AttBone = "LidCont"
SWEP.Category="HMCD: Union - Machine Guns"
SWEP.LaserAngle = Angle(-90.65, -90, 0.6)
SWEP.Supersonic = true
SWEP.Accuracy = .999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_m249"
SWEP.FuckedWorldModel = true
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "base_draw"
SWEP.FireAnim = "base_fire_1"
SWEP.IronFireAnim = "iron_fire_1"
SWEP.BipodFireAnim = "deployed_fire_1"
SWEP.BipodIronFireAnim = "deployed_iron_fire_1"
SWEP.ReloadAnimEmpty = "base_reload_empty"
SWEP.ReloadAnim = "base_reload"
SWEP.ReloadAnimHalf = "base_reload_half"
SWEP.BipodReloadAnimEmpty = "deployed_reload_empty"
SWEP.BipodReloadAnim = "deployed_reload"
SWEP.BipodReloadAnimHalf = "deployed_reload_half"
SWEP.CloseFireSound = "rifle_win1892/win1892_fire_01.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_ar_far.wav"
--SWEP.CloseFireSound="m249/m249_fp.wav"
SWEP.ShellAttachment = 3
SWEP.FarFireSound = "m249/m249_dist.wav"
SWEP.SuppressedFireSound = "m249/m249_suppressed_fp.wav"
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.FireAnimRate = 1
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "pcf_jack_mf_mrifle2"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(4,-9,-4)
SWEP.HolsterAng=Angle(160,10,190)
SWEP.CarryWeight = 6000
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.NextFireTime = 0
SWEP.ShellEffect = "eff_jack_hmcd_556"
SWEP.ShellEffect2 = "eff_jack_hmcd_m249link"
SWEP.BipodFireAnim = "deployed_fire_" .. math.random(1, 2) .. ""
SWEP.BipodIronFireAnim = "deployed_iron_fire_" .. math.random(1, 2) .. ""
SWEP.InsHands = true

SWEP.MuzzlePos = {25.5, -5.1 - 4.1}

SWEP.BulletDir = {400, 2, -1.5}

SWEP.BipodUsable = true
SWEP.BipodPlaceAnim = "deployed_in"
SWEP.BipodRemoveAnim = "deployed_out"

SWEP.BipodDeploySound = {.5, "weapons/m249/handling/m249_bipoddeploy.wav"}

SWEP.BipodRemoveSound = {.5, "weapons/m249/handling/m249_bipodretract.wav"}

SWEP.BipodOffset = 10
SWEP.BipodAimOffset = Vector(0, 2.05, -0.95)
SWEP.SuicidePos = Vector(3.5, 6.5, -29)
SWEP.SuicideAng = Angle(100, 0, 90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"

SWEP.MuzzleInfo = {
	["Bone"] = "A_Muzzle",
	["Offset"] = Vector(30, 2, -2)
}

SWEP.Attachments = {
	["Owner"] = {
		["Suppressor"] = {
			bone = "A_Suppressor",
			pos = {
				right = 11,
				forward = -2.05,
				up = -0.05
			},
			ang = {
				up = 180,
				right = 90
			},
			scale = .7,
			model = "models/cw2/attachments/556suppressor.mdl",
			num = HMCD_RIFLESUPP
		},
		["Laser"] = {
			bone = "LidCont",
			pos = {
				right = -4,
				forward = -0.2,
				up = 0.3
			},
			ang = {
				up = 90
			},
			scale = .5,
			model = "models/cw2/attachments/anpeq15.mdl",
			aimpos = Vector(-2.05, -1.5, 0.25),
			bipodpos = Vector(0, 2, -0.2),
			num = HMCD_LASERBIG
		},
		["Sight"] = {
			bone = "LidCont",
			pos = {
				right = -3,
				forward = -0.2,
				up = 0.5
			},
			ang = {
				up = 270
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl",
			sightpos = {
				right = 9.15,
				forward = -0.3,
				up = 1.45
			},
			sightang = {
				up = -90
			},
			aimpos = Vector(-1.95, -1.5, 0.25),
			bipodpos = Vector(0, 2, -0.2),
			num = HMCD_KOBRA
		},
		["Sight2"] = {
			bone = "LidCont",
			pos = {
				right = -3.2,
				forward = -0.2,
				up = 0.5
			},
			ang = {
				up = 270
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl",
			sightpos = {
				right = 9.15,
				forward = -0.3,
				up = 1.5
			},
			sightang = {
				up = -90
			},
			aimpos = Vector(-1.95, -1.5, 0.17),
			bipodpos = Vector(0, 2, -.05),
			num = HMCD_AIMPOINT
		},
		["Sight3"] = {
			bone = "LidCont",
			pos = {
				right = -3.2,
				forward = -0.2,
				up = 0.5
			},
			ang = {
				up = 270
			},
			scale = .7,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl",
			sightpos = {
				right = 9.15,
				forward = -0.3,
				up = 1.55
			},
			sightang = {
				up = -90
			},
			aimpos = Vector(-1.95, -1.5, 0.15),
			bipodpos = Vector(0, 2, -.05),
			num = HMCD_EOTECH
		}
	},
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				forward = 5,
				up = -1
			},
			ang = {
				forward = 180,
			}
		},
		["Suppressor"] = {
			pos = {
				forward = 13.5,
				up = -7.4,
				right = 1.1
			},
			ang = {
				right = 270,
				up = 90,
				forward = 270
			},
			scale = .9,
			model = "models/cw2/attachments/556suppressor.mdl"
		},
		["Laser"] = {
			pos = {
				forward = 7,
				up = -6.4,
				right = 1.2
			},
			ang = {
				forward = 180,
				up = 180
			},
			scale = .9,
			model = "models/cw2/attachments/anpeq15.mdl"
		},
		["Sight"] = {
			pos = {
				forward = 6,
				up = -6.4,
				right = 1
			},
			ang = {
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
		},
		["Sight2"] = {
			pos = {
				forward = 6,
				up = -6.6,
				right = 1
			},
			ang = {
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
		},
		["Sight3"] = {
			pos = {
				forward = 6,
				up = -6.6,
				right = 1
			},
			ang = {
				forward = 180
			},
			scale = .9,
			model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
		}
	}
}

function SWEP:Reload()
	self.ReloadInterrupted = false
	if not IsFirstTimePredicted() then return end
	if not (IsValid(self) and IsValid(self:GetOwner())) then return end
	if not self:GetReady() then return end
	if self.SprintingWeapon > 0 then return end

	if CLIENT then
		LocalPlayer().AmmoShow = CurTime() + 2
	end

	if (self:Clip1() < self.Primary.ClipSize) and (self:GetOwner():GetAmmoCount(self.AmmoType) > 0) then
		local TacticalReload = self:Clip1() > 0
		self:SetReady(false)
		self:GetOwner():SetAnimation(PLAYER_RELOAD)

		if SERVER then
			-- Reload type when there's no ammo left and you still have plenty in reserve
			if self:GetOwner():GetViewModel():GetBodygroup(1) == 0 then
				self.ReloadTime = 9

				timer.Simple(1, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_boltback.wav", 65, 100)
				end)

				timer.Simple(1.3, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_boltrelease.wav", 65, 100)
				end)

				timer.Simple(2.8, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_coveropen.wav", 65, 100)
				end)

				timer.Simple(4, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_magout.wav", 65, 100)
				end)

				timer.Simple(5, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_fetchmag.wav", 65, 100)

					if self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1() >= 16 then
						self:GetOwner():GetViewModel():SetBodygroup(1, 16)
					end

					if self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1() < 16 then
						self:GetOwner():GetViewModel():SetBodygroup(1, self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1())
					end
				end)

				timer.Simple(6.7, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_magin.wav", 65, 100)
				end)

				timer.Simple(7.7, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_bulletjingle.wav", 65, 100)
				end)

				timer.Simple(9.02, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_coverclose.wav", 65, 100)
				end)
			end

			-- Reload type when there's more than 15 bullets left in the belt and you still have plenty in reserve
			if self:GetOwner():GetViewModel():GetBodygroup(1) == 16 then
				self.ReloadTime = 9

				timer.Simple(0.9, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_coveropen.wav", 65, 100)
				end)

				timer.Simple(2, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_magout.wav", 65, 100)
				end)

				timer.Simple(3, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_fetchmag.wav", 65, 100)

					if self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1() >= 16 then
						self:GetOwner():GetViewModel():SetBodygroup(1, 16)
					end

					if self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1() < 16 then
						self:GetOwner():GetViewModel():SetBodygroup(1, self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1())
					end
				end)

				timer.Simple(4.7, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_magin.wav", 65, 100)
				end)

				timer.Simple(5.5, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_bulletjingle.wav", 65, 100)
				end)

				timer.Simple(7, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_coverclose.wav", 65, 100)
				end)
			end

			-- Reload type when there's more than 0, but less than 16 bullets left and still plenty of ammo in reserve
			if self:GetOwner():GetViewModel():GetBodygroup(1) ~= 16 and self:GetOwner():GetViewModel():GetBodygroup(1) ~= 0 then
				self.ReloadTime = 9

				timer.Simple(0.9, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_coveropen.wav", 65, 100)
				end)

				timer.Simple(1.9, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_beltremove.wav", 65, 100)
				end)

				timer.Simple(3, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_magout.wav", 65, 100)
				end)

				timer.Simple(4, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_fetchmag.wav", 65, 100)

					if self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1() >= 16 then
						self:GetOwner():GetViewModel():SetBodygroup(1, 16)
					end

					if self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1() < 16 then
						self:GetOwner():GetViewModel():SetBodygroup(1, self:GetOwner():GetAmmoCount(self.AmmoType) + self:Clip1())
					end
				end)

				timer.Simple(5.7, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_magin.wav", 65, 100)
				end)

				timer.Simple(6.5, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_bulletjingle.wav", 65, 100)
				end)

				timer.Simple(7.9, function()
					self.Weapon:EmitSound("weapons/m249/handling/m249_coverclose.wav", 65, 100)
				end)
			end
		end

		if (self.ReloadType == "clip") or (self.ReloadType == "magazine") then
			if self:GetOwner():GetViewModel():GetBodygroup(1) == 16 then
				if self.BipodAmt < 100 then
					self:DoBFSAnimation(self.ReloadAnim)
				else
					self:DoBFSAnimation(self.BipodReloadAnim)
				end
			end

			if self:GetOwner():GetViewModel():GetBodygroup(1) == 0 then
				if self.BipodAmt < 100 then
					self:DoBFSAnimation(self.ReloadAnimEmpty)
				else
					self:DoBFSAnimation(self.BipodReloadAnimEmpty)
				end
			end

			if self:GetOwner():GetViewModel():GetBodygroup(1) ~= 0 and self:GetOwner():GetViewModel():GetBodygroup(1) ~= 16 then
				if self.BipodAmt < 100 then
					self:DoBFSAnimation(self.ReloadAnimHalf)
				else
					self:DoBFSAnimation(self.BipodReloadAnimHalf)
				end
			end

			self:GetOwner():GetViewModel():SetPlaybackRate(self.ReloadRate)

			if SERVER then
				if self.CycleType == "revolving" then
					timer.Simple(self.ReloadTime / 3, function()
						if IsValid(self) and IsValid(self:GetOwner()) then
							for i = 1, self.Primary.ClipSize - self:Clip1() do
								local effectdata = EffectData()
								effectdata:SetOrigin(self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Forearm")))
								effectdata:SetAngles((-vector_up):Angle())
								effectdata:SetEntity(self:GetOwner())
								util.Effect(self.ShellType, effectdata, true, true)
							end
						end
					end)
				end

				local ReloadAdd = 0

				if not TacticalReload then
					ReloadAdd = .2
				end

				self.NextReload = CurTime() + self.ReloadTime + ReloadAdd
			end
		elseif self.ReloadType == "individual" then
			self:SetReloading(true)
			self:ReadyAfterAnim("start_reload")
		end
	end
end