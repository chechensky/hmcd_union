local ply_GetAll = player.GetAll

hook.Add("PlayerPostThink", "roundsynch", function(ply)
    ply:SetNWString("Round", GAMEMODE.RoundName)
    ply:SetNWInt("RoundType", GAMEMODE.RoundType)
end)

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
    elseif args[1] == "sandbox" then
        GAMEMODE.RoundNext = "sandbox"
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
        local pizda = tonumber(args[1])
        GAMEMODE.RoundType = pizda
        PrintMessage(HUD_PRINTTALK, "Next Homicide roundtype: " .. HMCD_RoundsTypeNormalise[pizda])
    end
end)

---------- round logics???)())))))))
local pitch = math.random(80, 120)

function GM:StartRound()
    local hmcd_roundtype = math.random(1,5)
    local roundt = table.Random(Rounds)
    GAMEMODE.RoundName = GAMEMODE.RoundNext
    LocalPlayer():SetNWString("Round", GAMEMODE.RoundNext)
    GAMEMODE.RoundNext = roundt
    if GAMEMODE.RoundName == "homicide" then
        GAMEMODE.RoundType = GAMEMODE.RoundNextType
        LocalPlayer():SetNWInt("RoundType", GAMEMODE.RoundNextType)
        GAMEMODE.RoundNextType = math.random(1, 5)

    else
        GAMEMODE.RoundType = 0
        LocalPlayer():SetNWInt("RoundType", 0)
        GAMEMODE.RoundNextType = math.random(1, 5)
    end
    game.CleanUpMap(false, { "env_fire", "entityflame", "_firesmoke" })
	for _,ply in pairs(ply_GetAll())do
        ply:UnSpectate()
		ply:StripAmmo()
		ply:StripWeapons()
		ply:Spawn()
	end
    if GAMEMODE.RoundName == "homicide" then
        timer.Simple(.3,function()

            local traitor = table.Random(ply_GetAll())
            local gunman

            repeat
                gunman = table.Random(ply_GetAll())
            until gunman != traitor
            traitor.Role = "Traitor"
            traitor:SetNWString("RoleShow", "Traitor")
            if GAMEMODE.RoundType != 5 then
                gunman.SecretRole = "Gunman"
                gunman:SetNWString("RoleShow", "Gunman")
            end

            GAMEMODE.Traitor = traitor
            GAMEMODE.RoundState = 1

	        for _,ply in pairs(ply_GetAll())do
	            if HMCD_Loadout[ply:GetNWString("RoleShow", "")][GAMEMODE.RoundType] then
		            for i,wep in pairs(HMCD_Loadout[ply:GetNWString("RoleShow", "")][GAMEMODE.RoundType]) do
				        ply:Give(wep)
	            	end
	            end
	            if HMCD_Loadout_Firearms[ply:GetNWString("RoleShow", "")][GAMEMODE.RoundType] then
		            for i,wep in pairs(HMCD_Loadout_Firearms[ply:GetNWString("RoleShow", "")][GAMEMODE.RoundType]) do
                        if wep != "" then
				            ply:Give(wep)
                            ply:GiveAmmo(weapons.Get(wep).Primary.ClipSize, weapons.Get(wep).Primary.Ammo, true)
                            if GAMEMODE.RoundType == 2 and ply.Role == "Traitor" then
                                ply.Equipment[6]=true
		                        net.Start("hmcd_equipment")
		                        net.WriteInt(6,6)
		                        net.WriteBit(true)
		                        net.Send(ply)
                            end
                        end
	            	end
	            end
	        end
        end)
    elseif GAMEMODE.RoundName == "sandbox" then
        timer.Simple(.3,function()
	        for _,ply in pairs(ply_GetAll())do
                ply.Role = "Sandboxer"
	        end
        end)
    elseif GAMEMODE.RoundName == "dm" then
        timer.Simple(.3, function()
	        for _,ply in pairs(ply_GetAll())do
                ply.Role = "Fighter"
                ply:SetNWString("RoleShow", "Fighter")
	        end
        end)
    end
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
    if #ply_GetAll() < 2 then GAMEMODE.RoundState = 2 return end
    if GAMEMODE.RoundState == 0 or GAMEMODE.RoundState == 2 then 
        if GAMEMODE.RoundState == 2 and #ply_GetAll() > 1 then 
            GAMEMODE:EndRound(1, table.Random(player.GetAll())) 
        end
    return end
    local alive_ply = GetAlivePlayerCount()
    if alive_ply <= 0 then
        GAMEMODE:EndRound(1, table.Random(player.GetAll()))
    end

    if GAMEMODE.RoundName != "homicide" then
        GAMEMODE.RoundType = 0
    end

    if GAMEMODE.RoundName == "dm" then
        if alive_ply == 1 then
            GAMEMODE:EndRound(1, GetLastPlayerAlive())
        end
    return end

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
    if GAMEMODE.RoundName != "sandbox" then return false end
end)