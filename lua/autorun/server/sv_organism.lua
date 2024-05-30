print("no empty")

-- Stamina Work

hook.Add( "PlayerPostThink", "StaminaInt", function( ply )
	local leg = ply.stamina['leg']

	local run = leg*6.5+ply.adrenaline
	local walk = leg*2+ply.adrenaline
	local jump = leg*4.6+ply.adrenaline

	if walk != ply:GetWalkSpeed() then ply:SetWalkSpeed(walk)  end
	if jump != ply:GetJumpPower() then ply:SetJumpPower(jump) end
	if run != ply:GetRunSpeed() then ply:SetRunSpeed(run) end
	if leg < 20 and !ply.stamina_sound then
		ply:EmitSound("player/breathe1.wav", 75, 100, 1, CHAN_AUTO, SND_NOFLAGS)
		ply.stamina_sound = true
		timer.Simple(5, function()
			ply:StopSound("player/breathe1.wav")
		end)
	end
end)

hook.Add( "PlayerFootstep", "StaminaMinus", function( ply, pos, foot, sound, volume, rf )
	if ply.adrenaline > 0 then return end
    if ply:IsSprinting() then
        if ply.stamina['leg'] > 0 then ply.stamina['leg'] = ply.stamina['leg'] - 0.6 end
    else
        if ply.stamina['leg'] > 0 then ply.stamina['leg'] = ply.stamina['leg'] - 0.3 end
    end
end)

------------------------------------------------------------------

-- Organs Work
OrgansNextThink = 0
hook.Add("Player Think","Organs_Hit_Reactions",function(ply,time)
	ply.OrgansNextThink = ply.OrgansNextThink or OrgansNextThink
	if ply.o2 < 0 then
		ply:ChatPrint("Your dead reason is oxygen empty.")
		ply:Kill()
		ply.o2 = 1
	end

	if ply.Blood <= 1000 and ply:Alive() then
		ply:ChatPrint("Your dead reason is small blood ints.")
		ply:Kill()
	end
	

	
	if not(ply.OrgansNextThink>CurTime())then
		ply.OrgansNextThink=CurTime() + 0.2
		if ply.Organs and ply:Alive() then
			if ply.holdbreath then
				ply.o2 = ply.o2 - math.Rand(0.01,0.05)
			end
			if ply.Hit["liver"] == true then
				ply.Bleed = ply.Bleed + 20
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
				ply.Bleed = ply.Bleed + 20
			end
		end
    end
end)

------------------------------------------------------------------

-- Heart Work

function Pulse(ply)
    local basePulse = 70
    local bloodFactor = ply.Blood / 4000
    local adrenalineFactor = ply.adrenaline
    local painFactor = 1 + (ply.pain / 1000)

    pulse = basePulse * bloodFactor * painFactor + adrenalineFactor
	return pulse
end

hook.Add("Player Think","HeartWork",function(ply,time)
	if not ply:Alive() or ply:HasGodMode() then return end
	ply.pulse = Pulse(ply)
	local ent = IsValid(ply.fakeragdoll) and ply.fakeragdoll or ply
	if ply.Bleed > 0 then
		ply.Bleed = ply.Bleed - 0.1
		ply.Blood = math.max(ply.Blood - ply.Bleed / 2,0)
		BloodParticle(ply)
		sound.Play(table.Random(blood_drop), ent:GetPos(), 55, 100,1)
		if IsValid(ply.fakeragdoll) then BloodSpray(ply, ply.fakeragdoll:GetPos()) else BloodSpray(ply, ent:GetPos()+Vector(0,0,40)) end
	end
end)