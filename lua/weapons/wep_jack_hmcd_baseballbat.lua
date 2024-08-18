if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
elseif CLIENT then
	SWEP.DrawAmmo = false
	SWEP.ViewModelFlip = false -- Не было там такого
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
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_bat_wooden.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_bat_wood.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_baseballbat")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Baseball Bat"
SWEP.Instructions = "This is a typical wooden baseball bat. Use it as you see fit (attack/defend etc). Can not be holstered.\nLMB to swing."
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
SWEP.Category="HMCD: Union - Melee"
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
SWEP.ENT = "ent_jack_hmcd_baseballbat"
SWEP.NoHolster = true
SWEP.DeathDroppable = false
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 3000
SWEP.UseHands = true
SWEP.DangerLevel = 55
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

SWEP.ViewPunch = Angle(0, 20, 0)
SWEP.ReachDistance = 70
SWEP.Force = 150
SWEP.ArmorMul = .5

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
		"Wood_Plank.ImpactHard", 0, 65, {90, 110}
	},
	{
		"Wood_Plank.ImpactHard", -1, 65, {90, 110}
	}
}

SWEP.UniversalSound = {
	"Wood_Plank.ImpactSoft", 0, 65, {90, 110}
}

SWEP.AttackPlayback = 1
SWEP.MinDamage = 20
SWEP.MaxDamage = 25
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 4500
SWEP.DamageType = DMG_CLUB
SWEP.PrehitViewPunch = Angle(0, -10, 0)

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
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() * 1 + Ang:Up() * 0)
				Ang:RotateAroundAxis(Ang:Right(), 180)
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