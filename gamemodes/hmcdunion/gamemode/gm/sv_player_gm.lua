local PlayerMeta = FindMetaTable("Player")

concommand.Add("hmcd_droprequest_ammo",function(ply,cmd,args)
	Type,Amount=args[1],tonumber(args[2])
	local Amm=ply:GetAmmoCount(Type)
	if(Amm<Amount)then Amount=Amm end
	if(Amount>0)then
		ply:DropAmmo(Type,Amount)
	end
end)

function PlayerMeta:DropAmmo(type,amt)
	if not(amt)then amt=self:GetAmmoCount(type) end
	if not(amt>0)then return end
	self:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)
	self:RemoveAmmo(amt,type)
	local Ammo=ents.Create("ent_jack_hmcd_ammo")
	Ammo.HmcdSpawned=true
	Ammo.AmmoType=type
	Ammo.Rounds=amt
	Ammo:SetPos(self:GetShootPos()+self:GetAimVector()*20)
	Ammo:Spawn();Ammo:Activate()
	Ammo:GetPhysicsObject():SetVelocity(self:GetVelocity()+self:GetAimVector()*100)
end