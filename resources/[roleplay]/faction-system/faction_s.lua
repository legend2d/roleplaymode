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

function getAllRanks(factionid)
	if tonumber(factionid) then
		local ranks = {}
		local factiontype = getFactionData(factionid, "type")
		for i = 1, 20 do
		local rank = getFactionRank(factionid, i)
		table.insert(ranks, {id = i, rankname = rank})
		end
		triggerClientEvent(source, "faction_rankChange", source, ranks, factiontype)
		triggerClientEvent(source, "closeExamples", source)
	end
end
addEvent("getAllRanks", true)
addEventHandler("getAllRanks", root, getAllRanks)

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

function getOnlineFactionPlayers(factionid)
	if tonumber(factionid) then
		for id, plrs in pairs(getElementsByType("player")) do
		if tonumber(getElementData(plrs, "faction"))==factionid then
			return plrs
		end
		end
	end
end

fChat = {}

local function factionChatManage(faction)
	if (faction) then
		local players = getOnlineFactionPlayers(tonumber(faction))
		local rutbe = getFactionRank(tonumber(faction), tonumber(getPlayerFactionRank(getPlayerName(source))))
		if not fChat[faction] then
			fChat[faction] = true
			outputChatBox("#66CCCC(( OLUŞUM: "..rutbe.." "..getPlayerName(source).." tarafından birlik sohbeti açıldı. ))",players,0,0,0,true)
		else
			fChat[faction] = false
			outputChatBox("#66CCCC(( OLUŞUM: "..rutbe.." "..getPlayerName(source).." tarafından birlik sohbeti kapatıldı. ))",players,0,0,0,true)
		end
	end
end
addEvent("factionChat", true)
addEventHandler("factionChat", root, factionChatManage)

local function openFactionPanel(source)
	local example = triggerClientEvent(source, "factionPanel_example", source)
	if not getElementData(source, "factionpanel") then
	setElementData(source, "factionpanel", true)
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
	else
	triggerClientEvent(source, "closeAll", source)
	return end
end

addEventHandler("onResourceStart", root, function()
for k, players in pairs(getElementsByType("player")) do
bindKey ( players, "F3", "down", openFactionPanel )	
end
end)

function birlikAktif(player, command)
	if tonumber(getElementData(player, "faction"))>=0 then
		local factionPlayers = getPlayersByFaction(tonumber(getElementData(player, "faction"))) 
		for k, faction in pairs(factionPlayers) do
		local fact = tonumber(getElementData(player, "faction"))
		local rutbe = getFactionRank(fact, tonumber(getPlayerFactionRank(faction)))
		local online = exports.globals:findPlayerByPartialNick(faction)
		if (online) then
			on = "#FF6600"
		else
			on = "#CCCCCC"
		end
		outputChatBox(""..on..""..faction.." - Rütbe: "..rutbe.."",player,0,0,0,true)
		end
	end
end
addCommandHandler("birlikaktif", birlikAktif)

function factionChat(player, command, ...)
	local faction = getElementData(player, "faction") 
	if (faction) then
		if not fChat[faction] then 
			outputChatBox("[-] #ffffffBirlik sohbeti yöneticiler tarafından kapatıldı.",player,255,0,0,true)
		else
			if not ... then outputChatBox("[-] #ffffff/f [İleti]",player,0,255,255,true) return end
			local msg = table.concat({...}, " ")
			local factionPlayers = getOnlineFactionPlayers(tonumber(faction))
			local rutbe = getFactionRank(tonumber(faction), tonumber(getPlayerFactionRank(getPlayerName(player))))
			outputChatBox("#66CCCC(( "..rutbe.." "..getPlayerName(player)..": "..msg.." ))",factionPlayers,0,0,0,true)
		end
	end
end
addCommandHandler("f", factionChat)

