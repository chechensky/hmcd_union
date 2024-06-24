--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_remington.lua
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
else
	killicon.AddFont("wep_jack_hmcd_shotgun", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_ins2_remington_m870")
end

SWEP.IconTexture = "vgui/hud/tfa_ins2_remington_m870"
SWEP.IconLength = 3
SWEP.IconHeight = 2
SWEP.Base = "wep_cat_base"
SWEP.PrintName = "Remington 870"
SWEP.Instructions = "This is a typical pump-action shotgun used by law enforcement. It has a 6-round magazine and fires beanbag rounds.\n\nLMB to fire.\nRMB to aim.\nRELOAD to reload.\nShot placement counts."
SWEP.Primary.ClipSize = 6
SWEP.SlotPos = 2
SWEP.ViewModel = "models/weapons/smc/r870/c_remington_m870.mdl"
SWEP.WorldModel = "models/weapons/smc/r870/w_remington_m870.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 10
SWEP.Traumatic = true
SWEP.SprintPos = Vector(10, -1, -1)
SWEP.SprintAng = Angle(-20, 70, -40)
SWEP.AimPos = Vector(-2.4, -1.5, 1.4)
SWEP.ReloadRate = .5
SWEP.AmmoType = "Buckshot"
SWEP.AimTime = 5
SWEP.BearTime = 7
SWEP.TriggerDelay = .1
SWEP.CycleTime = .9
SWEP.Recoil = 1
SWEP.Supersonic = false
SWEP.Category="HMCD: Union - Shotguns"
SWEP.Accuracy = .99
SWEP.HipFireInaccuracy = .07
SWEP.CloseFireSound = "shtg_remington870/remington_fire_01.wav"
--SWEP.SuppressedFireSound="snd_jack_hmcd_supppistol.wav"
--SWEP.FarFireSound="snd_jack_hmcd_sht_far.wav"
--SWEP.CloseFireSound="toz_shotgun/toz_fp.wav"
SWEP.SuppressedFireSound = "toz_shotgun/toz_suppressed_fp.wav"
SWEP.FarFireSound = "toz_shotgun/toz_dist.wav"
SWEP.ENT = "ent_jack_hmcd_remington"
SWEP.MuzzleEffect = ""
SWEP.MuzzleEffectSuppressed = "pcf_jack_mf_suppressed"
SWEP.MuzzleAttachment = "gbib"
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.DeathDroppable = false
SWEP.IronFireAnim = "iron_fire_" .. math.random(1, 2) .. ""
SWEP.FireAnim = "base_fire_" .. math.random(1, 2) .. ""
SWEP.IronCockAnim = "iron_fire_cock_" .. math.random(1, 2) .. ""
SWEP.CockAnim = "base_fire_cock_" .. math.random(1, 2) .. ""
SWEP.LastFireAnim = "base_firelast"
SWEP.LastIronFireAnim = "iron_fire_last"
SWEP.DrawAnim = "base_draw"
SWEP.UseHands = true
SWEP.CockAnimDelay = .25
SWEP.ShellType = ""
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.FuckedWorldModel = true
SWEP.ReloadSound = "snd_jack_shotguninsert.wav"
SWEP.ReloadType = "individual"
SWEP.CycleType = "manual"
SWEP.BarrelLength = 10
SWEP.HolsterSlot=1
SWEP.HolsterPos=Vector(3.5,0,-4)
SWEP.HolsterAng=Angle(160,5,180)
SWEP.CarryWeight = 5000
SWEP.ShellEffect = "eff_jack_hmcd_beanbag"
SWEP.ShellAttachment = 3

SWEP.MuzzlePos = {25.7, -5.7, 2.1}

SWEP.ShellDelay = .45
SWEP.InsHands = true

SWEP.BulletDir = {400, 2.5, -2}

SWEP.CycleSound = "snd_jack_hmcd_shotpump.wav"
SWEP.NoCocking = true
SWEP.StallAnim = "base_reload_end"
SWEP.StallTime = .5
SWEP.LoadAnim = "base_reload_insert"
SWEP.LoadFinishAnim = "base_reload_end"
SWEP.StartReloadAnim = "base_reload_start"
SWEP.ReloadSoundDelay = .3

SWEP.Attachments = {
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = 1,
				up = -1.5,
				forward = 4
			},
			ang = {
				forward = 180,
				right = 10
			}
		}
	}
}