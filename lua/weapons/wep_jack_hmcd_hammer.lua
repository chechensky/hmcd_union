--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_hammer.lua
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
	SWEP.SlotPos = 5
	killicon.AddFont("wep_jack_hmcd_hammer", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

	function SWEP:Initialize()
	end

	--wat
	function SWEP:DrawViewModel()
		return false
	end

	function SWEP:DrawWorldModel()
		self:DrawModel()
	end

	local NailMat = surface.GetTextureID("vgui/hud/hmcd_nail")

	function SWEP:DrawHUD()
		local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

		if self:CanNail(Tr) then
			surface.SetTexture(NailMat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(ScrW() / 2, ScrH() / 2 - 32, 64, 64)
		end
	end
end

SWEP.Base = "wep_jack_hmcd_melee_base"
SWEP.ViewModel = "models/weapons/v_jjife_t.mdl"
SWEP.WorldModel = "models/weapons/w_jjife_t.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_hammer")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_hammer"
SWEP.PrintName = "Claw Hammer"
SWEP.Instructions = "This is a typical clawed carpentry hammer. Use it to put nails into things and build structures. You can also attack with it.\n\nLMB to attack.\nRMB with blunt attack mode to nail.\nRMB with stab attack mode to pull out a nail.\nR+LMB to switch attack mode.\nYou can only nail a thin soft-material item that is closely overlapping another surface.\nNails are stronger than duct tape."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Category="HMCD: Union - Melee"
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 900
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.ENT = "ent_jack_hmcd_hammer"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.AmmoType = "XBowBolt"
SWEP.CanAmmoShow = true

SWEP.UnNailables = {MAT_METAL, MAT_SAND, MAT_SLOSH, MAT_GLASS}

SWEP.CarryWeight = 1000
SWEP.AttackType = "Blunt"
SWEP.NextAttackTypeSwitch = 0
SWEP.DangerLevel = 45
SWEP.DownAmt = 20
SWEP.HoldType = "melee"
SWEP.RunHoldType = "normal"
SWEP.ReachDistance = 60
SWEP.ViewPunch = Angle(3, 0, 0)
SWEP.Force = 125
SWEP.BloodDecals = 1

SWEP.SoftImpactSounds = {
	{
		"Flesh.ImpactHard", 0, 55, {90, 110}
	}
}

SWEP.PrehitViewPunch = Angle(-3, 0, 0)

SWEP.UniversalSound = {
	"snd_jack_hmcd_hammerhit.wav", 0, 60, {90, 110}
}

SWEP.MinDamage = 14
SWEP.MaxDamage = 18

SWEP.MaxMinBluntDamage = {14, 18}

SWEP.MaxMinSlashDamage = {8, 14}

SWEP.DamageForceDiv = 5
SWEP.DrawAnim = "draw"
SWEP.DrawDelay = 1
SWEP.DamageType = DMG_CLUB
SWEP.WooshBeforeHit = false
SWEP.ForceOffset = 4500
SWEP.ArmorMul = .5

function SWEP:CanNail(Tr)
	print(self:GetOwner():GetAmmoCount(self.Primary.Ammo))
	print( (self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0) and Tr.Hit and Tr.Entity and (IsValid(Tr.Entity) or Tr.Entity:IsWorld()) and not (Tr.Entity:IsPlayer() or Tr.Entity:IsNPC()) and not table.HasValue(self.UnNailables, Tr.MatType) )
	return (self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0) and Tr.Hit and Tr.Entity and (IsValid(Tr.Entity) or Tr.Entity:IsWorld()) and not (Tr.Entity:IsPlayer() or Tr.Entity:IsNPC()) and not table.HasValue(self.UnNailables, Tr.MatType)
end

function SWEP:Initialize()
	self:SetAttackType(false)
	self:SetHoldType("melee")
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "AttackType")
end

function SWEP:PrimaryAttack()
	if self:GetOwner():KeyDown(IN_RELOAD) then return end
	local Ent, HitPos, HitNorm = HMCD_WhomILookinAt(self:GetOwner(), .35, 70)

	if not IsFirstTimePredicted() then
		if self.AttackType == "Blunt" then
			if Ent then
				self:DoBFSAnimation("midslash2")
				self:GetOwner():GetViewModel():SetPlaybackRate(.65)
			else
				self:DoBFSAnimation("midslash1")
				self:GetOwner():GetViewModel():SetPlaybackRate(1.5)
			end
		else
			if Ent then
				self:DoBFSAnimation("stab")
				self:GetOwner():GetViewModel():SetPlaybackRate(.65)
			else
				self:DoBFSAnimation("stab_miss")
				self:GetOwner():GetViewModel():SetPlaybackRate(1.5)
			end
		end

		return
	end



	if self.AttackType == "Blunt" then
		if Ent then
			self:DoBFSAnimation("midslash2")
			self:GetOwner():GetViewModel():SetPlaybackRate(.65)
		else
			self:DoBFSAnimation("midslash1")
			self:GetOwner():GetViewModel():SetPlaybackRate(1.5)
		end
	else
		if Ent then
			self:DoBFSAnimation("stab")
			self:GetOwner():GetViewModel():SetPlaybackRate(.65)
		else
			self:DoBFSAnimation("stab_miss")
			self:GetOwner():GetViewModel():SetPlaybackRate(1.5)
		end
	end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:GetOwner():ViewPunch(Angle(-3, 0, 0))

	if SERVER then
		sound.Play("weapons/slam/throw.wav", self:GetOwner():GetPos(), 60, math.random(90, 110))
	end

	timer.Simple(.1, function()
		if IsValid(self) and Ent then
			self:AttackFront()
		end
	end)

	self:SetNextSecondaryFire(CurTime() + 1.5)

	if self.AttackType == "Blunt" then
		if Ent then
			self:SetNextPrimaryFire(CurTime() + 1.5)
		else
			self:SetNextPrimaryFire(CurTime() + 1)
		end
	else
		if Ent then
			self:SetNextPrimaryFire(CurTime() + 2.5)
		else
			self:SetNextPrimaryFire(CurTime() + 1)
		end
	end
end

function SWEP:SecondaryAttack()
	if self:GetOwner():KeyDown(IN_RELOAD) then return end


	if CLIENT and not (self:GetOwner():GetAmmoCount(self.Primary.Ammo) > 0) then
		LocalPlayer().AmmoShow = CurTime() + 3

		return
	end

	if SERVER then
		local ShPos, AimVec = self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector()

		local Tr = util.QuickTrace(ShPos, AimVec * 65, {self:GetOwner()})
		if self.AttackType == "Blunt" then
			if self:CanNail(Tr) then
				print("1")
				local NewTr, NewEnt = util.QuickTrace(Tr.HitPos, AimVec * 10, {self:GetOwner(), Tr.Entity}), nil

				if self:CanNail(NewTr) then
					if not NewTr.HitSky then
						NewEnt = NewTr.Entity
					end

					if NewEnt and (IsValid(NewEnt) or NewEnt:IsWorld()) and not (NewEnt:IsPlayer() or NewEnt:IsNPC() or (NewEnt == Tr.Entity)) then
						if HMCD_IsDoor(Tr.Entity) then
							if self:GetOwner():GetAmmoCount(self.AmmoType) >= 3 then
								Tr.Entity:Fire("lock", "", 0)

								if not Tr.Entity.Nails then
									Tr.Entity.Nails = {}
								end

								for i = 1, 3 do
									table.insert(Tr.Entity.Nails, Tr.Entity:WorldToLocal(Tr.HitPos))
								end

								self:TakePrimaryAmmo(3)
								sound.Play("snd_jack_hmcd_hammerhit.wav", Tr.HitPos, 65, math.random(90, 110))
								self:SprayDecals()
								self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Door Sealed")
								self:GetOwner():ViewPunch(Angle(3, 0, 0))
								self:DoBFSAnimation("midslash2")
								self:GetOwner():SetAnimation(PLAYER_ATTACK1)
								self:GetOwner():GetViewModel():SetPlaybackRate(.75)

								timer.Simple(1, function()
									if IsValid(self) then
										self:DoBFSAnimation("idle")
									end
								end)

								self:SetNextSecondaryFire(CurTime() + 2.5)
								self:SetNextPrimaryFire(CurTime() + 2.5)
							else
								self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Need at least 3 nails to seal door.")
							end
						else
							local Strength = HMCD_BindObjects(Tr.Entity, Tr.HitPos, NewEnt, NewTr.HitPos, 1.5, Tr.PhysicsBone, NewTr.PhysicsBone, self)
							if not Strength then return end
							local ent = Tr.Entity

							if ent:GetClass() == "prop_ragdoll" and ent.fleshy then
								local Dam = DamageInfo()
								Dam:SetAttacker(self:GetOwner())
								Dam:SetInflictor(self.Weapon)
								Dam:SetDamage(2)
								Dam:SetDamageForce(Vector(0, 0, 0))
								Dam:SetDamageType(DMG_SLASH)
								Dam:SetDamagePosition(Tr.HitPos)
								ent:TakeDamageInfo(Dam)

								if string.find(ent:GetModel(), "zombie") == nil then
									local owner = ent:GetRagdollOwner()

									if IsValid(owner) and owner:Alive() then
										owner.Bleedout = owner.Bleedout + math.random(10, 15)
										owner:ApplyPain(math.random(10, 15))
									else
										if not ent.Bleedout then
											ent.Bleedout = math.random(10, 15)
										else
											ent.Bleedout = ent.Bleedout + math.random(10, 15)
										end
									end
								end
							elseif ent:GetClass() == "ent_jack_hmcd_phone" then
								ent:Break()
							end

							self:TakePrimaryAmmo(1)
							sound.Play("snd_jack_hmcd_hammerhit.wav", Tr.HitPos, 65, math.random(90, 110))
							util.Decal("hmcd_jackanail", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)
							self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Bond strength: " .. tostring(Strength))
							self:GetOwner():ViewPunch(Angle(3, 0, 0))
							self:DoBFSAnimation("midslash2")
							self:GetOwner():SetAnimation(PLAYER_ATTACK1)
							self:GetOwner():GetViewModel():SetPlaybackRate(.75)

							timer.Simple(1, function()
								if IsValid(self) then
									self:DoBFSAnimation("idle")
								end
							end)

							self:SetNextSecondaryFire(CurTime() + 2.5)
							self:SetNextPrimaryFire(CurTime() + 2.5)
						end
					end
				end
			end
		else
			for i, info in pairs(constraint.FindConstraints(Tr.Entity, "Rope")) do
				if info.isNail then
					local pos = info.Entity[1].LPos

					if Tr.HitPos:DistToSqr(Tr.Entity:LocalToWorld(info.Entity[1].LPos)) < 100 then
						timer.Simple(.2, function()
							if IsValid(self) then
								self:DoBFSAnimation("stab")
								self:GetOwner():GetViewModel():SetPlaybackRate(.65)
							end
						end)

						self:GetOwner():EmitSound("nail_pull.mp3", 70, math.random(80, 120))
						local ind = self:EntIndex()
						local pulloutTime = CurTime() + 2

						hook.Add("Think", ind .. "NailPullOut", function()
							if not (IsValid(self) and IsValid(self:GetOwner())) then
								hook.Remove("Think", ind .. "NailPullOut")

								return
							end

							local TrTwo = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

							if Tr.Entity:LocalToWorld(info.Entity[1].LPos):DistToSqr(TrTwo.HitPos) >= 100 then
								self:DoBFSAnimation("draw")
								self:GetOwner():StopSound("nail_pull.mp3")
								hook.Remove("Think", ind .. "NailPullOut")

								return
							end

							if pulloutTime < CurTime() then
								if IsValid(info.Constraint) then
									info.Constraint:Remove()
								end

								self:GetOwner():GiveAmmo(1, "AirboatGun", true)
								hook.Remove("Think", ind .. "NailPullOut")
							end
						end)

						self:SetNextSecondaryFire(CurTime() + 2.5)
						self:SetNextPrimaryFire(CurTime() + 2.5)

						return
					end
				end
			end

			for i, info in pairs(constraint.FindConstraints(Tr.Entity, "Weld")) do
				if info.isNail then
					local ent, bone = info.Entity[1].Entity, info.Entity[1].Bone

					if bone == 0 then
						ent, bone = info.Entity[2].Entity, info.Entity[2].Bone
					end

					local pos = ent:GetPhysicsObjectNum(bone):GetPos()

					if Tr.HitPos:DistToSqr(pos) < 100 then
						timer.Simple(.2, function()
							if IsValid(self) then
								self:DoBFSAnimation("stab")
								self:GetOwner():GetViewModel():SetPlaybackRate(.65)
							end
						end)

						self:GetOwner():EmitSound("nail_pull.mp3", 70, math.random(80, 120))
						local ind = self:EntIndex()
						local pulloutTime = CurTime() + 2

						hook.Add("Think", ind .. "NailPullOut", function()
							if not (IsValid(self) and IsValid(self:GetOwner())) then
								hook.Remove("Think", ind .. "NailPullOut")

								return
							end

							local TrTwo = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

							if TrTwo.HitPos:DistToSqr(pos) >= 100 then
								self:DoBFSAnimation("draw")
								self:GetOwner():StopSound("nail_pull.mp3")
								hook.Remove("Think", ind .. "NailPullOut")

								return
							end

							if pulloutTime < CurTime() then
								if IsValid(info.Constraint) then
									info.Constraint:Remove()
								end

								self:GetOwner():GiveAmmo(1, "AirboatGun", true)
								hook.Remove("Think", ind .. "NailPullOut")
							end
						end)

						self:SetNextSecondaryFire(CurTime() + 2.5)
						self:SetNextPrimaryFire(CurTime() + 2.5)

						return
					end
				end
			end

			if Tr.Entity.Nails then
				for i, pos in pairs(Tr.Entity.Nails) do
					local position = Tr.Entity:LocalToWorld(pos)

					if position:DistToSqr(Tr.HitPos) < 100 and self:GetOwner():VisibleVec(position) then
						self:GetOwner():EmitSound("nail_pull.mp3", 70, math.random(80, 120))

						timer.Simple(.2, function()
							if IsValid(self) then
								self:DoBFSAnimation("stab")
								self:GetOwner():GetViewModel():SetPlaybackRate(.65)
							end
						end)

						local ind = self:EntIndex()
						local pulloutTime = CurTime() + 2

						hook.Add("Think", ind .. "NailPullOut", function()
							if not (IsValid(self) and IsValid(self:GetOwner())) then
								hook.Remove("Think", ind .. "NailPullOut")

								return
							end

							local TrTwo = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 65, {self:GetOwner()})

							if position:DistToSqr(TrTwo.HitPos) >= 100 then
								self:DoBFSAnimation("draw")
								self:GetOwner():StopSound("nail_pull.mp3")
								hook.Remove("Think", ind .. "NailPullOut")

								return
							end

							if pulloutTime < CurTime() then
								table.remove(Tr.Entity.Nails, i)
								self:GetOwner():GiveAmmo(1, "AirboatGun", true)

								if Tr.Entity and #Tr.Entity.Nails == 0 then
									if not ((Tr.Entity.Tapes and #Tr.Entity.Tapes > 0) or Tr.Entity.OriginallyLocked) then
										Tr.Entity:Fire("unlock", "", 0)
									end
								end

								hook.Remove("Think", ind .. "NailPullOut")
							end
						end)

						self:SetNextSecondaryFire(CurTime() + 2.5)
						self:SetNextPrimaryFire(CurTime() + 2.5)

						return
					end
				end
			end
		end
	end

	if self.DamageType == DMG_SLASH then
		self:RemoveTape()
	end
end

function SWEP:SprayDecals()
	local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector() * 70, {self:GetOwner()})

	util.Decal("hmcd_jackanail", Tr.HitPos + Tr.HitNormal, Tr.HitPos - Tr.HitNormal)

	local Tr2 = util.QuickTrace(self:GetOwner():GetShootPos(), (self:GetOwner():GetAimVector() + Vector(0, 0, .15)) * 70, {self:GetOwner()})

	util.Decal("hmcd_jackanail", Tr2.HitPos + Tr2.HitNormal, Tr2.HitPos - Tr2.HitNormal)

	local Tr3 = util.QuickTrace(self:GetOwner():GetShootPos(), (self:GetOwner():GetAimVector() + Vector(0, 0, -.15)) * 70, {self:GetOwner()})

	util.Decal("hmcd_jackanail", Tr3.HitPos + Tr3.HitNormal, Tr3.HitPos - Tr3.HitNormal)

	local Tr4 = util.QuickTrace(self:GetOwner():GetShootPos(), (self:GetOwner():GetAimVector() + Vector(0, .15, 0)) * 70, {self:GetOwner()})

	util.Decal("hmcd_jackanail", Tr4.HitPos + Tr4.HitNormal, Tr4.HitPos - Tr4.HitNormal)

	local Tr5 = util.QuickTrace(self:GetOwner():GetShootPos(), (self:GetOwner():GetAimVector() + Vector(0, -.15, 0)) * 70, {self:GetOwner()})

	util.Decal("hmcd_jackanail", Tr5.HitPos + Tr5.HitNormal, Tr5.HitPos - Tr5.HitNormal)

	local Tr6 = util.QuickTrace(self:GetOwner():GetShootPos(), (self:GetOwner():GetAimVector() + Vector(.15, 0, 0)) * 70, {self:GetOwner()})

	util.Decal("hmcd_jackanail", Tr6.HitPos + Tr6.HitNormal, Tr6.HitPos - Tr6.HitNormal)

	local Tr7 = util.QuickTrace(self:GetOwner():GetShootPos(), (self:GetOwner():GetAimVector() + Vector(-.15, 0, 0)) * 70, {self:GetOwner()})

	util.Decal("hmcd_jackanail", Tr7.HitPos + Tr7.HitNormal, Tr7.HitPos - Tr7.HitNormal)
end

function SWEP:Reload()
	if CLIENT then
		LocalPlayer().AmmoShow = CurTime() + 3

		return
	end
end

if CLIENT then
	function SWEP:PreDrawViewModel(vm, ply, wep)
	end

	--
	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 20)
		end

		pos = pos - ang:Up() * (self.DownAmt + 0) --+ang:Forward()*0+ang:Right()*0
		--ang:RotateAroundAxis(ang:Up(),0)
		--ang:RotateAroundAxis(ang:Right(),0)
		--ang:RotateAroundAxis(ang:Forward(),0)

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
		local Anglez = Angle(-90, -60, -70)
		local Rightness = -3

		if self:GetAttackType() == true then
			Anglez = Angle(-90, 60, 90)
			Rightness = 5
		end

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() * Rightness - Ang:Up() * 1.5)
				Ang:RotateAroundAxis(Ang:Right(), Anglez.x)
				Ang:RotateAroundAxis(Ang:Up(), Anglez.y)
				Ang:RotateAroundAxis(Ang:Forward(), Anglez.z)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/weapons/w_jjife_t.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			--self.DatWorldModel:SetModelScale(1,0)
		end
	end
end