local PlayerMeta = FindMetaTable("Player")
local EntityMeta = FindMetaTable("Entity")
BleedingEntities = BleedingEntities or {}

RagdollDamageBoneMul={ -- Умножения урона при попадании по регдоллу
	[HITGROUP_LEFTLEG]=0.3,
	[HITGROUP_RIGHTLEG]=0.3,

	[HITGROUP_GENERIC]=0.7,

	[HITGROUP_LEFTARM]=0.4,
	[HITGROUP_RIGHTARM]=0.4,

	[HITGROUP_CHEST]=0.8,
	[HITGROUP_STOMACH]=0.7,

	[HITGROUP_HEAD]=5,
}

bonetohitgroup={ --Хитгруппы костей
    ["ValveBiped.Bip01_Head1"]=1,
    ["ValveBiped.Bip01_R_UpperArm"]=5,
    ["ValveBiped.Bip01_R_Forearm"]=5,
    ["ValveBiped.Bip01_R_Hand"]=5,
    ["ValveBiped.Bip01_L_UpperArm"]=4,
    ["ValveBiped.Bip01_L_Forearm"]=4,
    ["ValveBiped.Bip01_L_Hand"]=4,
    ["ValveBiped.Bip01_Pelvis"]=3,
    ["ValveBiped.Bip01_Spine2"]=2,
    ["ValveBiped.Bip01_L_Thigh"]=6,
    ["ValveBiped.Bip01_L_Calf"]=6,
    ["ValveBiped.Bip01_L_Foot"]=6,
    ["ValveBiped.Bip01_R_Thigh"]=7,
    ["ValveBiped.Bip01_R_Calf"]=7,
    ["ValveBiped.Bip01_R_Foot"]=7
}

function GetFakeWeapon(ply)
    ply.curweapon = ply.Info.ActiveWeapon
end

function SavePlyInfo(ply) -- Сохранение игрока перед его падением в фейк
    ply.Info = {}
    local info = ply.Info
    info.HasSuit = ply:IsSuitEquipped()
    info.SuitPower = ply:GetSuitPower()
    info.Ammo = ply:GetAmmo()
	info.ArteryHit = ply:GetNWBool("ArteryHit")
	info.NeckArteryHit = ply:GetNWBool("NeckArteryHit")
    info.ActiveWeapon = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() or nil
    info.ActiveWeapon2 = ply:GetActiveWeapon()
    
	GetFakeWeapon(ply)
    info.Weapons={}
    for i,wep in pairs(ply:GetWeapons())do
        info.Weapons[wep:GetClass()]={
            Clip1=wep:Clip1(),
            Clip2=wep:Clip2(),
			Base=wep.Base,
            AmmoType=wep:GetPrimaryAmmoType(),
			Sight=wep:GetNWBool("Sight"),
			Sight2=wep:GetNWBool("Sight2"),
			Sight3=wep:GetNWBool("Sight3"),
			Laser=wep:GetNWBool("Laser"),
			Suppressor=wep:GetNWBool("Suppressor"),
			Rail=wep:GetNWBool("Rail"),
			Romeo8T=wep:GetNWBool("Romeo8T"),
			Scope1=wep:GetNWBool("Scope1"),
			Resource=wep.Resource
        }
    end
    info.Weapons2={}
    for i,wep in ipairs(ply:GetWeapons())do
        info.Weapons2[i-1]=wep:GetClass()
    end
    info.AllAmmo={}
    local i
    for ammo, amt in pairs(ply:GetAmmo())do
		i = i or 0
        i = i + 1
        info.AllAmmo[ammo]={i,amt}
    end
    --PrintTable(info.AllAmmo)
    return info
end

function GiveAttachments(ply)
    local info = ply.Info
    if(!info)then return end
    for name, wepinfo in pairs(info.Weapons or {}) do
		if wepinfo.Base == "wep_cat_base" then
			ply.wep:SetNWBool("Sight", wepinfo.Sight)
			ply.wep:SetNWBool("Sight2", wepinfo.Sight2)
			ply.wep:SetNWBool("Sight3", wepinfo.Sight3)
			ply.wep:SetNWBool("Laser", wepinfo.Laser)
			ply.wep:SetNWBool("Suppressor", wepinfo.Suppressor)
			ply.wep:SetNWBool("Rail", wepinfo.Rail)
			ply.wep:SetNWBool("Romeo8T", wepinfo.Romeo8T)
			ply.wep:SetNWBool("Scope1", wepinfo.Scope1)
		end
    end
end

function GetFakeWeapon(ply)
	ply.curweapon = ply.Info.ActiveWeapon
end

function ClearFakeWeapon(ply)
	if ply.FakeShooting then DespawnWeapon(ply) end
end
util.AddNetworkString("ragplayercolor")
function EntityMeta:BetterSetPlayerColor(col)
	if not (col or self) then return end
	timer.Simple(
		.1,
		function()
			if not IsValid(self) then return end
			net.Start("ragplayercolor")
			net.WriteEntity(self)
			net.WriteVector(col)
			net.Broadcast()
		end
	)
end

function SavePlyInfoPreSpawn(ply) -- Сохранение игрока перед вставанием
	ply.Info = ply.Info or {}
	local info = ply.Info
	info.Hp = ply:Health()
	info.Armor = ply:Armor()
	return info
end

function ReturnPlyInfo(ply) -- возвращение информации игроку по его вставанию
    ClearFakeWeapon(ply)
	ply:SetSuppressPickupNotices(true)
    local info = ply.Info
    if(!info)then return end

    ply:StripWeapons()
    ply:StripAmmo()
	
	ply.slots = {}
    for name, wepinfo in pairs(info.Weapons or {}) do
        local weapon = ply:Give(name, true)

		if IsValid(weapon) then
			if wepinfo.Base == "wep_cat_base" then
				weapon:SetNWBool("Sight", wepinfo.Sight)
				weapon:SetNWBool("Sight2", wepinfo.Sight2)
				weapon:SetNWBool("Sight3", wepinfo.Sight3)
				weapon:SetNWBool("Laser", wepinfo.Laser)
				weapon:SetNWBool("Suppressor", wepinfo.Suppressor)
				weapon:SetNWBool("Rail", wepinfo.Rail)
				weapon:SetNWBool("Romeo8T", wepinfo.Romeo8T)
				weapon:SetNWBool("Scope1", wepinfo.Scope1)
			end

			weapon.Resource = wepinfo.Resource

			if wepinfo.Clip1~=nil and wepinfo.Clip2~=nil then
            	weapon:SetClip1(wepinfo.Clip1)
            	weapon:SetClip2(wepinfo.Clip2)
        	end

		end
    end
    for ammo, amt in pairs(info.Ammo or {}) do
        ply:GiveAmmo(amt,ammo)
    end
    if info.ActiveWeapon then
        ply:SelectWeapon(info.ActiveWeapon)
    end
    if info.HasSuit then
        ply:EquipSuit()
        ply:SetSuitPower(info.SuitPower or 0)
    else
        ply:RemoveSuit()
    end
    ply:SetHealth(info.Hp)
    ply:SetArmor(info.Armor)

end

function Faking(ply) -- функция падения
	if not ply:Alive() then return end
	if not ply.fake then
		if hook.Run("Fake",ply) ~= nil then return end
		SavePlyInfo(ply)
		ply.fake = true
		--ply.curweapon = ply:GetActiveWeapon():GetClass() or "" 
		ply:SetNWBool("fake",ply.fake)
		ply:SetSuppressPickupNotices(true)
		ply:DrawViewModel(false)
		if (SERVER) then
		ply:DrawWorldModel(false)
		ply:DrawViewModel(false)
		end
		local veh
		if ply:InVehicle() then
			veh = ply:GetVehicle()
			ply:ExitVehicle()
		end

		local rag = ply:CreateRagdoll()
		rag.eye = true
		if IsValid(veh) then
			rag:GetPhysicsObject():SetVelocity(veh:GetPhysicsObject():GetVelocity() * 5)
		end
		if IsValid(ply:GetNWEntity("Ragdoll")) then
			ply.fakeragdoll=ply:GetNWEntity("Ragdoll")
			ply.fake = true
			local wep = ply:GetActiveWeapon()

			if IsValid(wep) and table.HasValue(Guns,wep:GetClass())then
				SpawnWeapon(ply)
			end
			ply.walktime = CurTime()
			rag.temp = ply.temp
			rag:SetFlexWeight(9,2)
			rag.bull = ents.Create("npc_bullseye")
			rag:SetNWEntity("RagdollController",ply)
			local bull = rag.bull
			local bodyphy = rag:GetPhysicsObjectNum(10)
			bull:SetPos(bodyphy:GetPos()+bodyphy:GetAngles():Right()*7)
			bull:SetMoveType( MOVETYPE_OBSERVER )
			bull:SetParent(rag,rag:LookupAttachment("eyes"))
			bull:SetHealth(1000)
			bull:Spawn()
			bull:Activate()
			bull:SetNotSolid(true)
			FakeBullseyeTrigger(rag,ply)
			ply:HuySpectate(OBS_MODE_CHASE)
			ply:SpectateEntity(ply:GetNWEntity("Ragdoll"))
			ply:SetActiveWeapon(nil)
			ply:DropObject()

			timer.Create("faketimer"..ply:EntIndex(), 0.8, 1, function() end)

			if table.HasValue(Guns,ply.curweapon) then
				ply.FakeShooting=true
				ply:SetNWInt("FakeShooting",true)
			else
				ply.FakeShooting=false
				ply:SetNWInt("FakeShooting",false)
			end
		end
	else
		local rag = ply:GetNWEntity("Ragdoll")
		local pos = rag:GetPos()
		if ply.Otrub then
			ply:ChatPrint("You're unconscious")
		return false end
		if ply.Hit["spine"] then
			ply:ChatPrint("Your spine is broken")
		return false end
		if ply.Bones['LeftLeg']<1 and ply.Bones['RightLeg']<1 then
			ply:ChatPrint("Your both legs are broken")
		return false end
		local rag = ply:GetNWEntity("Ragdoll")
		if IsValid(rag) then
			if IsValid(rag.bull) then
				rag.bull:Remove()
			end
			ply.GotUp = CurTime()
			if hook.Run("Fake Up",ply,rag) ~= nil then return end

			ply.fake = false
			ply:SetNWBool("fake",ply.fake)

			ply.fakeragdoll=nil
			SavePlyInfoPreSpawn(ply)
			local pos=rag:GetPos()
			local vel=rag:GetVelocity()
			PLYSPAWN_OVERRIDE = true
			ply:SetNWBool("unfaked",PLYSPAWN_OVERRIDE)
			local eyepos=ply:EyeAngles()
			local health = ply:Health()
			ply:Spawn()
			ReturnPlyInfo(ply)
			ply:SetHealth(health)
			ply.FakeShooting=false
			ply:SetNWInt("FakeShooting",false)
			ply:SetVelocity(vel)
			ply:SetEyeAngles(eyepos)
			PLYSPAWN_OVERRIDE = nil
			ply:SetNWBool("unfaked",PLYSPAWN_OVERRIDE)

			local trace = {start = pos,endpos = pos - Vector(0,0,64),filter = {ply,rag}}
			local tracea = util.TraceLine(trace)
			if tracea.Hit then
				--ply:ChatPrint(tostring(tracea.Fraction).." 1")
				pos:Add(Vector(0,0,64) * (tracea.Fraction))
			end

			local trace = {start = pos,endpos = pos + Vector(0,0,64),filter = {ply,rag}}
			local tracea = util.TraceLine(trace)
			if tracea.Hit then
				--ply:ChatPrint(tostring(1 - tracea.Fraction).." 2")
				pos:Add(-Vector(0,0,64) * (1 - tracea.Fraction))
			end
			
			ply:SetPos(pos)

			ply:DrawViewModel(true)
			ply:DrawWorldModel(true)
			ply:SetModel(ply:GetNWEntity("Ragdoll"):GetModel())
			ply:GetNWEntity("Ragdoll").huychlen = true
			ply:GetNWEntity("Ragdoll"):Remove()
			ply:SetNWEntity("Ragdoll",nil)
		end
	end
end

hook.Add("CanExitVehicle","fakefastcar",function(veh,ply)
    --if veh:GetPhysicsObject():GetVelocity():Length() > 100 then Faking(ply) return false end
end)

function FakeBullseyeTrigger(rag,owner)
	if not IsValid(rag.bull) then return end
	for i,ent in pairs(ents.FindByClass("npc_*"))do
		if(ent:IsNPC() and ent:Disposition(owner)==D_HT)then
			ent:AddEntityRelationship(rag.bull,D_HT,0)
		end
	end
end

hook.Add("OnEntityCreated","hg-bullseye",function(ent)
	ent:SetShouldPlayPickupSound(false)
	if ent:IsNPC() then
		for i,rag in pairs(ents.FindByClass("prop_ragdoll"))do
			if IsValid(rag.bull) then
				ent:AddEntityRelationship(rag.bull,D_HT,0)
			end
		end
	end
end)

hook.Add("Player Think","FakedShoot",function(ply,time) --функция стрельбы лежа
	if IsValid(ply:GetNWEntity("Ragdoll")) and ply.FakeShooting and ply:Alive() then
		SpawnWeapon(ply)
	else
		if IsValid(ply.wep) then
			DespawnWeapon(ply)
		end
	end
end)


function RagdollOwner(rag) --функция, определяет хозяина регдолла
	if not IsValid(rag) then return end

	local ent = rag:GetNWEntity("RagdollController")
	return IsValid(ent) and ent
end

function PlayerMeta:DropWeapon1(wep)
    local ply = self
	wep = wep or ply:GetActiveWeapon()
    if !IsValid(wep) then return end

	if wep:GetClass() == "wep_jack_hmcd_hands" then return end
	ply:DropWeapon(wep)
	wep.Spawned = true
	ply:SelectWeapon("wep_jack_hmcd_hands")
end

util.AddNetworkString("pophead")

function PlayerMeta:PickupEnt()
local ply = self
local rag = ply:GetNWEntity("Ragdoll")
local phys = rag:GetPhysicsObjectNum(7)
local offset = phys:GetAngles():Right()*5
local traceinfo={
start=phys:GetPos(),
endpos=phys:GetPos()+offset,
filter=rag,
output=trace,
}
local trace = util.TraceLine(traceinfo)
if trace.Entity == Entity(0) or trace.Entity == NULL or !trace.Entity.canpickup then return end
if trace.Entity:GetClass()=="wep" then
    ply:Give(trace.Entity.curweapon,true):SetClip1(trace.Entity.Clip)
    --SavePlyInfo(ply)
    ply.wep.RoundsInMag=trace.Entity.Clip
    trace.Entity:Remove()
end
end


hook.Add("DoPlayerDeath","blad",function(ply,att,dmginfo)
	if IsValid(ply.wep) then
		ply.wep.OwnerAlive = false
		ply.wep = nil
	end
	SavePlyInfo(ply)
	local rag = ply:GetNWEntity("Ragdoll")
	
	if not IsValid(rag) then
		rag = ply:CreateRagdoll(att,dmginfo)
		ply:SetNWEntity("Ragdoll",rag)
	end
	rag=ply:GetNWEntity("Ragdoll")
	rag:GetPhysicsObject():SetMass(1)
	rag:SetNWEntity("RagdollController",nil)

	net.Start("pophead")
	net.WriteEntity(rag)
	net.Send(ply)
	if IsValid(rag.bull) then rag.bull:Remove() end
	rag:SetNWBool("Dead", true)

	if checkAllBleedOuts_bolshe(ply, 0) then
		rag.IsBleeding=true
		rag.bloodNext = CurTime()
		rag.Blood = ply.Blood
		table.insert(BleedingEntities,rag)
	end

	rag.Info = ply.Info
	rag:SetNWBool("Dead", true)
	rag.curweapon=ply.curweapon
	if(IsValid(rag.ZacConsLH))then
		rag.ZacConsLH:Remove()
		rag.ZacConsLH=nil
	end

	if(IsValid(rag.ZacConsRH))then
		rag.ZacConsRH:Remove()
		rag.ZacConsRH=nil
	end

	local ent = ply:GetNWEntity("Ragdoll")
	if IsValid(ent) then ent:SetNWEntity("RagdollOwner",Entity(-1)) end

	ply:SetDSP(0)
	ply.fakeragdoll = nil
	ply.fake = nil
	ply.FakeShooting = false
	PLYSPAWN_OVERRIDE = nil
	ply.FakeShooting=false
	ent.canaccept_dead = true
	ply:SetNWInt("FakeShooting",false)
	ent:SetFlexWeight(9, 10)
	if fs then
		ent.temp = ply.temp
		if ply.Otrub then
			ent.eye = false
		else
			ent.eye = true
		end
		timer.Create("temperature_1"..ent:EntIndex(),30,1,function()
			if IsValid(ent) then
				ent.temp = "Little Cold"
				timer.Create("temperature_2"..ent:EntIndex(),10,1,function()
					if IsValid(ent) then
						ent.temp = "Cold"
					end
				end)
			end
		end)

	end
	timer.Create("collision"..ent:EntIndex(),15,1,function()
		if IsValid(ent) and GAMEMODE.RoundName != "homicide" then rag:SetCollisionGroup(COLLISION_GROUP_WEAPON) end
	end)
	timer.Create("stopbleed"..ent:EntIndex(),30,1,function()
		if IsValid(ent) then ent.IsBleeding = false end
	end)
	timer.Create("delete"..ent:EntIndex(),120,1,function()
		if IsValid(ent) and GAMEMODE.RoundName != "homicide" then ent:Remove() end
	end)
end)

hook.Add("PostPlayerDeath","fuckyou",function(ply)

end)

hook.Add("PhysgunDrop", "DropPlayer", function(ply,ent)
	ent.isheld=false
end)

hook.Add("PlayerDisconnected","saveplyinfo",function(ply)
	--if ply:Alive() then
		--SavePlyInfo(ply)
		--ply:Kill()
	--end
end)

hook.Add("PhysgunPickup", "DropPlayer2", function(ply,ent)

	if ply:IsAdmin()  then

		if ent:IsPlayer() and !ent.fake then
			if hook.Run("Should Fake Physgun",ply,ent) ~= nil then return false end

			Faking(ent)
			return false
		end
	end
end)

util.AddNetworkString("fuckfake")
hook.Add("PlayerSpawn","resetfakebody",function(ply) --обнуление регдолла после вставания
	ply.fake = false
	ply:AddEFlags(EFL_NO_DAMAGE_FORCES)

	net.Start("fuckfake")
	net.Send(ply)

	ply:SetNWBool("fake",false)

	if PLYSPAWN_OVERRIDE then return end
	ply.FakeShooting = false

	ply:SetDuckSpeed(0.3)
	ply:SetUnDuckSpeed(0.3)
	
	ply.slots = {}
	if ply.UsersInventory ~= nil then
		for plys,bool in pairs(ply.UsersInventory) do
			ply.UsersInventory[plys] = nil
			send(plys,lootEnt,true)
		end
	end
	ply:SetNWEntity("Ragdoll",nil)
end)

local function hasWeapon(ply, weaponName)
    if not IsValid(ply) or not ply:IsPlayer() then return false end -- Проверяем, является ли объект игроком и существует ли он
    
    for _, weapon in pairs(ply:GetWeapons()) do -- Перебираем все оружия игрока
        if IsValid(weapon) and weapon:GetClass() == weaponName then -- Проверяем, является ли оружие действительным и совпадает ли его класс с заданным названием
            return true -- Если нашли оружие, возвращаем true
        end
    end
    
    return false 
end

zeroAng = Angle(0,0,0)
concommand.Add("fake",function(ply)
	if ply:GetNWString("Round","") == "dm" and ply:GetNWInt("DMTime", 10) >= 1 then return nil end
	if ply.Otrub then return nil end
	if ply.in_handcuff then return nil end
	if ply.Stunned then return nil end
	if timer.Exists("faketimer"..ply:EntIndex()) then return nil end
	if IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetNWEntity("Ragdoll"):GetVelocity():Length()>300 then return nil end
	if IsValid(ply:GetNWEntity("Ragdoll")) and table.Count(constraint.FindConstraints( ply:GetNWEntity("Ragdoll"), 'Rope' ))>0 then return nil end
	--if IsValid(ply:GetNWEntity("Ragdoll")) and table.Count(constraint.FindConstraints( ply:GetNWEntity("Ragdoll"), 'Weld' ))>0 then return nil end

	timer.Create("faketimer"..ply:EntIndex(), 0.2, 1, function() end)
	if ply:Alive() then
		Faking(ply)
		ply.fakeragdoll=ply:GetNWEntity("Ragdoll")
	end
end)

hook.Add("PreCleanupMap","cleannoobs",function() --все игроки встают после очистки карты
	for i, v in player.Iterator() do
		if v.fake then Faking(v) end
	end

	BleedingEntities = {}

end)

local function Remove(self,ply)
end

local CustomWeight = {
	["models/player/police_fem.mdl"] = 50,
	["models/player/police.mdl"] = 60,
	["models/player/combine_soldier.mdl"] = 70,
	["models/player/combine_super_soldier.mdl"] = 80,
	["models/player/combine_soldier_prisonguard.mdl"] = 70,
	["models/player/azov.mdl"] = 10,
	["models/player/Rusty/NatGuard/male_01.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_02.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_03.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_04.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_05.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_06.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_07.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_08.mdl"] = 90,
	["models/player/Rusty/NatGuard/male_09.mdl"] = 90,
	["models/LeymiRBA/Gyokami/Gyokami.mdl"] = 50,
	["models/player/smoky/Smoky.mdl"] = 65,
	["models/player/smoky/Smokycl.mdl"] = 65,
	["models/knyaje pack/dibil/sso_politepeople.mdl"] = 40
}

for i = 1,6 do
	CustomWeight["models/monolithservers/mpd/female_0"..i..".mdl"] = 20
end

for i = 1,6 do
	CustomWeight["models/monolithservers/mpd/female_0"..i.."_2.mdl"] = 20
end

for i = 1,6 do
	CustomWeight["models/monolithservers/mpd/male_0"..i..".mdl"] = 20
end

for i = 1,6 do
	CustomWeight["models/monolithservers/mpd/male_0"..i.."_2.mdl"] = 20
end

local hitgroup_angle = {
	[HITGROUP_LEFTLEG] = 2000,
	[HITGROUP_RIGHTLEG] = 2000,
	[HITGROUP_STOMACH] = 3500,
	[HITGROUP_CHEST] = 3500,
	[HITGROUP_LEFTARM] = 6000,
	[HITGROUP_RIGHTARM] = 6000,
	[HITGROUP_HEAD] = 8000,
}

function PlayerMeta:CreateRagdoll(attacker,dmginfo) --изменение функции регдолла
	--if not self:Alive() then return end
	local ragd=self:GetNWEntity("Ragdoll")
	ragd.ExplProof = true
	--debug.Trace()
	if IsValid(ragd) then
		if(IsValid(ragd.ZacConsLH))then
			ragd.ZacConsLH:Remove()
			ragd.ZacConsLH=nil
		end
		if(IsValid(ragd.ZacConsRH))then
			ragd.ZacConsRH:Remove()
			ragd.ZacConsRH=nil
		end
		return
	end

	local Data = duplicator.CopyEntTable( self )
	local rag = ents.Create( "prop_ragdoll" )
	duplicator.DoGeneric( rag, Data )
	rag:SetModel(self:GetModel())
	rag:SetNWVector("plycolor",self:GetPlayerColor())
	rag:SetSkin(self:GetSkin())
	rag:BetterSetPlayerColor(self:GetPlayerColor())
	rag:Spawn()
	rag:SetCollisionGroup(COLLISION_GROUP_NONE)
	rag:CallOnRemove("huyhjuy",function() self.firstrag = false end)
	rag:CallOnRemove("huy2ss",function()
		if not rag.huychlen and RagdollOwner(rag) then
			rag.huychlen = false
			RagdollOwner(rag):KillSilent()
		end
	end)
	if self:GetNWString("Bodyvest", "") == "Level IIIA" or self:GetNWString("Bodyvest", "") == "Level III" then

		--local ent = ents.Create((self:GetNWString("Bodyvest", "") == "Level IIIA" and "ent_jack_hmcd_softarmor") or "ent_jack_hmcd_hardarmor")
		local ent = ents.Create("prop_physics")
		local Pos,Ang = rag:GetBonePosition(rag:LookupBone("ValveBiped.Bip01_Spine4"))
		local Right,Forward,Up = Ang:Right(),Ang:Forward(),Ang:Up()
		if self.ModelSex == "male" then
			Pos = Pos + Right * -15 + Forward * -55 + Up * 0
		else
			Pos = Pos + Right * -8 + Forward * -58 + Up * 0
		end

		ent.IsArmor = true
		rag.Bodyvest = ent
		rag:SetNWEntity("ENT_Bodyvest", ent)
		ent:SetPos(Pos)
		ent:SetAngles(Angle(0,0,0))
		ent:SetModel("models/sal/acc/armor01.mdl")

		if self:GetNWString("Bodyvest","") == "Level III" then
			ent:SetColor(Color(5,0,5))
		else
			ent:SetColor(Color(255,255,255))
		end

		ent:Spawn()
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)

		if IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():SetMaterial("plastic")
			ent:GetPhysicsObject():SetMass(4)
		end

		constraint.Weld(ent,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone("ValveBiped.Bip01_Spine4")),0,true,false)

		rag:DeleteOnRemove(ent)
		ent:CallOnRemove("BodyvestNo",function()
			if IsValid(rag) then
				rag.Bodyvest = nil
			end
		end)
	end
	if self:GetNWBool("Headcrab", false) == true then

		--local ent = ents.Create((self:GetNWString("Bodyvest", "") == "Level IIIA" and "ent_jack_hmcd_softarmor") or "ent_jack_hmcd_hardarmor")
		local ent = ents.Create("prop_physics")
		local Pos,Ang = rag:GetBonePosition(rag:LookupBone("ValveBiped.Bip01_Head1"))
		local Right,Forward,Up = Ang:Right(),Ang:Forward(),Ang:Up()
		if self.ModelSex == "male" then
			Pos = Pos + Right * 4 + Forward * -5 + Up * 0
		else
			Pos = Pos + Right * 4 + Forward * -5 + Up * 0
		end

		ent.IsArmor = false
		rag.HeadcrabEnt = ent
		rag:SetNWEntity("ENT_Helmet", ent)
		ent:SetPos(Pos)
		ent:SetAngles(Angle(0,0,0))
		ent:SetModel("models/headcrabclassic.mdl")
		timer.Create("HeadcrabVelocity"..rag:EntIndex(), 2, 0, function()
			if IsValid(rag) and IsValid(rag.HeadcrabEnt) then
				rag.HeadcrabEnt:GetPhysicsObject():SetVelocity(rag:GetBonePosition(rag:LookupBone("ValveBiped.Bip01_Head1"))*math.random(1, 6))
				if rag:GetNWBool("Dead", false) == true then
					rag.HeadcrabEnt:GetPhysicsObject():SetVelocity(rag:GetBonePosition(rag:LookupBone("ValveBiped.Bip01_Head1"))*25)
					local headcrab = ents.Create("npc_headcrab")
					headcrab:SetPos(rag.HeadcrabEnt:GetPos()+Vector(0,0,15))
					headcrab:SetAngles(rag.HeadcrabEnt:GetAngles())
					headcrab:Activate()
					headcrab:Spawn()
					rag.HeadcrabEnt:Remove()
				end
			end
		end)
		ent:SetColor(Color(255,255,255))

		ent:Spawn()
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)

		if IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():SetMaterial("plastic")
			ent:GetPhysicsObject():SetMass(0)
		end

		local pizdahelmet = constraint.Weld(ent,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone("ValveBiped.Bip01_Head1")),0,true,false)
		rag:DeleteOnRemove(ent)
		ent:CallOnRemove("HelmetNo",function()
			if IsValid(rag) then
				rag.Helmet = nil
			end
		end)
	end
	if self:GetNWString("Helmet", "") == "ACH" then

		--local ent = ents.Create((self:GetNWString("Bodyvest", "") == "Level IIIA" and "ent_jack_hmcd_softarmor") or "ent_jack_hmcd_hardarmor")
		local ent = ents.Create("prop_physics")
		local Pos,Ang = rag:GetBonePosition(rag:LookupBone("ValveBiped.Bip01_Head1"))
		local Right,Forward,Up = Ang:Right(),Ang:Forward(),Ang:Up()
		if self.ModelSex == "male" then
			Pos = Pos + Right * 2 + Forward * 0 + Up * 0
		else
			Pos = Pos + Right * 2 + Forward * 0 + Up * 0
		end

		ent.IsArmor = true
		rag.Helmet = ent
		rag:SetNWEntity("ENT_Helmet", ent)
		ent:SetPos(Pos)
		ent:SetAngles(Angle(0,0,0))
		ent:SetModel("models/barney_helmet.mdl")
		ent:SetMaterial("models/mat_jack_hmcd_armor")

		ent:SetColor(Color(255,255,255))

		ent:Spawn()
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)

		if IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():SetMaterial("plastic")
			ent:GetPhysicsObject():SetMass(0)
		end

		local pizdahelmet = constraint.Weld(ent,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone("ValveBiped.Bip01_Head1")),0,true,false)
		rag.helmetweld = pizdahelmet
		rag:DeleteOnRemove(ent)
		ent:CallOnRemove("HelmetNo",function()
			if IsValid(rag) then
				rag.Helmet = nil
			end
		end)
	end
	if self:GetNWString("Mask", "") == "NVG" then

		--local ent = ents.Create((self:GetNWString("Bodyvest", "") == "Level IIIA" and "ent_jack_hmcd_softarmor") or "ent_jack_hmcd_hardarmor")
		local ent = ents.Create("prop_physics")
		local Pos,Ang = rag:GetBonePosition(rag:LookupBone("ValveBiped.Bip01_Head1"))
		local Right,Forward,Up = Ang:Right(),Ang:Forward(),Ang:Up()
		Pos = Pos + Right * 2 + Forward * 0 + Up * 0

		ent.IsArmor = true
		rag.Mask = ent
		rag:SetNWEntity("ENT_Mask", ent)
		ent:SetPos(Pos)
		ent:SetAngles(Angle(0,0,0))
		ent:SetModel("models/arctic_nvgs/nvg_gpnvg.mdl")

		ent:SetColor(Color(255,255,255))

		ent:Spawn()
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)

		if IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():SetMaterial("plastic")
			ent:GetPhysicsObject():SetMass(0)
		end

		constraint.Weld(ent,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone("ValveBiped.Bip01_Head1")),0,true,false)

		rag:DeleteOnRemove(ent)
		ent:CallOnRemove("MaskNo",function()
			if IsValid(rag) then
				rag.Mask = nil
			end
		end)
	end
	rag:AddEFlags(EFL_NO_DAMAGE_FORCES)
	if IsValid(rag:GetPhysicsObject()) then
		rag:GetPhysicsObject():SetMass(CustomWeight[rag:GetModel()] or 15)
	end
	rag:SetNWString("Mask",self:GetNWString("Mask"))
	rag:SetNWString("Bodyvest",self:GetNWString("Bodyvest"))
	rag:SetNWString("Helmet",self:GetNWString("Bodyvest"))
	rag:Activate()
	rag:SetNWEntity("RagdollOwner", self)
	local vel = self:GetVelocity()/1
	for i = 0, rag:GetPhysicsObjectCount() - 1 do
		local physobj = rag:GetPhysicsObjectNum( i )
		local ragbonename = rag:GetBoneName(rag:TranslatePhysBoneToBone(i))
		local bone = self:LookupBone(ragbonename)
		if(bone)then
			local bonemat = self:GetBoneMatrix(bone)
			if(bonemat)then
				local bonepos = bonemat:GetTranslation()
				local boneang = bonemat:GetAngles()
				physobj:SetPos( bonepos,true )
				physobj:SetAngles( boneang )
				if !self:Alive() then vel=vel end
				physobj:AddVelocity( vel )
			end
		end
	end

	rag:SetNWString("Character_Name", self:GetNWString("Character_Name"))

	if IsValid(self.wep) then
		self.wep.rag = rag
	end

	self.fakeragdoll = rag
	self:SetNWEntity("Ragdoll", rag )
	if self.lasthitgroup and IsValid(rag:GetPhysicsObject()) then
		rag:GetPhysicsObject():SetVelocity(-self:GetAimVector()*math.random(400, 700))
		rag:GetPhysicsObject():AddAngleVelocity(Vector(0, 0, hitgroup_angle[self.lasthitgroup]))
	end
	if not self:Alive() then
		net.Start("pophead")
		net.WriteEntity(rag)
		net.Send(self)
        rag.Info=self.Info
        if IsValid(self:GetActiveWeapon()) then
            self.curweapon = nil
            if table.HasValue(Guns,self:GetActiveWeapon():GetClass()) then
				self.curweapon = self:GetActiveWeapon():GetClass()
				SpawnWeapon(self,self:GetActiveWeapon():Clip1())
				rag.curweapon = self:GetActiveWeapon():GetClass()
			end
        end
        rag.Info=self.Info
        rag.curweapon=self.curweapon
        rag:SetFlexWeight(9,0)
		if checkAllBleedOuts_bolshe(self, 0) then
			rag.IsBleeding=true
			rag.bloodNext = CurTime()
			rag.Blood = self.Blood
			table.insert(BleedingEntities,rag)
		end
		if IsValid(rag.bull) then
			rag.bull:Remove()
		end
        rag:SetNWBool("Dead", true)
		self.fakeragdoll = nil
		--if not self:GetActiveWeapon():IsValid() then return rag end
		net.Start("ebal_chellele")
		net.WriteEntity(rag)
		net.WriteEntity(rag.curweapon)
		net.Broadcast()
    else
		if not self:GetActiveWeapon():IsValid() then return rag end
		net.Start("ebal_chellele")
		net.WriteEntity(self)
		net.WriteString(self:GetActiveWeapon():GetClass())
		net.Broadcast()
	end
	return rag
end

hook.Add("OnPlayerHitGround","GovnoJopa",function(ply,a,b,speed)
	if speed > 200 then
		if hook.Run("Should Fake Ground",ply) ~= nil then return end

		local tr = {}
		tr.start = ply:GetPos()
		tr.endpos = ply:GetPos() - Vector(0,0,10)
		tr.mins = ply:OBBMins()
		tr.maxs = ply:OBBMaxs()
		tr.filter = ply
		local traceResult = util.TraceHull(tr)
		if traceResult.Entity:IsPlayer() and not traceResult.Entity.fake then
			Faking(traceResult.Entity)
		end
	end
end)

local CurTime = CurTime
hook.Add("StartCommand","asdfgghh",function(ply,cmd)
	local rag = ply:GetNWEntity("Ragdoll")
	if (ply.GotUp or 0) - CurTime() > -0.1 and not IsValid(rag) then cmd:AddKey(IN_DUCK) end
	if IsValid(rag) then cmd:RemoveKey(IN_DUCK) end
end)

hook.Add( "KeyPress", "Shooting", function( ply, key )
	if !ply:Alive() or ply.Otrub or !ply.fake then return end
	if ply.FakeShooting and !weapons.Get(ply.curweapon).Primary.Automatic then
		if( key == IN_ATTACK )then
		end
	end

	if(key == IN_RELOAD)then
		Reload(ply.wep)
	end
end )

local dvec = Vector(0,0,-64)

hook.Add("Player Think","FakeControl",function(ply,time) --управление в фейке
	if not ply:Alive() then return end
	local rag = ply:GetNWEntity("Ragdoll")

	if not IsValid(rag) or not ply:Alive() then return end
	local bone = rag:LookupBone("ValveBiped.Bip01_Head1")
	if not bone then return end
	if IsValid(ply.bull) then
		ply.bull:SetPos(rag:GetPos())
	end
	local head1 = rag:GetBonePosition(bone) + dvec
	ply:SetPos(head1)
	ply:SetNWBool("fake",ply.fake)
	local deltatime = CurTime()-(rag.ZacLastCallTime or CurTime())
	rag.ZacLastCallTime=CurTime()
	local eyeangs = ply:EyeAngles()
	local head = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Head1" )) )
	local pelvis = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Pelvis" )) )
	local dist = (rag:GetAttachment(rag:LookupAttachment( "eyes" )).Ang:Forward()):Distance(ply:GetAimVector()*10000)
	local distmod = math.Clamp(1-(dist/20000),0.1,1)
	local lookat = LerpVector(distmod,rag:GetAttachment(rag:LookupAttachment( "eyes" )).Ang:Forward()*100000,ply:GetAimVector()*100000)
	local attachment = rag:GetAttachment( rag:LookupAttachment( "eyes" ) )
	local LocalPos, LocalAng = WorldToLocal( lookat, Angle( 0, 60, 0 ), attachment.Pos, attachment.Ang )
	if !ply.Otrub then rag:SetEyeTarget( LocalPos ) else rag:SetEyeTarget( Vector(0,0,0) ) end
	if ply:Alive() then
		--RagdollOwner(rag):SetMoveParent( rag )
		--RagdollOwner(rag):SetParent( rag )
	if !ply.Otrub and !ply.Hit["highspine"] then
		if ply:KeyDown( IN_JUMP ) and (table.Count(constraint.FindConstraints( ply:GetNWEntity("Ragdoll"), 'Rope' ))>0 or ((rag.IsWeld or 0) > 0)) and ply.stamina['leg']>20 and (ply.lastuntietry or 0) < CurTime() then
			ply.lastuntietry = CurTime() + 2
			
			rag.IsWeld = math.max((rag.IsWeld or 0) - 0.1,0)

			local RopeCount = table.Count(constraint.FindConstraints( ply:GetNWEntity("Ragdoll"), 'Rope' ))
			Ropes = constraint.FindConstraints( ply:GetNWEntity("Ragdoll"), 'Rope' )
			Try = math.random(1,10*RopeCount)
			ply.stamina['leg']=ply.stamina['leg'] - 5
			local phys = rag:GetPhysicsObjectNum( 1 )
			local speed = 200
			local shadowparams = {
				secondstoarrive=0.5,
				pos=phys:GetPos()+phys:GetAngles():Forward()*20,
				angle=phys:GetAngles(),
				maxangulardamp=30,
				maxspeeddamp=30,
				maxangular=90,
				maxspeed=speed,
				teleportdistance=0,
				deltatime=0.01,
			}
			phys:Wake()
			phys:ComputeShadowControl(shadowparams)
			if Try > (7*RopeCount) or ((rag.IsWeld or 0) > 0) then
				if RopeCount>1 or (rag.IsWeld or 0 > 0) then
					if RopeCount > 1 then
						ply:ChatPrint("Осталось: "..RopeCount - 1)
					end
					if (rag.IsWeld or 0) > 0 then
						ply:ChatPrint("Осталось отбить гвоздей: "..tostring(math.ceil(rag.IsWeld)))
						ply.BleedOuts["right_leg"] = ply.BleedOuts["right_leg"] + 10
						ply.pain_add = ply.pain_add + 10
					end
				else
					ply:ChatPrint("Ты развязался")
				end
				
				if Ropes and Ropes[1] and Ropes[1].Constraint then
    				Ropes[1].Constraint:Remove()
				end
				rag:EmitSound("snd_jack_hmcd_ducttape.wav",90,50,0.5,CHAN_AUTO)
			end
		end
		if(ply:KeyDown(IN_ATTACK))then
            if !ply.FakeShooting then
				local phys = rag:GetPhysicsObjectNum( 5 )	
				local ang=ply:EyeAngles()
				ang:RotateAroundAxis(eyeangs:Forward(),90)
				local shadowparams = {
					secondstoarrive=0.5,
					pos=head:GetPos()+eyeangs:Forward()*(180/math.Clamp(rag:GetVelocity():Length()/300,1,6)),
					angle=ang,
					maxangular=370,
					maxangulardamp=100,
					maxspeeddamp=10,
					maxspeed=110,
					teleportdistance=0,
					deltatime=deltatime,
					}
				phys:Wake()
				phys:ComputeShadowControl(shadowparams)
			end
		end

		if ply.FakeShooting and weapons.Get(ply.curweapon).Primary.Automatic then
			if(ply:KeyDown(IN_ATTACK))then--KeyDown if an automatic gun
			end
		end
		
		if(ply:KeyDown(IN_ATTACK2))then
			local physa = rag:GetPhysicsObjectNum( 7 )
			local phys = rag:GetPhysicsObjectNum( 5 ) --rhand
			local ang=ply:EyeAngles() --LerpAngle(0.5,ply:EyeAngles(),ply:GetNWEntity("DeathRagdoll"):GetAttachment(1).Ang)

			if ply.FakeShooting then
				ang:RotateAroundAxis(eyeangs:Forward(),180)
			else
				ang:RotateAroundAxis(eyeangs:Forward(),90)
			end


			local shadowparams = {
				secondstoarrive=0.5,
				pos=head:GetPos()+eyeangs:Forward()*(180/math.Clamp(rag:GetVelocity():Length()/150,1,6)),
				angle=ang,
				maxangular=370,
				maxangulardamp=100,
				maxspeeddamp=10,
				maxspeed=110,
				teleportdistance=0,
				deltatime=deltatime,
			}
			physa:Wake()
			if (!ply.suiciding or TwoHandedOrNo[ply.curweapon]) then
				if TwoHandedOrNo[ply.curweapon] and IsValid(ply.wep) then
					shadowparams.angle:RotateAroundAxis(eyeangs:Up(),45)
					shadowparams.pos=shadowparams.pos+eyeangs:Right()*50
					shadowparams.pos=shadowparams.pos+eyeangs:Up()*40
					shadowparams.angle:RotateAroundAxis(eyeangs:Forward(),-90)
					ply.wep:GetPhysicsObject():ComputeShadowControl(shadowparams)
					--shadowparams.maxspeed=20
					phys:ComputeShadowControl(shadowparams) --if 2handed
					shadowparams.pos=head:GetPos()
					shadowparams.angle=ang
					ply.wep:GetPhysicsObject():ComputeShadowControl(shadowparams)
				else
					physa:ComputeShadowControl(shadowparams)
				end
			else
				if ply.FakeShooting and IsValid(ply.wep) then
					print("Pizda")
					shadowparams.maxspeed=500
					shadowparams.maxangular=500
					shadowparams.pos=head:GetPos()-ply.wep:GetAngles():Forward()*12
					shadowparams.angle=ply.wep:GetPhysicsObject():GetAngles()
					ply.wep:GetPhysicsObject():ComputeShadowControl(shadowparams)
					physa:ComputeShadowControl(shadowparams)
				end
			end
			--[[physa:ComputeShadowControl(shadowparams)
			if TwoHandedOrNo[ply.curweapon] then
				shadowparams.maxspeed=90
				ply.wep:GetPhysicsObject():ComputeShadowControl(shadowparams)
				shadowparams.maxspeed=20
				shadowparams.angle:RotateAroundAxis(eyeangs:Forward(),90)
				phys:ComputeShadowControl(shadowparams) --if 2handed
			end--]]
		end
		if ply:KeyDown( IN_JUMP ) and !rag.jumpdelay then
			rag.jumpdelay = true
			timer.Simple(1.3, function()
				rag.jumpdelay = false
			end)
			local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Pelvis" )) )
			local angs = ply:EyeAngles()
			local shadowparams = {
				secondstoarrive=0.01,
				pos=head:GetPos(),
				angle=head:GetAngles():Forward(),
				maxangulardamp=100,
				maxspeeddamp=100,
				maxangular=370,
				maxspeed=400,
				teleportdistance=0,
				deltatime=deltatime,
			}
			phys:Wake()
			phys:ComputeShadowControl(shadowparams)
		end

		if(ply:KeyDown(IN_USE))then
			local phys = head
			local angs = ply:EyeAngles()
			angs:RotateAroundAxis(angs:Forward(),90)
			angs:RotateAroundAxis(angs:Up(),90)
			local shadowparams = {
				secondstoarrive=0.2,
				pos=head:GetPos()+vector_up*(20/math.Clamp(rag:GetVelocity():Length()/300,1,12)),
				angle=angs,
				maxangulardamp=10,
				maxspeeddamp=10,
				maxangular=370,
				maxspeed=40,
				teleportdistance=0,
				deltatime=deltatime,
			}
			head:Wake()
			head:ComputeShadowControl(shadowparams)
		end

		end
		if (ply:KeyDown(IN_SPEED)) and !RagdollOwner(rag).Otrub then
			local bone = rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" ))
			local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )) )
			if(!IsValid(rag.ZacConsLH) and (!rag.ZacNextGrLH || rag.ZacNextGrLH<=CurTime()))then
				rag.ZacNextGrLH=CurTime()+0.1
				for i=1,3 do
					local offset = phys:GetAngles():Up()*5
					if(i==2)then
						offset = phys:GetAngles():Right()*5
					end
					if(i==3)then
						offset = phys:GetAngles():Right()*-5
					end
					local traceinfo={
						start=phys:GetPos(),
						endpos=phys:GetPos()+offset,
						filter=rag,
						output=trace,
					}
					local trace = util.TraceLine(traceinfo)
					if(trace.Hit and !trace.HitSky)then
						local cons = constraint.Weld(rag,trace.Entity,bone,trace.PhysicsBone,0,false,false)
						if(IsValid(cons))then
							rag.ZacConsLH=cons
						end
						break
					end
				end
			end
		else
			if(IsValid(rag.ZacConsLH))then
				rag.ZacConsLH:Remove()
				rag.ZacConsLH=nil
			end
		end
		if(ply:KeyDown(IN_WALK) and !ply.RightArmbroke) and !RagdollOwner(rag).Otrub then
			local bone = rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))
			local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )) )
			if(!IsValid(rag.ZacConsRH) and (!rag.ZacNextGrRH || rag.ZacNextGrRH<=CurTime()))then
				rag.ZacNextGrRH=CurTime()+0.1
				for i=1,3 do
					local offset = phys:GetAngles():Up()*5
					if(i==2)then
						offset = phys:GetAngles():Right()*5
					end
					if(i==3)then
						offset = phys:GetAngles():Right()*-5
					end
					local traceinfo={
						start=phys:GetPos(),
						endpos=phys:GetPos()+offset,
						filter=rag,
						output=trace,
					}
					local trace = util.TraceLine(traceinfo)
					if(trace.Hit and !trace.HitSky)then
						local cons = constraint.Weld(rag,trace.Entity,bone,trace.PhysicsBone,0,false,false)
						if(IsValid(cons))then
							rag.ZacConsRH=cons
						end
						break
					end
				end
			end
		else
			if(IsValid(rag.ZacConsRH))then
				rag.ZacConsRH:Remove()
				rag.ZacConsRH=nil
			end
		end
		if(ply:KeyDown(IN_FORWARD) and IsValid(rag.ZacConsLH))then
			local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Spine" )) )
			local lh = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )) )
			local angs = ply:EyeAngles()
			angs:RotateAroundAxis(angs:Forward(),90)
			angs:RotateAroundAxis(angs:Up(),90)
			local speed = 35
			
			if(rag.ZacConsLH.Ent2:GetVelocity():LengthSqr()<1000) then
				local shadowparams = {
					secondstoarrive=1.1,
					pos=lh:GetPos(),
					angle=phys:GetAngles(),
					maxangulardamp=10,
					maxspeeddamp=10,
					maxangular=50,
					maxspeed=speed,
					teleportdistance=0,
					deltatime=deltatime,
				}
				phys:Wake()
				phys:ComputeShadowControl(shadowparams)
			end
		end
		if(ply:KeyDown(IN_FORWARD) and IsValid(rag.ZacConsRH))then
			local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Spine" )) )
			local rh = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )) )
			local angs = ply:EyeAngles()
			angs:RotateAroundAxis(angs:Forward(),90)
			angs:RotateAroundAxis(angs:Up(),90)
			local speed = 35
			
			if(rag.ZacConsRH.Ent2:GetVelocity():LengthSqr()<1000)then
				local shadowparams = {
					secondstoarrive=1.1,
					pos=rh:GetPos(),
					angle=phys:GetAngles(),
					maxangulardamp=10,
					maxspeeddamp=10,
					maxangular=50,
					maxspeed=speed,
					teleportdistance=0,
					deltatime=deltatime,
				}
				phys:Wake()
				phys:ComputeShadowControl(shadowparams)
				--[[
				shadowparams.pos=phys:GetPos()+ply:EyeAngles():Right()*300
				rag:GetPhysicsObjectNum( 9 ):Wake()
				rag:GetPhysicsObjectNum( 9 ):ComputeShadowControl(shadowparams)				-переделывай говно
				shadowparams.pos=phys:GetPos()-ply:EyeAngles():Forward()*300
				rag:GetPhysicsObjectNum( 11 ):Wake()
				rag:GetPhysicsObjectNum( 11 ):ComputeShadowControl(shadowparams)
				shadowparams.pos=rh:GetPos()
				--]]
				--[[local angre2=ply:EyeAngles()
				angre2:RotateAroundAxis(ply:EyeAngles():Forward(),90)
				shadowparams.angle=angre2
				shadowparams.maxangular=100
				shadowparams.pos=rag:GetPhysicsObjectNum( 1 ):GetPos()
				shadowparams.secondstoarrive=1
				rag:GetPhysicsObjectNum( 0 ):Wake()
				rag:GetPhysicsObjectNum( 0 ):ComputeShadowControl(shadowparams)]]--
			end
		end
		if(ply:KeyDown(IN_BACK) and IsValid(rag.ZacConsLH))then
			local phys = rag:GetPhysicsObjectNum( 1 )
			local chst = rag:GetPhysicsObjectNum( 0 )
			local angs = ply:EyeAngles()
			angs:RotateAroundAxis(angs:Forward(),90)
			angs:RotateAroundAxis(angs:Up(),90)
			local speed = 34
			
			if(rag.ZacConsLH.Ent2:GetVelocity():LengthSqr()<1000)then
				local shadowparams = {
					secondstoarrive=0.3,
					pos=chst:GetPos(),
					angle=phys:GetAngles(),
					maxangulardamp=10,
					maxspeeddamp=10,
					maxangular=50,
					maxspeed=speed,
					teleportdistance=0,
					deltatime=deltatime,
				}
				phys:Wake()
				phys:ComputeShadowControl(shadowparams)
			end
		end
		if(ply:KeyDown(IN_BACK) and IsValid(rag.ZacConsRH))then
			local phys = rag:GetPhysicsObjectNum( 1 )
			local chst = rag:GetPhysicsObjectNum( 0 )
			local angs = ply:EyeAngles()
			angs:RotateAroundAxis(angs:Forward(),90)
			angs:RotateAroundAxis(angs:Up(),90)
			local speed = 34
			
			if(rag.ZacConsRH.Ent2:GetVelocity():LengthSqr()<1000)then
				local shadowparams = {
					secondstoarrive=0.3,
					pos=chst:GetPos(),
					angle=phys:GetAngles(),
					maxangulardamp=10,
					maxspeeddamp=10,
					maxangular=50,
					maxspeed=speed,
					teleportdistance=0,
					deltatime=deltatime,
				}
				phys:Wake()
				phys:ComputeShadowControl(shadowparams)
			end
		end
	end
end)

hook.Add("Player Think","VelocityPlayerFallOnPlayerCheck",function(ply,time)
	local speed = ply:GetVelocity():Length()
	if ply:GetMoveType() != MOVETYPE_NOCLIP and not ply.fake and not ply:HasGodMode() and ply:Alive() then
		if speed < 550 or (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "wep_jack_hmcd_fastzombhands") then return end
		if hook.Run("Should Fake Velocity",ply,speed) ~= nil then return end

		Faking(ply)
	end
end)

util.AddNetworkString("ebal_chellele")
hook.Add("PlayerSwitchWeapon","wep",function(ply,oldwep,newwep)
	if GAMEMODE.NoGun then return true end
	if ply.in_handcuff then return true end
	if ply.Otrub then return true end

	if ply.fake then
		if IsValid(ply.Info.ActiveWeapon2) and IsValid(ply.wep) and ply.wep.RoundsInMag~=nil and ply.wep.Amt~=nil and ply.wep.AmmoType~=nil then
			ply.Info.ActiveWeapon2:SetClip1((ply.wep.RoundsInMag or 0))
			ply:SetAmmo((ply.wep.Amt or 0), (ply.wep.AmmoType or 0))
		end

		if table.HasValue(Guns,newwep:GetClass()) then
			if IsValid(ply.wep) then DespawnWeapon(ply) end
			ply:SetActiveWeapon(newwep)
			ply.Info.ActiveWeapon=newwep
			ply.curweapon=newwep:GetClass()
			SavePlyInfo(ply)
			ply:SetActiveWeapon(nil)
			SpawnWeapon(ply)
			ply.FakeShooting=true
		else
			if IsValid(ply.wep) then DespawnWeapon(ply) end
			ply:SetActiveWeapon(nil)
			ply.curweapon=nil
			ply.FakeShooting=false
		end
		net.Start("ebal_chellele")
		net.WriteEntity(ply)
		net.WriteString(ply.curweapon or "")
		net.Broadcast()
		return true
	end
end)

function PlayerMeta:HuySpectate()
	local ply = self
	ply:Spectate(OBS_MODE_CHASE)
	ply:UnSpectate()

	ply:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	ply:SetMoveType(MOVETYPE_OBSERVER)
end

concommand.Add("checha_getotrub",function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
	print(huyply.Otrub)
end)

concommand.Add("checha_setarmor",function(ply,cmd,args)
	local huyply = args[1] and player.GetListByName(args[1])[1] or ply
	huyply:SetNWString(args[2], args[3])
end)

hook.Add("PlayerSay","dropweaponhuy",function(ply,text)
end)

hook.Add("UpdateAnimation","huy",function(ply,event,data)
	ply:RemoveGesture(ACT_GMOD_NOCLIP_LAYER)
end)

hook.Add("Player Think","holdentity",function(ply,time)
	--[[if IsValid(ply.holdEntity) then

	end--]]
end)