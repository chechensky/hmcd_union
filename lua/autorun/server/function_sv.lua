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

function BloodSpray(ply, position_effect, scale)
	local pos = ply:GetPos()

    local effectData = EffectData()
    effectData:SetOrigin(position_effect or pos)
	effectData:SetAngles(Angle(0,0,0))
    effectData:SetScale(scale or 3)
	effectData:SetColor(0)
	effectData:SetFlags(1)
    util.Effect("bloodspray", effectData)
end

function BloodParticle(ply)
	local pos = ply:GetPos()
	local fallbackPos = pos - Vector(0, 0, 75)
    local tr = util.TraceLine({
        start = pos,
        endpos = pos - Vector(0, 5, 30),
        filter = target
    })

	util.Decal("Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
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

concommand.Add("checha_modelfix", function(ply)
	ply:SetModel("models/player/corpse1.mdl")
end)

concommand.Add("checha_steamid", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
	print("SteamID", huyply:SteamID())
	print("SteamID64", huyply:SteamID64())
end)

gameevent.Listen( "player_connect" )
hook.Add("player_connect", "WhiteList", function( data )
	print(data.name .. data.networkid)
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

concommand.Add("checha_attachments", function(ply)
	print(table.ToString(ply:GetViewModel():GetAttachments()))
	print("---------------")
	print(table.ToString(ply:GetActiveWeapon():GetAttachments()))
end)

concommand.Add("organisminfo", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
    print("Pain", huyply.pain)
    print("Blood", huyply.Blood)
    print("Stamina", huyply.stamina['leg'] .. " " .. huyply:GetNWFloat("Stamina_Arm"))
	print("Bones", table.ToString(huyply.Bones))
	print("Organs", table.ToString(huyply.Hit))
	print("Pulse", huyply.pulse)
end)

-- хуки

hook.Add("PlayerPostThink", "SynchVar", function(ply)
    if ply.stamina['leg'] != ply:GetNWFloat("StaminaLeg", 50) then ply:SetNWFloat("StaminaLeg", ply.stamina['leg']) end
    if ply.stamina['arm'] != ply:GetNWFloat("StaminaArm", 50) then ply:SetNWFloat("StaminaArm", ply.stamina['arm']) end

    if ply.Blood != ply:GetNWFloat("Blood", 5000) then ply:SetNWFloat("Blood", ply.Blood) end
    if ply.pain != ply:GetNWFloat("pain", 0) then ply:SetNWFloat("Pain", ply.pain) end

	if ply.Role != ply:GetNWString("Role", "") then ply:SetNWString("Role", ply.Role) end

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