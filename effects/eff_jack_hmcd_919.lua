--[[
Server Name: [EU] Homicide
Server IP:   185.17.0.25:27025
File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_919.lua

--]]
EFFECT.Models = {}
EFFECT.Models[3] = Model("models/shells/fhell_9x19mm.mdl")
EFFECT.Sounds = {}

EFFECT.Sounds[3] = {
	Pitch = 90,
	Wavs = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}
}

function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then
		self.Entity:SetModel("models/shells/fhell_9x19mm.mdl")
		self.RemoveMe = true

		return
	end

	local bullettype = math.Clamp(data:GetScale() or 3, 3, 3)
	local angle, pos = self.Entity:GetBulletEjectPos(data:GetOrigin(), data:GetEntity(), data:GetAttachment())
	local direction = angle:Forward()

	if string.find(data:GetEntity():GetClass(), "ent_jack") then
		local ang = data:GetEntity():GetAngles()
		direction = ang:Forward() * data:GetEntity().BulletEjectDir[1] + ang:Right() * data:GetEntity().BulletEjectDir[2] + ang:Up() * data:GetEntity().BulletEjectDir[3]
	elseif data:GetEntity():GetClass() == "wep_jack_hmcd_glock17" then
		direction = angle:Forward() + angle:Right() * 0.5
	elseif data:GetEntity():GetClass() == "wep_jack_hmcd_usp" then
		direction = angle:Forward() * 0.75
	elseif (data:GetEntity():GetClass() == "wep_jack_hmcd_mp5") and not (data:GetEntity():IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer()) then
		direction = -angle:Right()
	end

	local ang = LocalPlayer():GetAimVector():Angle()
	self.Entity:SetPos(pos)
	self.Entity:SetModel(self.Models[bullettype] or "models/shells/fhell_9x19mm.mdl")
	self.Entity:PhysicsInitBox(Vector(-1, -1, -1), Vector(1, 1, 1))
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.Entity:SetCollisionBounds(Vector(-128 - 128, -128), Vector(128, 128, 128))
	local phys = self.Entity:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:SetDamping(0, 15)

		if data:GetEntity():IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer() then
			phys:SetVelocity(direction * math.random(150, 300))
		else
			phys:SetVelocity(-direction * math.random(150, 300))
		end

		phys:AddAngleVelocity(VectorRand() * 25000)
		phys:SetMaterial("gmod_silent")
	end

	timer.Simple(.5, function()
		if IsValid(self) then
			ParticleEffectAttach("pcf_jack_mf_barrelsmoke", PATTACH_POINT_FOLLOW, self, 1)
		end
	end)

	if data:GetEntity():IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer() then
		ang:RotateAroundAxis(ang:Forward(), 90)
	end

	--[[if data:GetEntity():GetClass()=="wep_jack_hmcd_pistol" or data:GetEntity():GetClass()=="wep_jack_hmcd_smallpistol" then
		ang:RotateAroundAxis(ang:Up(),90)
	end]]
	self.Entity:SetAngles(ang)
	self.HitSound = table.Random(self.Sounds[bullettype].Wavs)
	self.HitPitch = self.Sounds[bullettype].Pitch + math.random(-10, 10)
	self.SoundTime = CurTime() + math.Rand(0.5, 0.75)
	self.LifeTime = CurTime() + 60
	self.Alpha = 255
end

function EFFECT:GetBulletEjectPos(Position, Ent, Attachment)
	if not Ent:IsValid() then return Angle(), Position end
	if not Ent:IsWeapon() then return Angle(), Position end

	-- Shoot from the viewmodel
	if Ent:IsCarriedByLocalPlayer() and GetViewEntity() == LocalPlayer() then
		local ViewModel = LocalPlayer():GetViewModel()

		if ViewModel:IsValid() then
			local att = ViewModel:GetAttachment(Attachment)
			if att then return att.Ang, att.Pos + att.Ang:Forward() * 0 end
		end
		-- Shoot from the world model
	else
		local att = Ent.Owner:GetAttachment(5)

		if Ent:GetClass() == "wep_jack_hmcd_usp" then
			att = Ent:GetAttachment(Attachment)
		end

		if att then
			if Ent:GetClass() == "wep_jack_hmcd_pistol" or Ent:GetClass() == "wep_jack_hmcd_smallpistol" then
				return att.Ang, att.Pos + att.Ang:Forward() * 5 + att.Ang:Up() * 4
			elseif Ent:GetClass() == "wep_jack_hmcd_usp" then
				return att.Ang, att.Pos + att.Ang:Forward() * 13 + att.Ang:Up() * 13 + att.Ang:Right() * -33
			else
				return att.Ang, att.Pos + att.Ang:Forward() * 20 + att.Ang:Up() * 7 + att.Ang:Right() * -18
			end
		end
	end

	return Angle(), Position
end

function EFFECT:Think()
	if self.RemoveMe then return false end

	if self.SoundTime and self.SoundTime < CurTime() then
		self.SoundTime = nil
		sound.Play(self.HitSound, self.Entity:GetPos(), 75, self.HitPitch)
	end

	if self.LifeTime < CurTime() then
		self.Alpha = (self.Alpha or 255) - 2
		self.Entity:SetColor(Color(255, 255, 255, self.Alpha))
	end

	return self.Alpha > 2
end

function EFFECT:Render()
	self.Entity:DrawModel()
end