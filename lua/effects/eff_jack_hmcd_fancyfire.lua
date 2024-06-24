--[[File Path:   gamemodes/homicide/entities/effects/eff_jack_hmcd_fancyfire.lua

--]]
--[[---------------------------------------------------------
	EFFECT:Init(data)
---------------------------------------------------------]]
local explosionParticles = {"ins_molotov_smoke", "ins_molotov_flame_b", "ins_molotov_flamewave", "ins_molotov_burst_b", "ins_molotov_burst_glass", "ins_molotov_trailers", "ins_molotov_burst_flame", "ins_molotov_burst", "ins_molotov_trails", "ins_molotov_flash"}

function EFFECT:Init(data)
	self.ID = GAMEMODE.RoundNum
	local SelfPos = data:GetOrigin()
	local ang = data:GetAngles()
	local parent = data:GetEntity()
	if self:WaterLevel() == 3 then return end

	for i = 1, table.Count(explosionParticles) do
		ParticleEffect(explosionParticles[i], SelfPos, ang, parent)
	end
end

--[[---------------------------------------------------------
	EFFECT:Think()
---------------------------------------------------------]]
function EFFECT:Think()
	if self.ID ~= GAMEMODE.RoundNum then
		self:SetShouldDraw(false)

		return false
	end
end

--[[---------------------------------------------------------
	EFFECT:Render()
---------------------------------------------------------]]
function EFFECT:Render()
end
--wat