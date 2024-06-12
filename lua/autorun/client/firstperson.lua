print("no empty")

net.Receive("ebal_chellele",function(len)
    net.ReadEntity().curweapon = net.ReadString()
end)

net.Receive("pophead",function(len)
	local rag = net.ReadEntity()
	deathrag = rag
end)

-- просто нетворки сверху не  смотреть

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudBattery"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudZoom"] = true,
	["CTargetID"]=true
}

hook.Add( "HUDShouldDraw", "HideHUD", function(name)
	if hide[name] then
		return false
	end
    -- спастил с гмодвики
end)

hook.Add("HUDDrawTargetID","HideHUD2", function() return false end)

AddCSLuaFile()
local viewmodeldraw = {
	["weapon_physgun"] = true,
	["gmod_tool"] = true,
	["gmod_camera"] = true,
	["sf_tool"] = true,
    ["weapon_drr_remote"] = true
}
LerpEyeRagdoll = Angle(0,0,0)
local vecZero = Vector(0,0,0)
local tryaska = vecZero
local shootfov = 0
local GOVNOVEC = Vector(0,0,7)

local mul = 1
local FrameTime,TickInterval = FrameTime,engine.TickInterval

hook.Add("Think","Mul lerp",function()
	mul = FrameTime() / TickInterval()
end)

local Lerp,LerpVector,LerpAngle = Lerp,LerpVector,LerpAngle
local math_min = math.min

function LerpAngleFT(lerp,source,set)
	return LerpAngle(math_min(lerp * mul,1),source,set)
end

local function ImersiveCam(ply,pos,ang,fov)
	local lply = LocalPlayer()
	local ragdoll = lply:GetNWEntity("Ragdoll")
	if !ply:Alive() and IsValid(ragdoll) then
		ragdoll:ManipulateBoneScale(6,Vector(1,1,1))
		local att = ragdoll:GetAttachment(ragdoll:LookupAttachment("eyes"))
		local eyeAngs = lply:EyeAngles()
		LerpEyeRagdoll = LerpAngleFT(30,LerpEyeRagdoll,LerpAngle(1,eyeAngs,att.Ang))
		LerpEyeRagdoll[3] = LerpEyeRagdoll[3]
		local view = {
			origin = att.Pos,
			angles = LerpEyeRagdoll,
			znear = 1,
			zfar = 26000
		}
		return view
	elseif ply:Alive() and ply:GetNWBool("fake") and IsValid(ragdoll) then
		ragdoll:ManipulateBoneScale(6,vecZero)
		local PosAng = ragdoll:GetAttachment(ragdoll:LookupAttachment("eyes"))
		LerpEyeRagdoll = LerpAngleFT(1,LerpEyeRagdoll,LerpAngle(0.5,lply:EyeAngles(),PosAng.Ang))
		LerpEyeRagdoll[3] = LerpEyeRagdoll[3]
		local camfake = {
			origin = PosAng.Pos - Vector(2,0,0),
			angles = PosAng.Ang,
			znear = 1,
			zfar = 26000,
			fov = 110
		}
		return camfake
	end
end

hook.Add( "CalcView", "RagCam", ImersiveCam )