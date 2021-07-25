ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


cf = {}
-- discord webhook --
cf.EnableDiscordLog = true
cf.DiscordWebhook = 'webookburaya'
cf.WebhookName = 'z12 logger' --webhook name
cf.WebhookAvatarUrl = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png' -- webhook avatar url


-- discord webhook --

function dclog(xPlayer, text)
	local playerName = Sanitize(xPlayer.getName())
	
	local discord_webhook = GetConvar('discord_webhook', cf.DiscordWebhook)
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
	  ["username"] = cf.WebhookName,
	  ["avatar_url"] = cf.WebhookAvatarUrl,
	  ["embeds"] = {{
		["author"] = {
		  ["name"] = playerName .. ' - ' .. xPlayer.identifier
		},
		["color"] = 1942002,
		["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
	  }}
	}
	data['embeds'][1]['description'] = text
	PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end
----------------------


local timeOut = false

local alarmTriggered = false

ESX.RegisterServerCallback('z12-weashop:vitrineReward', function(source, cb)
local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
        local item = math.random(1, #Config.VitrineRewards)
        local amount = math.random(Config.VitrineRewards[item]["amount"]["min"], Config.VitrineRewards[item]["amount"]["max"])
        xPlayer.addInventoryItem(Config.VitrineRewards[item]["item"], amount)
        dclog(xPlayer, 'GunShoptan **'..Config.VitrineRewards[item]["item"]..'** x '..amount..'  Buldu.')
end)	

ESX.RegisterServerCallback('z12-weashop:server:setVitrineState', function(source, cb, stateType, state, k)
	Config.Locations[k][stateType] = state
    TriggerClientEvent('z12-weashop:client:setVitrineState', -1, stateType, state, k)
end)

ESX.RegisterServerCallback('z12-weashop:server:setTimeout', function(source, cb)
	if not timeOut then
        timeOut = true
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('z12-weashop:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('z12-weashop:client:setAlertState', -1, false)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)


ESX.RegisterServerCallback("z12:checkcops",function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local policeOnline = 0
	for i = 1, #Players do
		local xPlayer = ESX.GetPlayerFromId(Players[i])
		if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "sheriff" then
			policeOnline = policeOnline + 1
		end
	end
	if policeOnline >= Config.RequiredCops then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Şehirde Yeterli Güvenlik Güçleri  yok!'})
	end
end)
