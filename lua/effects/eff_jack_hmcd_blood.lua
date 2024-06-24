--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_blood.lua

--]]
function EFFECT:Init(data)
	local Pos = data:GetOrigin()
	local ply = LocalPlayer()
	local dist = Pos:DistToSqr(ply:GetPos()) / 1000
	if dist > 3000 then return end
	self.Position = data:GetStart()
	self.Entity = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.DataNormal = data:GetNormal()
	self.EndPos = data:GetOrigin()
	if self.Entity == nil then return end
	if self:WaterLevel() == 0 then return end
	if not self.Entity:IsValid() then return end
	local sname = self.Entity:GetBoneSurfaceProp(0)
	--	print(sname)
	local hblood = Color(255, 0, 0)
	local antblood = Color(225, 255, 0)
	local zblood = Color(255, 255, 0)
	local forwardvel = self.Entity:GetVelocity():Angle():Forward()
	local velmedian = math.abs((forwardvel.x + forwardvel.y + forwardvel.z) / 3)
	local emitter = ParticleEmitter(Pos)
	local minparticles = 5
	local maxparticles = 25
	local fpsthreshold = 50
	local threshholdvalue = math.Clamp(1 / FrameTime(), minparticles, fpsthreshold)

	for i = 1, math.Round(math.Rand(minparticles, math.Clamp(threshholdvalue, minparticles, maxparticles))) do
		bubble = emitter:Add("particle/particle_smokegrenade", Pos + Vector(math.random(0, 0), math.random(0, 0), -8))

		if bubble == nil then
			bubble = emitter:Add("particle/particle_smokegrenade", Pos + Vector(math.random(0, 0), math.random(0, 0), -5))
		end

		if bubble then
			bubble:SetColor(hblood.r, hblood.g, hblood.b)

			if sname == "flesh" or sname == "zombieflesh" then
				bubble:SetColor(hblood.r, hblood.g, hblood.b)
			elseif sname == "antlion" then
				bubble:SetColor(antblood.r, antblood.g, antblood.b)
			elseif sname == "alienflesh" then
				bubble:SetColor(zblood.r, zblood.g, zblood.b)
			end

			--			bubble:SetPos(bboxpos + vector_origin)
			bubble:SetVelocity(Vector(math.random(-2, 2), math.random(-2, 2), math.Rand(-1, 0)))
			bubble:SetLifeTime(0)
			bubble:SetDieTime(math.random(30, 45))
			bubble:SetStartAlpha(255)
			bubble:SetEndAlpha(0)
			bubble:SetStartSize(0.1)
			bubble:SetEndSize(80 * velmedian)
			bubble:SetAngles(Angle(21, 3, 5))
			--bubble:SetAngleVelocity( Angle(3) ) 
			bubble:SetRoll(math.Rand(0, 360))
			--bubble:SetGravity( Vector(0,0,i*-2)) 
			bubble:SetAirResistance(2)
			bubble:SetCollide(true)
			bubble:SetLighting(true)
			bubble:SetBounce(0)
		end
	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end