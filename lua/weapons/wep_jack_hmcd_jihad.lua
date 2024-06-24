--[[File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_jihad.lua
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
	util.AddNetworkString("hmcd_splodetype")
elseif CLIENT then
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFOV = 80
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	killicon.AddFont("wep_jack_hmcd_ied", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

	function SWEP:DrawViewModel()
		return false
	end

	function SWEP:DrawWorldModel()
		self:DrawModel()
	end

	local function drawTextShadow(t, f, x, y, c, px, py)
		color_black.a = c.a
		draw.SimpleText(t, f, x + 1, y + 1, color_black, px, py)
		draw.SimpleText(t, f, x, y, c, px, py)
		color_black.a = 255
	end

	net.Receive("hmcd_splodetype", function()
		local Ent = net.ReadEntity()
		Ent.SplodeType = net.ReadInt(32)
	end)

	function SWEP:DrawHUD()
	end
end

--
SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/props_junk/cardboard_jox004a.mdl"
SWEP.WorldModel = "models/props_junk/cardboard_jox004a.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_jihad")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_jihad"
SWEP.PrintName = "Explosive Belt"
SWEP.Instructions = "This is a concealed belt rigged with military-grade explosives surrounded by nails and ball bearings, and a detonator. Use it to end your pathetic life with one final aloha snackbar.\n\nLMB to suicide"
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 2
SWEP.SwayScale = 2
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Primary.Delay = 0.5
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 120
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = -1
SWEP.Primary.Force = 900
SWEP.Category="HMCD: Union - Traitor"
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
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 3500

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:SetupDataTables()
end

--
function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end

	self:SetNextPrimaryFire(CurTime() + 2)

	if IsValid(self) then
		self:AllahuAkbar()
	end
end

function SWEP:AllahuAkbar()
	if CLIENT then return end
	self:GetOwner():LagCompensation(true)
	sound.Play("snd_jack_hmcd_jihad" .. math.random(1, 3) .. ".wav", self:GetOwner():GetShootPos(), 75, math.random(95, 105))

	timer.Simple(math.Rand(.9, 1.1), function()
		if IsValid(self) and self:GetOwner() and self:GetOwner():Alive() then
			self:GetOwner():ExplodeIED()
		end
	end)

	self:GetOwner():LagCompensation(false)
end

function SWEP:Deploy()
	if not IsFirstTimePredicted() then return end
	self.DownAmt = 16
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)

	return true
end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
end

--
function SWEP:SecondaryAttack()
end

--
function SWEP:Think()
end

--
function SWEP:Reload()
end

--
if CLIENT then
	local Hidden = 0

	function SWEP:GetViewModelPosition(pos, ang)
		if not self.DownAmt then
			self.DownAmt = 16
		end

		if self:GetOwner():KeyDown(IN_SPEED) then
			self.DownAmt = math.Clamp(self.DownAmt + .2, 0, 16)
		else
			self.DownAmt = math.Clamp(self.DownAmt - .2, 0, 16)
		end

		Hidden = 22
		local NewPos = pos + ang:Forward() * 50 - ang:Up() * (20 + self.DownAmt + Hidden) + ang:Right() * 20

		return NewPos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))

		if self.DatDetModel then
			self.DatDetModel:SetRenderOrigin(Pos + Ang:Forward() * 4 + Ang:Right() * 1)
			Ang:RotateAroundAxis(Ang:Up(), 90)
			Ang:RotateAroundAxis(Ang:Right(), 180)
			self.DatDetModel:SetRenderAngles(Ang)
			self.DatDetModel:DrawModel()
		else
			self.DatDetModel = ClientsideModel("models/weapons/w_models/w_jda_engineer.mdl")
			self.DatDetModel:SetPos(self:GetPos())
			self.DatDetModel:SetParent(self)
			self.DatDetModel:SetNoDraw(true)
			self.DatDetModel:SetModelScale(.35, 0)
		end
	end

	function SWEP:ViewModelDrawn(model)
		local Pos, Ang = model:GetPos(), model:GetAngles()

		if self.DatDetViewModel then
			if Pos and Ang then
				self.DatDetViewModel:SetRenderOrigin(Pos + Ang:Up() * 20)
				Ang:RotateAroundAxis(Ang:Up(), 180)
				Ang:RotateAroundAxis(Ang:Right(), 30)
				self.DatDetViewModel:SetRenderAngles(Ang)
				self.DatDetViewModel:DrawModel()
			end
		else
			self.DatDetViewModel = ClientsideModel("models/weapons/w_models/w_jda_engineer.mdl")
			self.DatDetViewModel:SetPos(self:GetPos())
			self.DatDetViewModel:SetParent(self)
			self.DatDetViewModel:SetNoDraw(true)
			self.DatDetViewModel:SetModelScale(.5, 0)
		end
	end
end