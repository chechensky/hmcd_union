--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_leadpipe.lua
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
SWEP.IconTexture = "vgui/hud/tfa_nmrih_lpipe"
SWEP.IconLength = 2
SWEP.Base = "wep_jack_hmcd_melee_base"
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_pipe_lead.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_pipe_lead.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_nmrih_lpipe")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Lead Pipe"
SWEP.Instructions = "This is a heavy lead pipe with a curved end.\nLMB to swing."
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
SWEP.Category="HMCD: Union - Melee"
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
SWEP.ENT = "ent_jack_hmcd_leadpipe"
SWEP.DeathDroppable = false
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 4000
SWEP.UseHands = true
--
SWEP.HoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.AttackAnim = "attack_quick"
SWEP.ViewAttackAnimDelay = .1
SWEP.AttackFrontDelay = .5
SWEP.PrehitViewPunchDelay = .2
SWEP.IdleAnim = "Idle"
SWEP.AttackAnimDelay = .1
SWEP.AttackDelay = 1.25
SWEP.DrawAnim = "Draw"

SWEP.DrawSound = {
	"SolidMetal.ImpactSoft", 65, {90, 110}
}

SWEP.WooshSound = {
	"weapons/iceaxe/iceaxe_swing1.wav", 65, {60, 70}
}

SWEP.ViewPunch = Angle(0, 20, 0)
SWEP.ReachDistance = 70
SWEP.Force = 150
SWEP.ArmorMul = .25

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

SWEP.AttackPlayback = 1
SWEP.MinDamage = 20
SWEP.MaxDamage = 25
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 4500
SWEP.DamageType = DMG_CLUB
SWEP.PrehitViewPunch = Angle(0, -10, 0)
SWEP.ReachDistance = 55
SWEP.CanUpdateIdle = true

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .2, 0, 50)
		else
			DownAmt = math.Clamp(DownAmt - .2, 0, 10)
		end

		ang:RotateAroundAxis(ang:Forward(), 0)

		return pos - ang:Up() * DownAmt + ang:Right() * 3 + ang:Forward() * 1, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			if not self.WModel then
				self.WModel = ClientsideModel(self.WorldModel)
				self.WModel:SetPos(self:GetOwner():GetPos())
				self.WModel:SetParent(self:GetOwner())
				self.WModel:SetNoDraw(true)
			else
				local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

				if pos and ang then
					self.WModel:SetRenderOrigin(pos + ang:Right() + ang:Up() * -1 + ang:Forward() * 4 + ang:Right() * 1)
					ang:RotateAroundAxis(ang:Forward(), 180)
					ang:RotateAroundAxis(ang:Up(), 90)
					self.WModel:SetRenderAngles(ang)
					self.WModel:DrawModel()
				end
			end
		end
	end
end