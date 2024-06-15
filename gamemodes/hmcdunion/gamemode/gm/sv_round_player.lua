local hRun = hook.Run
hook.Add("RoundPlayerVar", "FUNC_VAR", function(ply)
    ply.Role = "Bystander"
    ply.SecretRole = ""
    ply:SetNWString("SecretRole", "")
    ply:SetNWString("RoleShow", "Bystander")
end)

hook.Add("PlayerSpawn", "RoundPlayerVar_Spawn", function(ply)
    if PLYSPAWN_OVERRIDE then return end
    hRun("RoundPlayerVar", ply)
end)

hook.Add("PlayerPostThink", "RoleColor_Synch", function(ply)
    if ply.Role == "Bystander" and ply:GetNWInt("RoleColor_R") != 57 and ply:GetNWInt("RoleColor_G") != 62 and ply:GetNWInt("RoleColor_B") != 213 then
        ply:SetNWInt("RoleColor_R", 57)
        ply:SetNWInt("RoleColor_G", 62)
        ply:SetNWInt("RoleColor_B", 213)
    elseif ply.Role == "Traitor" and ply:GetNWInt("RoleColor_R") != 164 and ply:GetNWInt("RoleColor_G") != 26 and ply:GetNWInt("RoleColor_B") != 26 then
        ply:SetNWInt("RoleColor_R", 164)
        ply:SetNWInt("RoleColor_G", 26)
        ply:SetNWInt("RoleColor_B", 26)
    end
end)