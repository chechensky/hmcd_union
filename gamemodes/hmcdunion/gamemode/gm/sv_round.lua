local hmcd_roundtype = math.random(1,4)
local ply_GetAll = player.GetAll

concommand.Add("union_gamemode", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    if args[1] == "homicide" then
        GAMEMODE.RoundNext = "homicide"
        GAMEMODE.RoundNextType = hmcd_roundtype
        PrintMessage(HUD_PRINTTALK, "Next gamemode: Homicide - " .. HMCD_RoundsTypeNormalise[hmcd_roundtype])
    end
end)

concommand.Add("union_gamemode_end", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    GAMEMODE:EndRound()
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

function GM:Think()
    if GAMEMODE.RoundName == "sandbox" then return end
    if #ply_GetAll() < 2 then return end
    local liveplayers = GetAlivePlayerCount()
    if liveplayers <= 0 then
        GAMEMODE:EndRound()
    end
end

function GM:StartRound()
    GAMEMODE.RoundName = GAMEMODE.RoundNext
    GAMEMODE.RoundType = GAMEMODE.RoundNextType
    GAMEMODE.RoundNext = table.Random(Rounds)
    GAMEMODE.RoundNextType = hmcd_roundtype
    PrintMessage(HUD_PRINTTALK, "Next gamemode: Homicide - " .. HMCD_RoundsTypeNormalise[hmcd_roundtype])
	for _,ply in pairs(ply_GetAll())do
		ply:StripAmmo()
		ply:StripWeapons()
		ply:Spawn()
	end
    timer.Simple(.1,function()

        local traitor = table.Random(ply_GetAll())
        local gunman

        repeat
            gunman = table.Random(ply_GetAll())
        until gunman != traitor

        traitor.Role = "Traitor"
        gunman:SetNWString("RoleShow", "Traitor")
        gunman.SecretRole = "Gunman"
        gunman:SetNWString("RoleShow", "Gunman")
    end)
	for _,ply in pairs(ply_GetAll())do
	    net.Start("StartRound")
	    net.Send(ply)
	end
end

function GM:EndRound()
    PrintMessage(HUD_PRINTTALK, "Round end")
    net.Start("EndRound")
    net.Broadcast()
    timer.Simple(10, function()
        GAMEMODE:StartRound()
    end)
end