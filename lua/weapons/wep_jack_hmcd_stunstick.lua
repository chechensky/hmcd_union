--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_stunstick.lua
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
	SWEP.ViewModelFOV = 60
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
SWEP.ViewModel = "models/weapons/c_stunstick_h.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_stunstick")
	SWEP.BounceWeaponIcon = false
end

SWEP.PrintName = "Stunstick"
SWEP.Instructions = "This is a short-range melee weapon that immobilizes organic targets by producing an electrical charge that shimmers on the shaft.\nLMB to swing."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Category="HMCD: Union - Melee"
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
SWEP.IconTexture = "vgui/wep_jack_hmcd_stunstick"
SWEP.IconLength = 2
SWEP.ENT = "ent_jack_hmcd_stunstick"
SWEP.UseHands = true
SWEP.CarryWeight = 2000
SWEP.DangerLevel = 55
SWEP.HoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.AttackAnim = "misscenter1"
SWEP.IdleAnim = "idle"
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
		"weapons/stunstick/stunstick_fleshhit1.wav", 1, 65, {90, 110}
	},
}

SWEP.HardImpactSounds = {
	{
		"weapons/stunstick/stunstick_impact1.wav", 0, 65, {90, 110}
	},
}

SWEP.MinDamage = 10
SWEP.MaxDamage = 15
SWEP.DamageForceDiv = 5
SWEP.ForceOffset = 4500
SWEP.DamageType = DMG_CLUB
SWEP.PrehitViewPunch = Angle(0, -10, 0)
SWEP.AttackFrontDelay = .3

function SWEP:SetupWeaponHoldTypeForAI(t)
	self.ActivityTranslateAI = {}
	self.ActivityTranslateAI[ACT_IDLE] = ACT_IDLE
	self.ActivityTranslateAI[ACT_IDLE_ANGRY] = ACT_RANGE_ATTACK_PISTOL
	self.ActivityTranslateAI[ACT_WALK] = ACT_WALK_PISTOL
	self.ActivityTranslateAI[ACT_IDLE_RELAXED] = ACT_IDLE_RELAXED
	self.ActivityTranslateAI[ACT_IDLE_STIMULATED] = ACT_IDLE_STIMULATED
	self.ActivityTranslateAI[ACT_IDLE_AGITATED] = ACT_IDLE_ANGRY
	self.ActivityTranslateAI[ACT_WALK_RELAXED] = ACT_WALK_RELAXED
	self.ActivityTranslateAI[ACT_WALK_STIMULATED] = ACT_WALK_STIMULATED
	self.ActivityTranslateAI[ACT_WALK_AGITATED] = ACT_WALK_AIM
	self.ActivityTranslateAI[ACT_RUN_RELAXED] = ACT_RUN_RELAXED
	self.ActivityTranslateAI[ACT_RUN_STIMULATED] = ACT_RUN_STIMULATED
	self.ActivityTranslateAI[ACT_RUN_AGITATED] = ACT_RUN_AIM
	self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] = ACT_IDLE_RELAXED
	self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] = ACT_IDLE_AIM_STIMULATED
	self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] = ACT_IDLE_ANGRY
	self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] = ACT_WALK_RELAXED
	self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] = ACT_WALK_AIM_STIMULATED
	self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] = ACT_WALK_AIM
	self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] = ACT_RUN_RELAXED
	self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] = ACT_RUN_AIM_STIMULATED
	self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] = ACT_RUN_AIM
	self.ActivityTranslateAI[ACT_WALK_AIM] = ACT_WALK_AIM
	self.ActivityTranslateAI[ACT_WALK_CROUCH] = ACT_WALK_CROUCH
	self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] = ACT_WALK_CROUCH_AIM
	self.ActivityTranslateAI[ACT_RUN] = ACT_RUN_PISTOL
	self.ActivityTranslateAI[ACT_RUN_AIM] = ACT_RUN_AIM
	self.ActivityTranslateAI[ACT_RUN_CROUCH] = ACT_RUN_CROUCH
	self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] = ACT_RUN_CROUCH_AIM
	self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] = ACT_GESTURE_RANGE_ATTACK
	self.ActivityTranslateAI[ACT_COVER_LOW] = ACT_COVER
	self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] = ACT_RANGE_AIM_PISTOL_LOW
	self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_PISTOL_LOW
	self.ActivityTranslateAI[ACT_RELOAD_LOW] = ACT_RELOAD_PISTOL_LOW
	self.ActivityTranslateAI[ACT_GESTURE_RELOAD] = ACT_GESTURE_RELOAD_PISTOL
	self.ActivityTranslateAI[ACT_MELEE_ATTACK1] = ACT_MELEE_ATTACK1
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if self:GetOwner():KeyDown(IN_SPEED) then
			DownAmt = math.Clamp(DownAmt + .2, 0, 50)
		else
			DownAmt = math.Clamp(DownAmt - .2, 0, 10)
		end

		return pos + ang:Up() * 0 - ang:Forward() * (DownAmt - 10) - ang:Up() * DownAmt + ang:Right() * 3, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			self:DrawModel()
		end
	end
end