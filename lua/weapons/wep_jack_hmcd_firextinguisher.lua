--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_firextinguisher.lua
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
	SWEP.Slot = 3
	SWEP.SlotPos = 4
	killicon.AddFont("wep_jack_hmcd_fireextinguisher", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.Base = "wep_jack_hmcd_melee_base"
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_tool_extinguisher.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_tool_extinguisher.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_nmrih_fext")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Fire Extinguisher"
SWEP.Instructions = "This is a hand-held cylindrical pressure vessel containing an agent that can be discharged to extinguish a fire.\n\nLMB to squeeze the lever/attack.\nRELOAD to switch between attack/extinguish mode."
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
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 900
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Category="HMCD: Union - Other"
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.Recoil = 0
SWEP.Secondary.Damage = 0
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.IconTexture = "vgui/hud/tfa_nmrih_fext"
SWEP.IconLength = 1.7
SWEP.ENT = "ent_jack_hmcd_fireextinguisher"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 450
SWEP.DrawAnim = "Draw"
SWEP.UseHands = true
SWEP.SafetyOn = true
SWEP.NextSafetySwitch = 0
SWEP.SafetyOffAnim = "HoseEquip"
SWEP.SafetyOnAnim = "HoseUnequip"
SWEP.FireAnim = "HoseSpray"
SWEP.HoseIdleAnim = "HoseIdle"
SWEP.IdleAnim = "idle"
SWEP.DoStopAnimation = true
SWEP.DoStartAnimation = true
SWEP.BearTime = 7
SWEP.SprintPos = Vector(10, -10, 0)
SWEP.SprintAng = Angle(0, 30, 0)

function SWEP:Initialize()
	self:SetHoldType("slam")
	self.DownAmt = 20
	self:SetAmount(1500)
	self:SetSprinting(0)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "Sprinting")
	self:NetworkVar("Float", 0, "Amount")
	self:NetworkVar("Float", 1, "NextFire")
	self:NetworkVar("Float", 2, "NextIdle")
end

function SWEP:UpdateNextFire()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextFire(CurTime() + vm:SequenceDuration())
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration())
end

function SWEP:DoBFSAnimation(anim)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
end

function SWEP:Deploy()
	if self.SafetyOff then
		self.SafetyOff = false
	end

	if not IsFirstTimePredicted() then
		self:DoBFSAnimation(self.DrawAnim)
		self:GetOwner():GetViewModel():SetPlaybackRate(.1)

		return
	end

	self:DoBFSAnimation(self.DrawAnim)
	self:UpdateNextIdle()

	return true
end

function SWEP:Reload()

	if self.NextSafetySwitch > CurTime() then return end
	if self:GetOwner():KeyDown(IN_ATTACK) then return end
	self.NextSafetySwitch = CurTime() + 1

	if self.SafetyOn then
		self.SafetyOn = false
		self:DoBFSAnimation(self.SafetyOffAnim)
		self:UpdateNextIdle()
	else
		self.SafetyOn = true
		self:DoBFSAnimation(self.SafetyOnAnim)
		self:UpdateNextIdle()
	end
end

function SWEP:CanSprayEyes(ent)
	local entPos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1"))
	local TrueVec = (self:GetOwner():GetShootPos() - entPos):GetNormalized()
	local LookVec

	if ent.GetAimVector then
		LookVec = ent:GetAimVector()
	else
		LookVec = ent:EyeAngles():Forward()
	end

	local DotProduct = LookVec:DotProduct(TrueVec)
	local ApproachAngle = -math.deg(math.asin(DotProduct)) + 90

	if ApproachAngle <= 90 then
		return true
	else
		return false
	end
end

function SWEP:OnRemove()
	self:StopSound("fire_extinguisher/fire_extinguisger_startloop.wav")
end

function SWEP:OnHolster(newWep)
	self:StopSound("fire_extinguisher/fire_extinguisger_startloop.wav")

	return true
end

function SWEP:Think()
	if SERVER then
		local HoldType = "slam"

		if self:GetOwner():KeyDown(IN_SPEED) then
			self:StopSound("fire_extinguisher/fire_extinguisger_startloop.wav")
			HoldType = "normal"
		elseif self.SafetyOn then
			HoldType = "melee2"
		end

		self:SetHoldType(HoldType)
	end

	if self.SafetyOn == false then
		if (self:GetOwner():KeyDown(IN_ATTACK) and not self:GetOwner():KeyDown(IN_SPEED)) and not self:GetOwner().fake then
			if self:GetAmount() > 0 then
				local Tr = util.QuickTrace(self:GetOwner():GetShootPos(), self:GetOwner():EyeAngles():Forward() * 300, {self:GetOwner()})

				if Tr.Hit then
					util.Decal("FireExt_" .. math.random(1, 2), Tr.HitPos - Tr.HitNormal, Tr.HitPos + Tr.HitNormal)

					for key, ent in pairs(ents.FindInSphere(Tr.HitPos, 150)) do
						local Tr2 = util.QuickTrace(Tr.HitPos, ent:GetPos(), {ent})

						local Diffz = Tr.HitPos.z - ent:GetPos().z

						if ent:GetClass() == "ent_jack_hmcd_molotovtest" and ent.Detonated and (Diffz < 40 and Diffz > -40) then
							ent.Crispiness = ent.Crispiness - 1
						end

						if SERVER and ent:GetClass() == "env_fire" then
							ent:SetHealth(ent:Health() - 1)

							if ent:Health() < 0 then
								ent:Remove()
							end
						end
					end

					if Tr.Entity:IsOnFire() then
						if SERVER then
							if IsValid(Tr.Entity.CurrentFire) then
								local timeLeft = Tr.Entity.CurrentFire:GetInternalVariable("lifetime") - CurTime()
								Tr.Entity.CurrentFire:SetSaveValue("lifetime", CurTime() + timeLeft / 2)
							end
						end
					end
				else
					for key, ent in pairs(ents.FindInSphere(Tr.HitPos, 300)) do
						if SERVER and ent:GetClass() == "ent_jack_hmcd_fire" then
							ent.Radius = math.Clamp(ent.Radius - 1, 0, 1000)

							if ent.Radius <= 20 then
								SafeRemoveEntity(ent)
							end
						end
					end
				end

				if SERVER then
					local owner = Tr.Entity

					if IsValid(owner) and owner:IsPlayer() then
						if owner:GetNWString("Helmet") ~= "Motorcycle" and owner:GetNWString("Mask") ~= "Gas Mask" and not (string.find(owner:GetNWString("Bodyvest"), "Combine") or owner:GetNWString("Helmet") == "RiotHelm") and (Tr.HitGroup == 1 or (Tr.PhysicsBone ~= 0 and HMCD_GetRagdollHitgroup(Tr.Entity, Tr.PhysicsBone) == 1)) and self:CanSprayEyes(Tr.Entity) then

							if pepper < 1000 then
								net.Start("hmcd_pepperspray")
								net.WriteEntity(owner)
								net.WriteInt(owner.DigestedContents["PepperSpray"], 11)
								net.Send(player.GetAll())
							end
						end
					end
				end

				self:SetAmount(self:GetAmount() - 1)

				if self:GetNextFire() < CurTime() then
					self:DoBFSAnimation(self.FireAnim)
					self:UpdateNextFire()
				end
			else
				self:StopSound("fire_extinguisher/fire_extinguisger_startloop.wav")
			end

			if self.DoStartAnimation then
				self.DoStopAnimation = true
				self.DoStartAnimation = false
			end
		else
			if self.DoStopAnimation then
				self:StopSound("fire_extinguisher/fire_extinguisger_startloop.wav")
				self.DoStartAnimation = true
				self.DoStopAnimation = false
				self:DoBFSAnimation(self.HoseIdleAnim)
			end
		end
	end

	if not self:GetOwner():KeyDown(IN_ATTACK) then
		if self:GetNextIdle() < CurTime() then
			if self.SafetyOn then
				self:DoBFSAnimation(self.IdleAnim)
			else
				self:DoBFSAnimation(self.HoseIdleAnim)
			end

			self:UpdateNextIdle()
		end
	end

	if SERVER then
		local Sprintin, SprintAmt = self:GetOwner():KeyDown(IN_SPEED), self:GetSprinting()

		if Sprintin then
			self:SetSprinting(math.Clamp(SprintAmt + 40 * (1 / self.BearTime), 0, 100))
		else
			self:SetSprinting(math.Clamp(SprintAmt - 20 * (1 / self.BearTime), 0, 100))
		end
	end
end

function SWEP:PrimaryAttack()
	if not self.SafetyOn and self:GetAmount() ~= 0 and not self:GetOwner():IsSprinting() then
		local effectdata = EffectData()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))
		effectdata:SetEntity(self.Weapon)
		effectdata:SetNormal(self:GetOwner():GetAimVector())
		effectdata:SetOrigin(Pos + Ang:Forward() * 15 + Ang:Right() * 3.3 + Ang:Up() * 0)

		if CLIENT then
			effectdata:SetAttachment(1)
		else
			effectdata:SetAttachment(0)
		end

		util.Effect("eff_jack_hmcd_fireextparticle", effectdata)
		self:EmitSound("fire_extinguisher/fire_extinguisger_startloop.wav", 60, 120)
	elseif self.SafetyOn and not self:GetOwner():IsSprinting() then
		if not IsFirstTimePredicted() then
			timer.Simple(.2, function()
				if IsValid(self) then
					self:DoBFSAnimation("attack_quick")
				end
			end)

			return
		end

		sound.Play("snd_jack_hmcd_tinyswish", self:GetOwner():GetShootPos(), 60, math.random(80, 90))
		self:DoBFSAnimation("idle")
		self:SetNextPrimaryFire(CurTime() + 1.25)
		self:UpdateNextIdle()

		timer.Simple(.2, function()
			if IsValid(self) then
				self:GetOwner():ViewPunch(Angle(0, -10, 0))
			end
		end)

		timer.Simple(.1, function()
			if IsValid(self) then
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			end
		end)

		timer.Simple(.05, function()
			if IsValid(self) then
				self:DoBFSAnimation("attack_quick")

				timer.Simple(.25, function()
					if IsValid(self) then
						self:AttackFront()
					end
				end)
			end
		end)
	end
end

SWEP.ViewPunch = Angle(0, 20, 0)
SWEP.ReachDistance = 70

SWEP.WooshSound = {
	"weapons/iceaxe/iceaxe_swing1.wav", 65, {60, 70}
}

SWEP.Force = 40

SWEP.SoftImpactSounds = {
	{
		"Flesh.ImpactHard", 1, 65, {90, 110}
	},
	{
		"Flesh.ImpactHard", 0, 65, {90, 110}
	},
	{
		"Flesh.ImpactHard", -1, 65, {90, 110}
	}
}

SWEP.HardImpactSounds = {
	{
		"Canister.ImpactHard", 0, 65, {90, 110}
	},
	{
		"Canister.ImpactHard", 0, 65, {90, 110}
	}
}

SWEP.UniversalSound = {
	"Canister.ImpactHard", 0, 65, {90, 110}
}

SWEP.MinDamage = 25
SWEP.MaxDamage = 30
SWEP.DamageType = DMG_CLUB
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 1500
SWEP.ArmorMul = .5

if CLIENT then
	local LastSprintGotten = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not IsValid(self:GetOwner()) then return pos, ang end
		local SprintGotten = Lerp(.1, LastSprintGotten, self:GetSprinting())
		LastSprintGotten = SprintGotten
		local Sprint, Up, Forward, Right = SprintGotten / 100, ang:Up(), ang:Forward(), ang:Right()

		if Sprint > 0 then
			pos = pos + Up * self.SprintPos.z * Sprint + Forward * self.SprintPos.y * Sprint + Right * self.SprintPos.x * Sprint
			ang:RotateAroundAxis(ang:Right(), self.SprintAng.p * Sprint)
			ang:RotateAroundAxis(ang:Up(), self.SprintAng.y * Sprint)
			ang:RotateAroundAxis(ang:Forward(), self.SprintAng.r * Sprint)
		end

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			self:DrawModel()
		end
	end
end

function SWEP:DrawWorldModel()
	local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

	if self.DatWorldModel then
		if Pos and Ang then
			self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 5 + Ang:Right() * 2 + Ang:Up() * 11)
			Ang:RotateAroundAxis(Ang:Right(), 180)
			Ang:RotateAroundAxis(Ang:Up(), -180)
			self.DatWorldModel:SetRenderAngles(Ang)
			self.DatWorldModel:DrawModel()
		end
	else
		self.DatWorldModel = ClientsideModel(self.WorldModel)
		self.DatWorldModel:SetPos(self:GetPos())
		self.DatWorldModel:SetParent(self)
		self.DatWorldModel:SetNoDraw(true)
	end
end