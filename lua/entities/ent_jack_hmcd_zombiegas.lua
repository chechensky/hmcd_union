--[[File Path:   gamemodes/homicide/entities/entities/ent_jack_hmcd_zombiegas.lua

--]]
AddCSLuaFile()
DEFINE_BASECLASS("base_anim")
ENT.PrintName = "Zombie gas"
ENT.ImpactSound = ""
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.MinSize = 32
ENT.MaxSize = 32
ENT.HmcdGas = true

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
	self.LifeTime = 30
	self.DieTime = CurTime() + self.LifeTime
	-- We do NOT want to execute anything below in this FUNCTION on CLIENT
	if CLIENT then return end
	self:SetBallSize(.1)
	-- Use the helibomb model just for the shadow (because it's about the same size)
	self:SetModel("models/Combine_Helicopter/helicopter_bomb01.mdl")
	-- We will put this here just in case, even though it should be called from OnBallSizeChanged in any case
	self:RebuildPhysics()

	-- Select a random color for the ball
	self:SetBallColor(table.Random({Vector(1, 0.3, 0.3), Vector(0.3, 1, 0.3), Vector(1, 1, 0.3), Vector(0.2, 0.3, 1),}))

	self.Repulsion = .01
	self:DrawShadow(false)
end

function ENT:Think()
	if CLIENT then return end
	local Time, SelfPos = CurTime(), self:GetPos()

	if self.DieTime < Time then
		self:Remove()

		return
	end

	local Force = VectorRand() * 7 * self.Repulsion
	Force = Force - self:GetVelocity() / 2

	for key, obj in pairs(ents.FindInSphere(SelfPos, 200 * self.Repulsion)) do
		if not (obj == self) and self:Visible(obj) then
			if obj.HmcdGas then
				local Vec = (obj:GetPos() - SelfPos):GetNormalized()
				Force = Force - Vec * self.Repulsion * 2
			elseif obj:IsPlayer() and obj:Alive() then
				local headpos, headang = obj:GetBonePosition(obj:LookupBone("ValveBiped.Bip01_Head1"))

				if math.abs(headpos.y - obj:GetPos().y) < 1 then
					local infectchance = 3

					if obj:GetNWString("Helmet") == "Motorcycle" then
						infectchance = infectchance * 3
					end

					if math.random(1, infectchance) == 1 then
						local mul = ((GAMEMODE.ZombieMutations["Air"] or 0) + 1) / 2
						obj:AddBacteria(35 * mul, CurTime() - 101)
					end
				end
			end
		end
	end

	self.Repulsion = math.Clamp(self.Repulsion + .03, 0, 1)
	self:GetPhysicsObject():ApplyForceCenter(Force)
	self:NextThink(Time + 1)

	return true
end

function ENT:RebuildPhysics(value)
	local size = math.Clamp(value or self:GetBallSize(), self.MinSize, self.MaxSize) / 2.1
	self:PhysicsInitSphere(size, "metal_bouncy")
	self:SetCollisionBounds(Vector(-.1, -.1, -.1), Vector(.1, .1, .1))
	self:PhysWake()
	self:GetPhysicsObject():SetMass(1)
	self:GetPhysicsObject():EnableGravity(false)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS) -- don't block traces
	self:SetCustomCollisionCheck(true) -- only collide with the World and doors
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
	-- Bounce like a crazy bitch
	local NewVelocity = physobj:GetVelocity()
	NewVelocity:Normalize()
	physobj:SetVelocity(NewVelocity * 50 * self.Repulsion)
end

--[[---------------------------------------------------------
	Name: OnTakeDamage
-----------------------------------------------------------]]
function ENT:OnTakeDamage(dmginfo)
	-- React physically when shot/getting blown
	self:TakePhysicsDamage(dmginfo)
end

--[[---------------------------------------------------------
	Name: Use
-----------------------------------------------------------]]
function ENT:Use(activator, caller)
end

--
if SERVER then return end -- We do NOT want to execute anything below in this FILE on SERVER
local matBall = Material("particle/smokestack")

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
	-- hydrogen cyanide is invisible and practically odorless
	-- but it is fun to see how the gas spreads, so let the murderer see it with sv_cheats
	if GetConVar("sv_cheats"):GetBool() then
		local Time = CurTime()
		render.SetMaterial(matBall)
		local pos = self:GetPos()
		local lcolor = render.ComputeLighting(pos, Vector(0, 0, 1))
		local a, size = math.Clamp(((self.DieTime - Time) / self.LifeTime) * 255, 0, 255), 20
		render.DrawSprite(pos, size, size, Color(lcolor.x, lcolor.y, lcolor.z, a))
		size = math.Clamp(size + FrameTime() / 100, 0, 200)
	end
end