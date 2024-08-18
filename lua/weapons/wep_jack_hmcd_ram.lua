--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_ram.lua
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
	killicon.AddFont("wep_jack_hmcd_axe", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/weapons/custom/v_batram.mdl"
SWEP.WorldModel = "models/weapons/custom/w_batram.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_ram")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_ram"
SWEP.IconLength = 2
SWEP.PrintName = "Battering Ram"
SWEP.Instructions = "This is a small, one-man ram for forcing open locked portals or effecting a door breaching.\n\nLMB to swing.\nCan bust down doors."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.Category="HMCD: Union - Other"
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 30
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
SWEP.ENT = "ent_jack_hmcd_ram"
SWEP.UseHands = true
SWEP.DeathDroppable = false
SWEP.HomicideSWEP = true
SWEP.HolsterPos = Vector(0, 0, 0)
SWEP.HolsterAng = Angle(90, 5, 180)
SWEP.SprintPos = Vector(10, 0, 0)
SWEP.SprintAng = Angle(0, 60, 0)
SWEP.CarryWeight = 3000
SWEP.BearTime = 6
--
SWEP.HoldType = "melee2"
SWEP.RunHoldType = "normal"
SWEP.AttackAnim = "attack_quick"
SWEP.ViewAttackAnimDelay = .1
SWEP.AttackFrontDelay = .4
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

SWEP.ViewPunch = Angle(0, 30, 0)
SWEP.ReachDistance = 80
SWEP.Force = 150

SWEP.SoftImpactSounds = {
	{
		"Flesh.ImpactHard", 1, 65, {90, 110}
	},
	{
		"ambient/materials/door_hit1.wav", 0, 65, {90, 110}
	},
	{
		"snd_jack_hmcd_axehit.wav", -1, 65, {90, 110}
	},
	{
		"ambient/materials/door_hit1.wav", 0, 65, {90, 110}
	}
}

SWEP.HardImpactSounds = {
	{
		"ambient/materials/door_hit1.wav", 0, 65, {90, 110}
	},
	{
		"SolidMetal.ImpactHard", -1, 65, {90, 110}
	},
	{
		"Wood_Plank.ImpactSoft", 1, 65, {90, 110}
	}
}

SWEP.UniversalSound = {
	"Wood_Plank.ImpactSoft", 0, 65, {90, 110}
}

SWEP.AttackPlayback = 1
SWEP.MinDamage = 25
SWEP.MaxDamage = 30
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 4500
SWEP.DamageType = DMG_CLUB
SWEP.PrehitViewPunch = Angle(0, -15, 0)
SWEP.CanBreakDoors = true
SWEP.HoldType = "shotgun"
SWEP.RunHoldType = "passive"

function SWEP:Initialize()
	self:SetHoldType("shotgun")
	self:SetWindUp(0)
	self.NextWindThink = CurTime()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "WindUp")
	self:NetworkVar("Int", 1, "Sprinting")
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	--for i=0,10 do PrintTable(self:GetOwner():GetViewModel():GetAnimInfo(i)) end

	if self:GetSprinting() ~= 0 then return end

	if not IsFirstTimePredicted() then
		timer.Simple(.2, function()
			if IsValid(self) then
				self:DoBFSAnimation("aim")
			end
		end)

		return
	end

	sound.Play("snd_jack_hmcd_tinyswish", self:GetOwner():GetShootPos(), 60, math.random(80, 90))
	self:SetWindUp(1)
	self:DoBFSAnimation("aim")
	self:SetNextPrimaryFire(CurTime() + 1.25)
	self:GetOwner():ViewPunch(Angle(0, -15, 0))

	timer.Simple(.1, function()
		if IsValid(self) then
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		end
	end)

	timer.Simple(.2, function()
		if IsValid(self) then
			self:DoBFSAnimation("punch")

			timer.Simple(.1, function()
				if IsValid(self) then
					self:AttackFront()
				end
			end)
		end
	end)
end

function SWEP:Think()
	local Time = CurTime()

	if self.NextWindThink < Time then
		self.NextWindThink = Time + .05
		self:SetWindUp(math.Clamp(self:GetWindUp() - .1, 0, 1))
	end

	local Sprintin, Aimin, SprintAmt = self:GetOwner():KeyDown(IN_SPEED), self:GetOwner():KeyDown(IN_ATTACK2), self:GetSprinting()
	if Sprintin then
		self:SetSprinting(math.Clamp(SprintAmt + 40 * (1 / self.BearTime), 0, 100))
	elseif Aimin and self:GetOwner():OnGround() and (self.Alt == 0) and not ((self.CycleType == "manual") and (self.LastFire + .75 > CurTime())) then
		self:SetSprinting(math.Clamp(SprintAmt - 20 * (1 / self.BearTime), 0, 100))
	else
		self:SetSprinting(math.Clamp(SprintAmt - 20 * (1 / self.BearTime), 0, 100))
	end

	local HoldType = self.HoldType

	if self:GetOwner():KeyDown(IN_SPEED) and self.RunHoldType then
		HoldType = self.RunHoldType
	else
		if (self.NextDownTime and self.NextDownTime > CurTime()) and not (self.AttackType == "Stab") then
			HoldType = "melee"
		end
	end

	self:SetHoldType(HoldType)
end

if CLIENT then
	local DownAmt = 0
	local LastSprintGotten = 0

	function SWEP:GetViewModelPosition(pos, ang)
		local SprintGotten = Lerp(.1, LastSprintGotten, self:GetSprinting())
		local Up, Forward, Right = ang:Up(), ang:Forward(), ang:Right()
		LastSprintGotten = SprintGotten
		local Sprint = SprintGotten / 100

		if Sprint > 0 then
			pos = pos + Up * self.SprintPos.z * Sprint + Forward * self.SprintPos.y * Sprint + Right * self.SprintPos.x * Sprint
			ang:RotateAroundAxis(ang:Right(), self.SprintAng.p * Sprint)
			ang:RotateAroundAxis(ang:Up(), self.SprintAng.y * Sprint)
			ang:RotateAroundAxis(ang:Forward(), self.SprintAng.r * Sprint)
		end

		return pos + ang:Up() * 0 - ang:Forward() * DownAmt - ang:Up() * DownAmt + ang:Right(), ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 1 + Ang:Right() - Ang:Up() * 1.2)
				Ang:RotateAroundAxis(Ang:Up(), 270)
				Ang:RotateAroundAxis(Ang:Right(), 0)
				Ang:RotateAroundAxis(Ang:Forward(), 170)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/weapons/custom/w_batram.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			self.DatWorldModel:SetModelScale(1, 0)
		end
	end
end