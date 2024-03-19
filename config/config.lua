Config = {}

Config.Target = 'ox_target' -- 'ox_target' or 'prompts' (if you are using prompts, then you will need lunar_bridge)

Config.ped = {
    model = `s_m_m_cntrybar_01`,
    blip = {
        name = 'Trucker Job',
        sprite = 477,
        color = 47,
        scale = 0.75
    },

    ---@type vector4[]
    locations = {
       { coords = vector4(174.7710, -1541.7792, 29.2618, 312.7672), startLocation = vector4(189.2902, -1557.4293, 29.2358, 217.1079) },
       { coords = vector4(497.4454, -2136.8506, 5.9175, 218.1256), startLocation = vector4(519.3080, -2162.7725, 5.9867, 174.6475) },
       { coords = vector4(-645.6096, -1218.6119, 11.1338, 305.3105), startLocation = vector4(-644.7180, -1199.0930, 12.2275, 119.8040) },
    }
}

Config.Locations = {
    deliveries = {
        {
            title = 'Paleto Bay',
            description = 'Nejlepší způsob, jak vydělat hodně peněz, ale pamatujte, že to zabere hodně času.',
            
            ---@type vector4[]
            deliverLocation = vector4(5.9582, 6267.7905, 31.3186, 300.1554),
            price = 20000,
            model = `mule`
        },
        {
            title = 'Sandy Shores',
            description = 'Doručte balíček do Sandy Shores. Není to nejlepší, ale bude to stát za to.',

            ---@type vector4[]
            deliverLocation = vector4(1726.4741, 3711.4336, 34.2674, 202.6521),
            price = 10000,
            model = `mule2`
        },
        {
            title = 'Grapeseed',
            description = 'Přineste balíček do Grapeseed místnímu farmáři. Dobře vám zaplatí.',

            ---@type vector4[]
            deliverLocation = vector4(1970.1108, 4646.9585, 40.9360, 138.2880),
            price = 13000,
            model = `mule3`
        },
        {
            title = 'Lumber Yard',
            description = 'Doručte balík na Lumber Yard. Určitě vám velmi dobře zaplatí.',

            ---@type vector4[]
            deliverLocation = vector4(-568.7229, 5348.7061, 70.2413, 160.1296),
            price = 22000,
            model = `mule4`
        }
    },
    account = 'money'
}