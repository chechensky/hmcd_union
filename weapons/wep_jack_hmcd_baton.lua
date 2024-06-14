if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
elseif CLIENT then
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 85
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	killicon.AddFont("wep_zac_hmcd_policebaton", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/police_baton/v_police_baton.mdl"
SWEP.WorldModel = "models/police_baton/w_police_baton.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_zac_hmcd_policebaton")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_zac_hmcd_policebaton"
SWEP.IconLength = 2
SWEP.PrintName = "Police Tonfa"
SWEP.Instructions = "This is a roughly cylindrical club made of rubber, carried as a compliance tool and defensive weapon by law-enforcement officers.\n\nLMB to swing."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.AttackSlowDown = .75
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 5000
SWEP.Primary.DefaultClip = -1
SWEP.Category="HMCD: Union - Melee"
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.CommandDroppable = true
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
SWEP.CarryWeight = 1000
SWEP.ENT = "ent_jack_hmcd_baton"
SWEP.CanUpdateIdle = true
SWEP.Hidden = 2
SWEP.HoldType = "melee"
SWEP.RunHoldType = "normal"

SWEP.DrawSound = {
	"Flesh.ImpactSoft", 55, {90, 110}
}

SWEP.DrawAnim = "draw"
SWEP.ViewPunch = Angle(2, 0, 0)
SWEP.MinDamage = 5
SWEP.MaxDamage = 10
SWEP.ReachDistance = 60
SWEP.Force = 125

SWEP.UniversalSound = {
	"Flesh.ImpactHard", 0, 60, {90, 110}
}

SWEP.DamageForceDiv = 100
SWEP.DamageType = DMG_CLUB
SWEP.ForceOffset = 300
SWEP.IdleAnim = "idle"
SWEP.ArmorMul = .25

function SWEP:PrimaryAttack()
	local Ent, HitPos, HitNorm = HMCD_WhomILookinAt(self:GetOwner(), .35, self.ReachDistance)

	if not IsFirstTimePredicted() then
		if Ent then
			self:DoBFSAnimation("attack")
		else
			self:DoBFSAnimation("attack_miss")
		end

		return
	end



	if Ent then
		self:DoBFSAnimation("attack")
	else
		self:DoBFSAnimation("attack_miss")
	end

	self:UpdateNextIdle()
	self:GetOwner():GetViewModel():SetPlaybackRate(1)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SetNextPrimaryFire(CurTime() + .7)

	if SERVER then
		timer.Simple(.05, function()
			if IsValid(self) then
				sound.Play("weapons/slam/throw.wav", self:GetPos(), 75, math.random(90, 110))
			end
		end)
	end

	timer.Simple(.15, function()
		if IsValid(self) then
			self:AttackFront()
		end
	end)
end

if CLIENT then
	local DownAmt = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 20)
		end

		pos = pos - ang:Up() * (self.DownAmt + self.Hidden) + ang:Forward() * -1 + ang:Right()

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		if 1 then
			self:DrawModel()
		end
	end
end