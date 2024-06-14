--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_crossbow.lua
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
	killicon.AddFont("wep_jack_hmcd_rifle", "HL2MPTypeDeath", "1", Color(255, 0, 0))
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_crossbow")
end

SWEP.Base = "wep_jack_hmcd_firearm_base"
SWEP.IconTexture = "vgui/wep_jack_hmcd_crossbow"
SWEP.IconLength = 2
SWEP.PrintName = "Crossbow"
SWEP.Instructions = "This is a ranged weapon that fires red-hot bolts of steel rebar, constructed by Resistance fighters from the scavenged junk and debris.\nRMB to aim.\nRELOAD to reload.\nShot placement counts.\nCrouching helps stability."
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.ViewModel = "models/weapons/c_crossbow_h.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.ViewModelFlip = false
SWEP.Damage = 115
SWEP.UseHands = true
SWEP.SprintPos = Vector(15, -3, -6)
SWEP.SprintAng = Angle(0, 60, -30)
SWEP.AimPos = Vector(-5.8, -7, .3)
SWEP.AltAimPos = Vector(1.8, -3.3, 1.5)
SWEP.AimAng = Angle(1, 0, 0)
SWEP.ReloadTime = 4.5
SWEP.ReloadRate = .75
SWEP.ReloadSound = ""
SWEP.AmmoType = "XBowBolt"
SWEP.TriggerDelay = .2
SWEP.CycleTime = 1.2
SWEP.Recoil = 0.5
SWEP.Supersonic = false
SWEP.Accuracy = .9999
SWEP.ShotPitch = 100
SWEP.World_MuzzleAttachmentName="muzzle"
SWEP.ENT = "ent_jack_hmcd_crossbow"
SWEP.DeathDroppable = false
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.Category="HMCD: Union - Other"
SWEP.CycleType = ""
SWEP.ReloadType = "magazine"
SWEP.DrawAnim = "draw"
SWEP.DrawAnimEmpty = "draw_empty"
SWEP.FireAnim = "fire"
SWEP.ReloadAnim = "reload"
SWEP.CloseFireSound = "weapons/crossbow/fire1.wav"
SWEP.FarFireSound = ""
SWEP.ShellType = ""
SWEP.Scoped = true
SWEP.ViewModelFOV = 80
SWEP.ScopeFoV = 15
SWEP.ScopedSensitivity = .1
SWEP.BarrelLength = 18
SWEP.AimTime = 6.25
SWEP.BearTime = 9
SWEP.FuckedWorldModel = true
SWEP.HipHoldType = "ar2"
SWEP.AimHoldType = "ar2"
SWEP.DownHoldType = "passive"
SWEP.MuzzleEffect = ""
SWEP.HipFireInaccuracy=.05
SWEP.HolsterPos=Vector(1.5,1,-4)
SWEP.HolsterAng=Angle(150,5,90)
SWEP.HipFireInaccuracy = .05
SWEP.CarryWeight = 2000
SWEP.Foved = 11

SWEP.MuzzlePos = {0, 0, 0}

SWEP.DrawRate = 1
SWEP.NoBulletInChamber = true
SWEP.ReloadAdd = 0

SWEP.ReloadSounds = {
	{"weapons/crossbow/crossbow_draw.wav", 0.9, "Both"},
	{"weapons/crossbow/bolt_load" .. math.random(1, 2) .. ".wav", 3, "Both"}
}

SWEP.BulletDir = {400, 0.3, -1}

SWEP.Attachments = {
	["Viewer"] = {
		["Weapon"] = {
			pos = {
				right = -1.4,
				up = 0,
				forward = 0
			},
			ang = {
				forward = 180,
				right = 15
			}
		}
	}
}

if CLIENT then

	function SWEP:DrawHUD()
    ply = self:GetOwner()
    local muzzle = ply:GetViewModel():GetAttachment(4)
    local rt = {
        x = 0,
        y = 0,
        w = 512,
        h = 512,
        angles = muzzle.Ang+Angle(0,0,181),
        origin = muzzle.Pos,
        drawviewmodel = false,
        fov = self.Foved,
        znear = 1,
        zfar = 26000
    }
    rt.angles[3] = rt.angles[3] -180
    self.rtmat = GetRenderTarget("huy-glass", 512, 512, false)  
    self.mat = Material("models/weapons/v_crossbow/lensdirt")
    self.mat:SetTexture("$basetexture",self.rtmat)
	
	self.mat2 = Material("models/weapons/v_crossbow/lens")
	self.mat:SetTexture("$basetexture",self.rtmat)

    render.PushRenderTarget(self.rtmat, 0, 0, 512, 512)
        local old = DisableClipping(true)
        render.Clear(1,1,1,255)
        render.RenderView( rt )

        cam.Start2D()
			surface.SetDrawColor(0, 0, 0, 255 - self.AimPerc * 2.55)
            surface.DrawTexturedRectRotated( 256, 256, 512, 512, 0 )
		if self.AimPerc > 55 then
            surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial(Material("vgui/arc9_eft_shared/reticles/scope_25_4mm_vomz_pilad_4x32m_mark.png"))
            surface.DrawTexturedRectRotated( 256, 256, 512, 512, 0 )
		end
        cam.End2D()
        DisableClipping(old)
    render.PopRenderTarget()
	end

end

function SWEP:AltPrimaryFire()
	if CLIENT then return end
	self:GetOwner():SetLagCompensated(true)
	local Bolt = ents.Create("ent_jack_hmcd_arrow")
	Bolt.Model = "models/crossbow_bolt.mdl"
	Bolt.FleshyImpactSound = "weapons/crossbow/bolt_skewer1.wav"
	Bolt.Damage = 160
	Bolt.PenetrationPower = 70
	Bolt.HmcdSpawned = self.HmcdSpawned
	Bolt:SetPos(self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 50 + self:GetOwner():GetRight() * 2 + self:GetOwner():GetUp() * -0.5)
	Bolt.Owner = self:GetOwner()
	local Ang = self:GetOwner():GetAimVector():Angle()
	Ang:RotateAroundAxis(Ang:Right(), -180)
	Bolt:SetAngles(Ang)
	Bolt.Fired = true
	Bolt.InitialDir = self:GetOwner():GetAimVector()
	Bolt.InitialVel = self:GetOwner():GetVelocity()
	Bolt.Poisoned = self:GetOwner().HMCD_AmmoPoisoned
	self:GetOwner().HMCD_AmmoPoisoned = false
	Bolt:Spawn()
	Bolt:Activate()
	self:GetOwner():SetLagCompensated(false)
	self:GetOwner():GetViewModel():SetSkin(0)
end