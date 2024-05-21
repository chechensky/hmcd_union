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