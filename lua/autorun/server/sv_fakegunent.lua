Guns = {
	"wep_jack_hmcd_assaultrifle",
	"wep_jack_hmcd_smallpistol",
	"wep_jack_hmcd_akm",
	"wep_jack_hmcd_suppressed",
	"wep_jack_hmcd_revolver",
	"wep_jack_hmcd_cz75a",
	"wep_jack_hmcd_crossbow",
	"wep_jack_hmcd_mp7",
	"wep_jack_hmcd_rifle",
	"wep_jack_hmcd_mp5",
	"wep_jack_hmcd_m249",
	"wep_jack_hmcd_combinesniper",
	"wep_jack_hmcd_ar2",
	"wep_jack_hmcd_ptrd",
	"wep_jack_hmcd_remington",
	"wep_jack_hmcd_shotgun",
	"wep_jack_hmcd_spas",
	"wep_jack_hmcd_sr25",
	"wep_jack_hmcd_dbarrel",
	"wep_jack_hmcd_glock17",
	"wep_jack_hmcd_usp",
}

TwoHandedOrNo = {
	["wep_jack_hmcd_assaultrifle"]=true,
	["wep_jack_hmcd_smallpistol"]=false,
	["wep_jack_hmcd_akm"]=true,
	["wep_jack_hmcd_suppressed"]=false,
	["wep_jack_hmcd_revolver"]=false,
	["wep_jack_hmcd_cz75a"]=false,
	["wep_jack_hmcd_crossbow"]=true,
	["wep_jack_hmcd_mp7"]=true,
	["wep_jack_hmcd_rifle"]=true,
	["wep_jack_hmcd_mp5"]=true,
	["wep_jack_hmcd_m249"]=true,
	["wep_jack_hmcd_combinesniper"]=true,
	["wep_jack_hmcd_ar2"]=true,
	["wep_jack_hmcd_ptrd"]=true,
	["wep_jack_hmcd_remington"]=true,
	["wep_jack_hmcd_shotgun"]=true,
	["wep_jack_hmcd_spas"]=true,
	["wep_jack_hmcd_sr25"]=true,
	["wep_jack_hmcd_dbarrel"]=true,
	["wep_jack_hmcd_glock17"]=false,
	["wep_jack_hmcd_usp"]=false,
}

local Vectors = {
	["wep_jack_hmcd_assaultrifle"]=Vector(13,-1.8,3),
	["wep_jack_hmcd_akm"]=Vector(13,-1.8,3),
	["wep_jack_hmcd_crossbow"]=Vector(0,1,-1),
	["wep_jack_hmcd_mp7"]=Vector(4,-1.8,-1.5),
	["wep_jack_hmcd_rifle"]=Vector(0,-1.5,-2),
	["wep_jack_hmcd_mp5"]=Vector(5,-1.8,-1),
	["wep_jack_hmcd_m249"]=Vector(5.5,-1.8,-2),
	["wep_jack_hmcd_combinesniper"]=Vector(15,-1.8,-2),
	["wep_jack_hmcd_ar2"]=Vector(5.5,-1.8,-2),
	["wep_jack_hmcd_ptrd"]=Vector(4,-1.8,-2),
	["wep_jack_hmcd_remington"]=Vector(5,-1.3,-4),
	["wep_jack_hmcd_shotgun"]=Vector(0,-1.3,1),
	["wep_jack_hmcd_spas"]=Vector(6,-1,-2.8),
	["wep_jack_hmcd_sr25"]=Vector(5,-1,-1),
	["wep_jack_hmcd_dbarrel"]=Vector(1.5,-1,-1),
	["wep_jack_hmcd_glock17"]=Vector(3.5,-1,-2),
	
	["wep_jack_hmcd_suppressed"]=Vector(6,-1.5,-1),
	["wep_jack_hmcd_smallpistol"]=Vector(0,-.5,0),
	["wep_jack_hmcd_revolver"]=Vector(-2,-1,1.5),
	["wep_jack_hmcd_cz75a"]=Vector(12,-1,4),
	["wep_jack_hmcd_akm"]=Vector(13,-1.8,3),
	["wep_jack_hmcd_usp"]=Vector(6,-1.5,-1)
}

local Vectors2 = {
	["wep_jack_hmcd_assaultrifle"]=Vector(15,-3.8,-4),
	["wep_jack_hmcd_akm"]=Vector(15,-3.8,-4),
	["wep_jack_hmcd_crossbow"]=Vector(18,-3.8,-2),
	["wep_jack_hmcd_mp7"]=Vector(5,-3.8,-2),
	["wep_jack_hmcd_rifle"]=Vector(18,-3.8,-2),
	["wep_jack_hmcd_mp5"]=Vector(12,-2.8,-3.5),
	["wep_jack_hmcd_m249"]=Vector(10,-3.8,-1),
	["wep_jack_hmcd_combinesniper"]=Vector(10,-3.8,-1),
	["wep_jack_hmcd_ar2"]=Vector(10,-3.8,-1),
	["wep_jack_hmcd_ptrd"]=Vector(13,-4.5,-5.5),
	["wep_jack_hmcd_remington"]=Vector(14,-3.8,-3),
	["wep_jack_hmcd_shotgun"]=Vector(18,-3,-1.5),
	["wep_jack_hmcd_spas"]=Vector(13,-4,-2),
	["wep_jack_hmcd_sr25"]=Vector(13,-4,-4),
	["wep_jack_hmcd_dbarrel"]=Vector(10,-3.9,-2)
}

local bullets = {
	["wep_jack_hmcd_remington"] = 0.08,
	["wep_jack_hmcd_shotgun"] = 0.08,
	["wep_jack_hmcd_spas"] = 0.08,
	["wep_jack_hmcd_dbarrel"] = 0.1
}

local cir = {
	["wep_jack_hmcd_remington"] = 8,
	["wep_jack_hmcd_shotgun"] = 8,
	["wep_jack_hmcd_spas"] = 12,
	["wep_jack_hmcd_dbarrel"] = 12
}

-- checha tables

local Angle_Normalize = {
	["wep_jack_hmcd_ar2"]=Angle(0,180,180),
	["wep_jack_hmcd_usp"]=Angle(0,-10,-180),
	["wep_jack_hmcd_glock17"]=Angle(0,-10,-180)
}

-- в первом векторе обязательнор нахуй поставить - в начале, мне лень было кодить там что бы автоматом - ставился
local RecoilVector1 = {
	["wep_jack_hmcd_akm"]=-150,
	["wep_jack_hmcd_glock17"]=-35,
	["wep_jack_hmcd_smallpistol"]=-25
}
local RecoilVector2 = {
	["wep_jack_hmcd_akm"]=150,
	["wep_jack_hmcd_glock17"]=35,
	["wep_jack_hmcd_smallpistol"]=25
}
local RecoilUp = {
	["wep_jack_hmcd_akm"]=100,
	["wep_jack_hmcd_glock17"]=10,
	["wep_jack_hmcd_smallpistol"]=15
}

local W_Models = {}

vecZero = Vector(0,0,0)

function SpawnWeapon(ply,clip1)
	--local guninfo = ply.GunInfo
	--local guninfo = ply.GunInfo луа очень легкий

	if !IsValid(ply.wep) and table.HasValue(Guns,ply.curweapon) then
		local rag = ply:GetNWEntity("Ragdoll")

		if IsValid(rag) then
			ply.FakeShooting=true
			ply.wep = ents.Create("prop_physics")
			ply.wep:SetModel(weapons.Get(ply.curweapon).WorldModel or W_Models[ply.curweapon] or nil)
			ply.wep:SetOwner(ply)
			local vec1=rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetPos()
			local vec2 = vecZero
			vec2:Set((Vectors[ply.curweapon] or Vector(0,0,0)))

			vec2:Rotate(rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetAngles())
			ply.wep:SetPos(vec1+vec2)

			ply.wep:SetAngles(rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetAngles()-(Angle_Normalize[ply.curweapon] or Angle(0,0,-180)))

			ply.wep:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			ply.wep:Spawn()
			ply:SetNWEntity("wep",ply.wep)
			ply.wep:GetPhysicsObject():SetMass(0)
			local weapon = ply:GetActiveWeapon()

			CheckAmmo(ply, ply.wep)
			if !IsValid(ply.WepCons) then
				local cons = constraint.Weld(ply.wep,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )),0,true)
				if IsValid(cons) then
					ply.WepCons=cons
				end
			end
			ply.wep.curweapon = ply.curweapon
			net.Start("ebal_chellele")
			net.WriteEntity(ply)
			net.WriteString(ply.curweapon)
			net.Broadcast()
			rag.wep = ply.wep
			rag.wep:CallOnRemove("inv",remove,rag)
			ply.wep.rag = rag
			ply.wepClip = ply.Info.Weapons[ply.curweapon].Clip1
			ply.wep.AmmoType = ply.Info.Weapons[ply.curweapon].AmmoType

			ply:SetNWString("curweapon",ply.wep.curweapon)
			if (TwoHandedOrNo[ply.curweapon]) then
				local vec1=rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetPos()
				local vec22 = vecZero
				vec22:Set(Vectors2[ply.curweapon])
				vec22:Rotate(rag:GetPhysicsObjectNum(rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" ))):GetAngles())
				rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )) ):SetPos(vec1+vec22)
				rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )) ):SetAngles(ply:GetNWEntity("Ragdoll"):GetPhysicsObjectNum( 7 ):GetAngles()-Angle(0,0,180))
				if !IsValid(ply.WepCons2) then
					local cons2 = constraint.Weld(ply.wep,rag,0,rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_L_Hand" )),0,true)			--2hand constraint
					if IsValid(cons2) then
						ply.WepCons2=cons2
					end
				end
			end
		end
	end
end

function DespawnWeapon(ply)
	if not ply.Info then return end

	if not ply.Info.Weapons[ply.Info.ActiveWeapon] then return end
	ply.Info.Weapons[ply.Info.ActiveWeapon].Clip1 = ply.wepClip
	ply.Info.ActiveWeapon2=ply.curweapon
	--if ply:Alive() and !ply.wep.pickable then
	if ply.wep_sup then
		ply.wep_sup_what = true
		ply.wep_sup = false
	end
	if ply.wep_sight then
		ply.wep_sight_what = true
		ply.wep_sight = false
	end
		if IsValid(ply.wep) and ply:Alive() then
			ply.wep:Remove()
			ply.wep=nil
			ply.wepmelee = nil
			ply.wepgrenade = nil
			ply.wepmedicine = nil
		elseif IsValid(ply.wep) and !ply:Alive() then
            ply.wep.canpickup=true
            ply.wep:SetOwner(nil)
            ply.wep.curweapon=ply.curweapon
            ply.wep=nil
			ply.wepmelee = nil
			ply.wepgrenade = nil
			ply.wepmedicine = nil
        end

		if IsValid(ply.WepCons) and ply:Alive() then
			ply.WepCons:Remove()
			ply.WepCons=nil
		elseif IsValid(ply.WepCons) then
			ply.WepCons=nil
		end

		if IsValid(ply.WepCons2) and ply:Alive() then
			ply.WepCons2:Remove()
			ply.WepCons2=nil
		elseif IsValid(ply.WepCons2) then
			ply.WepCons2=nil
		end
		ply.FakeShooting=false
	--[[else
		ply.wep.pickable=true
		ply.wep=nil
		ply.FakeShooting=false
	end--]]
end
Items = {
	['bandage']=1
}
function CheckAmmo(ply, wep)
	--print(ply.Info.ActiveWeapon)
	--print(ply.Info.Weapons[ply.Info.ActiveWeapon].Clip1)
	--print(ply.Info.ActiveWeapon2:GetMaxClip1())
	--if Items[wep] then return end
	--if ply.curweapon=="bandage" then wep:SetModelScale(0.4) end
	if ply:Alive() then
		wep.Clip = ply.Info.Weapons[ply.Info.ActiveWeapon].Clip1 or 0
		wep.MaxClip = ply.Info.ActiveWeapon2:GetMaxClip1() or 0
		--print(ply:GetAmmoCount(ply.Info.ActiveWeapon2:GetPrimaryAmmoType()))
		wep.Amt=ply:GetAmmoCount(ply.Info.ActiveWeapon2:GetPrimaryAmmoType()) or 0
		wep.AmmoType=ply.Info.ActiveWeapon2:GetPrimaryAmmoType() or 0
	else
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end

		wep.Clip = wep:Clip1()
		wep.AmmoType=wep:GetPrimaryAmmoType()
		--print(wep.Clip, wep.AmmoType)
	end
end

function SpawnWeaponEnt(weapon, pos, ply)
    local wep = ents.Create("prop_physics")
    wep:SetModel(GunsModel[weapon])
    wep:SetPos(pos)
	wep:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    wep:Spawn()
    wep:SetAngles(ply:EyeAngles() or Angle(0,0,0))
	--wep:GetPhysicsObject():SetMass(500)
    wep.curweapon = ply.curweapon
    wep.Clip = ply.Clip
    wep.AmmoType = ply.AmmoType
    wep.canpickup=true
    return wep
end

function ReloadSound(wep)
    local ply = wep:GetOwner()
	local weptable = weapons.Get(wep.curweapon)
    timer.Create(ply:EntIndex().."snd"..wep:EntIndex(),weptable.ReloadTime,1,function()
        if wep:IsValid() then
			wep:GetPhysicsObject():ApplyForceCenter(wep:GetAngles():Up()*100+wep:GetAngles():Forward()*-200)
            wep:EmitSound(weptable.ReloadSound, 55, 100, 1, CHAN_AUTO)
        end
    end)
end

function Reload(wep)
	if not wep then return end
	local weptable = weapons.Get(wep.curweapon)
	if !IsValid(wep) then return nil end
	local ply = wep:GetOwner()
	if !timer.Exists("reload"..wep:EntIndex()) and wep.Clip ~= wep.MaxClip and wep.Amt > 0 then
		ReloadSound(wep)
		timer.Create("reload"..wep:EntIndex(), weptable.ReloadTime, 1, function()
			if IsValid(wep) then
				local oldclip = wep.Clip
				wep.Clip = math.Clamp(wep.Clip + wep.Amt, 0, wep.MaxClip)
				local needed = wep.Clip - oldclip
				wep.Amt=wep.Amt-needed
				ply.Info.Ammo[wep.AmmoType]=wep.Amt
			end
		end)
	end
end

NextShot = 2
local lastAttackTime = 0
local attackDelay = 0.4

HMCD_SurfaceHardness={
    [MAT_METAL]=.95,[MAT_COMPUTER]=.95,[MAT_VENT]=.95,[MAT_GRATE]=.95,[MAT_FLESH]=.3,[MAT_ALIENFLESH]=.3,
    [MAT_SAND]=.1,[MAT_DIRT]=.3,[74]=.1,[85]=.2,[MAT_WOOD]=.5,[MAT_FOLIAGE]=.5,
    [MAT_CONCRETE]=.9,[MAT_TILE]=.8,[MAT_SLOSH]=.05,[MAT_PLASTIC]=.3,[MAT_GLASS]=.6
}

local pos = Vector(0,0,0)

function TrownGranade(ply,force,granade)
    local granade = ents.Create(granade)
    granade:SetPos(ply:GetShootPos() +ply:GetAimVector()*10)
	granade:SetAngles(ply:EyeAngles()+Angle(45,45,0))
	granade:SetOwner(ply)
	granade:SetPhysicsAttacker(ply)
    granade:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	granade:Spawn()       
	granade:Arm()
	local phys = granade:GetPhysicsObject()              
	if not IsValid(phys) then granade:Remove() return end                         
	phys:SetVelocity(ply:GetVelocity() + ply:GetAimVector() * force)
	phys:AddAngleVelocity(VectorRand() * force/2)
end

function FireShot(wep)
	if not IsValid(wep) then return end
	local ply = wep:GetOwner()
	local info = ply.Info
	-- knife
	if ply.wepmelee == true or string.find(wep.curweapon, "knife") or wep.curweapon == "wep_jack_gmod_knife" then
		if CurTime() < lastAttackTime + attackDelay then return end
			local tr = util.TraceLine({
				start = wep:GetPos(),
				endpos = wep:GetPos() + wep:GetForward() * 60,
				filter = ply
			})
			if RagdollOwner(tr.Entity) == ply then return end
			if tr.Hit and IsValid(tr.Entity) and tr.Entity:IsPlayer() or tr.Entity:IsRagdoll() then
			local dmginfo = DamageInfo()
			if string.find(wep.curweapon, "knife") or wep.curweapon == "wep_jack_gmod_knife" or wep.curweapon == "wep_jack_gmod_hatchet" or wep.curweapon == "wep_mann_hmcd_machete" then dmginfo:SetDamageType( DMG_SLASH ) else dmginfo:SetDamageType(DMG_CLUB) end
			dmginfo:SetAttacker( ply )
			dmginfo:SetDamagePosition( tr.HitPos )
			dmginfo:SetDamageForce( ply:GetForward() * 40 )
			dmginfo:SetDamage( weapons.Get(wep.curweapon).Primary.Damage )
			if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsRagdoll() then
				if string.find(wep.curweapon, "knife") or wep.curweapon == "wep_jack_gmod_knife" or wep.curweapon == "wep_jack_gmod_hatchet" or wep.curweapon == "wep_mann_hmcd_machete" then  sound.Play("snd_jack_hmcd_knifestab.wav", tr.HitPos, 75, 100) else sound.Play("Flesh.ImpactHard", tr.HitPos, 75, 100) end
				local rag = ply.fakeragdoll
				local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )) )
				local head = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Head1" )) )
				local ang=ply:EyeAngles()
				local eyeangs = ply:EyeAngles()
				ang:RotateAroundAxis(eyeangs:Forward(),90)
				ang:RotateAroundAxis(eyeangs:Right(),75)
				local shadowparams = {
					secondstoarrive=0.01,
					pos=head:GetPos()+eyeangs:Forward()*100+eyeangs:Right()*200,
					angle=ang,
					maxangular=670,
					maxangulardamp=600,
					maxspeeddamp=50,
					maxspeed=500,
					teleportdistance=0,
					deltatime=0.01,
				}
				phys:Wake()
				phys:ComputeShadowControl(shadowparams)
			end
			if RagdollOwner(tr.Entity) != ply then tr.Entity:TakeDamageInfo( dmginfo ) end
			lastAttackTime = CurTime()
		end
	end

	if wep.curweapon == "wep_jack_gmod_pocketknife" then
		if CurTime() < lastAttackTime + attackDelay then return end
		local rag = ply.fakeragdoll
		local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )) )
		local head = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Head1" )) )
		local ang=ply:EyeAngles()
		local eyeangs = ply:EyeAngles()
		ang:RotateAroundAxis(eyeangs:Forward(),90)
		ang:RotateAroundAxis(eyeangs:Right(),75)
		local shadowparams = {
			secondstoarrive=0.01,
			pos=head:GetPos()+eyeangs:Forward()*2+eyeangs:Right()*5,
			angle=ang,
			maxangular=670,
			maxangulardamp=600,
			maxspeeddamp=50,
			maxspeed=500,
			teleportdistance=0,
			deltatime=0.01,
		}
		phys:Wake()
		phys:ComputeShadowControl(shadowparams)
		local tr = util.TraceLine({
			start = wep:GetPos(),
			endpos = wep:GetPos() + wep:GetForward() * 20,
			filter = ply
		})
		if tr.Hit and IsValid(tr.Entity) and tr.Entity:IsPlayer() or tr.Entity:IsRagdoll() then
			local dmginfo = DamageInfo()
			dmginfo:SetDamageType( DMG_SLASH )
			dmginfo:SetAttacker( ply )
			dmginfo:SetDamagePosition( tr.HitPos )
			dmginfo:SetDamageForce( ply:GetForward() * 40 )

			dmginfo:SetDamage( 20 / 1.5 )

			if tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:IsRagdoll() then
				sound.Play("snd_jack_hmcd_knifestab.wav", tr.HitPos, 75, 100)
		local rag = ply.fakeragdoll
		local phys = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_R_Hand" )) )
		local head = rag:GetPhysicsObjectNum( rag:TranslateBoneToPhysBone(rag:LookupBone( "ValveBiped.Bip01_Head1" )) )
		local ang=ply:EyeAngles()
		local eyeangs = ply:EyeAngles()
		ang:RotateAroundAxis(eyeangs:Forward(),90)
		ang:RotateAroundAxis(eyeangs:Right(),75)
		local shadowparams = {
			secondstoarrive=0.01,
			pos=head:GetPos()+eyeangs:Forward()*100+eyeangs:Right()*200,
			angle=ang,
			maxangular=670,
			maxangulardamp=600,
			maxspeeddamp=50,
			maxspeed=500,
			teleportdistance=0,
			deltatime=0.01,
		}
		phys:Wake()
		phys:ComputeShadowControl(shadowparams)
			end
			tr.Entity:TakeDamageInfo( dmginfo )
			lastAttackTime = CurTime()
		end
	end

	-- gren
	if wep.curweapon == "wep_nab_hmcd_m67" then
		ply:StripWeapon(wep.curweapon)
		info.Weapons["wep_nab_hmcd_m67"] = nil
		ply.wep:Remove()
		ply.wep = nil
		ply.wepmelee = nil
		ply.wepgrenade = nil
		ply.wepmedicine = nil
     	ply:SelectWeapon("wep_jack_hmcd_hands")
		TrownGranade(ply,750,"ent_nab_hmcd_m67")
	elseif wep.curweapon == "wep_jack_gmod_oldgrenade_dm" then
		ply:StripWeapon(wep.curweapon)
		info.Weapons["wep_jack_gmod_oldgrenade_dm"] = nil
		ply.wep:Remove()
		ply.wep = nil
		ply.wepmelee = nil
		ply.wepgrenade = nil
		ply.wepmedicine = nil
     	ply:SelectWeapon("wep_jack_hmcd_hands")
		TrownGranade(ply,750,"ent_hgjack_type59")
	elseif wep.curweapon == "weapon_hg_rgd5" then
		ply:StripWeapon(wep.curweapon)
		info.Weapons["weapon_hg_rgd5"] = nil
		ply.wep:Remove()
		ply.wep = nil
		ply.wepmelee = nil
		ply.wepgrenade = nil
		ply.wepmedicine = nil
     	ply:SelectWeapon("wep_jack_hmcd_hands")
		TrownGranade(ply,750,"ent_hgjack_rgd5nade")
	end

	if wep.curweapon == "tire" then
		ply:StripWeapon(wep.curweapon)
		info.Weapons["tire"] = nil
		ply:SelectWeapon("weapon_physgun")
		local healsound = Sound("bandageuse.wav")
    	ply.RightLegbroke = false
    	ply.LeftLegbroke = false
		ply.RightArmbroke = false
		ply.LeftArmbroke = false
		ply.LeftArm = 1
		ply.RightArm = 1
    	ply.RightLeg = 1
    	ply.LeftLeg = 1
		ply:SetNWBool("LeftLeg", ply.LeftLegbroke)
		ply:SetNWBool("RightLeg", ply.RightLegbroke)
		ply:SetNWBool("RightArm", ply.RightArmbroke)
		ply:SetNWBool("LeftArm", ply.LeftArmbroke)
		ply.wep:Remove()
		ply.wep = nil
		ply.wepmelee = nil
		ply.wepgrenade = nil
		ply.wepmedicine = nil
        ply:SelectWeapon("wep_jack_hmcd_hands")
        ply:EmitSound(healsound)
	end

	local weptable = weapons.Get(wep.curweapon)
	function wep:BulletCallbackFunc(dmgAmt,ply,tr,dmg,tracer,hard,multi)
		if(tr.MatType==MAT_FLESH)then
			local vPoint = tr.HitPos
			local effectdata = EffectData()
			effectdata:SetOrigin( vPoint )
			util.Effect( "BloodImpact", effectdata )
		end
		if(self.NumBullet or 1>1)then return end
		if(tr.HitSky)then return end
		if(hard)then self:RicochetOrPenetrate(tr) end
	end
	function wep:RicochetOrPenetrate(initialTrace)
		local AVec,IPos,TNorm,SMul=initialTrace.Normal,initialTrace.HitPos,initialTrace.HitNormal,HMCD_SurfaceHardness[initialTrace.MatType]
		if not(SMul)then SMul=.5 end
		local ApproachAngle=-math.deg(math.asin(TNorm:DotProduct(AVec)))
		local MaxRicAngle=80*SMul
		if(ApproachAngle>(MaxRicAngle*1.25))then -- all the way through
			local MaxDist,SearchPos,SearchDist,Penetrated=(weapons.Get(wep.curweapon).Damage/SMul)*.15,IPos,5,false
			while((not(Penetrated))and(SearchDist<MaxDist))do
				SearchPos=IPos+AVec*SearchDist
				local PeneTrace=util.QuickTrace(SearchPos,-AVec*SearchDist)
				if((not(PeneTrace.StartSolid))and(PeneTrace.Hit))then
					Penetrated=true
				else
					SearchDist=SearchDist+5
				end
			end
			if(Penetrated)then
				self:FireBullets({
					Attacker=self:GetOwner(),
					Damage=1,
					Force=1,
					Num=1,
					Tracer=0,
					TracerName="",
					Dir=-AVec,
					Spread=Vector(0,0,0),
					Src=SearchPos+AVec
				})
				self:FireBullets({
					Attacker=self:GetOwner(),
					Damage=weapons.Get(wep.curweapon).Damage*.65,
					Force=0,
					Num=1,
					Tracer=0,
					TracerName="",
					Dir=AVec,
					Spread=Vector(0,0,0),
					Src=SearchPos+AVec
				})
			end
		elseif(ApproachAngle<(MaxRicAngle*.75))then -- ping whiiiizzzz
			sound.Play("snd_jack_hmcd_ricochet_"..math.random(1,2)..".wav",IPos,70,math.random(90,100))
			local NewVec=AVec:Angle()
			NewVec:RotateAroundAxis(TNorm,180)
			NewVec=NewVec:Forward()
			self:FireBullets({
				Attacker=self:GetOwner(),
				Damage=weapons.Get(wep.curweapon).Damage*.85,
				Force=0,
				Num=1,
				Tracer=0,
				TracerName="",
				Dir=-NewVec,
				Spread=Vector(0,0,0),
				Src=IPos+TNorm
			})
		end
	end

	if !IsValid(wep) then return nil end
	
	if timer.Exists("reload"..wep:EntIndex()) then return nil end
	local guninfo = wep.GunInfo
	
	wep.NextShot=wep.NextShot or NextShot

	if ( wep.NextShot > CurTime() ) then return end
	if wep.Clip<=0 then
		sound.Play("snd_jack_hmcd_click.wav",wep:GetPos(),65,100)
		wep.NextShot = CurTime() + weptable.CycleTime
	return nil end
	local shootwait = weptable.ShootWait_Ragdoll or weptable.CycleTime*math.random(0.8, 2.3)
	print(shootwait)
	wep.NextShot = CurTime() + shootwait
	local Attachment = wep:GetAttachment(wep:LookupAttachment(weptable.World_MuzzleAttachmentName or "muzzle"))

	local damage = weapons.Get(wep.curweapon).Damage
	local ply = wep:GetOwner()

	local bullet = {}
		bullet.Num 			= (weptable.NumBullet or 1)
		bullet.Src 			= Attachment.Pos
		bullet.Dir 			= Attachment.Ang:Forward()
		bullet.Spread 		= 0
		bullet.Tracer		= 1
		bullet.TracerName 	= 4
		bullet.Force		= 10
		bullet.Damage		= damage*1.2
		bullet.Attacker 	= ply
		bullet.Callback=function(ply,tr,dmgInfo)
			wep:BulletCallbackFunc(damage,ply,tr,damage,false,true,false)
			if weptable.NumBullet and weptable.NumBullet > 1 then
				local k = math.max(1 - tr.StartPos:Distance(tr.HitPos) / 750,0)
	
				dmgInfo:ScaleDamage(k)
			end
			if ply.wep_sup != true then
				local ef = EffectData()
				ef:SetEntity( wep )
				ef:SetAttachment( 1 ) -- self:LookupAttachment( "muzzle" )
				ef:SetScale(0.1)
				ef:SetFlags( 7 ) -- Sets the Combine AR2 Muzzle flash
		
				util.Effect( "MuzzleFlash", ef )
			end
		end
	

	--[[local bullet = {}
		bullet.Num 			= 1
		bullet.Src 			= shootOrigin
		bullet.Dir 			= shootDir
		bullet.Spread 		= 0.05
		bullet.Tracer		= guninfo.Trace
		bullet.TracerName 	= nil
		bullet.Force		= 10
		bullet.Damage		= guninfo.Damage
		bullet.Attacker 	= ply
	--]]
	ParticleEffectAttach("pcf_jack_mf_barrelsmoke",PATTACH_POINT_FOLLOW,wep,1)

	wep:FireBullets( bullet )
	--wep:EmitSound(weptable.Primary.Sound,511,math.random(100,120),1,CHAN_WEAPON,0,0)
	wep:EmitSound(weptable.CloseFireSound,100,math.random(90,110),1,CHAN_WEAPON,0,0)
	if wep.curweapon == "wep_jack_hmcd_rifle" then wep:EmitSound("snd_jack_hmcd_boltcycle.wav",55,100,1,CHAN_ITEM,0,0) end
	local ply = wep:GetOwner()

	local vector1 = RecoilVector1[wep.curweapon] or -30
	local vector2 = RecoilVector2[wep.curweapon] or 30

	wep:GetPhysicsObject():ApplyForceCenter(wep:GetAngles():Forward()*-damage*3+wep:GetAngles():Right()*VectorRand(vector1,vector2)+wep:GetAngles():Up()*(RecoilUp[wep.curweapon] or 50))

	wep.Clip=wep.Clip-1
	ply.wepClip = wep.Clip
	-- Make a muzzle flash
	local obj = wep:LookupAttachment(weptable.ShellAttachment)
	local Attachment = wep:GetAttachment(obj)
	if Attachment then
		local Angles = Attachment.Ang
		if weptable.ShellRotate then Angles:RotateAroundAxis(vector_up,180)  end
		local ef = EffectData()
		ef:SetOrigin(Attachment.Pos)
		ef:SetAngles(Angles)
		ef:SetFlags( 7 ) -- Sets the Combine AR2 Muzzle flash

		if weptable.Shell != nil then util.Effect( weptable.ShellEffect, ef ) end
	end
end