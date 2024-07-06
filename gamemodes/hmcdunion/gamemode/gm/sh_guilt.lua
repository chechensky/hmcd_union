local PlayerMeta = FindMetaTable("Player")

local Guilt_Sentences = {
    "Seizure",
    "Thunder"
}

function PlayerMeta:GuiltAdd(count) 
    local guilt = self:GetNWInt("Guilt", 0)
    self:SetNWInt("Guilt", guilt + count)
    self:SetPData("U_Guilt", guilt)
end

function PlayerMeta:GuiltRemove(count) 
    local guilt = self:GetNWInt("Guilt", 0)
    self:SetNWInt("Guilt", guilt - count)
    self:SetPData("U_Guilt", guilt)
end

function PlayerMeta:GuiltSet(count) 
    local guilt = self:GetNWInt("Guilt", 0)
    self:SetNWInt("Guilt", count)
    self:SetPData("U_Guilt", guily)
end

hook.Add("Player Think", "GuiltThink", function(ply)
    if ply.Guilt_Sentence == "Seizure" then
        ply.Guilt_Sentence = nil
        ply.Seizure = true
        ply.SeizureReps = 0
        if math.random(1,2) == 1 then Faking(ply) end
    elseif ply.Guilt_Sentence == "Thunder" then
        ply.Guilt_Sentence = nil
        sound.Play("snd_jack_hmcd_lightning.wav", ply:GetPos(), 100, 100, 10)
    end
end)

hook.Add("HOOK_UNION_Damage","GuiltLogic",function(ply,hitgroup,dmginfo,rag)
    local victim = ply
    local attacker
    if !dmginfo:GetAttacker():IsPlayer() then
        attacker = dmginfo:GetAttacker():GetOwner()
    else
        attacker = dmginfo:GetAttacker()
    end

    if !attacker:IsPlayer() then return end

    if dmginfo:GetDamage() > 5 and attacker.Role != "Traitor" then
        if attacker:GetNWBool("LostInnocence", false) != true then
            attacker:SetNWBool("LostInnocence", true)
        end
        -- простите вот кодеры если таймеры это хуйня но сука я не могу придумать через что это можно сделать
        timer.Simple(10, function()
            if attacker:GetNWBool("LostInnocence", false) == true then
                attacker:SetNWBool("LostInnocence", false)
            end
        end)
    end
    if attacker.Role != victim.Role then
        if ply:GetNWString("Round", "") == "homicide" and attacker.Role == "Traitor" then return end
        if ply:GetNWString("Round", "") == "homicide" and victim.Role == "Traitor" then return end
        if ply:GetNWString("Round", "") == "dm" then return end
        local guiltint = math.ceil(dmginfo:GetDamage() / math.random(2, 4)) -- АХВХАВХАВХАХВ ceil вместо floor XDXDXDXDXDXDXDX ТУДА НАХУЙ ЭТИХ ТИМКИЛЛЕРОВ
        attacker:GuiltAdd( guiltint )
        if attacker:GetNWInt("Guilt", 0) >= 100 then
            attacker:GuiltSet(0)
            attacker.Guilt_Sentence = table.Random(Guilt_Sentences)
        end
    end
end)

local hook_run = hook.Run

timer.Create("Seizure",2,0,function()
    for _, ply in player.Iterator() do
        hook_run("SeizureGuilt", ply)
    end
end)

hook.Add("SeizureGuilt", "GuiltSuka", function(ply)
    if !ply.Seizure then return end
    ply.SeizureReps = ply.SeizureReps + 1
    ply:ViewPunch(Angle ( math.random(0.3, 2), math.random(0.3, 0.5), math.random(0.1, 1) ) )
    timer.Simple(1.1,function() ply:SetEyeAngles(Angle( math.random(10, 80), math.random(20, 40), -math.random(10, 30)) ) end)
    ply:ConCommand("+attack")
    if ply.SeizureReps >= 10 then
        ply.Seizure = false
        ply.SeizureReps = 0
        ply:ConCommand("-attack")
    end
end)