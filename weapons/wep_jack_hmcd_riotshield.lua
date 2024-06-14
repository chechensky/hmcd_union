--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_riotshield.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]
AddCSLuaFile()
SWEP.Spawnable = true

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_riotshield")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_riotshield"
SWEP.IconLength = 2
SWEP.IconHeight = 2
SWEP.PrintName = "Riot Shield"
SWEP.Instructions = "This is a protection device made out of UHMWPE that is designed to stop or deflect bullets fired at their carrier."
SWEP.Slot = 1
SWEP.SlotPos = 3
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Spawnable = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/bshields/rshield.mdl"
SWEP.ViewModelFOV = 80
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.NoHolster = false
SWEP.HomicideSWEP = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Category="HMCD: Union - Other"
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.ENT = "ent_jack_hmcd_riotshield"
SWEP.DeathDroppable = false
SWEP.HolsterSlot=4
SWEP.HolsterPos=Vector(0,-10,0)
SWEP.HolsterAng=Angle(90,270,180)

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:Think()
	return
end

function SWEP:Holster()
	if SERVER then
		if self and self.shield then
			self.shield:Remove()
		end
	end

	return true
end

function SWEP:OnDrop()
	if IsValid(self.shield) then
		self.shield:Remove()
	end

	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

function SWEP:PrimaryAttack()
	return
end

function SWEP:SecondaryAttack()
	return
end

function SWEP:Reload()
	return
end

function SWEP:OnRemove()
	if IsValid(self.shield) then
		self.shield:Remove()
	end
end

function SWEP:Deploy()
	if SERVER then
		self:GetOwner():DrawViewModel(false)
		if IsValid(self.shield) then return end
		self:SetNoDraw(true)
		local crouchadd = 0

		if self:GetOwner():Crouching() then
			crouchadd = -17
		end

		self.shield = ents.Create("prop_physics")
		self.shield:SetModel(self.WorldModel)
		self.shield:SetPos(self:GetOwner():GetPos() + Vector(0, 0, 40 + crouchadd) + (self:GetOwner():GetForward() * 12.5))
		self.shield:SetAngles(Angle(0, self:GetOwner():EyeAngles().y - 1, 0))
		self.shield:SetParent(self:GetOwner())
		self.shield:Fire("SetParentAttachmentMaintainOffset", "eyes", 0.01)
		self.shield:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self.shield:Spawn()
		self.shield:Activate()
	end

	return true
end

function SWEP:DrawWorldModel()
	self:DrawModel()
end