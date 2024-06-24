--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_shield.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]
AddCSLuaFile()
SWEP.Spawnable = true
SWEP.PrintName = "Ballistic Shield"
SWEP.Instructions = "This is a protection device made out of UHMWPE that is designed to stop or deflect bullets fired at their carrier."
SWEP.Slot = 1
SWEP.SlotPos = 3
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Spawnable = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/bshields/hshield.mdl"
SWEP.ViewModelFOV = 80
SWEP.CommandDroppable = true
SWEP.Spawnable = true
SWEP.HomicideSWEP = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.ENT = "ent_jack_hmcd_shield"
SWEP.Category="HMCD: Union - Other"
SWEP.DeathDroppable = false

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:Think()
	return
end

function SWEP:OnDrop()
	self.shield:Remove()
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
		self:SetNoDraw(true)
		local isValid = IsValid(self.shield)

		if not isValid then
			self.shield = ents.Create("prop_dynamic")
			self.shield:SetModel(self.WorldModel)
		end

		self.shield:SetPos(self:GetOwner():GetPos() + Vector(0, 0, 54) + (self:GetOwner():GetForward() * 11.5))
		self.shield:SetAngles(Angle(-10, self:GetOwner():EyeAngles().y, 0))

		if not isValid then
			self.shield:SetParent(self:GetOwner())
			self.shield:Fire("SetParentAttachmentMaintainOffset", "chest", 0.01)
			self.shield:SetCollisionGroup(COLLISION_GROUP_WORLD)
			self.shield:Spawn()
			self.shield:Activate()
		end
	end

	return true
end

function SWEP:DrawWorldModel()
	self:DrawModel()
end

function SWEP:Holster(newWep)
	if IsValid(self.shield) then
		self.shield:Remove()

		if IsValid(self:GetOwner()) then
			self:GetOwner():DropWeapon(self)
		end
	end

	return true
end