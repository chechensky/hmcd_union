-- функции
local PlayerMeta = FindMetaTable("Player")
fs = GetConVar("checha_feature"):GetBool()

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

function PlayerMeta:SetRoleColor(r, g, b)
    self:SetNWInt("RoleColor_R", r)
	self:SetNWInt("RoleColor_G", g)
    self:SetNWInt("RoleColor_B", b)
end

function StandartHeal(ply)
	sound.Play("snd_jack_hmcd_bandage.wav", ply:GetShootPos(), 60, math.random(90, 110))
	ply:ViewPunch(Angle(-10, 0, 0))
	ply:RemoveAllDecals()
    if IsValid(ply:GetActiveWeapon()) then 
        ply:GetActiveWeapon().Resource = ply:GetActiveWeapon().Resource - 20
        if ply:GetActiveWeapon().Resource <= 0 then
            ply:ChatPrint("Zero medicaments.")
        else
            ply:ChatPrint("Medicaments count: " .. ply:GetActiveWeapon().Resource)
        end
    end
end
-- ну пиздец снова

function findMaxValue(tbl)
    local maxKey, maxValue = nil, -math.huge
    for k, v in pairs(tbl) do
        if v > maxValue then
            maxKey, maxValue = k, v
        end
    end
    return maxKey, maxValue
	-- что за хуйню я прям щас написал я не знаю, надеюсь она будет работать
end

function checkAllBleedOuts_bolshe(ply, check)
	return ply.BleedOuts["stomach"] > check or ply.BleedOuts["chest"] > check or ply.BleedOuts["left_hand"] > check or ply.BleedOuts["right_hand"] > check or ply.BleedOuts["right_leg"] > check or ply.BleedOuts["left_leg"] > check
end

function checkAllBleedOuts_menshe(ply, check)
	return ply.BleedOuts["stomach"] <= check or ply.BleedOuts["chest"] <= check or ply.BleedOuts["left_hand"] <= check or ply.BleedOuts["right_hand"] <= check or ply.BleedOuts["right_leg"] <= check or ply.BleedOuts["left_leg"] <= check
end
-- две верхние функции это просто пиздец

function BloodParticle(ply)
	local rn = math.Rand(-0.35, 0.35)
	local rnn = math.Rand(-0.35, 0.35)
	local tr = {}
	tr.start = Vector(ply:GetPos()) + Vector(0, 0, 50)
	tr.endpos = tr.start + Vector(rn, rnn, -1) * 8000
	tr.filter = {ply, ply.fakeragdoll}
	local trw = util.TraceHull(tr)
	local Pos1 = trw.HitPos + trw.HitNormal
	local Pos2 = trw.HitPos - trw.HitNormal
	util.Decal("Blood", Pos1, Pos2, ply)
end

function GetAlivePlayerCount()
    local aliveCount = 0
    for _, ply in player.Iterator() do
        if ply:Alive() then
            aliveCount = aliveCount + 1
        end
    end
    return aliveCount
end

function GetLastPlayerAlive()
	local aliveCount = GetAlivePlayerCount()
	local lastplayer
    for _, ply in player.Iterator() do
        if ply:Alive() then
            if aliveCount == 1 then
				lastplayer = ply
			end
        end
    end
    return lastplayer
end
function GetRandomRolePlayer(role)
    local roleply = nil
    for _, ply in player.Iterator() do
        if ply:Alive() then
			if ply.Role == role then
            	roleply = ply
			end
		end
    end
    return roleply
end

function GetAliveRoleCount(role)
    local rolealive = 0
    for _, ply in player.Iterator() do
        if ply:Alive() then
			if ply.Role == role then
            	rolealive = rolealive + 1
			end
		end
    end
    return rolealive
end

function Bleed(ply, mbleed, limb, ent)
	local multiplier
	local fatalbleed = ply.BleedOuts[limb] / 2.5
	if ply.Wounds[limb] == 0 then
		multiplier = 1
	else
		multiplier = ply.Wounds[limb]
	end
	ply.BleedOuts[limb] = ply.BleedOuts[limb] - mbleed
	for i=1, multiplier do
		ply.Blood = ply.Blood - (fatalbleed * multiplier)
		BloodParticle(ply)
		sound.Play(table.Random(blood_drop), ent:GetPos(), 55, 100,1)
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

concommand.Add("checha_modelfix", function(ply)
	ply:SetModel("models/player/corpse1.mdl") -- ДЖОН ФОРСАКЕНЕД
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

concommand.Add("checha_attachments", function(ply)
	print(table.ToString(ply:GetViewModel():GetAttachments()))
	print("---------------")
	print(table.ToString(ply:GetActiveWeapon():GetAttachments()))
end)

concommand.Add("organisminfo", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
    print("Pain", huyply.pain)
    print("Blood", huyply.Blood)
	print("Adrenaline", huyply.adrenaline)
    print("Stamina", huyply.stamina['leg'] .. " " .. huyply:GetNWFloat("Stamina_Arm"))
	print("----------------------- Hits:")
	PrintTable(huyply.Hit)
	print("----------------------- Bones:")
	PrintTable(huyply.Bones)
	print("----------------------- Wounds:")
	PrintTable(huyply.Wounds)
	print("----------------------- BleedOuts:")
	PrintTable(huyply.BleedOuts)
	print("-----------------------")
end)

concommand.Add("oi", function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
    print("Health", huyply:Health())
	print("Pain", huyply.pain)
    print("Blood", huyply.Blood)
	print("Adrenaline", huyply.adrenaline)
    print("Stamina", huyply.stamina['leg'] .. " " .. huyply:GetNWFloat("Stamina_Arm"))
	print("----------------------- Hits:")
	PrintTable(huyply.Hit)
	print("----------------------- Bones:")
	PrintTable(huyply.Bones)
	print("----------------------- Wounds:")
	PrintTable(huyply.Wounds)
	print("----------------------- BleedOuts:")
	PrintTable(huyply.BleedOuts)
	print("-----------------------")
end)

-- хуки

hook.Add("PlayerPostThink", "SynchVar", function(ply)
	-- normalize bleedouts int)))
	for k, v in pairs(ply.BleedOuts) do
		if v < 0 then
	        ply.BleedOuts[k] = 0
	    end
	end

    if ply.stamina['leg'] != ply:GetNWFloat("StaminaLeg", 50) then ply:SetNWFloat("StaminaLeg", ply.stamina['leg']) end
    if ply.stamina['arm'] != ply:GetNWFloat("StaminaArm", 50) then ply:SetNWFloat("StaminaArm", ply.stamina['arm']) end

    if ply.Blood != ply:GetNWFloat("Blood", 5000) then ply:SetNWFloat("Blood", ply.Blood) end
    if ply.pain != ply:GetNWFloat("pain", 0) then ply:SetNWFloat("pain", ply.pain) end

	if ply.Role != ply:GetNWString("Role", "") then ply:SetNWString("Role", ply.Role) end
	if ply.SecretRole != ply:GetNWString("SecretRole", "") then ply:SetNWString("SecretRole", ply.SecretRole) end

	if ply.Otrub != ply:GetNWBool("Otrub", false) then ply:SetNWBool("Otrub", ply.Otrub) end

    if ply.Bones["RightArm"] != ply:GetNWFloat("RightArm", 1) then ply:SetNWFloat("RightArm", ply.Bones["RightArm"]) end
    if ply.Bones["LeftArm"] != ply:GetNWFloat("LeftArm", 1) then ply:SetNWFloat("LeftArm", ply.Bones["LeftArm"]) end

    if ply.Bones["RightLeg"] != ply:GetNWFloat("RightLeg", 1) then ply:SetNWFloat("RightLeg", ply.Bones["RightLeg"]) end
    if ply.Bones["LeftLeg"] != ply:GetNWFloat("LeftLeg", 1) then ply:SetNWFloat("LeftLeg", ply.Bones["LeftLeg"]) end
	ply:SetNWBool("InHandCuff", ply.in_handcuff)
end)

local hook_Run = hook.Run

hook.Add("Think", "PlayerThinker_NewHook", function(ply)
	time = CurTime()
	for _, plys in player.Iterator() do
		hook_Run("Player Think", plys, time)
	end
end)

concommand.Add("sex2", function(ply)
    if !ply:IsAdmin() then return end
	local bones = ply:GetBoneCount()
    if not bones or bones <= 0 then return end
    for i = 0, bones - 1 do
        ply:ManipulateBonePosition(i, Vector(0, 0, 0))
        ply:ManipulateBoneAngles(i, Angle(0, 0, 0))
		ply:ManipulateBoneScale(i, Vector(1,1,1))
    end
end)