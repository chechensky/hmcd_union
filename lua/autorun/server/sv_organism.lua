print("no empty")

local player_GetAll = player.GetAll

-- Stamina Work

hook.Add( "PlayerPostThink", "StaminaInt", function( ply)
	local leg = ply.stamina['leg']

	local run = leg*4
	local walk = leg*2
	local jump = leg*4

	if walk != ply:GetWalkSpeed() then ply:SetWalkSpeed(walk) end
	if jump != ply:GetJumpPower() then ply:SetJumpPower(jump) end
	if run != ply:GetRunSpeed() then ply:SetRunSpeed(run) end
end)

hook.Add( "PlayerFootstep", "StaminaMinus", function( ply, pos, foot, sound, volume, rf )
    if ply:IsSprinting() then
        if ply.stamina['leg'] > 0 then ply.stamina['leg'] = ply.stamina['leg'] - 0.6 end
    else
        if ply.stamina['leg'] > 0 then ply.stamina['leg'] = ply.stamina['leg'] - 0.3 end
    end
end)

hook.Add( "Player Think", "StaminaPlus", function( ply, time )
    ply.StaminaThink = ply.StaminaThink or 3
    if ply.StaminaThink < time and ply.stamina['leg'] < 50 and !ply:IsSprinting() then
        ply.StaminaThink = time + 0.5
        ply.stamina['leg'] = ply.stamina['leg'] + 1.3
    end
end)

------------------------------------------------------------------

-- Organs Work
OrgansNextThink = 0
hook.Add("Player Think","Organs_Hit_Reactions",function(ply,time)
	ply.OrgansNextThink = ply.OrgansNextThink or OrgansNextThink
	if ply.o2 < 0 then
		ply:ChatPrint("Вы задохнулись.")
		ply:Kill()
		ply.o2 = 1
	end
	if not(ply.OrgansNextThink>CurTime())then
		ply.OrgansNextThink=CurTime() + 0.2
		if ply.Organs and ply:Alive() then
			if ply.holdbreath then
				ply.o2 = ply.o2 - math.Rand(0.01,0.05)
			end
			if ply.Hit["brain"] == true then
				ply:Kill()
			end
			if ply.Hit["liver"] == true then
				ply.Bleed = ply.Bleed + 60
			end
			if ply.Hit["stomach"] == true then
				ply.Bleed = ply.Bleed + 10
			end
			if ply.Hit["intestines"] == true then
				ply.Bleed = ply.Bleed + 20
			end
			if ply.Hit["heart"] == true then
				ply.heartstop = true
				ply.Bleed = ply.Bleed + 100
			end
			if ply.Hit["lungs"] == true then
				ply.Bleed = ply.Bleed + 30
				ply.o2 = ply.o2 - math.random(0.02, 0.07)
			end
		end
    end
end)

------------------------------------------------------------------

-- Heart Work

function Pulse(ply)
    local basePulse = 70
    local bloodFactor = ply.Blood / 4000
    local adrenalineFactor = 1 + (ply.adrenaline / 1000)
    local painFactor = 1 + (ply.pain / 1000)

    pulse = basePulse * bloodFactor * adrenalineFactor * painFactor
    -- Нормализация пульса в пределах реальных значений
    if pulse < 30 then
        pulse = 30
    elseif pulse > 180 then
        pulse = 180
    end
	
	return pulse
end

hook.Add("Player Think","HeartWork",function(ply,time)
	if not ply:Alive() or ply:HasGodMode() then return end
	ply.Organs = ply.Organs or {}
	local pulsehow = Pulse(ply)
	ply.pulse = not heartstop and pulsehow or Lerp(0.1,(ply.pulse or 0),5)
	local ent = IsValid(ply.fakeragdoll) and ply.fakeragdoll or ply

	if ply.heartstop then
		ply.Otrub = true
		ply.pulse = ply.pulse - 20
	end

	if ply.pulseStart + ply.pulse/2 > time then return end
	ply.pulseStart = time
	ply:EmitSound("snd_jack_hmcd_heartpound.wav",70,100,0.1 / ply.pulse,CHAN_AUTO)
	if ply.Bleed > 0 then
		ply.Bleed = ply.Bleed - 0.1
		ply.Blood = math.max(ply.Blood - ply.Bleed / 2,0)
		BloodParticle(ply)
	end

	if ply.bloodNext > time then return end
	ply.bloodNext = time + 0.25
end)