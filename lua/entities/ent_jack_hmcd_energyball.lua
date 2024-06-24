--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_energyball.lua

--]]
AddCSLuaFile()
DEFINE_BASECLASS("base_anim")
ENT.PrintName = "Energy ball"
ENT.Category = "Fun + Games"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.ImpactSound = ""
--ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.MinSize = 50
ENT.MaxSize = 50
ENT.HmcdGas = true
ENT.NextBounceTime = 0
ENT.JIBFS_NoBlock = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "BallSize", {
		KeyName = "ballsize",
		Edit = {
			type = "Float",
			min = self.MinSize,
			max = self.MaxSize,
			order = 1
		}
	})

	self:NetworkVar("Vector", 0, "BallColor", {
		KeyName = "ballcolor",
		Edit = {
			type = "VectorColor",
			order = 2
		}
	})

	self:NetworkVarNotify("BallSize", self.OnBallSizeChanged)
end

--[[---------------------------------------------------------
	Name: Initialize
-----------------------------------------------------------]]
function ENT:Initialize()
	self.LifeTime = 150
	self.DieTime = CurTime() + self.LifeTime
	self.TouchedRagdoll = false
	ParticleEffectAttach("huy", PATTACH_POINT_FOLLOW, self, 3)

	if self.Safe then
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		timer.Simple(.2, function()
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
		end)
	else
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
	end

	-- We do NOT want to execute anything below in this FUNCTION on CLIENT
	if CLIENT then return end

	timer.Simple(1, function()
		self.Safe = false
	end)

	timer.Simple(6.4, function()
		if IsValid(self) then
			self:GetPhysicsObject():SetVelocity(vector_origin)
			local Rand = math.random(1, 2)
			sound.Play("weapons/physcannon/energy_sing_explosion2.wav", self:GetPos(), 100, math.random(90, 100))

			if Rand == 1 then
				ParticleEffect("har_cb_explosion_a", self:GetPos(), self:GetAngles(), self)
			else
				ParticleEffect("har_cb_explosion_b", self:GetPos(), self:GetAngles(), self)
			end
		end
	end)

	timer.Simple(7, function()
		if IsValid(self) then
			self:Remove()
		end
	end)

	self:SetBallSize(5)
	-- Use the helibomb model just for the shadow (because it's about the same size)
	self:SetModel("models/hunter/misc/sphere025x025.mdl")
	-- We will put this here just in case, even though it should be called from OnBallSizeChanged in any case
	self:RebuildPhysics()
	-- Select a random color for the ball
	--[[self:SetBallColor( table.Random( {
		Vector( 1, 0.3, 0.3 ),
		Vector( 0.3, 1, 0.3 ),
		Vector( 1, 1, 0.3 ),
		Vector( 0.2, 0.3, 1 ),
	} ) )]]
	self.Repulsion = .01
	self:DrawShadow(false)
end

function ENT:Think()
	if CLIENT then return end
	--if CurTime()>self.SpeedUpTime then self:GetPhysicsObject():SetVelocity(self:GetPhysicsObject():GetVelocity()*1) self.SpeedUpTime=CurTime()+1 end
	local Time, SelfPos = CurTime(), self:GetPos()

	if self.DieTime < Time then
		self:Remove()

		return
	end

	--[[local Force=VectorRand()*7*self.Repulsion
	Force=Force-self:GetVelocity()/2
	for key,obj in pairs(ents.FindInSphere(SelfPos,200*self.Repulsion))do
		if(not(obj==self)and(self:Visible(obj)))then
			if(obj.HmcdGas)then
				local Vec=(obj:GetPos()-SelfPos):GetNormalized()
				Force=Force-Vec*self.Repulsion*2
			end
		end
	end
	self.Repulsion=math.Clamp(self.Repulsion+.03,0,1)
	self:GetPhysicsObject():ApplyForceCenter(Force)]]
	self:NextThink(Time + 1)

	return true
end

function ENT:RebuildPhysics(value)
	local size = math.Clamp(value or self:GetBallSize(), self.MinSize, self.MaxSize) / 5
	self:PhysicsInitSphere(size, "metal_bouncy")
	self:PhysWake()
	self:GetPhysicsObject():SetMass(1)
	self:GetPhysicsObject():EnableGravity(false)
	--self:SetCollisionGroup(COLLISION_GROUP_DEBRIS) -- don't block traces
	--self:SetCustomCollisionCheck(true) -- only collide with the World and doors
	--self:GetPhysicsObject():SetMaterial("chainlink") -- pass-through for bullets
end

function ENT:OnBallSizeChanged(varname, oldvalue, newvalue)
	-- Do not rebuild if the size wasn't changed
	if oldvalue == newvalue then return end
	self:RebuildPhysics(newvalue)
end

--[[---------------------------------------------------------
	Name: PhysicsCollide
-----------------------------------------------------------]]
local BounceSound = Sound("garrysmod/balloon_pop_cute.wav")

function ENT:PhysicsCollide(data, physobj)
	-- no sound
	--[[
	if ( data.Speed > 60 && data.DeltaTime > 0.2 ) then

		local pitch = 32 + 128 - math.Clamp( self:GetBallSize(), self.MinSize, self.MaxSize )
		sound.Play( BounceSound, self:GetPos(), 75, math.random( pitch - 10, pitch + 10 ), math.Clamp( data.Speed / 150, 0, 1 ) )

	end
	--]]
	if self.NextBounceTime < CurTime() then
		sound.Play("weapons/physcannon/energy_bounce" .. math.random(1, 2) .. ".wav", self:GetPos(), 100, math.random(90, 100))
		local edata = EffectData()
		edata:SetStart(data.HitPos)
		edata:SetOrigin(data.HitPos)
		edata:SetNormal(data.HitPos:GetNormalized())
		edata:SetEntity(self)
		edata:SetRadius(10)
		util.Effect("cball_bounce", edata, true, true)
		self.NextBounceTime = CurTime() + 0.1
	end

	-- Bounce like a crazy bitch
	local NewVelocity = physobj:GetVelocity()
	NewVelocity:Normalize()
	physobj:SetVelocity(NewVelocity * 1000)
end

--[[---------------------------------------------------------
	Name: OnTakeDamage
-----------------------------------------------------------]]
function ENT:OnTakeDamage(dmginfo)
	return 0
end

-- React physically when shot/getting blown
--self:TakePhysicsDamage( dmginfo )
--[[---------------------------------------------------------
	Name: Use
-----------------------------------------------------------]]
function ENT:Use(activator, caller)
end

--
function ENT:StartTouch(ply)
	if ply == self.Owner and self.Safe == true then return end
	local removeEnt = ply
	local owner = ply

	if HMCD_IsDoor(ply) then
		removeEnt = HMCD_BlastThatDoor(ply, (ply:GetPos() - self:GetPos()):GetNormalized() * 1000)
	elseif owner:IsPlayer() and owner:Alive() then
		if not owner.fake then
			owner:Kill()
		end

		owner.LastDamageType = HMCD_DamageTypes[DMG_DISSOLVE]
		owner.LastAttacker = self.Owner

		if IsValid(self.Owner) then
			owner.LastAttackerName = self.Owner.BystanderName or "combine soldier"
		end

		owner:Kill()
	elseif ply:GetClass() == "func_surf_breakable" then
		ply:TakeDamage(1000, self.Owner, self)
	end

	removeEnt:SetName("removeEnt_" .. removeEnt:EntIndex())
	local dis = ents.Create("env_entity_dissolver")
	dis:SetKeyValue("target", removeEnt:GetName())
	dis:SetKeyValue("dissolvetype", "0")
	dis:Spawn()
	dis:Activate()
	dis:Input("Dissolve")
end

if SERVER then return end -- We do NOT want to execute anything below in this FILE on SERVER
local matBall = Material("models/hands/hands_color")

--local matBall = Material( "sprites/sent_ball" )
function ENT:Draw()
	--[[
	render.SetMaterial( matBall )

	local pos = self:GetPos()
	local lcolor = render.ComputeLighting( pos, Vector( 0, 0, 1 ) )

	lcolor.x = ( math.Clamp( lcolor.x, 0, 1 ) + 0.5 ) * 255
	lcolor.y = ( math.Clamp( lcolor.y, 0, 1 ) + 0.5 ) * 255
	lcolor.z = ( math.Clamp( lcolor.z, 0, 1 ) + 0.5 ) * 255

	local size = 5
	render.DrawSprite( pos, size, size, Color( lcolor.x, lcolor.y, lcolor.z, 255 ) )
	--]]
	local Time = CurTime()
	render.SetMaterial(matBall)
	local pos = self:GetPos()
	local lcolor = render.ComputeLighting(pos, Vector(0, 0, 1))
	local a, size = math.Clamp(((self.DieTime - Time) / self.LifeTime) * 255, 0, 255), 10
	render.DrawSprite(pos, size, size, Color(120, 141, 17, a))
	size = math.Clamp(size + FrameTime() / 100, 0, 200)
	--self:DrawModel()
end