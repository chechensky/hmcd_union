local hRun = hook.Run
hook.Add("RoundPlayerVar", "FUNC_VAR", function(ply)
    ply.Role = "Bystander"
    ply.SecretRole = ""
    ply:SetNWString("SecretRole", "")
    ply:SetNWString("RoleShow", "Bystander")
    ply:SetRoleColor(57,62,213)
end)

hook.Add("PlayerSpawn", "RoundPlayerVar_Spawn", function(ply)
    if PLYSPAWN_OVERRIDE then return end
    hRun("RoundPlayerVar", ply)
end)