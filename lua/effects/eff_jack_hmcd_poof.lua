--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_poof.lua

--]]
--[[---------------------------------------------------------
   Init( data table )
---------------------------------------------------------]]
function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.Position.z = self.Position.z + 4
	self.TimeLeft = CurTime() + 1
	self.GAlpha = 254
	self.DerpAlpha = 254
	self.GSize = 200
	self.CloudHeight = 1 * 2.5
	self.Refract = 0
	self.Size = 48
	self.SplodeDist = 2000
	self.BlastSpeed = 6000
	self.lastThink = 0
	self.MinSplodeTime = CurTime() + self.CloudHeight / self.BlastSpeed
	self.MaxSplodeTime = CurTime() + 6
	self.GroundPos = self.Position - Vector(0, 0, self.CloudHeight)
	local Pos = self.Position
	self.smokeparticles = {}
	self.Emitter = ParticleEmitter(Pos)
	local Scayul = data:GetScale()
	self.Scayul = Scayul

	for k = 0, 50 * Scayul do
		local sprite = "particle/smokesprites_000" .. math.random(1, 9)
		local particle = self.Emitter:Add(sprite, Pos + VectorRand())
		particle:SetVelocity(VectorRand() * math.Rand(1, 25) * Scayul)
		particle:SetAirResistance(1)
		particle:SetGravity(Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(-1, 1)))
		particle:SetDieTime(math.Rand(.1, .3) * Scayul)
		particle:SetStartAlpha(math.Rand(200, 255))
		particle:SetEndAlpha(0)
		local Size = math.random(10, 15)
		particle:SetStartSize(Size / 3)
		particle:SetEndSize(Size)
		particle:SetRoll(0)

		if math.random(1, 2) == 1 then
			particle:SetRollDelta(0)
		else
			particle:SetRollDelta(math.Rand(-2, 2))
		end

		particle:SetColor(255, 255, 255)
		particle:SetLighting(false)
		particle:SetCollide(false)
	end

	self.Emitter:Finish()
end

--[[---------------------------------------------------------
   THINK
---------------------------------------------------------]]
function EFFECT:Think()
	return false
end

--[[---------------------------------------------------------
   Draw the effect
---------------------------------------------------------]]
function EFFECT:Render()
end