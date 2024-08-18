--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_hatchet.lua
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
	SWEP.Slot = 2
	SWEP.SlotPos = 3
	killicon.AddFont("wep_jack_hmcd_hatchet", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/weapons/j_jnife_j.mdl"
SWEP.WorldModel = "models/eu_homicide/w_hatchet.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_hatchet")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Hatchet"
SWEP.Instructions = "This is a small utility hatchet, similar in size and weight to a Tomahawk. Throw it at your enemies for a decent chance of doing a lot of damage.\n\nLMB to swing.\nRMB to throw."
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
SWEP.ENT = "ent_jack_hmcd_hatchet"
SWEP.NoHolster = true
SWEP.DeathDroppable = false
SWEP.HomicideSWEP = true
SWEP.Poisonable = true
SWEP.CarryWeight = 1500
SWEP.Category="HMCD: Union - Melee"
SWEP.DangerLevel = 60
SWEP.HoldType = "melee"
SWEP.RunHoldType = "normal"
SWEP.CanBreakDoors = true
SWEP.AttackDelay = 1.25
SWEP.PrehitViewPunch = Angle(-5, 0, 0)
SWEP.AttackAnim = "stab_miss"
SWEP.AttackFrontDelay = .1
--SWEP.ViewPunch=Angle(30,0,0)
SWEP.ReachDistance = 60

SWEP.WooshSound = {
	"weapons/iceaxe/iceaxe_swing1.wav", 65, {60, 70}
}

SWEP.Force = 150

SWEP.SoftImpactSounds = {
	{
		"snd_jack_hmcd_axehit.wav", 0, 65, {90, 110}
	},
	{
		"snd_jack_hmcd_axehit.wav", -1, 65, {90, 110}
	},
	{
		"Canister.ImpactHard", 0, 65, {90, 110}
	},
	{
		"Flesh.ImpactHard", 1, 65, {90, 110}
	}
}

SWEP.HardImpactSounds = {
	{
		"Canister.ImpactHard", 0, 65, {90, 110}
	},
	{
		"SolidMetal.ImpactHard", -1, 65, {90, 110}
	},
	{
		"Wood_Plank.ImpactSoft", 1, 65, {90, 110}
	}
}

SWEP.BloodDecals = 10

SWEP.UniversalSound = {
	"Wood_Plank.ImpactSoft", 0, 65, {90, 110}
}

SWEP.MinDamage = 35
SWEP.MaxDamage = 45
SWEP.DamageForceDiv = 50
SWEP.DamageType = DMG_SLASH
SWEP.ForceOffset = 500

SWEP.DrawSound = {
	"Wood_Plank.ImpactSoft", 65, {90, 110}
}

SWEP.DrawAnim = "draw"
SWEP.DrawPlayback = .5
SWEP.DrawDelay = .5
SWEP.IdleAnim = "idle"
SWEP.AttackPlayback = 1.5
SWEP.ViewPunchDelay = .1
SWEP.ViewPunch = Angle(15, 0, 0)

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then
		timer.Simple(0.1, function()
			if IsValid(self) then
				self:DoBFSAnimation("stab")
			end
		end)

		return
	end

	sound.Play("snd_jack_hmcd_tinyswish", self:GetOwner():GetShootPos(), 60, math.random(80, 90))
	self:DoBFSAnimation("idle")
	self:SetNextPrimaryFire(CurTime() + 1.25)
	self:SetNextSecondaryFire(CurTime() + 1.25)
	self:GetOwner():ViewPunch(Angle(-5, 0, 0))

	timer.Simple(.05, function()
		if IsValid(self) then
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
			self:DoBFSAnimation("stab")
			self:GetOwner():GetViewModel():SetPlaybackRate(1.5)
		end
	end)

	timer.Simple(.1, function()
		if IsValid(self) then
			timer.Simple(.1, function()
				if IsValid(self) then
					self:Throw()
				end
			end)
		end
	end)
end

function SWEP:Throw()
	if CLIENT then return end
	self:GetOwner():ViewPunch(Angle(10, 0, 0))
	self:GetOwner():LagCompensation(true)
	local Pos, AimVec = self:GetOwner():GetShootPos(), self:GetOwner():GetAimVector()
	sound.Play("weapons/iceaxe/iceaxe_swing1.wav", self:GetOwner():GetShootPos(), 65, math.random(60, 70))
	local Ax = ents.Create(self.ENT)
	Ax.HmcdSpawned = self.HmcdSpawned
	Ax:SetPos(Pos + AimVec * 20)
	local Ang = AimVec:Angle()
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 180)
	Ax:SetAngles(Ang)
	Ax.Thrown = true
	Ax.Poisoned = self.Poisoned
	Ax.Infected = self.Infected
	Ax.Owner = self:GetOwner()
	Ax:Spawn()
	Ax:Activate()
	Ax:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + AimVec * 1000)
	Ax:GetPhysicsObject():AddAngleVelocity(Vector(0, 0, 2000))
	self:Remove()
	self:GetOwner():LagCompensation(false)
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .6, 0, 50)
		else
			DownAmt = math.Clamp(DownAmt - .6, 0, 50)
		end

		ang:RotateAroundAxis(ang:Forward(), 10)

		return pos + ang:Up() * 0 - ang:Forward() * (DownAmt - 10) - ang:Up() * DownAmt + ang:Right() * 3, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() - Ang:Up() * 2)
				Ang:RotateAroundAxis(Ang:Forward(), 90)
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