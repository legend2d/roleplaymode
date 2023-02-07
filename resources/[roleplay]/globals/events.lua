local db = exports.mysql:dbConnect()

function giveMoney(player, miktar)
	if player and tonumber(miktar) then
		local karakter = getPlayerName(player)
		local mevcut = getElementData(player, "money")
		setElementData(player, "money", mevcut+miktar)
		givePlayerMoney(player, miktar)
		dbExec(db, "UPDATE karakterler SET money=? WHERE name=?",mevcut+miktar,karakter)
		return true
	end
end

function takeMoney(player, miktar)
	if player and tonumber(miktar) then
		local karakter = getPlayerName(player)
		local mevcut = getElementData(player, "money")
		if (tonumber(mevcut)<tonumber(miktar)) then return false end
		setElementData(player, "money", mevcut-miktar)
		takePlayerMoney(player, miktar)
		dbExec(db, "UPDATE karakterler SET money=? WHERE name=?",mevcut-miktar,karakter)
		return true
	end
end

function setMoney(player, miktar)
	if player and tonumber(miktar) then
		local karakter = getPlayerName(player)
		local mevcut = getElementData(player, "money")
		setElementData(player, "money", miktar)
		setPlayerMoney(player, miktar)
		dbExec(db, "UPDATE karakterler SET money=? WHERE name=?",miktar,karakter)
		return true
	end
end

function setArmor(player, miktar)
	if player and tonumber(miktar) then
		local karakter = getPlayerName(player)
		local mevcut = getElementData(player, "armor")
		setElementData(player, "armor", miktar)
		setPlayerArmor(player, miktar)
		dbExec(db, "UPDATE karakterler SET armor=? WHERE name=?",miktar,karakter)
		return true
	end
end

function setHP(player, miktar)
	if player and tonumber(miktar) then
		local karakter = getPlayerName(player)
		local mevcut = getElementData(player, "hp")
		setElementData(player, "hp", miktar)
		setElementHealth(player, miktar)
		dbExec(db, "UPDATE karakterler SET hp=? WHERE name=?",miktar,karakter)
		return true
	end
end

function setSkin(player, miktar)
	if player and tonumber(miktar) then
		local change_skin = setElementModel(player, miktar)
		if (change_skin) then
		local karakter = getPlayerName(player)
		setElementData(player, "skin", miktar)
		dbExec(db, "UPDATE karakterler SET skin=? WHERE name=?",miktar,karakter)
		return true
		end
	end
end

function getPlayerCharacterData(character, data)
	if (character) and (data) then
		local qh = dbQuery( db, "SELECT * FROM karakterler WHERE name=?", character)
   	 	local result = dbPoll( qh, -1 )
    	if #result > 0 then  
    		return result[1].data
		end
	end
end

function setLevel(player, miktar)
	if player and tonumber(miktar) then
		local karakter = getPlayerName(player)
		setElementData(player, "level", miktar)
		dbExec(db, "UPDATE karakterler SET level=? WHERE name=?",miktar,karakter)
		return true
	end
end

function stringCheck(word, min, max)
	if #word >= min and #word <= max then
		return true
	else
		return false
	end
end