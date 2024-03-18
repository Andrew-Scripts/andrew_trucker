local pending = {}
local spawned = {}

lib.callback.register('andrew_trucker:rentVehicle', function(source, index)
    local player = Framework.getPlayerFromId(source)

    if not player then return end

    local vehicle = Config.Locations.deliveries[index]

    pending[source] = true

    return true
end)

RegisterNetEvent('andrew_trucker:registerVehicle', function(netId)
    local source = source

    if pending[source] then
        spawned[netId] = true
        pending[source] = nil
    end
end)

local function getPackagePrice(vehicle)
    for _, truck in ipairs(Config.Locations.deliveries) do
        if truck.model == GetEntityModel(vehicle) then
            return truck.price
        end
    end
end

lib.callback.register('andrew_trucker:deliverPackage', function(source, netId)
    local player = Framework.getPlayerFromId(source)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    local price = getPackagePrice(vehicle)
    
    if not player
    or not price
    or not spawned[netId]
    or GetPedInVehicleSeat(vehicle, -1) ~= GetPlayerPed(source) then
        return
    end

    player:addAccountMoney(Config.Locations.account, price)
    spawned[netId] = nil

    SetTimeout(1500, function()
        DeleteEntity(vehicle)
    end)

    return true
end)