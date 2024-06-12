print("noempty")

hook.Add("Think","LipSync",function()
	for i, ply in pairs(player.GetAll()) do
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
			ent:SetFlexWeight( 9, weight/2)
		end
	end
end)

hook.Add("PostDrawOpaqueRenderables", "LaserChecha", function()
	local ply = LocalPlayer()
	local weapon = ply:GetActiveWeapon()

	local pos, ang = ply:GetPos(), ply:GetAngles()

	if weapon.Base != "wep_jack_hmcd_firearm_base" then return end
	if !weapon:GetNWBool("Laser", false) then return end
	if !weapon:GetNWBool("LaserStatus") then return end

	local startPos = ply:GetViewModel():GetAttachment(1).Pos + ply:GetViewModel():GetForward() * (weapon.LaserPos_Forward or 0) + ply:GetViewModel():GetUp() * (weapon.LaserPos_Up or 0) + ply:GetViewModel():GetRight() * (weapon.LaserPos_Right or 0)
	local endPos = startPos + ply:GetViewModel():GetRight() * (weapon.LaserPos_RightCorrect or 0) + ply:GetViewModel():GetForward() * 3000
	local tr = util.TraceLine({
    	start = startPos,
       	endpos = endPos,
    	filter = ply
	}) 

	render.SetMaterial(Material("cable/redlaser"))
	render.DrawBeam(startPos, tr.HitPos, 0.03, 2, 0, Color(255, 0, 0, 255))
    
	render.SetMaterial(Material("sprites/light_glow02_add"))
	render.DrawQuadEasy(tr.HitPos, tr.HitNormal, 10, 10, Color(255, 0, 0, 255), 0)
end)

dev = GetConVar( "developer" )

hook.Add("PostDrawTranslucentRenderables","hitboxs",function()
	if dev:GetInt() == 1 or dev:GetInt() == 3 then
		for _, ent in ipairs(player.GetAll()) do
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
		end
	end
end )

function createCircle(x, y, radius, seg)
    local cir = {}

    for i = 1, seg do
        local a = math.rad((i / seg) * -360)
        table.insert(cir, { x = x + math.sin(a) * radius, y = y + math.cos(a) * radius })
    end

    return cir
end

local sights={
    [1]=Material( "models/weapons/tfa_ins2/optics/kobra_dot", "noclamp nocull smooth"),
    [2]=Material( "models/weapons/tfa_ins2/optics/eotech_reticule", "noclamp nocull smooth"),
    [3]=Material( "scope/aimpoint", "noclamp nocull smooth")
}

local sightMuls={
    ["wep_jack_hmcd_mp7"]={
        [1]=0.4,
        [2]=0.4,
        [3]=0.7
    },
    ["wep_jack_hmcd_shotgun"]={
        [1]=0.33,
        [2]=0.33
    },
    ["wep_jack_hmcd_m249"]={
        [1]=0.33,
        [2]=0.33
    },
    ["wep_jack_hmcd_sr25"]={
        [3]=0.75
    },
    ["wep_jack_hmcd_assaultrifle"]={
        [1]=0.25,
        [2]=0.25
    },
    ["wep_jack_hmcd_akm"]={
        [3]=0.75
    }
}

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

net.Receive("ebal_chellele",function(len)
    net.ReadEntity().curweapon = net.ReadString()
end)

local CurTime = CurTime
local wtf
local tblNil = {}

deadBodies = deadBodies or {}
net.Receive("send_deadbodies",function(len)
    deadBodies = net.ReadTable()
end)

hook.Add("PostDrawOpaqueRenderables","drawweapon",function()
    if GAMEMODE.RoundName == "homicide" then return end
    if not vbwdraw:GetBool() then return end

    render.SetColorMaterial()

    local lply = LocalPlayer()
    local firstPerson = DRAWMODEL

    local worldModel = VBWModel
    if not IsValid(worldModel) then
        worldModel = ClientsideModel("models/hunter/plates/plate.mdl",RENDER_GROUP_OPAQUE_ENTITY)
        worldModel:SetNoDraw(true)
        VBWModel = worldModel
    end

    local cameraPos = EyePos()
    local dis = vbwdis:GetInt()
    local tbl = GetAll()
    
    for i = 1,#tbl do
        local ply = tbl[i]

        if lply == ply and not firstPerson then continue end

        local list = ply:GetWeapons()
        
        if #list == 0 then continue end
        
        local activeWep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass()

        local ent = ply:GetNWBool("fake") and ply:GetNWEntity("Ragdoll")
        activeWep = IsValid(ent) and ply.curweapon or activeWep
        ent = IsValid(ent) and ent or ply

        if cameraPos:Distance(ent:GetPos()) > dis then continue end

        local matrix = ent:LookupBone("ValveBiped.Bip01_Spine2")
        matrix = matrix and ent:GetBoneMatrix(matrix)
        if not matrix then continue end
        local spinePos,spineAng = matrix:GetTranslation(),matrix:GetAngles()

        matrix = ent:GetBoneMatrix(ent:LookupBone("ValveBiped.Bip01_Pelvis"))
        local pelvisPos,pelvisAng = matrix:GetTranslation(),matrix:GetAngles()
        
        if gameVBWHide then list = gameVBWHide(ply,list) or list end

        local mdl = ply:GetModel()
        --local isFamale = femaleMdl[mdl]
        
        local sUp,sRight,sForward = spineAng:Up(),spineAng:Right(),spineAng:Forward()
        local pUp,pRight,pForward = pelvisAng:Up(),pelvisAng:Right(),pelvisAng:Forward()
        
        for i,wep in pairs(list) do
            local active = activeWep ~= wep:GetClass() and wep.vbw
            
            wep.vbwActive = active
            if not active then continue end

            local localPos,localAng,pistol

            local func = wep.vbwFunc

            local clone

            if func then
                localPos,localAng,pistol = func(wep,ply,mdl)

                Offset:Set(pelvisPos)
                Ang:Set(pelvisAng)

                clone = Vector(localPos[1],localPos[2],localPos[3])
                clone:Rotate(Ang)

                Ang:RotateAroundAxis(pUp,localAng[1])
                Ang:RotateAroundAxis(pRight,localAng[2])
                Ang:RotateAroundAxis(pForward,localAng[3])
            else
                pistol = not wep.vbwRifle and (wep.vbwPistol or not wep.TwoHands)
                
                if pistol then
                    --[[if isFamale then
                        localPos = wep.vbwPosF or wep.vbwPos or PistolOffsetF
                        localAng = wep.vbwAngF or wep.vbwAng or PistolAngF
                    else]]--
                        localPos = wep.HolsterPos or PistolOffset
                        localAng = wep.HolsterAng or PistolAng
                    --end

                    Offset:Set(pelvisPos)
                    Ang:Set(pelvisAng)

                    clone = Vector(localPos[1],localPos[2],localPos[3])
                    clone:Rotate(Ang)

                    Ang:RotateAroundAxis(pUp,localAng[1])
                    Ang:RotateAroundAxis(pRight,localAng[2])
                    Ang:RotateAroundAxis(pForward,localAng[3])
                else
                    --[[if isFamale then
                        localPos = wep.vbwPosF or wep.vbwPos or RifleOffsetF
                        localAng = wep.vbwAngF or wep.vbwAng or RifleAngF
                    else]]--
                        localPos = wep.HolsterPos or RifleOffset
                        localAng = wep.HolsterAng or RifleAng
                    --end
                    
                    Offset:Set(spinePos)
                    Ang:Set(spineAng)

                    clone = Vector(localPos[1],localPos[2],localPos[3])
                    clone:Rotate(Ang)

                    Ang:RotateAroundAxis(sUp,localAng[1])
                    Ang:RotateAroundAxis(sRight,localAng[2])
                    Ang:RotateAroundAxis(sForward,localAng[3])
                end
            end

            Offset:Add(clone)
           
            worldModel:SetModel(wep.WorldModel)--"models/hunter/plates/plate05.mdl"
            worldModel:SetModelScale(wep.vbwModelScale or 1)
            worldModel:SetPos(Offset)
            worldModel:SetAngles(Ang)
            worldModel:DrawModel()
        end
    end

    local tbl2 = deadBodies or tblNil

    for i,val in pairs(tbl2) do
        
        if not tbl2[i] then continue end

        local ent = val[1]
        local list = val[2].Weapons
        
        if not IsValid(ent) or not list then continue end
        
        local activeWep = val.curweapon
        
        if cameraPos:Distance(ent:GetPos()) > dis then continue end

        local matrix = ent:LookupBone("ValveBiped.Bip01_Spine2")
        matrix = matrix and ent:GetBoneMatrix(matrix)
        if not matrix then continue end
        local spinePos,spineAng = matrix:GetTranslation(),matrix:GetAngles()

        matrix = ent:GetBoneMatrix(ent:LookupBone("ValveBiped.Bip01_Pelvis"))
        local pelvisPos,pelvisAng = matrix:GetTranslation(),matrix:GetAngles()
        
        if gameVBWHide then list = gameVBWHide(ent,list) or list end
        
        local mdl = ent:GetModel()
        --local isFamale = femaleMdl[mdl]

        local sUp,sRight,sForward = spineAng:Up(),spineAng:Right(),spineAng:Forward()
        local pUp,pRight,pForward = pelvisAng:Up(),pelvisAng:Right(),pelvisAng:Forward()
        
        for i,wep in pairs(list) do
            local active = activeWep ~= wep.ClassName and wep.vbw
            
            wep.vbwActive = active
            if not active then continue end
            
            local localPos,localAng,pistol

            local func = wep.vbwFunc

            local clone
            
            if func then
                localPos,localAng,pistol = func(wep,ent,mdl)
                
                Offset:Set(pelvisPos)
                Ang:Set(pelvisAng)

                clone = Vector(localPos[1],localPos[2],localPos[3])
                clone:Rotate(Ang)

                Ang:RotateAroundAxis(pUp,localAng[1])
                Ang:RotateAroundAxis(pRight,localAng[2])
                Ang:RotateAroundAxis(pForward,localAng[3])
            else
                pistol = not wep.vbwRifle and (wep.vbwPistol or not wep.TwoHands)
                
                if pistol then
                    --[[if isFamale then
                        localPos = wep.vbwPosF or wep.vbwPos or PistolOffsetF
                        localAng = wep.vbwAngF or wep.vbwAng or PistolAngF
                    else]]--
                        localPos = wep.HolsterPos or PistolOffset
                        localAng = wep.HolsterAng or PistolAng
                    --end

                    Offset:Set(pelvisPos)
                    Ang:Set(pelvisAng)

                    clone = Vector(localPos[1],localPos[2],localPos[3])
                    clone:Rotate(Ang)

                    Ang:RotateAroundAxis(pUp,localAng[1])
                    Ang:RotateAroundAxis(pRight,localAng[2])
                    Ang:RotateAroundAxis(pForward,localAng[3])
                else
                    --[[if isFamale then
                        localPos = wep.vbwPosF or wep.vbwPos or RifleOffsetF
                        localAng = wep.vbwAngF or wep.vbwAng or RifleAngF
                    else]]--
                        localPos = wep.HolsterPos or RifleOffset
                        localAng = wep.HolsterAng or RifleAng
                    --end
                    
                    Offset:Set(spinePos)
                    Ang:Set(spineAng)

                    clone = Vector(localPos[1],localPos[2],localPos[3])
                    clone:Rotate(Ang)

                    Ang:RotateAroundAxis(sUp,localAng[1])
                    Ang:RotateAroundAxis(sRight,localAng[2])
                    Ang:RotateAroundAxis(sForward,localAng[3])
                end
            end

            Offset:Add(clone)
           
            worldModel:SetModel(wep.WorldModel)--"models/hunter/plates/plate05.mdl"
            worldModel:SetModelScale(wep.vbwModelScale or 1)
            worldModel:SetPos(Offset)
            worldModel:SetAngles(Ang)
            worldModel:DrawModel()
        end
    end
end)