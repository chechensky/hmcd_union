AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
util.AddNetworkString("lutiiikol")

local plymanag = player_manager

function GM:PlayerSpawn(ply)
	if PLYSPAWN_OVERRIDE then return end

    ply:RemoveFlags(FL_ONGROUND)
    ply:SetMaterial("")

	ply:SetCanZoom(false)

	if not ply:Alive() then return end
	ply:UnSpectate()
	ply:SetupHands()

	ply:SetHealth(150)
	ply:SetMaxHealth(150)
	ply:SetSlowWalkSpeed(75)
	ply:SetLadderClimbSpeed(75)

	plymanag.SetPlayerClass(ply,"player_default")

	local phys = ply:GetPhysicsObject()
	if phys:IsValid() then phys:SetMass(15) end
end

function GM:PlayerConnect(name, ip)
	timer.Simple(.1, function()
		for key, found in player.Iterator() do
			if found:Nick() == name then
				umsg.Start("Skin_Appearance", found)
				umsg.End()
			end
		end
	end)
end

function GM:PlayerInitialSpawn(ply)
	if not (ply and IsValid(ply)) then return end
	timer.Simple(.1, function()
		if ply and IsValid(ply) then
			umsg.Start("Skin_Appearance", ply)
			umsg.End()
		end
	end)
end

local male_moans = {
	"vo/npc/male01/moan01.wav",
	"vo/npc/male01/moan02.wav",
	"vo/npc/male01/moan03.wav",
	"vo/npc/male01/moan04.wav",
	"vo/npc/male01/moan05.wav"
}

local female_moans = {
	"vo/npc/female01/moan01.wav",
	"vo/npc/female01/moan02.wav",
	"vo/npc/female01/moan03.wav",
	"vo/npc/female01/moan04.wav",
	"vo/npc/female01/moan05.wav"
}

function ValidPlayer_WithLifeID(ply, lifeid)
	local result

	if !IsValid(ply) or !ply:Alive() then result = false end
	if IsValid(ply) and ply:Alive() and ply.LifeID == lifeid then result = true end

	return result
end

function HMCD_Moan(ply)
	if ply.ModelSex == "male" then
		ply:EmitSound(table.Random(male_moans), 75, 100, 1, CHAN_AUTO)
	else
		ply:EmitSound(table.Random(female_moans), 75, 100, 1, CHAN_AUTO)
	end
end

function HMCD_Poison(victim, attacker, poison)
	
	if !IsValid(victim) or !victim:IsPlayer() then return end
	
	local TAS = victim.LifeID
	local CurareTime, VXTime, TetrodotoxinTime, CyanidePowderTime = math.random(5, 7), math.random(2,5), math.random(5, 15), math.random(5, 10)
	
	if poison == "Curare" then
		timer.Simple(CurareTime, function()
			if !ValidPlayer_WithLifeID(victim, TAS) then return end
			HMCD_Moan(victim)
			
			timer.Simple(CurareTime, function()
				if !ValidPlayer_WithLifeID(victim, TAS) then return end
				HMCD_Moan(victim)
				victim.pain = victim.pain + 100
				
				timer.Simple(CurareTime, function()
					if !ValidPlayer_WithLifeID(victim, TAS) then return end
					local poison=DamageInfo()
					poison:SetDamage(105)
					poison:SetDamageType(DMG_POISON)
					poison:SetAttacker(attacker)
					poison:SetInflictor(victim)
					poison:SetDamagePosition(victim:GetPos())
					poison:SetDamageForce(Vector(0,0,0))
					victim:TakeDamageInfo(poison)
				
				end)
			
			end)
		
		end)
	end

end