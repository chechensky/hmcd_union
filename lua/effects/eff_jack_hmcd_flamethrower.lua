--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_flamethrower.lua

--]]
--[[---------------------------------------------------------
	EFFECT:Init(data)
---------------------------------------------------------]]
function EFFECT:Init(data)
	local SelfPos = data:GetOrigin()
	local norm = data:GetNormal()
	if self:WaterLevel() == 3 then return end
	local Ent = data:GetEntity()
	local addVel = vector_origin
	local wep

	if IsValid(Ent) then
		addVel = Ent:GetVelocity()
		wep = Ent:GetActiveWeapon()
	end

	local Emitter = ParticleEmitter(SelfPos)

	if wep and wep:IsCarriedByLocalPlayer() then
		SelfPos = LocalPlayer():GetShootPos() + LocalPlayer():GetAimVector() * 25
		norm = LocalPlayer():GetAimVector()
	end

	local tr = util.QuickTrace(SelfPos, norm * 360, Ent)

	for i = 1, 30 * tr.Fraction do
		timer.Simple(i / 50, function()
			local zMul = 1

			if math.random(1, 2) == 1 then
				zMul = 2
			end

			local sprite = "sprites/flamelet" .. math.random(1, 5)
			local particle = Emitter:Add(sprite, SelfPos + norm * i * 12)

			if particle then
				particle:SetVelocity(70 * Vector(math.Rand(-.3, .3), math.Rand(-.3, .3), math.Rand(-.7, .7) * zMul) + addVel)
				particle:SetAirResistance(0)
				particle:SetGravity(Vector(0, 0, math.random(-30, 30)))
				particle:SetDieTime(.5)
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(255)
				particle:SetStartSize(math.random(10, 15))
				particle:SetEndSize(0)
				particle:SetRoll(math.Rand(-3, 3))
				particle:SetRollDelta(math.Rand(-2, 2))
				particle:SetLighting(false)
				local darg = math.Rand(150, 255)
				particle:SetColor(darg, darg, darg)
				particle:SetCollide(true)
				particle:SetBounce(.01)

				particle:SetCollideCallback(function(part, hitpos, hitnormal)
					if math.random(1, 25) == 5 then
						util.Decal("Scorch", hitpos + hitnormal, hitpos - hitnormal)
					end
				end)
			end
		end)
	end

	timer.Simple(.6, function()
		Emitter:Finish()
	end)
end

--[[---------------------------------------------------------
	EFFECT:Think()
---------------------------------------------------------]]
function EFFECT:Think()
	return false
end

--[[---------------------------------------------------------
	EFFECT:Render()
---------------------------------------------------------]]
function EFFECT:Render()
end
--wat