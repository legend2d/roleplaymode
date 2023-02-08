local function createFaction(player, command, factiontype, factionname)
	if not tonumber(factiontype) or not factionname then
		outputChatBox("[-] #ffffff/createfaction [Faction Type] [Faction Name]",player,0,255,255,true) 
		outputChatBox("[-] #ffffffFaction Types: 1 (Gang), 2 (Mafia), 3 (Govenrment), 4 (Other), 5 (Has Duty)",player,0,255,255,true)
	return end
	local checkName = exports.globals:stringCheck(factionname, 10, 30)
	if not checkName then outputChatBox("[-] #ffffffBirlik ismi minimum 10, maksimum 30 değer içermeli.",player,255,0,0,true) return end
    local search = dbPoll( dbQuery( exports.mysql:dbConnect(), "SELECT * FROM factions WHERE name=?", factionname), -1 )
    if #search > 0 then outputChatBox("[-] #ffffff"..factionname.." isimli birlik zaten sunucuda mevcut.",player,255,0,0,true) return end 
	if tonumber(factiontype) < 1 or tonumber(factiontype) > 6 then outputChatBox("[-] #ffffffFaction Types: 1 (Gang), 2 (Mafia), 3 (Govenrment), 4 (Other), 5 (Has Duty)",player,0,255,255,true) return end
	dbExec(exports.mysql:dbConnect(), "INSERT INTO factions(name, type, createdby) VALUES(?,?,?)",factionname,factiontype,(getElementData(player, "account") or "N/A"))
	outputChatBox("[-] #ffffffBaşarıyla "..factionname.." isimli birlik kuruldu.",player,0,255,0,true)
end
addCommandHandler("createfaction", createFaction)

local function showFactions(player, command)
	if getElementData(player, "admin")>5 then 
		factions = {}
		dbQuery(
		function(qh)
			local res, rows, err = dbPoll(qh, 0)
			for index, row in ipairs(res) do
				table.insert(factions, { row["id"], row["name"], row["type"], #getPlayersByFaction(row["id"]) } )
			end
			triggerClientEvent(player, "showFactionsClient", player, factions)
		end, exports.mysql:dbConnect(), "SELECT * FROM factions")
	end
end
addCommandHandler("showfactions", showFactions)

local function setFactionPlayer(player, command, target, factionid)
	if getElementData(player, "admin")>5 then
	if not target or not tonumber(factionid) then outputChatBox("[-] #ffffff/setfaction [Player/ID] [Faction ID]",player,0,255,255,true) return end
	local targetp = exports.globals:findPlayerByPartialNick(target) 
	if not targetp then outputChatBox("[-] #ffffffBöyle bir oyuncu bulunamadı ya da giriş yapmamış",player,255,0,0,true) return end
	local faction = getFactionData(tonumber(factionid), "name")
	if (faction) then 
		setElementData(targetp, "faction", factionid)
		setElementData(targetp, "factionrank", 1)
		setElementData(targetp, "factionlead", 0)
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET faction=? WHERE name=?",factionid,getPlayerName(targetp))
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionrank=? WHERE name=?",1,getPlayerName(targetp))
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",0,getPlayerName(targetp))
		outputChatBox("[-] #ffffffBaşarıyla "..getPlayerName(targetp).." kişisini "..faction.." birliğine atadınız.",player,0,255,0,true)
		outputChatBox("[-] #ffffff"..getElementData(player, "account").." isimli yönetici sizi "..faction.." birliğine atadı.",targetp,0,255,0,true)
		end
	end
end
addCommandHandler("setfaction", setFactionPlayer)

local function setFactionLeadPlayer(player, command, target, factionid)
	if getElementData(player, "admin")>5 then
	if not target or not tonumber(factionid) then outputChatBox("[-] #ffffff/setfactionleader [Player/ID] [Faction ID]",player,0,255,255,true) return end
	local targetp = exports.globals:findPlayerByPartialNick(target) 
	if not targetp then outputChatBox("[-] #ffffffBöyle bir oyuncu bulunamadı ya da giriş yapmamış",player,255,0,0,true) return end
	local faction = getFactionData(tonumber(factionid), "name")
	if (faction) then 
		setElementData(targetp, "faction", factionid)
		setElementData(targetp, "factionrank", 1)
		setElementData(targetp, "factionlead", 1)
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET faction=? WHERE name=?",factionid,getPlayerName(targetp))
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionrank=? WHERE name=?",1,getPlayerName(targetp))
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",1,getPlayerName(targetp))
		outputChatBox("[-] #ffffffBaşarıyla "..getPlayerName(targetp).." kişisini "..faction.." birliğine lider atadınız.",player,0,255,0,true)
		outputChatBox("[-] #ffffff"..getElementData(player, "account").." isimli yönetici sizi "..faction.." birliğine lider atadı.",targetp,0,255,0,true)
		end
	end
end
addCommandHandler("setfactionleader", setFactionLeadPlayer)