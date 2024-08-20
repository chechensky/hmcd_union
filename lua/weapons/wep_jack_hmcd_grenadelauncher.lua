if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
else
	killicon.AddFont("wep_jack_hmcd_shotgun", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_shotgun")
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_shotgun"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Milkor MGL"
SWEP.Instructions = "This is a lightweight 40 mm six-shot revolver-type grenade launcher. На самом деле гранатами стреляет там одна секунда и алах бабах происходит\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts."
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.SlotPos = 2
SWEP.ViewModel = "models/weapons/v_jmod_milkormgl.mdl"
SWEP.WorldModel = "models/weapons/w_jmod_milkormgl.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 15
SWEP.NumProjectiles = 8
SWEP.Spread = .0285
SWEP.Category="HMCD: Union - Explosives"
SWEP.SprintPos = Vector(5, -1, -1)
SWEP.SprintAng = Angle(-20, 70, -40)
SWEP.AimPos = Vector(-3.55, -1.5, 1.1)
SWEP.SightAimPos = Vector(-1.95, -1.5, 0.6)
SWEP.SightAimPos2 = Vector(-1.95, -2.5, 0.45)
SWEP.SightAimPos3 = Vector(-1.95, -2.5, 0.45)
SWEP.LaserAimPos = Vector(-1.95, -1.5, 0.45)
SWEP.AltAimPos = Vector(-1.95, -1.5, 1.1)
SWEP.ReloadRate = .5
SWEP.AmmoType = "Buckshot"
SWEP.SuppressedRifle = false
SWEP.SightRifle = false
SWEP.SightRifle2 = false
SWEP.SightRifle3 = false
SWEP.LaserRifle = false
SWEP.AttBone = "body"
SWEP.AimTime = 5
SWEP.BearTime = 7
SWEP.TriggerDelay = .1
SWEP.Angle1 = -90
SWEP.Angle2 = -1.3
SWEP.Angle3 = 0.04
SWEP.CycleTime = .9
SWEP.Recoil = 2
SWEP.Supersonic = false
SWEP.Accuracy = .99
SWEP.HipFireInaccuracy = .07
SWEP.CloseFireSound = "shtg_remington870/remington_fire_01.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_sht_far.wav"
--SWEP.CloseFireSound="toz_shotgun/toz_fp.wav"
SWEP.SuppressedFireSound = "toz_shotgun/toz_suppressed_fp.wav"
SWEP.FarFireSound = "toz_shotgun/toz_dist.wav"
SWEP.CycleSound = "snd_jack_hmcd_shotpump.wav"
SWEP.ENT = "ent_jack_hmcd_grenadelauncher"
SWEP.MuzzleEffect = "pcf_jack_mf_mshotgun"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.MuzzleAttachment = "gbib"
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.DeathDroppable = false
SWEP.ShellType = ""
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.FuckedWorldModel = false
SWEP.ReloadSound = "snd_jack_shotguninsert.wav"
SWEP.ReloadType = "individual"
SWEP.FireAnim = "fire"
SWEP.CycleType = "auto"
SWEP.BarrelLength = 10
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(3.5,-10,-6)
SWEP.HolsterAng=Angle(160,105,180)
SWEP.CarryWeight = 5000
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.SuppressorPos = Vector(4.1, -5.2, 4.3)
SWEP.SuppressorAng = Angle(-20, -185, 0)
SWEP.SuppressorModel = "models/weapons/tfa_ins2/upgrades/att_suppressor_12ga.mdl"
SWEP.SuppressorSize = .7
SWEP.LaserPos = Vector(2.5, -6.5, 4.5)
SWEP.LaserAng = Angle(-20, -190, 0)
SWEP.LaserModel = "models/cw2/attachments/anpeq15.mdl"
SWEP.Sight1Pos = Vector(2.5, -7, 4.5)
SWEP.Sight1Ang = Angle(-20, -185, 0)
SWEP.Sight1Model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl"
SWEP.Sight2Pos = Vector(2.5, -6, 4.5)
SWEP.Sight2Ang = Angle(-20, -185, 0)
SWEP.Sight2Model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl"
SWEP.Sight3Pos = Vector(2.5, -6, 4.5)
SWEP.Sight3Ang = Angle(-20, -185, 0)
SWEP.Sight3Model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl"
SWEP.ShellAttachment = 1
SWEP.DrawAnim = "draw"
SWEP.FireAnim = "fire"
SWEP.IronFireAnim = "fire"
SWEP.StallAnim = "reload_end"
SWEP.StallTime = .1
SWEP.LoadAnim = "reload_loop"
SWEP.LoadFinishAnim = "reload_end"
SWEP.StartReloadAnim = "reload_start"

SWEP.MuzzlePos = {25.7, -5.7, 2.1}

SWEP.ShellDelay = .45

SWEP.BulletDir = {400, 1.95, -1.25}

SWEP.UseHands = true
SWEP.ShellEffect = ""

SWEP.Attachments = {
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = 1
			},
			ang = {
				forward = 180,
				right = 10
			}
		}
	}
}

function SWEP:ThrowGrenade()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local Grenade = ents.Create("ent_jack_hmcd_m67")
	Grenade.HmcdSpawned = self.HmcdSpawned
	Grenade:SetAngles(VectorRand():Angle())
	Grenade:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector())
	Grenade.Owner = self:GetOwner()
	Grenade.TimeLeft = timer.TimeLeft(tostring(self:GetOwner()) .. "ExplodeTimer")
	Grenade:Spawn()
	Grenade:Activate()
	Grenade:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity() + self:GetOwner():GetAimVector() * 1500)
	Grenade:Arm()
	Grenade.SpoonOut = false
	Grenade.DetTime = CurTime() + 1
	self:GetOwner():SetLagCompensated(false)
	self.NotLoot = true
end

function SWEP:PrimaryAttack()
	if self:Clip1() <= 0 then return end
	if not self:GetReady() then return end
	if self.SprintingWeapon > 10 then return end
	if self.Reloading then return end
	self:DoBFSAnimation(self.FireAnim)
	self:EmitSound("weapons/m84/m84_detonate.wav")
	self:ThrowGrenade()
	self:TakePrimaryAmmo(1)
	self:DoBFSAnimation(self.FireAnim)
	self:SetNextPrimaryFire(CurTime() + self.TriggerDelay + self.CycleTime)
	self:GetOwner():ViewPunch(AngleRand(-8, 8))
end