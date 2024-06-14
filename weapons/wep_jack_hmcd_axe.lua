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
SWEP.ViewModel = "models/eu_homicide/c_axe.mdl"
SWEP.WorldModel = "models/props/cs_militia/axe.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_axe")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Woodcutting Axe"
SWEP.Instructions = "This is a typical woodcutter's axe with a sharp steel head. Murder the innocent like the a true psycopath.\n\nLMB to swing.\nCan also bust down doors and destroy fortifications."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.Category="HMCD: Union - Melee"
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
SWEP.ENT = "ent_jack_hmcd_axe"
SWEP.NoHolster = true
SWEP.DeathDroppable = false
SWEP.HomicideSWEP = true
SWEP.Poisonable = true
SWEP.CarryWeight = 4000
SWEP.DangerLevel = 65

SWEP.WooshSound = {
	"weapons/iceaxe/iceaxe_swing1.wav", 65, {60, 70}
}

SWEP.Force = 150
SWEP.MinDamage = 45
SWEP.MaxDamage = 55
SWEP.DamageType = DMG_SLASH

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

SWEP.SoftImpactSounds = {
	{
		"snd_jack_hmcd_axehit.wav", 0, 65, {90, 110}
	},
	{
		"Canister.ImpactHard", 0, 65, {90, 110}
	},
	{
		"Flesh.ImpactHard", 1, 65, {90, 110}
	}
}

SWEP.UniversalSound = {
	"Wood_Plank.ImpactSoft", 0, 65, {90, 110}
}

SWEP.CanBreakDoors = true
SWEP.ArmorMul = .6
SWEP.BloodDecals = 10
SWEP.ViewPunch = Angle(0, 30, 0)

SWEP.DrawSound = {
	"Wood_Plank.ImpactSoft", 65, {90, 110}
}

SWEP.DrawAnim = "draw"
SWEP.DrawPlayback = .5
SWEP.DrawDelay = 1
SWEP.ForceOffset = 1000
SWEP.HoldType = "melee2"
SWEP.AttackAnim = "attack"
SWEP.PrehitViewPunch = Angle(0, -15, 0)
SWEP.AttackPlayback = 1
SWEP.AttackDelay = 1.25
SWEP.AttackAnimDelay = .1
SWEP.ViewAttackAnimDelay = 0
SWEP.AttackFrontDelay = .3
SWEP.IdleAnim = "idle"
SWEP.ReachDistance = 80
SWEP.DamageForceDiv = 50
SWEP.UseHands = true
SWEP.CanUpdateIdle = true

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .6, 0, 50)
		else
			DownAmt = math.Clamp(DownAmt - .6, 0, 50)
		end

		return pos + ang:Up() * 0 - ang:Forward() * (DownAmt - 10) - ang:Up() * DownAmt + ang:Right() * 3, ang + Angle(-10, 0, 0)
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() - Ang:Up() * 7)
				Ang:RotateAroundAxis(Ang:Forward(), 90)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/props/cs_militia/axe.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			self.DatWorldModel:SetModelScale(1, 0)
		end
	end
end