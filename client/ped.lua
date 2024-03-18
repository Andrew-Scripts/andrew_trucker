local function open()
    local options = {}

    for index, job in ipairs(Config.Locations.deliveries) do
        table.insert(options, {
            title = job.title,
            description = job.description,
            icon = job.icon or 'truck',
            arrow = job.arrow or false,
            onSelect = start,
            args = { type = 'jobs', index = index }
        })
    end
    
    lib.registerContext({
        id = 'truckerman',
        title = locale('truckerman'),
        options = options
    })

    lib.showContext('truckerman')
end

for _, coords in ipairs(Config.ped.locations) do
    Utils.createPed(coords.coords, Config.ped.model, {
        {
            label = locale('open_truckerman'),
            icon = 'comment',
            onSelect = open
        }
    })
    Utils.createBlip(coords.coords, Config.ped.blip)
end