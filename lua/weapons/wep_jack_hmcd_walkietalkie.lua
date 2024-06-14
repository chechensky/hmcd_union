--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/weapons/wep_jack_hmcd_walkietalkie.lua
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
	killicon.AddFont("wep_jack_hmcd_walkietalkie", "HL2MPTypeDeath", "5", Color(0, 0, 255, 255))

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
SWEP.ViewModel = "models/sirgibs/ragdoll/css/terror_arctic_radio.mdl"
SWEP.WorldModel = "models/sirgibs/ragdoll/css/terror_arctic_radio.mdl"

if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/wep_jack_hmcd_walkietalkie")
	SWEP.BounceWeaponIcon = false
end

SWEP.IconTexture = "vgui/wep_jack_hmcd_walkietalkie"
SWEP.PrintName = "Walkie Talkie"
SWEP.Instructions = "This is an average consumer-grade medium-range walkie talkie. Use it to communicate (or to spy on communications).\n\nWith this in hand, anything you say in chat is broadcast to all individuals who also have a walkie talkie in their possession, regardless of distance or line-of-sight.\n\nPress LMB to increase the frequency.\nPress RMB to decrease the frequency.\nR to check current frequency.\nE+R to toggle."
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.BobScale = 3
SWEP.SwayScale = 3
SWEP.Weight = 3
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.CommandDroppable = false
SWEP.DeathDroppable = false
SWEP.Category="HMCD: Union - Other"
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
SWEP.ENT = "ent_jack_hmcd_walkietalkie"
SWEP.DownAmt = 0
SWEP.HomicideSWEP = true
SWEP.CarryWeight = 800
SWEP.CommandDroppable = true
SWEP.Spawnable = true

SWEP.Frequencies = {"79.7", "88.5", "91.5", "110.9", "118.8", "123.0", "131.8", "146.2", "156.7", "167.9"}

SWEP.NextToggle = 0
SWEP.Disabled = false
SWEP.AllowDuringBuytime = true

function SWEP:Initialize()
	self:SetHoldType("normal")
	self.DownAmt = 20
	self:SetFrequency(self.Frequencies[1])
	self.CurrentPos = 1

	if SERVER then
		timer.Simple(.1, function()
			if IsValid(self) then
				self:GetOwner():SetName(self:GetOwner():GetName())

				for i, ply in player.Iterator() do
					local wep = ply:GetWeapon("wep_jack_hmcd_walkietalkie")

					if ply ~= self:GetOwner() and IsValid(wep) and wep:GetFrequency() == self:GetFrequency() and not IsValid(ply.Mics["Ents"][self:GetOwner():EntIndex()]) then
						self:CreateMic(ply, self:GetOwner())

						if ply:GetActiveWeapon() == wep then
							self:CreateMic(ply, self:GetOwner())
						end
					end
				end

				for i, radio in pairs(ents.FindByClass("ent_jack_hmcd_walkietalkie")) do
					if radio.Frequency == self:GetFrequency() then
						self:CreateMic(self:GetOwner(), radio)
					end
				end
			end
		end)
	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("String", 0, "Frequency")
end

function SWEP:PrimaryAttack()
	if SERVER and not self.Disabled then
		if self.Frequencies[self.CurrentPos + 1] then
			self.CurrentPos = self.CurrentPos + 1
		else
			self.CurrentPos = 1
		end

		self:GetOwner():EmitSound("radiotune.mp3", 90, math.random(90, 110))
		self:SetFrequency(self.Frequencies[self.CurrentPos])
		self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Frequency switched to " .. self:GetFrequency() .. " MHz")
		self:SetNextPrimaryFire(CurTime() + 1.2)
		self:SetNextSecondaryFire(CurTime() + 1.2)
		self.NextToggle = CurTime() + 1.2

		for i, mic in pairs(self:GetOwner().Mics["Ents"]) do
			mic:Remove()
		end

		local ind = self:GetOwner():EntIndex()

		for i, ply in player.Iterator() do
			if ply.Mics and ply.Mics["Ents"][self:GetOwner():EntIndex()] then
				ply.Mics["Ents"][self:GetOwner():EntIndex()]:Remove()
				ply.Mics["Ents"][self:GetOwner():EntIndex()] = nil
				ply.Mics["Players"][self:GetOwner():EntIndex()] = nil
			end

			ply:SendLua("if not(GAMEMODE.RadioHolders) then GAMEMODE.RadioHolders={} end GAMEMODE.RadioHolders[tonumber(" .. ind .. ")]=" .. self:GetFrequency())
		end

		self:GetOwner().Mics["Players"] = {}
		self:GetOwner().Mics["Ents"] = {}

		for i, ply in player.Iterator() do
			local wep = ply:GetWeapon("wep_jack_hmcd_walkietalkie")

			if IsValid(wep) and wep:GetFrequency() == self:GetFrequency() and ply ~= self:GetOwner() and not IsValid(self:GetOwner().Mics["Ents"][ply:EntIndex()]) then
				self:CreateMic(self:GetOwner(), ply)

				if ply:GetActiveWeapon() == wep then
					self:CreateMic(ply, self:GetOwner())
				end
			end
		end

		for i, radio in pairs(ents.FindByClass("ent_jack_hmcd_walkietalkie")) do
			if radio.Frequency == self:GetFrequency() then
				self:CreateMic(self:GetOwner(), radio)
			end
		end
	end
end

function SWEP:CreateMic(listener, speaker)
	local mic = ents.Create("env_microphone")
	mic:SetName("micro_" .. mic:EntIndex())
	mic:SetPos(listener:GetPos())
	mic:SetParent(listener)
	mic:SetKeyValue("target", mic:GetName())
	mic:SetKeyValue("speaker_dsp_preset", "59")
	mic:SetKeyValue("Sensitivity", "1")

	if speaker:GetClass() == "ent_jack_hmcd_walkietalkie" then
		mic:SetKeyValue("MaxRange", "125")
	else
		mic:SetKeyValue("MaxRange", "250")
	end

	if not speaker:IsPlayer() then
		speaker:SetName("speaker_" .. speaker:EntIndex())
	end

	mic:AddFlags(16)
	mic:Fire("SetSpeakerName", speaker:GetName())
	mic:Spawn()
	mic:Activate()
	mic:Fire("Disable")
	listener.Mics["Ents"][speaker:EntIndex()] = mic
	listener.Mics["Players"][speaker:EntIndex()] = speaker
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + 1)
	self.DownAmt = 20

	if SERVER then
		for i, ply in player.Iterator() do
			local wep = ply:GetWeapon("wep_jack_hmcd_walkietalkie")

			if IsValid(wep) and wep:GetFrequency() == self:GetFrequency() and ply ~= self:GetOwner() and not IsValid(self:GetOwner().Mics["Ents"][ply:EntIndex()]) then
				self:CreateMic(self:GetOwner(), ply)
			end
		end

		for i, radio in pairs(ents.FindByClass("ent_jack_hmcd_walkietalkie")) do
			if radio.Frequency == self:GetFrequency() and not radio.Deleting then
				self:CreateMic(self:GetOwner(), radio)
			end
		end
	end

	return true
end

function SWEP:Holster(newWep)
	if SERVER then
		for i, mic in pairs(self:GetOwner().Mics["Ents"]) do
			mic:Remove()
		end

		self:GetOwner().Mics["Players"] = {}
		self:GetOwner().Mics["Ents"] = {}
	end

	return true
end

function SWEP:OnRemove()
	if SERVER and IsValid(self:GetOwner()) and self:GetOwner().Mics then
		for i, mic in pairs(self:GetOwner().Mics["Ents"]) do
			mic:Remove()
		end

		self:GetOwner().Mics["Players"] = {}
		self:GetOwner().Mics["Ents"] = {}
		local ind = self:GetOwner():EntIndex()

		for i, ply in player.Iterator() do
			if ply.Mics and ply.Mics["Ents"][self:GetOwner():EntIndex()] then
				ply.Mics["Ents"][self:GetOwner():EntIndex()] = nil
				ply.Mics["Players"][self:GetOwner():EntIndex()] = nil
			end

			ply:SendLua("if GAMEMODE.RadioHolders then GAMEMODE.RadioHolders[tonumber(" .. ind .. ")]=nil end")
		end
	end
end

function SWEP:SecondaryAttack()
	if SERVER and not self.Disabled then
		if self.Frequencies[self.CurrentPos - 1] then
			self.CurrentPos = self.CurrentPos - 1
		else
			self.CurrentPos = #self.Frequencies
		end

		self:GetOwner():EmitSound("radiotune.mp3", 90, math.random(90, 110))
		self:SetFrequency(self.Frequencies[self.CurrentPos])
		self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Frequency switched to " .. self:GetFrequency() .. " MHz")
		self:SetNextPrimaryFire(CurTime() + 1.2)
		self:SetNextSecondaryFire(CurTime() + 1.2)
		self.NextToggle = CurTime() + 1.2

		for i, mic in pairs(self:GetOwner().Mics["Ents"]) do
			mic:Remove()
		end

		local ind = self:GetOwner():EntIndex()

		for i, ply in player.Iterator() do
			if ply.Mics and ply.Mics["Ents"][self:GetOwner():EntIndex()] then
				ply.Mics["Ents"][self:GetOwner():EntIndex()]:Remove()
				ply.Mics["Ents"][self:GetOwner():EntIndex()] = nil
				ply.Mics["Players"][self:GetOwner():EntIndex()] = nil
			end

			ply:SendLua("if not(GAMEMODE.RadioHolders) then GAMEMODE.RadioHolders={} end GAMEMODE.RadioHolders[tonumber(" .. ind .. ")]=" .. self:GetFrequency())
		end

		self:GetOwner().Mics["Players"] = {}
		self:GetOwner().Mics["Ents"] = {}

		for i, ply in player.Iterator() do
			local wep = ply:GetWeapon("wep_jack_hmcd_walkietalkie")

			if IsValid(wep) and wep:GetFrequency() == self:GetFrequency() and ply ~= self:GetOwner() and not IsValid(self:GetOwner().Mics["Ents"][ply:EntIndex()]) then
				self:CreateMic(self:GetOwner(), ply)

				if ply:GetActiveWeapon() == wep then
					self:CreateMic(ply, self:GetOwner())
				end
			end
		end
	end
end

function SWEP:Think()
end

--
function SWEP:Reload()
	if SERVER and self.NextToggle < CurTime() then
		self.NextToggle = CurTime() + 1.2
		self:SetNextPrimaryFire(self.NextToggle)
		self:SetNextSecondaryFire(self.NextToggle)

		if not self:GetOwner():KeyDown(IN_USE) then
			if not self.Disabled then
				self:GetOwner():PrintMessage(HUD_PRINTCENTER, self:GetFrequency() .. " MHz")
			else
				self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Disabled")
			end
		else
			local ind = self:GetOwner():EntIndex()

			if self.Disabled then
				self:SetFrequency(self.Frequencies[self.CurrentPos])
				self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Enabled")

				for i, ply in player.Iterator() do
					local wep = ply:GetWeapon("wep_jack_hmcd_walkietalkie")

					if IsValid(wep) and wep:GetFrequency() == self:GetFrequency() and ply ~= self:GetOwner() and not IsValid(self:GetOwner().Mics["Ents"][ply:EntIndex()]) then
						self:CreateMic(self:GetOwner(), ply)

						if ply:GetActiveWeapon() == wep then
							self:CreateMic(ply, self:GetOwner())
						end
					end

					ply:SendLua("if not(GAMEMODE.RadioHolders) then GAMEMODE.RadioHolders={} end GAMEMODE.RadioHolders[tonumber(" .. ind .. ")]=" .. self:GetFrequency())
				end

				for i, radio in pairs(ents.FindByClass("ent_jack_hmcd_walkietalkie")) do
					if radio.Frequency == self:GetFrequency() then
						self:CreateMic(self:GetOwner(), radio)
					end
				end
			else
				self:SetFrequency(self:GetOwner():Nick())
				self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Disabled")

				for i, mic in pairs(self:GetOwner().Mics["Ents"]) do
					mic:Remove()
				end

				for i, ply in player.Iterator() do
					if ply.Mics and ply.Mics["Ents"][self:GetOwner():EntIndex()] then
						ply.Mics["Ents"][self:GetOwner():EntIndex()]:Remove()
						ply.Mics["Ents"][self:GetOwner():EntIndex()] = nil
						ply.Mics["Players"][self:GetOwner():EntIndex()] = nil
					end

					ply:SendLua("if not(GAMEMODE.RadioHolders) then GAMEMODE.RadioHolders={} end GAMEMODE.RadioHolders[tonumber(" .. ind .. ")]=nil")
				end

				self:GetOwner().Mics["Players"] = {}
				self:GetOwner().Mics["Ents"] = {}
			end

			self:GetOwner():EmitSound("radiotune.mp3", 90, math.random(90, 110))
			self.Disabled = not self.Disabled
		end
	end
end

function SWEP:OnDrop()
	local Ent = ents.Create(self.ENT)
	Ent.HmcdSpawned = self.HmcdSpawned
	Ent:SetPos(self:GetPos())
	Ent:SetAngles(self:GetAngles())
	Ent.Frequency = self:GetFrequency()
	Ent.Disabled = self.Disabled
	Ent.CurrentPos = self.CurrentPos
	Ent:Spawn()
	Ent:Activate()
	Ent:GetPhysicsObject():SetVelocity(self:GetVelocity() / 2)
	self:Remove()
end

--[[if((ply)and(ply.Alive)and(ply:Alive())and(ply.HasWeapon)and(ply:HasWeapon("wep_jack_hmcd_walkietalkie")))then
	sound.Play("ambient/levels/prison/radio_random"..math.random(1,15)..".wav",self:GetOwner():GetShootPos(),75,math.random(95,105))
end]]
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

		pos = pos - ang:Up() * (self.DownAmt + 47) + ang:Forward() * 20 + ang:Right() * 5
		ang:RotateAroundAxis(ang:Up(), -90)
		--ang:RotateAroundAxis(ang:Right(),-10)
		--ang:RotateAroundAxis(ang:Forward(),-10)

		return pos, ang
	end

	function SWEP:DrawWorldModel()
		local Pos, Ang = self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_L_Hand"))

		if self.DatWorldModel then
			if Pos and Ang then
				self.DatWorldModel:SetRenderOrigin(Pos - Ang:Up() * 50 - Ang:Right() * 8 + Ang:Forward() * 3)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel = ClientsideModel("models/sirgibs/ragdoll/css/terror_arctic_radio.mdl")
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			self.DatWorldModel:SetModelScale(1.25, 0)
		end
	end
end