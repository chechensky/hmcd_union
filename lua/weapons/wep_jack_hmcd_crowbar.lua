--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_crowbar.lua
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
	killicon.AddFont("wep_jack_hmcd_baseballbat", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_crowbar.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_nmrih_crowbar")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Crowbar"
SWEP.Instructions = "This is an iron bar with a flattened end.\nLMB to swing.\nRMB to pull out a nail."
SWEP.IconTexture = "vgui/hud/tfa_nmrih_crowbar"
SWEP.IconLength = 2
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
SWEP.Category="HMCD: Union - Melee"
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
SWEP.ENT = "ent_jack_hmcd_crowbar"
SWEP.BloodDecals = 2
SWEP.DeathDroppable = false
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 3000
SWEP.UseHands = true
SWEP.DangerLevel = 55
SWEP.HoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.AttackAnim = "attack_quick"
SWEP.ViewAttackAnimDelay = .1
SWEP.AttackFrontDelay = .5
SWEP.PrehitViewPunchDelay = .1
SWEP.IdleAnim = "idle"
SWEP.AttackAnimDelay = .1
SWEP.AttackDelay = 1.25
SWEP.DrawAnim = "draw"

SWEP.DrawSound = {
	"Wood_Plank.ImpactSoft", 65, {90, 110}
}

SWEP.WooshSound = {
	"weapons/iceaxe/iceaxe_swing1.wav", 65, {60, 70}
}

SWEP.ViewPunch = Angle(0, 20, 0)
SWEP.ReachDistance = 70
SWEP.Force = 150
SWEP.ArmorMul = .1

SWEP.SoftImpactSounds = {
	{
		"Flesh.BulletImpact", 1, 65, {90, 110}
	},
	{
		"Flesh.BulletImpact", 0, 65, {90, 110}
	},
	{
		"Flesh.BulletImpact", -1, 65, {90, 110}
	}
}

SWEP.HardImpactSounds = {
	{
		"Metal_Barrel.BulletImpact", 0, 65, {90, 110}
	},
	{
		"Metal_Barrel.BulletImpact", -1, 65, {90, 110}
	}
}

SWEP.AttackPlayback = 1
SWEP.MinDamage = 15
SWEP.MaxDamage = 20
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 4500
SWEP.DamageType = DMG_SLASH
SWEP.PrehitViewPunch = Angle(0, -10, 0)

function SWEP:Initialize()
	timer.Simple(.1, function()
		if IsValid(self:GetOwner()) and string.find(self:GetOwner():GetModel(), "freeman") then
			self.AttackPlayback = self.AttackPlayback * 1.5
			self.AttackFrontDelay = self.AttackFrontDelay / 2
			self.AttackDelay = self.AttackDelay / 2
		end
	end)
end

function SWEP:SecondaryAttack()
	if SERVER then
		local ShPos, AimVec = self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector()

		local Tr = util.QuickTrace(ShPos, AimVec * 65, {self:GetOwner()})

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

	self:RemoveTape()
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .2, 0, 50)
		else
			DownAmt = math.Clamp(DownAmt - .2, 0, 10)
		end

		return pos - ang:Up() * DownAmt + ang:Right() * 3, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() * 1 + Ang:Up() * -1)
				Ang:RotateAroundAxis(Ang:Right(), 180)
				Ang:RotateAroundAxis(Ang:Up(), -90)
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
end