local function SavePoints()
    file.Write("union_points.txt", util.TableToJSON(map_points, true))
end

local function LoadPoints()
    if file.Exists("union_points.txt", "DATA") then
        map_points = util.JSONToTable(file.Read("union_points.txt", "DATA"))
    else
        map_points = {}
    end
end

function TeleportPlayerByRole(ply)
    for _, point in pairs(map_points) do
        TeleportPlayer(ply, point)
    end
end

local function AddPoint(name, pos)
    if map_points[name] then
        if !point_index then point_index = 0 end
        if point_index >= 100 then
            point_index = 0
        else
            point_index = point_index + 1
        end
        name = name .. "_" .. point_index
    else
        point_index = 0
    end

    map_points[name] = {
        map = game.GetMap(),
        name = name,
        pos = pos
    }
    SavePoints()
end

local function TeleportPlayer(ply, point)
    if point and point.pos then
        ply:SetPos(point.pos)
    else
        ply:ChatPrint("Точка не найдена!")
    end
end

local function RemoveAllPointsByName(name)
    for point_name, _ in pairs(map_points) do
        if point_name:match(name) and map_points[point_name].map == game.GetMap() then
            map_points[point_name] = nil
        end
    end
    SavePoints()
end
concommand.Add("point_get", function(ply, cmd, args)
    if !ply:IsAdmin() then return end
    PrintTable(map_points)
end)

concommand.Add("point_add", function(ply, cmd, args)
    if !ply:IsAdmin() then return end
    if #args < 1 then return end
    AddPoint(args[1], ply:GetPos())
end)

concommand.Add("point_delete", function(ply, cmd, args)
    if !ply:IsAdmin() then return end
    if #args < 1 then return end
    if args[1] then
        RemoveAllPointsByName(args[1])
        ply:ChatPrint("Все точки с именем '" .. args[1] .. "' удалены!")
    else
        ply:ChatPrint("Укажите имя точки для удаления.")
    end    
end)

LoadPoints()