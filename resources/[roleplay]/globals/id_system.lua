function setNewPlayer()
	players = getElementsByType("player")
	for id,p in ipairs(players) do
	local new_id = id
	setPlayerName(source, "Kullanici#"..new_id.."")
	setElementData(source, "id", new_id)
	outputDebugString(""..getPlayerName(source).." oyuna katıldı, ID: "..getElementData(source, "id").."")
	break
end
end
addEventHandler("onPlayerJoin", root, setNewPlayer)

function findIDByPlayer(player)
	if player then
		local player = exports.globals:findPlayerByName(player)
		local theid
		players = getElementsByType("player")
		for id,p in ipairs(players) do
			if player == p then
				theid = id
			end
		end
		return theid
	else return false end
end

function findPlayerByID(theID)
	if theID then
		theID = tonumber(theID)
		local theplayer
		players = getElementsByType("player")
		for id,p in ipairs(players) do
			if theID == id then
				theplayer = p
			end
		end
		return theplayer
	else return false end
end

function findPlayerByPartialNick(element)
	local target
	if tonumber(element) then
	local target = exports.globals:findPlayerByID(element)
	return target
	elseif element then
	local target = exports.globals:findPlayerByName(element)
	return target
end
end