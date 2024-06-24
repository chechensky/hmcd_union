--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_puke.lua

--]]
function EFFECT:Init(data)
	self.Vec = data:GetNormal()
	self.StartPos = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.StartPos)
	local col = data:GetColor()

	for i = 1, 5 do
		local p = self.Emitter:Add("noxctf/sprite_bloodspray" .. math.random(8), self.StartPos)
		p:SetDieTime(2)
		p:SetStartSize(1)
		p:SetVelocity(self.Vec * 10)
		p:SetGravity(Vector(0, 0, math.random(-200, -400)))
		p:SetEndSize(math.Rand(5, 25))
		p:SetStartAlpha(105)
		p:SetEndAlpha(0)

		if col == 1 then
			p:SetColor(255, 160, 0)
		else
			p:SetColor(205, 0, 0)
		end

		p:SetRoll(math.Rand(-10, 10))
		p:SetRollDelta(math.Rand(-10, 10))
		p:SetCollide(true)

		p:SetCollideCallback(function(part, hitpos, hitnormal)
			p:SetDieTime(0)
		end)

		p:SetNextThink(CurTime())

		p:SetThinkFunction(function(part)
			if not p.UnderWater and bit.band(util.PointContents(p:GetPos()), CONTENTS_WATER) == CONTENTS_WATER then
				p:SetVelocity(p:GetVelocity() / 5)
				p:SetGravity(vector_origin)
				p.UnderWater = true
				p:SetDieTime(3)
				p:SetRoll(p:GetRoll() / 2)
				p:SetRollDelta(p:GetRollDelta() / 2)
			end

			p:SetNextThink(CurTime())
		end)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end