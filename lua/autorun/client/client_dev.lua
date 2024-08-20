fs = GetConVar("checha_feature"):GetBool()

hook.Add("Think","LipSync",function()
	for i, ply in player.Iterator() do
		if !ply:Alive() then
			ply.Equipment = {}
		end
		local ent = IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetNWEntity("Ragdoll") or ply

		local flexes = {
			ent:GetFlexIDByName( "jaw_drop" ),
			ent:GetFlexIDByName( "left_part" ),
			ent:GetFlexIDByName( "right_part" ),
			ent:GetFlexIDByName( "left_mouth_drop" ),
			ent:GetFlexIDByName( "right_mouth_drop" )
		}

		local weight = ply:IsSpeaking() && math.Clamp( ply:VoiceVolume() * 4, 0, 6 ) || 0

		for k, v in pairs( flexes ) do
			ent:SetFlexWeight( v, weight )
		end
	end
end)--липсинк ОЧЕНЬ СМЕНШОЙ!!! ALERT!! с хмгд, легкий

hook.Add("PostDrawOpaqueRenderables", "LaserChecha", function()
	local ply = LocalPlayer()
	local weapon = ply:GetActiveWeapon()

	local pos, ang = ply:GetPos(), ply:GetAngles()

	if weapon.Base != "wep_cat_base" then return end
	if !weapon:GetNWBool("Laser", false) then return end
	if !weapon:GetNWBool("LaserStatus") then return end

	local startPos = ply:GetViewModel():GetAttachment(1).Pos
	local endPos = startPos + ply:GetViewModel():GetForward() * 4200
	local tr = util.TraceLine({
    	start = startPos,
       	endpos = endPos,
    	filter = ply
	}) 
	render.SetMaterial(Material("sprites/light_glow02_add"))
	render.DrawQuadEasy(tr.HitPos, tr.HitNormal, 10, 10, Color(255, 0, 0, 255), 0)
end) -- лазеры ЧЕЧИ!!!

dev = GetConVar( "developer" )

hook.Add("PostDrawTranslucentRenderables","hitboxs",function()
	if dev:GetInt() == 1 or dev:GetInt() == 3 then
		--[[for _, ent in player.Iterator() do
			local cho = IsValid(ent:GetNWEntity("Ragdoll")) and ent:GetNWEntity("Ragdoll") or ent
        	local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine2'))
       		render.DrawWireframeBox( pos, ang, Vector(-1,0,-6),Vector(10,6,6), Color(200,200,200) )

			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Head1'))
        	render.DrawWireframeBox( pos, ang, Vector(2,-4,-3),Vector(6,1,3), Color(206,199,199) )
			
			render.DrawWireframeBox( pos, ang, Vector(-3,-2,-2),Vector(0,-1,-1), Color(206,199,199) )
       		render.DrawWireframeBox( pos, ang, Vector(-3,-2,1),Vector(0,-1,2), Color(206,199,199) )

			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine1'))
       		render.DrawWireframeBox( pos, ang, Vector(-4,-1,-6),Vector(2,5,-1), Color(206,199,199) )
		
			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine1'))
       		render.DrawWireframeBox( pos, ang, Vector(-4,-1,-1),Vector(2,5,6), Color(206,199,199) )
		
			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine'))
       		render.DrawWireframeBox( pos, ang, Vector(-4,-1,-6),Vector(1,5,6), Color(206,199,199) )
		
			local pos,ang = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine2'))
		    render.DrawWireframeBox( pos, ang, Vector(1,0,-1),Vector(5,4,3), Color(206,199,199) )
		
			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine4'))
		    render.DrawWireframeBox( pos, ang, Vector(-8,-1,-1),Vector(2,0,1), Color(206,199,199) )

			local pos = cho:GetBonePosition(cho:LookupBone('ValveBiped.Bip01_Spine1'))
		    render.DrawWireframeBox( pos, ang, Vector(-8,-3,-1),Vector(2,-2,1), Color(206,199,199) )
		end]]--
	end
end )--хбоксы кста хуйня с чедарабокса взял залупа член убрать надо будет или переделать нахуй

function createCircle(x, y, radius, seg)
    local cir = {}

    for i = 1, seg do
        local a = math.rad((i / seg) * -360)
        table.insert(cir, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius })
    end

    return cir
end

net.Receive(
	"ragplayercolor",
	function()
		local ent = net.ReadEntity()
		local col = net.ReadVector()
		if IsValid(ent) and isvector(col) then
			function ent:GetPlayerColor()
				return col
			end
		end
	end
)

local Vector = Vector
local vecZero,angZero = Vector(0,0,0),Angle(0,0,0)

local PistolOffset = Vector(8,-9,-8)
local PistolAng = Angle(-80,0,0)

local Offset,Ang = Vector(0,0,0),Angle(0,0,0)

local function remove(wep,ent) ent:Remove() end

local GetAll = player.GetAll
local LocalPlayer = LocalPlayer
local GetViewEntity = GetViewEntity

local vbwdraw = CreateClientConVar("vbw_draw","1",true,false)
local vbwdis = CreateClientConVar("vbw_dis","2000",true,false)

local femaleMdl = {}

for i = 1,6 do femaleMdl["models/player/group01/female_0" .. i .. ".mdl"] = true end
for i = 1,6 do femaleMdl["models/player/group03/female_0" .. i .. ".mdl"] = true end

--[[for count = 0,LocalPlayer():GetBoneCount() - 1 do
    print(LocalPlayer():GetBoneName(count))
end]]--
local bulletTrace = {}

hook.Add("EntityFireBullets", "CreateBulletHoles", function(ent, data)
    local trace = util.TraceLine({
        start = data.Src,
        endpos = data.Src + data.Dir * data.Distance,
        filter = ent
    })

    if trace.Hit then
        table.insert(bulletTrace, trace)
    end
end)

hook.Add("PostDrawOpaqueRenderables", "RenderBulletHoles", function()	
	if GetConVar("developer"):GetInt() == 1 then
    	for _, trace in ipairs(bulletTrace) do
			render.SetMaterial(Material("sprites/light_glow02_add"))
			render.DrawLine(trace.StartPos, trace.HitPos, Color(255,255,255,255), true)
			render.DrawWireframeBox(trace.HitPos, Angle(0, 0, 0), Vector(-1, -1, -1), Vector(2, 2, 2), Color(255, 0, 0, 255), true)
    	end
	end
end)

concommand.Add("checha_trace_clear", function(ply)
	if !ply:IsAdmin() then return end
	bulletTrace = {}
end)

net.Receive("ebal_chellele",function(len)
    net.ReadEntity().curweapon = net.ReadString()
end)

local MATERIAL_COLOR = Material( "color" )
net.Receive("hmcd_equipment",function()
	local num=net.ReadInt(6)
	if num != HMCD_REMOVEEQUIPMENT then

		local eq=HMCD_EquipmentNames[num]

		if not LocalPlayer().Equipment then 
			LocalPlayer().Equipment={} 
		end

		local hasEq = tobool( net.ReadBit() )

		if not hasEq then 
			hasEq=nil 
		end

		LocalPlayer().Equipment[eq]=hasEq
	else
		LocalPlayer().Equipment={}
	end
end)