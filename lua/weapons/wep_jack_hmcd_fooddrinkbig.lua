--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_fooddrinkbig.lua
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
	SWEP.Slot = 3
	SWEP.SlotPos = 2
	killicon.AddFont("wep_jack_hmcd_food", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/foodnhouseholditems/mcdburgerbox.mdl"
SWEP.WorldModel = "models/foodnhouseholditems/mcdburgerbox.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_fooddrink")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_fooddrink"
SWEP.PrintName = "Large Consumable"
SWEP.Instructions = "This is an item that you can eat/drink. Doing so grants a stamina-regeneration boost as well as some slow health regeneration.\n\nLMB to eat/drink."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Category="HMCD: Union - Food"
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
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
SWEP.ENT = "ent_jack_hmcd_fooddrinkbig"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 1000

local drink_food = {
	"models/foodnhouseholditems/cola.mdl",
	"models/foodnhouseholditems/juice.mdl",
	"models/foodnhouseholditems/juicesmall.mdl",
	"models/foodnhouseholditems/milk.mdl",
	"models/jorddrink/cozcan01a.mdl",
	"models/jorddrink/crucan01a.mdl",
	"models/jorddrink/dewcan01a.mdl",
	"models/jorddrink/foscan01a.mdl",
	"models/jorddrink/heican01a.mdl",
	"models/jorddrink/mongcan1a.mdl",
	"models/jorddrink/pepcan01a.mdl",
	"models/jorddrink/redcan01a.mdl",
	"models/jorddrink/the_bottle_of_water.mdl",
	"models/foodnhouseholditems/mcddrink.mdl",
	"models/jorddrink/7upcan01a.mdl",
	"models/jorddrink/barqcan1a.mdl"
}

local eat_food = {
	"models/foodnhouseholditems/applejacks.mdl",
	"models/foodnhouseholditems/cheerios.mdl",
	"models/foodnhouseholditems/chipsfritos.mdl",
	"models/foodnhouseholditems/chipslays3.mdl",
	"models/foodnhouseholditems/chipslays5.mdl",
	"models/foodnhouseholditems/kellogscornflakes.mdl",
	"models/foodnhouseholditems/mcdburgerbox.mdl",
	"models/foodnhouseholditems/mcdfrenchfries.mdl",
	"models/jordfood/capncrunch.mdl",
	"models/jordfood/canned_burger.mdl",
	"models/jordfood/can.mdl",
	"models/jordfood/cakes.mdl",
	"models/jordfood/atun.mdl",
	"models/jordfood/jtun.mdl",
	"models/jordfood/girlscout_cookies.mdl",
	"models/jordfood/prongleclosedfilledgreen.mdl",
	"models/foodnhouseholditems/miniwheats.mdl"
}

function SWEP:Initialize()
	self:SetHoldType("slam")
	self.DownAmt = 20

	if SERVER then
		local eat = table.Random(eat_food)
		local drink = table.Random(drink_food)
		if math.random(1, 2) == 1 then
			self:SetRandomModel(eat)
			self.Drink = false
		else
			self:SetRandomModel(drink)
			self.Drink = true
		end
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("String", 0, "RandomModel")
end

function SWEP:PrimaryAttack()
	if SERVER then
	if self:GetOwner().Bones['Jaw']<=0.6 then return end

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)

		if self.Poisoned and self:GetOwner().Murderer then
			self:GetOwner():PrintMessage(HUD_PRINTCENTER, "This is poisoned!")
			self:SetNextPrimaryFire(CurTime() + 1)

			return
		end

		if self.Drink then
			sound.Play("snd_jack_hmcd_drink" .. math.random(1, 3) .. ".wav", self:GetOwner():GetShootPos(), 60, math.random(90, 100))
		else
			sound.Play("snd_jack_hmcd_eat" .. math.random(1, 4) .. ".wav", self:GetOwner():GetShootPos(), 60, math.random(90, 100))
		end

		if self.Infected then
			self:GetOwner():AddBacteria(45, CurTime() - 101)
		end

		if self.Poisoned then
			HMCD_Poison(self:GetOwner(), self.Poisoner, "CyanidePowder")
		end

		self:GetOwner().stamina['leg'] = self:GetOwner().stamina['leg'] + 20
		self:GetOwner():SetHealth(self:GetOwner():Health() + 5)
		if self:GetOwner():Health() > 150 then self:GetOwner():SetHealth(150) end
		if self:GetOwner().stamina['leg'] > 50 then self:GetOwner().stamina['leg'] = 50 end 
		self:SetNextPrimaryFire(CurTime() + 1)
		self:Remove()
	end
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + 1)
	self.DownAmt = 20

	return true
end

function SWEP:SecondaryAttack()
end

--
function SWEP:Think()
	if SERVER then
		local HoldType = "slam"

		if self:GetOwner():KeyDown(IN_SPEED) then
			HoldType = "normal"
		end

		self:SetHoldType(HoldType)
	end
end

function SWEP:Reload()
end

--
function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent.RandomModel = self:GetRandomModel()
	Ent.Poisoned = self.Poisoned
	Ent.Poisoner = self.Poisoner
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

if CLIENT then
	function SWEP:PreDrawViewModel(vm, ply, wep)
		vm:SetModel(self:GetRandomModel())
	end

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 0
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 20)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 20)
		end

		pos = pos - ang:Up() * (self.DownAmt + 10) + ang:Forward() * 25 + ang:Right() * 7
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), -10)
		ang:RotateAroundAxis(ang:Forward(), -10)

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos + Ang:Forward() * 4 - Ang:Up() * 3)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel(self:GetRandomModel())
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
		end
	end
end