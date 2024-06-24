--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_pocketknife.lua
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
	SWEP.SlotPos = 2
	killicon.AddFont("wep_jack_hmcd_pocketknife", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/weapons/v_knife_s&wch0014.mdl"
SWEP.WorldModel = "models/weapons/w_knife_swch.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_pocketknife")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_pocketknife"
SWEP.PrintName = "S&W CH0014"
SWEP.Instructions = "This is a carbon-steel safety-liner-lock folding pocket-knife. Use it as you see fit to attack or defend.\n\nLMB to slash.\nR+LMB to switch attack mode."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.AttackSlowDown = .75
SWEP.CommandDroppable = true
SWEP.Spawnable = true
--SWEP.SHTF_NoDrop=true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 25
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Category="HMCD: Union - Melee"
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
SWEP.HomicideSWEP = true
SWEP.ENT = "ent_jack_hmcd_pocketknife"
SWEP.Poisonable = true
SWEP.CarryWeight = 500
SWEP.NextAttackTypeSwitch = 0
SWEP.AttackType = "Slash"
SWEP.DangerLevel = 50
SWEP.ViewPunch = Angle(0, 3, 0)

SWEP.MaxMinSlashDamage = {5, 9}

SWEP.MaxMinStabDamage = {7, 13}

SWEP.HoldType = "normal"

SWEP.HardImpactSounds = {
	{
		"snd_jack_hmcd_knifehit.wav", 0, 65, {100, 120}
	}
}

SWEP.SoftImpactSounds = {
	{
		"snd_jack_hmcd_slash.wav", 0, 60, {90, 110}
	}
}

SWEP.DamageType = DMG_SLASH
SWEP.DamageForceDiv = 100
SWEP.ForceOffset = 25

SWEP.DrawSound = {
	"weapons/s&wch0014/knife_deploy1.wav", 60, {90, 110}
}

SWEP.DrawAnim = "draw"
SWEP.CanUpdateIdle = true
SWEP.IdleAnim = "idle"
SWEP.NextDownTime = CurTime()
SWEP.ReachDistance = 60
SWEP.Force = 125
SWEP.BloodDecals = 1
SWEP.MinDamage = 5
SWEP.MaxDamage = 9

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "AttackType")
end

function SWEP:PrimaryAttack()
	if self:GetOwner():KeyDown(IN_RELOAD) then return end

	if not IsFirstTimePredicted() then
		self:DoBFSAnimation("stab")

		return
	end



	if self.AttackType == "Slash" then
		self:DoBFSAnimation("stab")
	else
		self:DoBFSAnimation("midslash" .. math.random(1, 2) .. "")
	end

	self:UpdateNextIdle()
	self:SetHoldType("melee")
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	local FirstStrike = false

	if not (self.AttackType == "Stab") then
		if self.NextDownTime < CurTime() then
			FirstStrike = true
		end

		self.NextDownTime = CurTime() + 1
	end

	local mul = 1

	if self.AttackType == "Stab" then
		mul = 2
	end

	self:SetNextPrimaryFire(CurTime() + .5 * mul)
	self:GetOwner():ViewPunch(Angle(0, -3, 0))

	if SERVER then
		sound.Play("weapons/slam/throw.wav", self:GetOwner():GetPos(), 60, math.random(90, 110))
	end

	timer.Simple(.05, function()
		if IsValid(self) then
			if FirstStrike then
				self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			end

			self:AttackFront()
		end
	end)
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)


		return pos + ang:Up() * -DownAmt, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

			if self.DatWorldModel then
				if Pos and Ang then
					self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() * 0.5)
					Ang:RotateAroundAxis(Ang:Forward(), 180)
					Ang:RotateAroundAxis(Ang:Up(), 90)
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
end