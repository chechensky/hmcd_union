--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_mask.lua
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
	SWEP.Slot = 5
	SWEP.SlotPos = 3
	killicon.AddFont("wep_jack_hmcd_mask", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/props_c17/SuitCase_Passenger_Physics.mdl"
SWEP.WorldModel = "models/props_c17/SuitCase_Passenger_Physics.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_mask")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_mask"
SWEP.PrintName = "Psycho Disguise"
SWEP.Instructions = "This disguise will completely hide your true identity and probably terrify people. Use it to prevent being identified during a murder. \nLMB to equip \nRMB to unequip"
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.CommandDroppable = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Category="HMCD: Union - Traitor"
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
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.DeathDroppable = false
SWEP.DisguiseUsed = false

function SWEP:Initialize()
	self:SetHoldType("normal")
	self.DownAmt = 20
end

function SWEP:SetupDataTables()
end

--
function SWEP:PrimaryAttack()
	if CLIENT then return end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	if self:GetOwner().MurdererIdentityHidden then return end

	self:GetOwner().TrueIdentity = {
		["clothes"] = self:GetOwner().ClothingType,
		["name"] = self:GetOwner():GetNWString("Character_Name"),
		["model"] = self:GetOwner():GetModel(),
		["color"] = self:GetOwner():GetPlayerColor(),
		["sex"] = self:GetOwner().ModelSex,
		["matindex"] = self:GetOwner().ClothingMatIndex
	}

	self:GetOwner():SetModel("models/eu_homicide/mkx_jajon.mdl")
	self:GetOwner():SetClothing()
	self:GetOwner().ModelSex = "male"
	self:GetOwner().ClothingMatIndex = 0

	self:GetOwner():SetNWString("Character_Name", "Murder")
	self:GetOwner().Role = "Traitor"

	self:GetOwner():SetPlayerColor(Vector(.25, 0, 0))
	self:GetOwner():ManipulateBoneScale(self:GetOwner():LookupBone("ValveBiped.Bip01_R_UpperArm"), Vector(1, .8, .8))
	self:GetOwner():ManipulateBoneScale(self:GetOwner():LookupBone("ValveBiped.Bip01_L_UpperArm"), Vector(1, .8, .8))
	self:GetOwner():ManipulateBoneScale(self:GetOwner():LookupBone("ValveBiped.Bip01_Spine4"), Vector(1, 1, 1))
	self:GetOwner():ManipulateBoneScale(self:GetOwner():LookupBone("ValveBiped.Bip01_Spine1"), Vector(1, .7, .7))
	self:GetOwner():ManipulateBoneScale(self:GetOwner():LookupBone("ValveBiped.Bip01_Pelvis"), Vector(.8, .8, .8))
	self:GetOwner():ManipulateBoneScale(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Thigh"), Vector(.9, .9, .9))
	self:GetOwner():ManipulateBoneScale(self:GetOwner():LookupBone("ValveBiped.Bip01_L_Thigh"), Vector(.9, .9, .9))
	sound.Play("snd_jack_hmcd_disguise.wav", self:GetOwner():GetPos(), 65, 110)
	self:GetOwner().MurdererIdentityHidden = true
	self.NotLoot = true
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	timer.Simple(.5, function()
		if IsValid(self) then
			if SERVER then
				self:GetOwner():SelectWeapon("wep_jack_hmcd_knife")
			end
		end
	end)
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
	self.DownAmt = 20

	return true
end

function SWEP:SecondaryAttack()
	if CLIENT then return end

	if not self:GetOwner().MurdererIdentityHidden then return end
	local Orig = self:GetOwner().TrueIdentity
	self:GetOwner():SetModel(Orig["model"])
	self:GetOwner().ModelSex = Orig["sex"]
	self:GetOwner().ClothingMatIndex = Orig["matindex"]
	self:GetOwner():SetClothing(Orig["clothes"])
	self:GetOwner():SetNWString("Character_Name", Orig["name"])
	self:GetOwner():SetPlayerColor(Orig["color"])
	sound.Play("snd_jack_hmcd_disguise.wav", self:GetOwner():GetPos(), 65, 90)
	self:GetOwner().TrueIdentity = nil
	self:GetOwner().MurdererIdentityHidden = false
	self.NotLoot = false
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	timer.Simple(.5, function()
		if IsValid(self) then
			self:GetOwner():SelectWeapon("wep_jack_hmcd_hands")
		end
	end)
end

function SWEP:Think()
end

--
function SWEP:Reload()
end

--
function SWEP:OnDrop()
end

--
if CLIENT then
	function SWEP:PreDrawViewModel(vm, ply, wep)
	end

	--
	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 20)
		end

		pos = pos - ang:Up() * (self.DownAmt + 8) + ang:Forward() * 45 + ang:Right() * 22
		--ang:RotateAroundAxis(ang:Forward(),-90)

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 3)
				--Ang:RotateAroundAxis(Ang:Up(),90)
				Ang:RotateAroundAxis(Ang:Right(), 90)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/props_c17/SuitCase_Passenger_Physics.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			self.DatWorldModel:SetModelScale(.75, 0)
		end
	end
end