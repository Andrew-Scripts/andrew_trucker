---@param truck { model: string | number, price: integer }
local function spawnVehicle(truck)
    local closest, dist = nil, math.huge

    for _, location in ipairs(Config.ped.locations) do
        local distance = #(location.startLocation.xyz - GetEntityCoords(cache.ped))

        if distance < dist then
            closest = location
            dist = distance
        end
    end

    if closest then
        local coords = vector3(closest.startLocation.x, closest.startLocation.y, closest.startLocation.z)

        Framework.spawnVehicle(truck.model, coords, closest.startLocation.w, function(vehicle)
            SetVehicleOwner(GetVehicleNumberPlateText(vehicle))
            TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
            SetVehicleFuel(vehicle, 100.0)
            TriggerServerEvent('andrew_trucker:registerVehicle', NetworkGetNetworkIdFromEntity(vehicle))
        end)
    end
end

---@CPoint?
local point
local shown = false

local function getPackagePrice(vehicle)
    for _, truck in ipairs(Config.Locations.deliveries) do
        if truck.model == GetEntityModel(vehicle) then
            return truck.price
        end
    end
end

local bind = lib.addKeybind({
    name = 'trucker_interaction',
    description = 'The main interaction keybind.',
    defaultKey = 'E',
    defaultMapper = 'keyboard',
    onReleased = function()
        if not point then return end

        local price = getPackagePrice(cache.vehicle)

        if not price then return end

        local confirmed = lib.alertDialog({
            header = locale('deliver'),
            content = locale('deliver_content', price),
            cancel = true,
            centered = true
        }) == 'confirm'

        if not confirmed then return end

        local netId = NetworkGetNetworkIdFromEntity(cache.vehicle)
        local success = lib.callback.await('andrew_trucker:deliverPackage', false, netId)

        if success then
            TaskLeaveAnyVehicle(cache.ped)
            ShowNotification(locale('delivered_package'), 'success')
        end
    end
})

---@param coords vector4
local function createDeliverZone(coords)
    lib.points.new({
        coords = coords,
        distance = 5.0,
        onEnter = function(self)
            point = self

            if not getPackagePrice(cache.vehicle) then return end

            ShowUI(locale('deliver_package_bind', bind:getCurrentKey()), 'rotate-left')
            shown = true
        end,
        onExit = function(self)
            if point ~= self then return end

            point = nil

            if not shown then return end

            HideUI()
            shown = false
        end
    })
end

local function rentVehicle(index)
    local truck = Config.Locations.deliveries[index]
    local confirmed = lib.alertDialog({
        header = locale('start_job'),
        content = locale('start_content', truck.price),
        centered = true,
        cancel = true
    }) == 'confirm'

    if not confirmed then return end

    local success = lib.callback.await('andrew_trucker:rentVehicle', false, index)

    if success then
        local blip = Utils.createBlip(truck.deliverLocation, {
            name = locale('deliver'),
            sprite = 1,
            color = 5,
            scale = 0.75
        })
        SetBlipRoute(blip, true)
        createDeliverZone(truck.deliverLocation)
        lib.points.new({
            coords = truck.deliverLocation,
            distance = 5.0,
            onEnter = function()
                RemoveBlip(blip)
            end
        })
        spawnVehicle(truck)
    end
end



function start(data)
    local index in data
    local item = Config.Locations.deliveries[index]
    rentVehicle(index)
end