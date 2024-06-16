local ply_GetAll = player.GetAll

concommand.Add("union_gamemode", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    if args[1] == "homicide" then
        local hmcd_roundtype = math.random(1,5)
        GAMEMODE.RoundNext = "homicide"
        GAMEMODE.RoundNextType = hmcd_roundtype
        PrintMessage(HUD_PRINTTALK, "Next gamemode: Homicide - " .. HMCD_RoundsTypeNormalise[hmcd_roundtype])
    elseif args[1] == "dm" then
        GAMEMODE.RoundNext = "dm"
        GAMEMODE.RoundNextType = 0
        PrintMessage(HUD_PRINTTALK, "Next gamemode: Deathmatch")
    elseif args[1] == "hl2" then
        GAMEMODE.RoundNext = "hl2"
        GAMEMODE.RoundNextType = 0
        PrintMessage(HUD_PRINTTALK, "Next gamemode: Half Life 2 - Deathmatch")
    end
end)

concommand.Add("union_gamemode_end", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    GAMEMODE:EndRound(1, ply)
end)

concommand.Add("union_homicidetype", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    print("Homicide Types: " .. "\n" .. "1 = Standart" .. "\n" .. "2 = SOE" .. "\n" .. "3 = JIHAD" .. "\n" .. "4 = Wild west")
    if args[1] == "1" or args[1] == "2" or args[1] == "3" or args[1] == "4" then
        GAMEMODE.RoundType = args[1]
        PrintMessage(HUD_PRINTTALK, "Next Homicide roundtype: " .. HMCD_RoundsTypeNormalise[args[1]])
        PrintMessage(HUD_PRINTCENTER, "Next Homicide roundtype: " .. HMCD_RoundsTypeNormalise[args[1]])
    end
end)

---------- round logics???)())))))))
local pitch = math.random(80, 120)

function GM:StartRound()
    local hmcd_roundtype = math.random(1,5)
    GAMEMODE.RoundName = GAMEMODE.RoundNext
    GAMEMODE.RoundType = GAMEMODE.RoundNextType
    game.CleanUpMap(false, { "env_fire", "entityflame", "_firesmoke" })
	for _,ply in pairs(ply_GetAll())do
        ply:UnSpectate()
		ply:StripAmmo()
		ply:StripWeapons()
		ply:Spawn()
	end
    timer.Simple(.3,function()

        local traitor = table.Random(ply_GetAll())
        local gunman

        repeat
            gunman = table.Random(ply_GetAll())
        until gunman != traitor
        traitor.Role = "Traitor"
        traitor:SetNWString("RoleShow", "Traitor")
        gunman.SecretRole = "Gunman"
        gunman:SetNWString("RoleShow", "Gunman")

        GAMEMODE.Traitor = traitor
        GAMEMODE.RoundState = 1
    end)
	for _,ply in pairs(ply_GetAll())do
	    net.Start("StartRound")
	    net.Send(ply)
	end
end

-- win traitor 1
-- lost traitor 2 
function GM:EndRound(reason, mvp)
    PrintMessage(HUD_PRINTTALK, "Round end")
    net.Start("EndRound")

	    net.WriteUInt(reason, 8)
	    net.WriteEntity(mvp or Entity(-1))
        if GAMEMODE.Traitor then
	        net.WriteVector(GAMEMODE.Traitor:GetPlayerColor())
	        net.WriteString(GAMEMODE.Traitor:GetNWString("Character_Name"))
        else
	        net.WriteVector(Vector(0,0,0))
	        net.WriteString("?")
        end

    net.Broadcast()
    timer.Simple(5, function()
        GAMEMODE:StartRound()
    end)
    GAMEMODE.RoundState = 0
end

function GM:Think()
    if GAMEMODE.RoundName == "sandbox" then return end
    if #ply_GetAll() < 2 then return end
    if GAMEMODE.RoundState == 0 or GAMEMODE.RoundState == 2 then return end
    if GAMEMODE.RoundState == 2 and #ply_GetAll() > 1 then GAMEMODE:EndRound(1, table.Random(ply_GetAll())) end
    local alive_ply = GetAlivePlayerCount()
    if GAMEMODE.RoundName == "homicide" then
        if GAMEMODE.RoundState == 1 then
            local alive_traitor, alive_innocent = GetAliveRoleCount("Traitor"), GetAliveRoleCount("Bystander")
            if alive_innocent < 1 then
                GAMEMODE:EndRound(1, GAMEMODE.Traitor)

            elseif alive_traitor < 1 and alive_innocent > 0 then
                GAMEMODE:EndRound(2, GAMEMODE.Traitor.LastAttacker)
            end

        end

    return end
end

hook.Add("PlayerPostThink", "Spectating", function(ply)
    if !ply:GetNWBool("Spectating", false) then return end
    if ply:Alive() then return end

	local plyselect = ply:GetNWEntity("SelectPlayer", Entity(-1))
    if !IsValid(ply:GetNWEntity("SelectPlayer", Entity(-1))) then ply:SetNWEntity("SelectPlayer", table.Random(player.GetAll())) end
    ButtonInput = 0
    ply.ButtonInput = ply.ButtonInput or ButtonInput

        if ply:KeyDown(IN_ATTACK) and ply.ButtonInput < CurTime() then
            ply.ButtonInput = CurTime() + math.random(0.1, 0.5)
            repeat
                 ply:SetNWEntity("SelectPlayer", table.Random(player.GetAll()))
            until ply != ply:GetNWEntity("SelectPlayer", Entity(-1))    
        end
        if ply:KeyDown(IN_ATTACK2) and ply.ButtonInput < CurTime() then
            ply.ButtonInput = CurTime() + math.random(0.1, 0.5)
            if ply:GetNWInt("SpectateMode") == 3 then ply:SetNWInt("SpectateMode", 1) else
                ply:SetNWInt("SpectateMode", 3)
                ply:UnSpectate()
            end
        end
        if ply:KeyDown(IN_RELOAD) and ply:GetNWInt("SpectateMode") != 3 and ply.ButtonInput < CurTime() then
            ply.ButtonInput = CurTime() + math.random(0.1, 0.5)
            ply:SetNWInt("SpectateMode", ( ply:GetNWInt("SpectateMode") + 1 ) % 3)
        end

    if ply:GetNWInt("SpectateMode") == 1 then
        ply:Spectate(OBS_MODE_CHASE)
        ply:SpectateEntity(plyselect)
    end

    if ply:GetNWInt("SpectateMode") == 2 then
        ply:Spectate(OBS_MODE_IN_EYE)
        ply:SpectateEntity(plyselect)
    end

    if ply:GetNWInt("SpectateMode") == 3 then
        ply:Spectate(OBS_MODE_ROAMING)
        ply:SpectateEntity(nil)
    end

end)

hook.Add("PlayerDeathThink", "DeathThink", function(ply)
    ply:SetNWBool("Spectating",true)
    if GAMEMODE.RoundName == "homicide" then return false end
end)