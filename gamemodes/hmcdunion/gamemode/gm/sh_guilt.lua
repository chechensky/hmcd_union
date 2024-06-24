local Guilt_Sentences = {
    "Seizure",
    "Thunder"
}
hook.Add("Player Think", "GuiltThink", function(ply)
    ply:SetPData("U_Guilt", ply:GetNWInt("Guilt", 0))
    if ply.Guilt_Sentence == "Seizure" then

    elseif ply.Guilt_Sentence == "Thunder" end
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

    if attacker.Role != victim.Role then
        attacker:SetNWInt("Guilt", attacker:GetNWInt("Guilt", 0) + dmginfo:GetDamage() / math.random(2, 4))
        attacker:SetPData("U_Guilt", attacker:GetNWInt("Guilt", 0))
        if attacker:GetPData("U_Guilt", 0) >= 100 then
            attacker:SetNWInt("Guilt", 0)
            attacker.Guilt_Sentence = table.Random(Guilt_Sentences)
        end
    end
end)