--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_cleaver.lua
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
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_cleaver.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_cleaver.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_nmrih_cleaver")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/hud/tfa_nmrih_cleaver"
SWEP.PrintName = "Butcher Knife"
SWEP.Instructions = "This is a large knife resembling a rectangular-bladed hatchet.\n\nLMB to slash."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.AttackSlowDown = .75
SWEP.CommandDroppable = true
SWEP.Spawnable = true
--SWEP.SHTF_NoDrop=true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Category="HMCD: Union - Melee"
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
SWEP.HomicideSWEP = true
SWEP.ENT = "ent_jack_hmcd_cleaver"
SWEP.Poisonable = true
SWEP.CarryWeight = 500
SWEP.CanUpdateIdle = true
SWEP.HoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.AttackAnim = "attack_quick"

SWEP.WooshSound = {
	"weapons/slam/throw.wav", 60, {90, 110},
	"owner"
}

SWEP.AttackDelay = 1
SWEP.AttackFrontDelay = .2
SWEP.PrehitViewPunch = Angle(0, -3, 0)
SWEP.DrawAnim = "draw"
SWEP.ViewPunch = Angle(0, 3, 0)
SWEP.ReachDistance = 60
SWEP.Force = 125
SWEP.BloodDecals = 1
SWEP.MinDamage = 25
SWEP.MaxDamage = 35

SWEP.HardImpactSounds = {
	{
		"snd_jack_hmcd_knifehit.wav", 0, 65, {100, 120}
	}
}

SWEP.SoftImpactSounds = {
	{
		"snd_jack_hmcd_knifestab.wav", 0, 60, {90, 110}
	}
}

SWEP.DamageType = DMG_SLASH
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 250
SWEP.IdleAnim = "idle"
SWEP.AttackPlayback = 1

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt - .6, -20, 50)
		else
			DownAmt = math.Clamp(DownAmt + .6, 20, 50)
		end

		ang:RotateAroundAxis(ang:Up(), 1)

		return pos + ang:Up() * -50 + ang:Forward() * -3 + ang:Up() * DownAmt - ang:Right() * -1, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			local pos, ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

			if not self.WModel then
				self.WModel = ClientsideModel(self.WorldModel)
				self.WModel:SetPos(self:GetOwner():GetPos())
				self.WModel:SetParent(self:GetOwner())
				self.WModel:SetNoDraw(true)
			else
				if pos and ang then
					self.WModel:SetRenderOrigin(pos + ang:Right() + ang:Up() * 1 + ang:Forward() * 1)
					ang:RotateAroundAxis(ang:Forward(), 180)
					ang:RotateAroundAxis(ang:Right(), 10)
					self.WModel:SetRenderAngles(ang)
					self.WModel:DrawModel()
				end
			end
		end
	end
end