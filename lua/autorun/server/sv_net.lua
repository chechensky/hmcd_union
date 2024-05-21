-- нетворки для клиент сайда, кстати в шэйред никогда нетворки не писать а то гавнаеды вдруг скриптхукнут хотя хуй

util.AddNetworkString("Unload")
net.Receive("Unload",function(len,ply)
	local wep = net.ReadEntity()
	local oldclip = wep:Clip1()
	local ammo = wep:GetPrimaryAmmoType()
	wep:EmitSound("snd_jack_hmcd_ammotake.wav")
	wep:SetClip1(0)
	ply:GiveAmmo(oldclip,ammo)
end)

util.AddNetworkString("GiveAmmo")
net.Receive("GiveAmmo", function(len, ply)
    local target = net.ReadEntity()
    local ammotype = net.ReadFloat()
    local count = net.ReadFloat()
    if not target:IsPlayer() then return end

    if count > 0 then
        ply:RemoveAmmo(count, ammotype)
        target:GiveAmmo(count, ammotype, true)
        ply:ChatPrint("Вы передали " .. target:Nick() .. " патроны " .. game.GetAmmoName(ammotype) .. " в количестве " .. count .. ".")
        ply:EmitSound("snd_jack_hmcd_ammobox.wav", 75, math.random(80,90), 1, CHAN_ITEM )
    end
end)

util.AddNetworkString( "DropAmmos" )
net.Receive( "DropAmmos", function( len, ply )
    if not ply:Alive() or ply.Otrub then return end
    local ammotype = net.ReadFloat()
    local count = net.ReadFloat()
    if ply:GetAmmoCount(ammotype) - count < 0 then ply:ChatPrint("У тебя столько нет пулек") return end
    if count < 1 then ply:ChatPrint("Ноль пулек не скинуть") return end
    ply:SetAmmo(ply:GetAmmoCount(ammotype)-count,ammotype)
    ply:EmitSound("snd_jack_hmcd_ammobox.wav", 75, math.random(80,90), 1, CHAN_ITEM )
end)