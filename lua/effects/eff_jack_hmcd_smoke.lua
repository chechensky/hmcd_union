--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_smoke.lua

--]]
--[[---------------------------------------------------------
   Init( data table )
---------------------------------------------------------]]
function EFFECT:Init(data)
	self.Position = data:GetOrigin()
	self.Position.z = self.Position.z + 4
	self.WindFactor = data:GetStart()
	local Pos = self.Position
	self.Emitter = ParticleEmitter(Pos, false)
	local Scayul = data:GetScale()
	self.Scayul = Scayul

	for k = 1, 13 * Scayul do
		local sprite, chance = "", math.random(2, 3)

		if chance == 1 then
			sprite = "particle/smokestack"
		elseif chance == 2 then
			sprite = "effects/thick_smoke"
		elseif chance == 3 then
			sprite = "effects/thick_smoke2"
		end

		local particle = self.Emitter:Add(sprite, Pos)
		local Vel = VectorRand() * math.Rand(150, 250) * Scayul
		Vel.z = Vel.z / 2
		particle:SetVelocity(Vel)
		particle:SetAirResistance(20)
		particle:SetGravity(VectorRand() * math.Rand(0, 10) + self.WindFactor)
		particle:SetDieTime(math.Rand(7, 12) * Scayul)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		local Size = math.random(200, 400) * Scayul
		particle:SetStartSize(Size / 10)
		particle:SetEndSize(Size)
		particle:SetRoll(0)

		if math.random(1, 2) == 1 then
			particle:SetRollDelta(0)
		else
			particle:SetRollDelta(math.Rand(-2, 2))
		end

		local Amt = math.random(200, 255)
		particle:SetColor(Amt, Amt, Amt)
		particle:SetLighting(true)
		particle:SetCollide(true)
		particle:SetBounce(.5)
	end

	self.Emitter:Finish()
	self.Emitter = nil
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
--