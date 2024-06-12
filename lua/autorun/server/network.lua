local PushSound = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
	"physics/body/body_medium_impact_soft5.wav",
	"physics/body/body_medium_impact_soft6.wav",
	"physics/body/body_medium_impact_soft7.wav",
}

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

util.AddNetworkString("Use_DoorStuck")
net.Receive("Use_DoorStuck", function(len,ply)
    local door = net.ReadEntity()

    if door.count_stuck == nil then door.count_stuck = 0 end
    if door:GetInternalVariable("m_bLocked") then ply:ChatPrint("This door is locked.") return end
    if door.count_stuck >= 3 then ply:ChatPrint("They have already tried to block this door.") return end

    door.count_stuck = door.count_stuck + 1
    ply:EmitSound("Flesh.ImpactSoft")
    ply:ViewPunch(Angle(5,0,0))
    if math.random(1, 3) == 2 then
        ply:ChatPrint("Yes! You managed to lock this door!")
        door:Fire("lock", "", 0)
        ply:EmitSound("Wood_Plank.ImpactSoft")
    else
        ply:ChatPrint("Nice try, it didn't work.")
    end
end)

util.AddNetworkString("Use_DoorUnStuck")
net.Receive("Use_DoorUnStuck", function(len,ply)
    local door = net.ReadEntity()

    if door.count_unstuck == nil then door.count_unstuck = 0 end
    if !door:GetInternalVariable("m_bLocked") then ply:ChatPrint("This door is not locked.") return end
    if door.count_unstuck >= 3 then ply:ChatPrint("They have already tried to unlock this door.") return end

    door.count_unstuck = door.count_unstuck + 1
    ply:EmitSound("Flesh.ImpactSoft")
    ply:ViewPunch(Angle(5,0,0))
    if math.random(1, 3) == 2 then
        ply:ChatPrint("Yes! You managed to unlock this door!")
        door:Fire("unlock", "", 0)
        ply:EmitSound("Flesh.ImpactSoft")
        constraint.RemoveAll(door)
    else
        ply:ChatPrint("Nice try, it didn't work.")
    end
end)

util.AddNetworkString("Player_Push")
net.Receive("Player_Push", function(len,ply)
    local pushed = net.ReadEntity()

    if !pushed:IsPlayer() and !IsValid(pushed) then return end
	ply:EmitSound( PushSound[math.random(#PushSound)], 100, 100 )
	local velAng = ply:EyeAngles():Forward()
	pushed:SetVelocity( velAng * 50 )
	pushed:ViewPunch( Angle( math.random( -30, 30 ), math.random( -30, 30 ), 0 ) )
end)

util.AddNetworkString("MK_CheckLeftArm")
net.Receive("MK_CheckLeftArm", function(len,ply)
    local dude = net.ReadEntity()
    ply:ChatPrint(dude.Wounds["left_hand"] .. " wounds.")
    if dude.BleedOuts["left_hand"] > 0 then
        ply:ChatPrint("Bleeding.")
    else
         ply:ChatPrint("No bleeding.")
    end
end)

util.AddNetworkString("MK_CheckRightArm")
net.Receive("MK_CheckRightArm", function(len,ply)
    local dude = net.ReadEntity()
    ply:ChatPrint(dude.Wounds["right_hand"] .. " wounds.")
    if dude.BleedOuts["right_hand"] > 0 then
        ply:ChatPrint("Bleeding.")
    else
         ply:ChatPrint("No bleeding.")
    end
end)

util.AddNetworkString("MK_CheckRightLeg")
net.Receive("MK_CheckRightLeg", function(len,ply)
    local dude = net.ReadEntity()
    ply:ChatPrint(dude.Wounds["right_leg"] .. " wounds.")
    if dude.BleedOuts["right_leg"] > 0 then
        ply:ChatPrint("Bleeding.")
    else
         ply:ChatPrint("No bleeding.")
    end
end)

util.AddNetworkString("MK_CheckLeftLeg")
net.Receive("MK_CheckLeftLeg", function(len,ply)
    local dude = net.ReadEntity()
    ply:ChatPrint(dude.Wounds["left_leg"] .. " wounds.")
    if ply.BleedOuts["left_leg"] > 0 then
        ply:ChatPrint("Bleeding.")
    else
         ply:ChatPrint("No bleeding.")
    end
end)

util.AddNetworkString("MK_CheckStomach")
net.Receive("MK_CheckStomach", function(len,ply)
    local dude = net.ReadEntity()
    ply:ChatPrint(dude.Wounds["stomach"] .. " wounds.")
    if dude.BleedOuts["stomach"] > 0 then
        ply:ChatPrint("Bleeding.")
    else
         ply:ChatPrint("No bleeding.")
    end
end)

util.AddNetworkString("MK_CheckChest")
net.Receive("MK_CheckChest", function(len,ply)
    local dude = net.ReadEntity()
    ply:ChatPrint(dude.Wounds["chest"] .. " wounds.")
    if dude.BleedOuts["chest"] > 0 then
        ply:ChatPrint("Bleeding.")
    else
        ply:ChatPrint("No bleeding.")
    end
end)

-----------------

util.AddNetworkString("MK_LeftArm")
net.Receive("MK_LeftArm", function(len,ply)
    local dude = net.ReadEntity()
    if ply:GetActiveWeapon().Resource <= 0 then ply:ChatPrint("Zero medicaments.") return end
    StandartHeal(ply)
    dude.pain = dude.pain - 40
    dude:SetHealth(dude:Health() + 50)
    if dude.BleedOuts["left_hand"] > 30 then
        dude.BleedOuts["left_hand"] = dude.BleedOuts["left_hand"] - 30
    end
end)

util.AddNetworkString("MK_RightArm")
net.Receive("MK_RightArm", function(len,ply)
    local dude = net.ReadEntity()
    if ply:GetActiveWeapon().Resource <= 0 then ply:ChatPrint("Zero medicaments.") return end
    StandartHeal(ply)
    dude.pain = dude.pain - 40
    dude:SetHealth(dude:Health() + 50)
    dude.BleedOuts["right_hand"] = dude.BleedOuts["right_hand"] - 30
end)

util.AddNetworkString("MK_RightLeg")
net.Receive("MK_RightLeg", function(len,ply)
    local dude = net.ReadEntity()
    if ply:GetActiveWeapon().Resource <= 0 then ply:ChatPrint("Zero medicaments.") return end
    StandartHeal(ply)
    dude.pain = dude.pain - 40
    dude:SetHealth(dude:Health() + 50)
    dude.BleedOuts["right_leg"] = dude.BleedOuts["right_leg"] - 30
end)

util.AddNetworkString("MK_LeftLeg")
net.Receive("MK_LeftLeg", function(len,ply)
    local dude = net.ReadEntity()
    if ply:GetActiveWeapon().Resource <= 0 then ply:ChatPrint("Zero medicaments.") return end
    StandartHeal(ply)
    dude.pain = dude.pain - 40
    dude:SetHealth(dude:Health() + 50)
    dude.BleedOuts["left_leg"] = dude.BleedOuts["left_leg"] - 30
end)

util.AddNetworkString("MK_Stomach")
net.Receive("MK_Stomach", function(len,ply)
    local dude = net.ReadEntity()
    if ply:GetActiveWeapon().Resource <= 0 then ply:ChatPrint("Zero medicaments.") return end
    StandartHeal(ply)
    dude.pain = dude.pain - 40
    dude:SetHealth(dude:Health() + 50)
    dude.BleedOuts["stomach"] = dude.BleedOuts["stomach"] - 30
end)

util.AddNetworkString("MK_Chest")
net.Receive("MK_Chest", function(len,ply)
    local dude = net.ReadEntity()
    if ply:GetActiveWeapon().Resource <= 0 then ply:ChatPrint("Zero medicaments.") return end
    StandartHeal(ply)
    dude.pain = dude.pain - 40
    dude:SetHealth(dude:Health() + 50)
    dude.BleedOuts["chest"] = dude.BleedOuts["chest"] - 30
end)