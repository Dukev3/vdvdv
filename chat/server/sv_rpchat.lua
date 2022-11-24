--[[

  ESX RP Chat

--]]
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

-- Default chat set to ooc
AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, string.len("/")) ~= "/" then
      local pName= getIdentity(source)
      local ids = "["..source.."] "
      fal = ids.. pName.firstname .. " " .. pName.lastname
      TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.7); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
          args = { fal , message}
      })
  end
  CancelEvent()
end)

AddEventHandler("chatMessage", function(source, args, raw)
CancelEvent()
end)

 

 RegisterCommand('tweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local name = getIdentity(source)
    local steamhex = GetPlayerIdentifier(source)
    local ids = "["..source.."] "
		local id = source;
    fal = ids.. name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.7); border-radius: 3px;"><i class="fab fa-twitter"></i> {0}:<br> {1}</div>',
        args = { fal, msg }
    })
    TriggerEvent('DiscordBot:ToDiscord', 'tweetadme', 'Tweet', '```ID:'..source..' '.. GetPlayerName(id) .. ' ('..steamhex..') | Said:'..msg..'```', 'IMAGE_URL', true)
end, false)

 --[[RegisterCommand('anontweet', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(11)
    local steamhex = GetPlayerIdentifier(source)
    local name = getIdentity(source)
	local id = source;
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.7); border-radius: 3px;"><i class="fab fa-twitter"></i> @Anonymous:<br> {1}</div>',
        args = { fal, msg }
    })
            TriggerEvent('DiscordBot:ToDiscord', 'tweetadme', '[Anonymous] Tweet', '```ID:'..source..' '.. GetPlayerName(id) .. ' ('..steamhex..') | Said: '..msg..'```', 'IMAGE_URL', true)
end, false) --]]

 RegisterCommand('ad', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local steamhex = GetPlayerIdentifier(source)
    local name = getIdentity(source)
    local ids = "["..source.."] "
    local id = source
    fal = ids.. name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(214, 168, 0, 0.71); border-radius: 3px;"><i class="fas fa-ad"></i> {0}:<br> {1}<br></div>',
        args = { fal, msg }
    })
           -- TriggerEvent('DiscordBot:ToDiscord', 'tweetadme', 'Advertisement', '```ID:'..source..' '..name..' | Said: '..msg..'```', 'IMAGE_URL', true)
            TriggerEvent('DiscordBot:ToDiscord', 'tweetadme', 'Advertisement', '```ID:'..source..' '.. GetPlayerName(id) .. ' ('..steamhex..') | Said: '..msg..'```', 'IMAGE_URL', true)
end, false)


 RegisterCommand('po', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = source
    local steamhex = GetPlayerIdentifier(source)
    fal = playerName
    if xPlayer.job.name == 'police' and xPlayer.job.grade >= 4 then
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(22, 33, 66, 0.7); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> Police:<br> {1}<br></div>',
        args = { fal, msg }
    })
    TriggerEvent('DiscordBot:ToDiscord', 'tweetadme', 'Police Announcement', '```ID:'..source..' '.. GetPlayerName(id) .. ' ('..steamhex..') | Said: '..msg..'```', 'IMAGE_URL', true)
else
    TriggerClientEvent('esx_rpchat:nopermissions', source)
end
end, false)

 RegisterCommand('ems', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = source
    local steamhex = GetPlayerIdentifier(source)
    fal = playerName
    if xPlayer.job.name == 'ambulance' and xPlayer.job.grade >= 6 then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(145, 4, 4, 1); border-radius: 3px;"><i class="fas fa-ambulance"></i> Medical:<br> {1}<br></div>',
            args = { fal, msg }
        })
        TriggerEvent('DiscordBot:ToDiscord', 'tweetadme', 'EMS Announcement', '```ID:'..source..' '.. GetPlayerName(id) .. ' ('..steamhex..') | Said: '..msg..'```', 'IMAGE_URL', true)

else
TriggerClientEvent('esx_rpchat:nopermissions', source)
end
end, false) 

RegisterCommand('mec', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = source
    local steamhex = GetPlayerIdentifier(source)
    fal = playerName
    if xPlayer.job.name == 'mechanic' and xPlayer.job.grade >= 4 then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(124, 101, 53, 1); border-radius: 3px;"><i class="fas fa-car-crash"></i> Mechanic:<br> {1}<br></div>',
            args = { fal, msg }
        })
        TriggerEvent('DiscordBot:ToDiscord', 'tweetadme', 'Mechanic Announcement', '```ID:'..source..' '.. GetPlayerName(id) .. ' ('..steamhex..') | Said: '..msg..'```', 'IMAGE_URL', true)
else
TriggerClientEvent('esx_rpchat:nopermissions', source)
end
end, false) 

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end