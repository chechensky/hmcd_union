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
local eblan = CreateClientConVar("eblan", 0, false, false, "")
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

local sight = 0
local changed = false

local function ImersiveCam(ply,pos,ang,fov)
	local plyselect = ply:GetNWEntity("SelectPlayer", Entity(-1))
	local ragdoll = ply:GetNWEntity("Ragdoll")
	if not ply:Alive() and ply:GetNWBool("Spectating", false) == true then
		if !plyselect:GetNWBool("fake") and ply:GetNWInt("SpectateMode", 0) == 0 then
			local att = plyselect:GetAttachment(plyselect:LookupAttachment("eyes"))
			local view = {
				origin = att.Pos + Vector(0,-15,0),
				angles = att.Ang
			}
			return view
		elseif plyselect:GetNWBool("fake") and IsValid(plyselect:GetNWEntity("Ragdoll")) and (ply:GetNWInt("SpectateMode", 0) == 0 or ply:GetNWInt("SpectateMode", 0) == 2) then
			local ragdollselect = plyselect:GetNWEntity("Ragdoll")
			ragdollselect:ManipulateBoneScale(ragdoll:LookupBone("ValveBiped.Bip01_Head1"),vecZero)
			local PosAng = ragdollselect:GetAttachment(ragdollselect:LookupAttachment("eyes"))
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
	if !ply:Alive() and ply:GetNWBool("fake") and IsValid(ragdoll) and ply:GetNWBool("spectatefake", false) == true then
		ragdoll:ManipulateBoneScale(ragdoll:LookupBone("ValveBiped.Bip01_Head1"),Vector())
		local PosAng = ragdoll:GetAttachment(ragdoll:LookupAttachment("eyes"))
		local camfake = {
			origin = PosAng.Pos + Vector(0,-5,0),
			angles = PosAng.Ang,
			znear = 1,
			zfar = 26000,
			fov = 110
		}
		return camfake
	end
	if ply:Alive() and ply:GetNWBool("fake") and IsValid(ragdoll) then
		ragdoll:ManipulateBoneScale(ragdoll:LookupBone("ValveBiped.Bip01_Head1"),vecZero)
		local PosAng = ragdoll:GetAttachment(ragdoll:LookupAttachment("anim_attachment_lh"))
		local PosAngHead= ragdoll:GetAttachment(ragdoll:LookupAttachment("eyes"))
		local camfake = {
			origin = PosAngHead.Pos,
			angles = PosAngHead.Ang,
			znear = 1,
			zfar = 26000,
			fov = 110
		}
		return camfake
	end
end

hook.Add( "CalcView", "RagCam", ImersiveCam )