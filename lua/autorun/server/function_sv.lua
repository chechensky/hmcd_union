-- функции

function player.GetListByName(name)
	local list = {}

	if name == "^" then
		return
	elseif name == "*" then

		return player.GetAll()
	end

	for i,ply in player.Iterator() do
		if string.find(string.lower(ply:Name()),string.lower(name)) then list[#list + 1] = ply end
	end

	return list
end

function BloodParticle(ply, position_effect)
	game.AddParticles("particles/huy.pcf")
	local pos = ply:GetPos()
    local tr = util.TraceLine({
        start = pos,
        endpos = pos - Vector(0, 5, 30),
        filter = target
    })

    local effectData = EffectData()
    effectData:SetOrigin(position_effect or pos)
    effectData:SetScale(1)
    util.Effect("Huy", effectData)

    if tr.Hit then
    end
end

-- команды

concommand.Add("checha_getflexname", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
	print(huyply:GetFlexName(args[2] or 0))
end)

concommand.Add("checha_getflexid", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
	print(huyply:GetFlexIDByName(args[2] or 0, args[3] or ""))
end)

concommand.Add("checha_setflexweight", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
	huyply:SetFlexWeight(args[2] or 0, args[3] or 0)
end)

concommand.Add("soundplay", function(ply,cmd,args)
	sound.Play(args[1] or "", ply:GetPos(), 75, 100)
end)

concommand.Add("checha_fake", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
	if !ply:IsAdmin() then return end
	Faking(huyply)
end)

concommand.Add("checha_ijnts",function(ply)
	ply.pain = ply.pain + 100
	ply.Blood = ply.Blood - 300
end)

concommand.Add("organisminfo", function(ply)
    print("Pain", ply.pain)
    print("Blood", ply.Blood)
    print("Stamina", ply.stamina['leg'] .. " " .. ply.stamina['arm'])
	print("Bones", table.ToString(ply.Bones))
	print("Organs", table.ToString(ply.Hit))
end)

-- хуки

hook.Add("PlayerPostThink", "SynchVar", function(ply)
    if ply.stamina['leg'] != ply:GetNWFloat("StaminaLeg", 50) then ply:SetNWFloat("StaminaLeg", ply.stamina['leg']) end
    if ply.stamina['arm'] != ply:GetNWFloat("StaminaArm", 50) then ply:SetNWFloat("StaminaArm", ply.stamina['arm']) end

    if ply.Blood != ply:GetNWFloat("Blood", 5000) then ply:SetNWFloat("Blood", ply.Blood) end
    if ply.pain != ply:GetNWFloat("Pain", 0) then ply:SetNWFloat("Pain", ply.pain) end

    if ply.Bones["RightArm"] != ply:GetNWFloat("RightArm", 1) then ply:SetNWFloat("RightArm", ply.Bones["RightArm"]) end
    if ply.Bones["LeftArm"] != ply:GetNWFloat("LeftArm", 1) then ply:SetNWFloat("LeftArm", ply.Bones["LeftArm"]) end

    if ply.Bones["RightLeg"] != ply:GetNWFloat("RightLeg", 1) then ply:SetNWFloat("RightLeg", ply.Bones["RightLeg"]) end
    if ply.Bones["LeftLeg"] != ply:GetNWFloat("LeftLeg", 1) then ply:SetNWFloat("LeftLeg", ply.Bones["LeftLeg"]) end
end)

local hook_Run = hook.Run

hook.Add("Think", "PlayerThinker_NewHook", function(ply)
	time = CurTime()
	for _, plys in player.Iterator() do
		hook_Run("Player Think", plys, time)
	end
end)