local ply_GetAll = player.GetAll

concommand.Add("union_gamemode", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    if args[1] == "homicide" then
        local hmcd_roundtype = math.random(1,5)
        SetGlobalString("RoundNext", "homicide")
        SetGlobalInt("RoundNextType", hmcd_roundtype)
        PrintMessage(HUD_PRINTTALK, "Next gamemode: Homicide - " .. HMCD_RoundsTypeNormalise[hmcd_roundtype])
    elseif args[1] == "dm" then
        SetGlobalString("RoundNext", "dm")
        SetGlobalInt("RoundNextType", 0)
        PrintMessage(HUD_PRINTTALK, "Next gamemode: Deathmatch")
    elseif args[1] == "hl2" then
        SetGlobalString("RoundNext", "hl2")
        SetGlobalInt("RoundNextType", 0)
        PrintMessage(HUD_PRINTTALK, "Next gamemode: Half Life 2 - Deathmatch")
    elseif args[1] == "sandbox" then
        SetGlobalString("RoundNext", "sandbox")
        SetGlobalInt("RoundNextType", 0)
        PrintMessage(HUD_PRINTTALK, "Next gamemode: SandBox")
    end
end)

concommand.Add("union_gamemode_end", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    GAMEMODE:EndRound(3, ply)
end)

concommand.Add("union_homicidetype", function(ply,cmd,args)
    if not ply:IsAdmin() then return end
    print("Homicide Types: " .. "\n" .. "1 = Standart" .. "\n" .. "2 = SOE" .. "\n" .. "3 = JIHAD" .. "\n" .. "4 = Wild west")
    if args[1] == "1" or args[1] == "2" or args[1] == "3" or args[1] == "4" then
        local pizda = tonumber(args[1])
        SetGlobalInt("RoundNextType", pizda)
        PrintMessage(HUD_PRINTTALK, "Next Homicide roundtype: " .. HMCD_RoundsTypeNormalise[pizda])
    end
end)

local CombineNames = {
    "Slam",
    "Leader",
    "Jet"
}

local CombineColorsNames = {
    "Red",
    "Blue",
    "WhiteRed"
}

local CombineColors = {
   ["Red"] = {
        199,
        32,
        32
    },
    ["Blue"] = {
        27,
        75,
        188
    },
    ["WhiteRed"] = {
        228,
        97,
        110
    }
}

concommand.Add("union_pidorsflash", function(ply,cmd,args)
	local attachmentsuka=ents.Create("ent_jack_hmcd_flashlight")
	attachmentsuka.HmcdSpawned=true
	attachmentsuka:SetPos(ply:GetShootPos()+ply:GetAimVector()*20)
    attachmentsuka:TurnOn()
	attachmentsuka:GetPhysicsObject():SetVelocity(ply:GetVelocity()+ply:GetAimVector()*100)
end)

---------- round logics???)())))))))
local pitch = math.random(80, 120)
function GM:StartRound()
	if #ply_GetAll()<2 then return end
    local hmcd_roundtype = math.random(1,5)
    local roundt = table.Random(Rounds)
    local rezhim = GetGlobalInt("RoundNextType", 2) or math.random(1, 5)
    SetGlobalString("RoundName", GetGlobalString("RoundNext", "homicide"))
    SetGlobalString("RoundNext", roundt)
    
    if GetGlobalString("RoundName", "homicide") == "homicide" then
        SetGlobalInt("RoundType", rezhim)
        SetGlobalInt("RoundNextType", math.random(1, 5))
    else
        SetGlobalInt("RoundType", 0)
        SetGlobalInt("RoundNextType", math.random(1, 5))
    end
    game.CleanUpMap(false, { "env_fire", "entityflame", "_firesmoke" })
	for _,ply in pairs(ply_GetAll())do

        if ply.fake then
            Faking(ply)
        end

        ply:UnSpectate()
		ply:StripAmmo()
		ply:StripWeapons()
		ply:Spawn()

	end
    if GetGlobalString("RoundName", "homicide") == "homicide" then
        timer.Simple(.4,function()

            local traitor = table.Random(ply_GetAll())
            local gunman

            repeat
                gunman = table.Random(ply_GetAll())
            until gunman != traitor
            traitor.Role = "Traitor"
            traitor:SetNWString("RoleShow", "Traitor")
            traitor:SetRoleColor(164,26,26)
            if GetGlobalInt("RoundType", 2) != 5 then
                gunman.SecretRole = "Gunman"
                gunman:SetNWString("RoleShow", "Gunman")
            end

            GAMEMODE.Traitor = traitor
            SetGlobalInt("RoundState", 1)
	        for _,ply in pairs(ply_GetAll())do
	            if HMCD_Loadout[ply:GetNWString("RoleShow", "")][GetGlobalInt("RoundType", 2)] then
		            for i,wep in pairs(HMCD_Loadout[ply:GetNWString("RoleShow", "")][GetGlobalInt("RoundType", 2)]) do
				        ply:Give(wep)
	            	end
	            end
	            if HMCD_Loadout_Firearms[ply:GetNWString("RoleShow", "")][GetGlobalInt("RoundType", 2)] then
		            for i,wep in pairs(HMCD_Loadout_Firearms[ply:GetNWString("RoleShow", "")][GetGlobalInt("RoundType", 2)]) do
                        if wep != "" then
				            ply:Give(wep)
                            if ply:GetNWString("RoleShow", "") == "Traitor" then ply:GiveAmmo(weapons.Get(wep).Primary.ClipSize, weapons.Get(wep).Primary.Ammo, true) end
                            if GetGlobalInt("RoundType", 2) == 2 and ply.Role == "Traitor" then
                                ply.Equipment[6]=true
		                        net.Start("hmcd_equipment")
		                        net.WriteInt(6,6)
		                        net.WriteBit(true)
		                        net.Send(ply)
                            end
                            if ply.Role == "Traitor" then
			                    ply:AllowFlashlight(true)
			                    ply.Equipment[HMCD_EquipmentNames[5]] = true
			                    net.Start("hmcd_equipment")
			                    net.WriteInt(5, 6)
			                    net.WriteBit(true)
			                    net.Send(ply)
                            end
                        end
	            	end
	            end
	        end
        end)
    elseif GetGlobalString("RoundName", "homicide") == "sandbox" then
        timer.Simple(.1,function()
	        for _,ply in pairs(ply_GetAll())do
                ply.Role = "Sandboxer"
                SetGlobalInt("RoundState", 1)
	        end
        end)
    elseif GetGlobalString("RoundName", "homicide") == "dm" then
        SetGlobalInt("DMTime", 10)
        GAMEMODE.NoGun = true
        timer.Simple(12,function()
            timer.Create("DM_Timer", 1, 10, function()
                SetGlobalInt("DMTime", GetGlobalInt("DMTime", 10) - 1)
                if timer.RepsLeft("DM_Timer") <= 0 then
                    timer.Remove("DM_Timer")
                    GAMEMODE.NoGun = false
                end
            end)
        end)
        timer.Simple(.4, function()
            local bodyvest = {
                "Level IIIA",
                "Level III"
            }

	        for _,ply in pairs(ply_GetAll())do
                ply.Role = "Fighter"
                ply:SetNWString("RoleShow", "Fighter")

                timer.Simple(1,function()
                    ply:SetNWString("Bodyvest", table.Random(bodyvest))
                    if math.random(1, 3) == 2 then
                        ply:SetNWString("Helmet", "ACH")
                    end
                end)

                local mainwep = table.Random(DM_LoadoutMain)
                local secwep = table.Random(DM_LoadoutSecondary)
				ply:Give(mainwep)
                ply:GiveAmmo(weapons.Get(mainwep).Primary.ClipSize * 1.5, weapons.Get(mainwep).Primary.Ammo, true)
				ply:Give(secwep)
                ply:GiveAmmo(weapons.Get(secwep).Primary.ClipSize * 0.5, weapons.Get(mainwep).Primary.Ammo, true)
                ply:Give("wep_jack_hmcd_knife")
                ply:Give(table.Random({"wep_jack_hmcd_bandagebig", "wep_jack_hmcd_bandage","wep_jack_hmcd_medkit"}))
                ply:Give(table.Random({"wep_jack_hmcd_painpills","wep_jack_hmcd_adrenaline"}))
                ply:Give("wep_jack_hmcd_oldgrenade_dm")
                for i=1, math.random(1, 4) do
                    local atth = math.random(6,15)
                    ply.Equipment[atth]=true
		            net.Start("hmcd_equipment")
		            net.WriteInt(atth,6)
		            net.WriteBit(true)
		            net.Send(ply)
                end
                SetGlobalInt("RoundState", 1)
	        end
        end)
    elseif GetGlobalString("RoundName", "homicide") == "hl2" then
        timer.Simple(.4, function()
            local bodyvest = {
                "Level IIIA",
                "Level III"
            }
	        for _, ply in pairs(ply_GetAll())do
                local class = table.Random(Classes)

                if _ % 2 == 0 then

                    ply.Role = "Rebel"

                    ply:SetNWString("HL2_Class", class)
                    ply:SetRoleColor(29,125,19)
                    timer.Simple(1,function()
                        ply:SetNWString("Bodyvest", table.Random(bodyvest))
                        if math.random(1, 3) == 2 then
                            ply:SetNWString("Helmet", "ACH")
                        end
                    end)
                    if ply:GetNWString("HL2_Class", "") == "Medic" then
                        ply:SetModel(table.Random(Medic_RebelModels[ply.ModelSex]))
                    else
                        ply:SetModel(table.Random(Fighter_RebelModels[ply.ModelSex]))
                    end
                    if #ents.FindByClass("info_player_terrorist") > 0 then
                        ply:SetPos(ents.FindByClass("info_player_terrorist")[table.Random(1,10)]:GetPos())
                    end

                else
                    local cmbcolor = CombineColors[table.Random(CombineColorsNames)]
                    ply.Role = "Combine"
                    ply.ModelSex = "combine"
                    ply:SetRoleColor(cmbcolor[1], cmbcolor[2], cmbcolor[3])
                    ply:SetNWString("Character_Name", table.Random(CombineNames) .. "-" .. math.random(1, 3))
                    ply:SetNWString("HL2_Class", table.Random(ClassesCombine))
                    ply:SetModel(CombineModels[ply:GetNWString("HL2_Class","")])
                    if ply:GetNWString("HL2_Class","") == "Shotguner" then
                        ply:SetBodygroup(0, 1)
                    end
                    ply:SetupHands()
                    if #ents.FindByClass("info_player_terrorist") > 0 then
                        ply:SetPos(ents.FindByClass("info_player_counterterrorist")[table.Random(1,10)]:GetPos())
                    end
                end
		        ply:SetNWString("RoleShow", ply.Role)
                for i,wep in pairs(HL2_Loadout[ply.Role][ply:GetNWString("HL2_Class")]) do
				    ply:Give(wep)
	            end

                local totalwep_main = table.Random(HL2_LoadoutFire_Main[ply.Role][ply:GetNWString("HL2_Class")])
                local totalwep_sec = table.Random(HL2_LoadoutFire_Secondary[ply.Role])
				ply:Give(totalwep_main)
                ply:GiveAmmo(weapons.Get(totalwep_main).Primary.ClipSize * 2, weapons.Get(totalwep_main).Primary.Ammo, true)
				
                ply:Give(totalwep_sec)
                ply:GiveAmmo(weapons.Get(totalwep_sec).Primary.ClipSize * 1, weapons.Get(totalwep_sec).Primary.Ammo, true)          
            timer.Simple(2, function()     
                print(GetAliveRoleCount("Rebel"))
                if GetAliveRoleCount("Rebel") > 2 then
            
                    local rpg = GetRandomRolePlayer("Rebel")
                    rpg:Give("wep_jack_hmcd_rpg", false)
                    rpg:GiveAmmo(1, "RPG_Round", true)
            
                end

                if GetAliveRoleCount("Rebel") > 3 then
                
                    local crossbow
                    repeat
                        crossbow = GetRandomRolePlayer("Rebel")
                    until crossbow != rpg
                    crossbow:Give("wep_jack_hmcd_crossbow", false)
                    crossbow:GiveAmmo(5, "XBowBolt", true)
                
                end
            end)
            end
            SetGlobalInt("RoundState", 1)
        end)
    end
    timer.Simple(1, function()
	    for _,ply in pairs(ply_GetAll())do
	        net.Start("StartRound")
	        net.Send(ply)
	    end
    end)
end

hook.Add("PlayerPostThink", "IncreaseFOVOnSprint", function(ply)
    if !IsValid(ply) or !ply:Alive() then return end
    if ply:KeyDown(IN_FORWARD) and ply:KeyDown(IN_SPEED) then
        ply:SetFOV(105, 0.1)
    else
        ply:SetFOV(95, 0.1)
    end
end)

-- win traitor 1
-- lost traitor 2 
function GM:EndRound(reason, mvp, survived)
    PrintMessage(HUD_PRINTTALK, "Round end")
    net.Start("EndRound")

	    net.WriteUInt(reason, 8)
	    net.WriteEntity(mvp or Entity(-1))
        if mvp then
	        net.WriteVector(mvp:GetPlayerColor())
	        net.WriteString(mvp:GetNWString("Character_Name"))
        else
	        net.WriteVector(Vector(0,0,0))
	        net.WriteString("?")
        end
        if survived then
            net.WriteString(survived:GetNWString("Character_Name", ""))
        else
            net.WriteString("?")
        end

    net.Broadcast()

    timer.Simple(5, function()
        GAMEMODE:StartRound()
    end)
    SetGlobalInt("RoundState", 0)
end

function GM:Think()
    if GetGlobalString("RoundName", "homicide") == "sandbox" then return end
    if #ply_GetAll() < 2 then SetGlobalInt("RoundState", 2) end
    if GetGlobalInt("RoundState", 0) == 0 or GetGlobalInt("RoundState", 0) == 2 then 
        if GetGlobalInt("RoundState", 0) == 2 and #ply_GetAll() > 1 then 
            GAMEMODE:EndRound(1, table.Random(player.GetAll()), nil) 
        end
    return end
    local alive_ply = GetAlivePlayerCount()
    if alive_ply <= 0 then
        GAMEMODE:EndRound(1, table.Random(player.GetAll()), nil)
    end
    if GetGlobalString("RoundName", "homicide") != "homicide" then
        SetGlobalInt("RoundType", 0)
    end

    if GetGlobalString("RoundName", "homicide") == "dm" then
        if alive_ply < 2 then
            GAMEMODE:EndRound(6, nil, GetLastPlayerAlive())
        end
    return end

    if GetGlobalString("RoundName", "homicide") == "hl2" then
        local alive_rebel, alive_combine = GetAliveRoleCount("Rebel"), GetAliveRoleCount("Combine")
        if alive_rebel < 1 then
            GAMEMODE:EndRound(4, nil)
        elseif alive_combine < 1 and alive_rebel > 0 then
            GAMEMODE:EndRound(5, nil)
        end
    return end

    if GetGlobalString("RoundName", "homicide") == "homicide" then
        if GetGlobalInt("RoundState", 0) == 1 then
            local alive_traitor, alive_innocent = GetAliveRoleCount("Traitor"), GetAliveRoleCount("Bystander")
            if alive_innocent < 1 then
                GAMEMODE:EndRound(1, GAMEMODE.Traitor)

            elseif alive_traitor < 1 and alive_innocent > 0 then
                GAMEMODE:EndRound(2, GAMEMODE.Traitor.LastAttacker)
                if GAMEMODE.Traitor.LastDamageType then
                    PrintMessage(HUD_PRINTTALK, "The murderer died because of " .. GAMEMODE.Traitor.LastDamageType)
                end
            end

        end

    return end
end

hook.Add("PlayerPostThink", "Spectating", function(ply)
    if !ply:GetNWBool("Spectating", false) then return end
	local plyselect = ply:GetNWEntity("SelectPlayer", Entity(-1))
    if !IsValid(ply:GetNWEntity("SelectPlayer", Entity(-1))) then ply:SetNWEntity("SelectPlayer", table.Random(player.GetAll())) end
    ButtonInput = 0
    ply.ButtonInput = ply.ButtonInput or ButtonInput

        if ply:KeyDown(IN_ATTACK) and ply.ButtonInput < CurTime() then
            ply.ButtonInput = CurTime() + math.random(0.1, 0.5)
            repeat
                 ply:SetNWEntity("SelectPlayer", table.Random(player.GetAll()))
            until ply != ply:GetNWEntity("SelectPlayer", Entity(-1)) and ply:GetNWEntity("SelectPlayer", Entity(-1)):Alive()
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
    return false
end)