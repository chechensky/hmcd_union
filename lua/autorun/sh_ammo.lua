
local ammotypes = {
    ["556x45mm"] = {
        name = "5.56x45 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 200,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    },
    ["762x51mmNATO"] = {
        name = "7.62x51 NATO",
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 300,
        maxcarry = 150,
        minsplash = 10,
        maxsplash = 5
    },
    ["762x54mm"] = {
        name = "7.62x54 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 350,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    },

    ["127x99mm"] = {
        name = "12.7x99 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 200,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    },

    ["nail"] = {
        name = "Nails",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE,
        plydmg = 0,
        npcdmg = 0,
        force = 200,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    },

    ["762x39mm"] = {
        name = "7.62x39 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 400,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    },

    ["545x39mm"] = {
        name = "5.45x39 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 160,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    },

    ["12/70gauge"] = {
        name = "12/70 gauge",
        dmgtype = DMG_BUCKSHOT, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 350,
        maxcarry = 46,
        minsplash = 10,
        maxsplash = 100
    },

    ["12/70rip"] = {
        name = "12/70 Rip",
        dmgtype = DMG_BUCKSHOT, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 400,
        maxcarry = 46,
        minsplash = 10,
        maxsplash = 40
    },

    ["12/70beanbag"] = {
        name = "12/70 beanbag",
        dmgtype = DMG_BUCKSHOT, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 350,
        maxcarry = 46,
        minsplash = 10,
        maxsplash = 5
    },

    ["9х19mm"] = {
        name = "9х19 mm Parabellum",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 80,
        minsplash = 10,
        maxsplash = 5
    },

    ["9х18mm"] = {
        name = "9х18 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 110,
        maxcarry = 80,
        minsplash = 15,
        maxsplash = 10
    },

    [".45rubber"] = {
        name = ".45 Rubber",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 80,
        minsplash = 10,
        maxsplash = 5
    },

    ["46x30mm"] = {
        name = "4.6x30 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 120,
        minsplash = 10,
        maxsplash = 5
    },
    
    ["57x28mm"] = {
        name = "5.7x28 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 150,
        minsplash = 10,
        maxsplash = 5
    },

    [".44magnum"] = {
        name = ".44 Remington Magnum",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 150,
        minsplash = 10,
        maxsplash = 5
    },

    [".50ae"] = {
        name = ".50 AE Magnum",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 150,
        minsplash = 10,
        maxsplash = 5
    },

    [".308winchester"] = {
        name = ".308 Winchester",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 150,
        minsplash = 10,
        maxsplash = 5
    },

    [".45acp"] = {
        name = ".45 acp",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_LINE_AND_WHIZ,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 150,
        minsplash = 10,
        maxsplash = 5
    },

    ["9x39mm"] = {
        name = "9x39 mm",
        dmgtype = DMG_BULLET, 
        tracer = TRACER_NONE,
        plydmg = 0,
        npcdmg = 0,
        force = 100,
        maxcarry = 150,
        minsplash = 10,
        maxsplash = 5
    },
}

local ammoents = {
    ["556x45mm"] = {
        Icon = "entities/eft_attachments/ammo/556/hp.png",
        Material = "models/hmcd_ammobox_556",
        Scale = 1.2
    },

    ["408cheyennetactical"] = {
        Icon = "entities/eft_attachments/ammo/556/rrlp.png",
        Material = "models/hmcd_ammobox_556",
        Scale = 1.2
    },

    ["762x54mm"] = {
        Icon = "entities/eft_attachments/ammo/762x54r/bs.png",
        Material = "models/hmcd_ammobox_556",
        Scale = 1.2
    },
    ["762x51mmNATO"] = {
        Icon = "entities/eft_attachments/ammo/762x51/m61.png",
        Material = "models/hmcd_ammobox_556",
        Scale = 1,
        Color = Color(212,189,58)
    },
    ["127x99mm"] = {
        Icon = "entities/eft_attachments/ammo/762x51/std.png",
        Material = "models/hmcd_ammobox_792",
        Scale = 1.6,
        Color = Color(86,58,212)
    },

    ["nail"] = {
        Icon = "vgui/hud/hmcd_nail",
        Material = "models/hmcd_ammobox_nails",
        Scale = 1.6,
    },

    ["762x39mm"] = {
        Icon = "entities/eft_attachments/ammo/762x39/hp.png",
        Material = "models/hmcd_ammobox_792",
        Scale = 1,
        Color = Color(95,95,95)
    },

    ["545x39mm"] = {
        Icon = "entities/eft_attachments/ammo/556/fmj.png",
        Material = "models/hmcd_ammobox_792",
        Scale = 0.8,
        Color = Color(125,155,95)
    },

    ["12/70gauge"] = {
        Icon = "entities/eft_attachments/ammo/12x70/bmg.png",
        Material = "models/hmcd_ammobox_12",
        Scale = 1.1,
    },

    ["12/70rip"] = {
        Icon = "entities/eft_attachments/ammo/12x70/rip.png",
        Material = "models/hmcd_ammobox_12",
        Scale = 1.1,
    },

    ["12/70beanbag"] = {
        Icon = "entities/eft_attachments/ammo/12x70/ftx.png",
        Material = "models/hmcd_ammobox_12",
        Scale = 0.9,
        Color = Color(255,155,55)
    },

    ["9х19mm"] = {
        Icon = "entities/eft_attachments/ammo/9x19/psogzh.png",
        Material = "models/hmcd_ammobox_9",
        Scale = 0.8,
    },
    ["9х18mm"] = {
        Icon = "entities/eft_attachments/ammo/9x19/psogzh.png",
        Material = "models/hmcd_ammobox_9",
        Scale = 0.8,
    },
    [".45rubber"] = {
        Icon = "entities/eft_attachments/ammo/9x19/quake.png",
        Material = "models/hmcd_ammobox_38",
        Scale = 0.8,
    },

    ["46x30mm"] = {
        Icon = "entities/eft_attachments/ammo/762x39/maiap.png",
        Material = "models/hmcd_ammobox_22",
        Scale = 1,
    },

    [".44magnum"] = {
        Icon = "entities/eft_attachments/ammo/9x19/lugercci.png",
        Material = "models/hmcd_ammobox_22",
        Scale = 0.8,
    },

    [".50ae"] = {
        Icon = "entities/eft_attachments/ammo/9x19/pstgzh.png",
        Material = "models/hmcd_ammobox_22",
        Scale = 1,
        Color = Color(212,189,58)
    },

    [".308winchester"] = {
        Icon = "entities/eft_attachments/ammo/762x51/m80.png",
        Material = "models/hmcd_ammobox_38",
        Scale = 1,
        Color = Color(212,189,58)
    },

    [".45acp"] = {
        Icon = "entities/eft_attachments/ammo/45acp/hydra.png",
        Material = "models/hmcd_ammobox_9",
        Scale = 1,
        Color = Color(86,58,212)
    },

    ["9x39mm"] = {
        Icon = "entities/eft_attachments/ammo/556/sost.png",
        Material = "models/hmcd_ammobox_9",
        Scale = 0.9,
        Color = Color(125,155,95)
    },
    
    ["57x28mm"] = {
        Icon = "entities/eft_attachments/ammo/556/warma.png",
        Material = "models/hmcd_ammobox_22",
        Scale = 1.2,
        Color = Color(125,155,95)
    },
}

print("yea!")
for k,v in pairs(ammotypes) do
    --PrintTable(v)
    game.AddAmmoType( v )
    if CLIENT then
        language.Add(v.name.."_ammo", v.name)
    end
    timer.Simple(1,function()
    local ammoent = {} 
    ammoent.Base = "ammo_base"
    ammoent.PrintName = v.name
    ammoent.Category = "CHBOX - Ammos"
    ammoent.Spawnable = true
    ammoent.AmmoCount = 10
    ammoent.AmmoType = v.name
    ammoent.IconOverride = ammoents[k].Icon
    ammoent.ModelMaterial = ammoents[k].Material
    ammoent.ModelScale = ammoents[k].Scale
    ammoent.Color = ammoents[k].Color or nil

    scripted_ents.Register( ammoent, "ent_ammo_"..k )
    end)
end

timer.Simple(1,function()
    game.BuildAmmoTypes()
    PrintTable(game.GetAmmoTypes())
end)

if CLIENT then
    local blurMat = Material("pp/blurscreen")
    local Dynamic = 0 
    local function BlurBackground(panel)
        if not((IsValid(panel))and(panel:IsVisible()))then return end
        local layers,density,alpha=1,1,255
        local x,y=panel:LocalToScreen(0,0)
        surface.SetDrawColor(255,255,255,alpha)
        surface.SetMaterial(blurMat)
        local FrameRate,Num,Dark=1/FrameTime(),5,150
        for i=1,Num do
            blurMat:SetFloat("$blur",(i/layers)*density*Dynamic)
            blurMat:Recompute()
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(-x,-y,ScrW(),ScrH())
        end
        surface.SetDrawColor(0,0,0,Dark*Dynamic)
        surface.DrawRect(0,0,panel:GetWide(),panel:GetTall())
        Dynamic=math.Clamp(Dynamic+(1/FrameRate)*7,0,1)
    end

    function AmmoMenu(ply)
        local ammodrop = 0
        if !ply:Alive() then return end
        local Frame = vgui.Create( "DFrame" )
        local trace = LocalPlayer():GetEyeTrace()
        Frame:SetTitle( "Меню патрон" )
        Frame:SetSize( 220,320 )
        Frame:Center()			
        Frame:MakePopup()
        Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
            --draw.RoundedBox( 5, 0, 0, w, h, Color( 5, 5, 5, 225 ) ) -- Draw a red box instead of the frame
            BlurBackground(Frame)
        end
        local DPanel = vgui.Create( "DScrollPanel", Frame )
        DPanel:SetPos( 5, 30 ) -- Set the position of the panel
        DPanel:SetSize( 190, 215 ) -- Set the size of the panel
        DPanel.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
            BlurBackground(DPanel)
        end

        local sbar = DPanel:GetVBar()
        function sbar:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(115, 115, 115))
        end
        function sbar.btnUp:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(155, 145, 145))
        end
        function sbar.btnDown:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(145, 145, 145))
        end
        function sbar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(195, 195, 195))
        end


        local DermaNumSlider = vgui.Create( "DNumSlider", Frame )
        DermaNumSlider:SetPos( 10, 245 )				
        DermaNumSlider:SetSize( 210, 25 )			
        DermaNumSlider:SetText( "Кол-во" )	
        DermaNumSlider:SetMin( 0 )				 	
        DermaNumSlider:SetMax( 60 )				
        DermaNumSlider:SetDecimals( 0 )				

        -- If not using convars, you can use this hook + Panel.SetValue()
        DermaNumSlider.OnValueChanged = function( self, value )
            ammodrop = math.Round(value)
        end 

        local ammos = LocalPlayer():GetAmmo()
        for k,v in pairs(ammos) do
            local DermaButton = vgui.Create( "DButton", DPanel ) 
            DermaButton:SetText( game.GetAmmoName( k )..": "..v )	
            DermaButton:SetTextColor( Color(255,255,255) )				
            DermaButton:SetPos( 0, 0 )	
            DermaButton:Dock( TOP )
            DermaButton:DockMargin( 5, 5, 5, 0 )				
            DermaButton:SetSize( 120, 20 )	
            DermaButton.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 155) )
            end				
            DermaButton.DoClick = function()		
                net.Start( "DropAmmos" )
                    net.WriteFloat( k )
                    net.WriteFloat( math.min(ammodrop,v) )
                net.SendToServer()
                Frame:Close()
            end

            DermaButton.DoRightClick = function()
                net.Start( "DropAmmos" )
                    net.WriteFloat( k )
                    net.WriteFloat( math.min(v,v) )
                net.SendToServer()
                Frame:Close()	
            end
            DermaButton.DoMiddleClick = function()
                if trace.Hit and trace.Entity:IsPlayer() then
                    net.Start("GiveAmmo")
                        net.WriteEntity(trace.Entity)
                        net.WriteFloat( k )
                        net.WriteFloat( math.min(ammodrop,v) )
                    net.SendToServer()
                    Frame:Close()
                end
            end
        end
        local DLabel = vgui.Create( "DLabel", Frame )
        DLabel:SetPos( 10, 270 )
        DLabel:SetText( "Левая кнопка Мыши - Скинуть Кол-во\nПравая кнопка - Скинуть все\nКолесико Мыши - Отдать игроку Кол-во" )
        DLabel:SetTextColor(Color(255,255,255))
        DLabel:SizeToContents()

    end

    concommand.Add( "menu_ammo", function( ply, cmd, args )
        AmmoMenu(ply)
    end )
end