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
    if attacker.Role != victim.Role and attacker.Role != "Traitor" then
        attacker:GuiltAdd(dmginfo:GetDamage() / math.random(2, 4))
        if attacker:GetNWInt("Guilt", 0) >= 100 then
            attacker:GuiltSet(0)
            attacker.Guilt_Sentence = table.Random(Guilt_Sentences)
        end
    end
end)