function getPlayersByFaction(factionid)
	if tonumber(factionid) then
		local factionPlayers = {}
		local findFaction = dbPoll( dbQuery( exports.mysql:dbConnect(), "SELECT * FROM karakterler WHERE faction=?", factionid), -1 )
		for k, players in pairs(findFaction) do
			table.insert(factionPlayers, players.name)
		end
		return factionPlayers
	end
end

function getFactionData(factionid, data)
	if tonumber(factionid) and data then
		local findFaction = dbPoll( dbQuery( exports.mysql:dbConnect(), "SELECT * FROM factions WHERE id=?", factionid), -1 )
		for rid, row in ipairs (findFaction) do
		for column, value in pairs (row) do 
			if column == data then
				return value
			end	
		end
		end
	end
end

function getFactionRank(faction, rankid)
	if tonumber(faction) and tonumber(rankid) then
		local findFaction = dbPoll( dbQuery( exports.mysql:dbConnect(), "SELECT * FROM factions WHERE id=?", faction), -1 )
		for rid, row in ipairs (findFaction) do
		for column, value in pairs (row) do 
		if column=="rank"..rankid.."" and value then
		return value
		end
		end
		end
	end
end
addEvent("getFactionRank", true)
addEventHandler("getFactionRank", root, getFactionRank)

function getPlayerFactionRank(player)
	if(player) then
		local findPlayer = dbPoll( dbQuery( exports.mysql:dbConnect(), "SELECT * FROM karakterler WHERE name=?", player), -1 )
		for k, player in pairs(findPlayer) do
			local rank = player.factionrank
			return rank
		end
	end
end
addEvent("getPlayerFactionRank", true)
addEventHandler("getPlayerFactionRank", root, getPlayerFactionRank)

function getPlayerFactionLead(player)
	if(player) then
		local findPlayer = dbPoll( dbQuery( exports.mysql:dbConnect(), "SELECT * FROM karakterler WHERE name=?", player), -1 )
		for k, player in pairs(findPlayer) do
			local lead = player.factionlead
			return lead
		end
	end
end
addEvent("getPlayerFactionLead", true)
addEventHandler("getPlayerFactionLead", root, getPlayerFactionLead)

local function openFactionPanel(source)
	local factionPlayers = {}
	if tonumber(getElementData(source, "faction"))<0 then outputChatBox("[-] #ffffffHerhangi bir oluşumda bulunmuyorsunuz.",source,255,0,0,true) return end
	local faction = getElementData(source, "faction") 
	local factionlist = getPlayersByFaction(faction)
	for k, players in pairs(factionlist) do
	local rutbe = getFactionRank(tonumber(faction), tonumber(getPlayerFactionRank(players)))
	local cek = exports.globals:findPlayerByPartialNick(players)
	local lider = getPlayerFactionLead(players)
	if lider == 1 then
	lead = "Evet"
	else
	lead = "Hayır"
	end
	if (cek) then
		onlined = "Aktif"
	else
		onlined = "Çevrimdışı"
	end
	table.insert(factionPlayers, {player = players, rank = rutbe, online = onlined, leader = lead, rankint = getPlayerFactionRank(players)})
	end
	table.sort(factionPlayers, function(a, b) return a.rankint > b.rankint end )
	local factname, factdesc = getFactionData(tonumber(faction), "name"), getFactionData(tonumber(faction), "desc")
	triggerClientEvent(source, "factionPanel", source, faction, factname, factionPlayers, factdesc)
end

addEventHandler("onResourceStart", root, function()
for k, players in pairs(getElementsByType("player")) do
bindKey ( players, "F3", "down", openFactionPanel )	
end
end)