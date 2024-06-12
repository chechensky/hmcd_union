local Ammo = {
    ["beanbag"] = {
        name = "Beanbag",
        dmgtype = DMG_CLUB, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 50,
        maxcarry = 50,
        minsplash = 0,
        maxsplash = 5
    }
}

local Ammo_Entity = {
    ["beanbag"] = {
        Icon = "entities/eft_attachments/ammo/556/hp.png",
        Material = "models/hmcd_ammobox_556",
        Scale = 1
    }
}

for k,v in pairs(Ammo) do
    game.AddAmmoType( v )
    if CLIENT then
        language.Add(v.name.."_ammo", v.name)
    end
    timer.Simple(0.1,function()
        local ammoent = {} 
        ammoent.Base = "ammo_base"
        ammoent.PrintName = v.name
        ammoent.Category = "HMCD: Union - Ammo"
        ammoent.Spawnable = true
        ammoent.AmmoCount = 10
        ammoent.AmmoType = v.name
        ammoent.ModelMaterial = Ammo_Entity[k].Material
        ammoent.ModelScale = Ammo_Entity[k].Scale
        ammoent.Color = Ammo_Entity[k].Color or nil
        scripted_ents.Register(ammoent, "ent_ammo_" .. k )
    end)
end

timer.Simple(2,function()
    game.BuildAmmoTypes()
end)