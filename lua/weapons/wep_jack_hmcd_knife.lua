--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_knife.lua
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
	SWEP.SlotPos = 1
	killicon.AddFont("wep_jack_hmcd_knife", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/weapons/gleb/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_knife")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_knife"
SWEP.PrintName = "SOG M37 Seal Pup"
SWEP.Instructions = "This is your trusty carbon-steel fixed-blade knife. Use it to take the lives of the innocent.\n\nLMB to stab.\nBackstabs do more damage."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.AttackSlowDown = .1
SWEP.Category="HMCD: Union - Melee"
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 40
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
--SWEP.CommandDroppable=true
SWEP.HomicideSWEP = true
--SWEP.ENT="ent_jack_hmcd_knife"
SWEP.UseHands = true
SWEP.Poisonable = true
SWEP.CarryWeight = 500
SWEP.DangerLevel = 55

SWEP.WooshSound = {
	"weapons/slam/throw.wav", 55, {90, 110}
}

SWEP.Force = 125
SWEP.MinDamage = 15
SWEP.MaxDamage = 25
SWEP.DamageType = DMG_SLASH

SWEP.HardImpactSounds = {
	{
		"snd_jack_hmcd_knifehit.wav", 0, 60, {90, 110}
	}
}

SWEP.SoftImpactSounds = {
	{
		"snd_jack_hmcd_knifestab.wav", 0, 50, {90, 110}
	}
}

SWEP.BloodDecals = 2
SWEP.ViewPunch = Angle(2, 0, 0)

SWEP.DrawSound = {
	"snd_jack_hmcd_knifedraw.wav", 55, {90, 110}
}

SWEP.DrawAnim = "draw"
SWEP.DrawPlayback = 1
SWEP.DrawDelay = 0
SWEP.CanUpdateIdle = true
SWEP.ForceOffset = 25
SWEP.HoldType = "knife"
SWEP.IdleAnim = "idle"
SWEP.AttackAnim = "stab_miss"
SWEP.AttackPlayback = 1.5
SWEP.AttackDelay = .65
SWEP.AttackFrontDelay = .15
SWEP.RunHoldType = "normal"
SWEP.ReachDistance = 80
SWEP.DamageForceDiv = 100
SWEP.BackStabMul = 2

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .3, 0, 10)
		else
			DownAmt = math.Clamp(DownAmt - .3, 0, 10)
		end

		ang:RotateAroundAxis(ang:Right(), 40)

		return pos - ang:Up() * 7 - ang:Forward() * (3 + DownAmt) - ang:Up() * DownAmt, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			self:DrawModel()
		end
	end
end