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

-- bodyloot
util.AddNetworkString("inventory")
util.AddNetworkString("ply_take_item")
util.AddNetworkString("ply_take_ammo")
util.AddNetworkString("ply_take_armor")


local function send(ply,lootEnt,remove)
	if ply then
		net.Start("inventory")
		net.WriteEntity(not remove and lootEnt or nil)

		net.WriteTable(lootEnt.Info.Weapons)
		net.WriteTable(lootEnt.Info.Ammo)
		net.Send(ply)
	else
		for ply in pairs(lootEnt.UsersInventory) do
			if not IsValid(ply) or not ply:Alive() or remove then lootEnt.UsersInventory[ply] = nil continue end

			send(ply,lootEnt,remove)
		end
	end
end

hook.Add("PlayerSpawn","!!!huyassdd",function(lootEnt)
	if lootEnt.UsersInventory ~= nil then
		for plys,bool in pairs(lootEnt.UsersInventory) do
			lootEnt.UsersInventory[plys] = nil
			send(plys,lootEnt,true)
		end
	end
end)

hook.Add("Player Think","Looting",function(ply)
	local key = ply:KeyDown(IN_USE)

	if not ply.fake and ply:Alive() and ply:KeyDown(IN_ATTACK2) then
		if ply.okeloot ~= key and key then
	        local Ent = HMCD_WhomILookinAt(ply, .35, 60)

			if not IsValid(Ent) then return end
			if IsValid(RagdollOwner(Ent)) then Ent = RagdollOwner(Ent) end
			if IsValid(Ent) and Ent.IsJModArmor then Ent = Ent.Owner end
			if Ent:IsPlayer() and Ent:Alive() and not Ent.fake then return end
			if not Ent.Info then return end
			Ent.UsersInventory = Ent.UsersInventory or {}
			Ent.UsersInventory[ply] = true

			send(ply,Ent)
			Ent:CallOnRemove("fuckoff",function() send(nil,Ent,true) end)
		end
	end

	ply.okeloot = key
end)
local function FindWeaponByClass(player, class)
    for _, weapon in pairs(player:GetWeapons()) do
        if weapon:GetClass() == class then
            return weapon
        end
    end
    return nil
end
local prekol = {
	weapon_physgun = true,
	gmod_tool = true
}

net.Receive("inventory",function(len,ply)
	local lootEnt = net.ReadEntity()
	if not IsValid(lootEnt) then return end

	lootEnt.UsersInventory[ply] = nil
end)

net.Receive("ply_take_item",function(len,ply)

	local lootEnt = net.ReadEntity()
	if not IsValid(lootEnt) then return end

	local wep = net.ReadString()

	local lootInfo = lootEnt.Info
	local wepInfo = lootInfo.Weapons[wep]
	
	if not wepInfo then return end

	if ply:HasWeapon(wep) then
		if lootEnt:IsPlayer() and (lootEnt.curweapon == wep and not lootEnt.Otrub) then return end
		if wepInfo.Clip1~=nil and wepInfo.Clip1 > 0 then
			ply:GiveAmmo(wepInfo.Clip1,wepInfo.AmmoType)
			wepInfo.Clip1 = 0
		else
			ply:ChatPrint("You already have this gun.")
		end
	else
		if lootEnt:IsPlayer() and (lootEnt.curweapon == wep and not lootEnt.Otrub) then return end
		
		ply.slots = ply.slots or {}
		local realwep = weapons.Get(wep)
		
		if IsValid(lootEnt.wep) and lootEnt.curweapon == wep then
			DespawnWeapon(lootEnt)
			lootEnt.wep:Remove()
		end

		local actwep = ply:GetActiveWeapon()
		local wep1 = ply:Give(wep)
		if IsValid(wep1) and wep1:IsWeapon() then
			wep1:SetClip1(wepInfo.Clip1 or 0)
		end
		ply:SelectWeapon(actwep:GetClass())
<<<<<<< HEAD
=======
        --print(lootEnt:IsPlayer())
>>>>>>> d44a84bc83d3f2e5937a97c3d003dfa74263fa66
        if lootEnt:IsPlayer() then lootEnt:StripWeapon(wep) end
		lootInfo.Weapons[wep] = nil
		table.RemoveByValue(lootInfo.Weapons2,wep)
	end
	net.Start("inventory")
		net.WriteEntity(lootEnt)

		net.WriteTable(lootEnt.Info.Weapons)
		net.WriteTable(lootEnt.Info.Ammo)
	net.Send(ply)
end)

net.Receive("ply_take_armor",function(len,ply)

    local lootEnt = net.ReadEntity()
    local armorname = net.ReadString()
    local armor = net.ReadString()
    local armorent = lootEnt.fakeragdoll:GetNWEntity("ENT_"..armorname, "")
    armorent:Remove()
    lootEnt:SetNWBool(armorname, "")
    ply:SetNWBool(armorname, armor)
end)

net.Receive("ply_take_ammo",function(len,ply)
	local lootEnt = net.ReadEntity()
	if not IsValid(lootEnt) then return end
	local ammo = net.ReadFloat()
	local lootInfo = lootEnt.Info
	if not lootInfo.Ammo[ammo] then return end

	ply:GiveAmmo(lootInfo.Ammo[ammo],ammo)
	lootInfo.Ammo[ammo] = nil

	net.Start("inventory")
		net.WriteEntity(lootEnt)

		net.WriteTable(lootEnt.Info.Weapons)
		net.WriteTable(lootEnt.Info.Ammo)
	net.Send(ply)
end)