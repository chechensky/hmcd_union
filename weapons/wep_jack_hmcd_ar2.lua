if SERVER then
	AddCSLuaFile()
	SWEP.Spawnable = true
else
	killicon.AddFont("wep_jack_hmcd_assaultrifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_ar2")
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_ar2"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_jack_hmcd_firearm_base"
SWEP.PrintName = "OSIPR"
SWEP.Instructions = "This is a pulse assault rifle using dark energy manufactured by the combine.\n\nLMB to fire.\nLMB + E to use alternative fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability.\nBullets can ricochet and penetrate."
SWEP.Primary.ClipSize = 31
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/c_irifle_h.mdl"
SWEP.WorldModel = "models/weapons/w_irifle_h.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 45
SWEP.Primary.Automatic = true
SWEP.Category="HMCD: Union - Rifles"
SWEP.ViewModelFOV = 80
SWEP.SprintPos = Vector(10, 0, -3)
SWEP.SprintAng = Angle(-20, 40, -50)
SWEP.AimPos = Vector(-5.03, -5, 2.1)
SWEP.AimAng = Angle(0, 0, 0)
SWEP.CloseAimPos = Vector(.45, 0, 0)
SWEP.AltAimPos = Vector(-1.902, -3.2, .13)
SWEP.ReloadTime = 3.1
SWEP.ReloadRate = .6
SWEP.UseHands = true
SWEP.ReloadSound = ""
SWEP.AmmoType = "AR2"
SWEP.AltAmmoType = "MP5_Grenade"
SWEP.TriggerDelay = .05
SWEP.CycleTime = .05
SWEP.Recoil = .5
SWEP.AttBone = "RAILS_LOW_001"
SWEP.LaserRifle = false
SWEP.Supersonic = true
SWEP.Accuracy = .999
SWEP.ShotPitch = 100
SWEP.ENT = "ent_jack_hmcd_ar2"
SWEP.FuckedWorldModel = true
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.CycleType = "auto"
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "IR_draw"
SWEP.FireAnim = "fire" .. math.random(2, 4) .. ""
SWEP.LastFireAnim = "fire_last"
SWEP.IronFireAnim = "fire_nicely"
SWEP.LastIronFireAnim = "fire_last_ironsight"
SWEP.ReloadAnim = "reloadempty"
SWEP.MidEmptyFireAnim = "fire_midempty"
SWEP.MidEmptyIronFireAnim = "fire_midempty_ironsight"
SWEP.MidEmptyReloadAnim = "reload_midempty"
SWEP.DrawAnimEmpty = "draw_empty"
SWEP.TacticalReloadAnim = "IR_reload"
SWEP.CloseFireSound = "weapons/ar2/fire" .. math.random(1, 3) .. ".wav"
SWEP.FarFireSound = "snd_jack_hmcd_ar_far.wav"
SWEP.ShellType = ""
SWEP.BarrelLength = 18
SWEP.FireAnimRate = 1
SWEP.AimTime = 6
SWEP.BearTime = 7
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = "new_ar2_muzzle"
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.HipFireInaccuracy = .05
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(3,-12,0)
SWEP.HolsterAng=Angle(20,-5,180)
SWEP.CarryWeight = 4500
SWEP.ScopeDotPosition = Vector(0, 0, 0)
SWEP.ScopeDotAngle = Angle(0, 0, 0)
SWEP.NextFireTime = 0
SWEP.NextAltFireTime = 0
SWEP.SmokeEffect = "smoke_ar2"

SWEP.MuzzlePos = {25, -5, 3, .1}

SWEP.ShellEffect = ""
SWEP.ReloadAdd = 0

SWEP.ReloadSounds = {
	{"weapons/ar2/ar2_reload_rotate.wav", 0.4, "Both"},
	{"weapons/ar2/ar2_magout.wav", 0.6, "Both"},
	{"weapons/ar2/ar2_magin.wav", 2, "Both"},
	{"weapons/ar2/ar2_reload_push.wav", 2.2, "Both"}
}

SWEP.BulletDir = {400, 5.3, -3}

SWEP.SuicidePos = Vector(5, 0, -40)
SWEP.SuicideAng = Angle(90, 0, 90)
SWEP.SuicideTime = 10
SWEP.SuicideType = "Rifle"

SWEP.MuzzleInfo = {
	["Bone"] = "ar2_weapon",
	["Offset"] = Vector(10, 3, 0)
}

SWEP.Attachments = {
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 0,
				forward = 15,
				up = -1
			},
			ang = {
				forward = 180,
				up = 180
			}
		}
	}
}

SWEP.NPCAnims = {
	[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_AR1,
	[ACT_RELOAD] = ACT_RELOAD_SHOTGUN,
	[ACT_IDLE] = ACT_IDLE_RIFLE,
	[ACT_IDLE_ANGRY] = ACT_RANGE_ATTACK_AR2,
	[ACT_WALK] = ACT_WALK_RIFLE,
	[ACT_IDLE_RELAXED] = ACT_IDLE_RELAXED,
	[ACT_IDLE_STIMULATED] = ACT_IDLE_STIMULATED,
	[ACT_IDLE_AGITATED] = ACT_IDLE_ANGRY_SHOTGUN,
	[ACT_WALK_RELAXED] = ACT_WALK_RELAXED,
	[ACT_WALK_STIMULATED] = ACT_WALK_STIMULATED,
	[ACT_WALK_AGITATED] = ACT_WALK_AIM_RIFLE,
	[ACT_RUN_RELAXED] = ACT_RUN_RELAXED,
	[ACT_RUN_STIMULATED] = ACT_RUN_STIMULATED,
	[ACT_RUN_AGITATED] = ACT_RUN_AIM_RIFLE,
	[ACT_IDLE_AIM_RELAXED] = ACT_IDLE_RELAXED,
	[ACT_IDLE_AIM_STIMULATED] = ACT_IDLE_AIM_STIMULATED,
	[ACT_IDLE_AIM_AGITATED] = ACT_IDLE_ANGRY_SHOTGUN,
	[ACT_WALK_AIM_RELAXED] = ACT_WALK_RELAXED,
	[ACT_WALK_AIM_STIMULATED] = ACT_WALK_AIM_STIMULATED,
	[ACT_WALK_AIM_AGITATED] = ACT_WALK_AIM_RIFLE,
	[ACT_RUN_AIM_RELAXED] = ACT_RUN_RELAXED,
	[ACT_RUN_AIM_STIMULATED] = ACT_RUN_AIM_STIMULATED,
	[ACT_RUN_AIM_AGITATED] = ACT_RUN_AIM_RIFLE,
	[ACT_WALK_AIM] = ACT_WALK_AIM_RIFLE,
	[ACT_WALK_CROUCH] = ACT_WALK_CROUCH,
	[ACT_WALK_CROUCH_AIM] = ACT_WALK_CROUCH_AIM,
	[ACT_RUN] = ACT_RUN_RIFLE,
	[ACT_RUN_AIM] = ACT_RUN_AIM_RIFLE,
	[ACT_RUN_CROUCH] = ACT_RUN_CROUCH,
	[ACT_RUN_CROUCH_AIM] = ACT_RUN_CROUCH_AIM,
	[ACT_GESTURE_RANGE_ATTACK1] = ACT_GESTURE_RANGE_ATTACK_AR2,
	[ACT_RANGE_AIM_LOW] = ACT_RANGE_AIM_AR2_LOW,
	[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_AR2,
	[ACT_RELOAD_LOW] = ACT_RELOAD,
	[ACT_GESTURE_RELOAD] = ACT_GESTURE_RELOAD,
	[ACT_MELEE_ATTACK1] = ACT_MELEE_ATTACK1
}