local factiontype = {

[1] = "Çete",
[2] = "Mafya",
[3] = "Belediye",
[4] = "Diğer",
[5] = "Departman",

}

function leaveFromFaction(player)
	if (getElementType(player)=="player") then
		local fact_name = getFactionData(getElementData(player, "faction"), "name")
		setElementData(player, "faction", -1)
		setElementData(player, "factionlead", 0)
		setElementData(player, "factionrank", 1)
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET faction=? WHERE name=?",-1,getPlayerName(player))
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionrank=? WHERE name=?",1,getPlayerName(player))
		dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",0,getPlayerName(player))
		outputChatBox("[-] #ffffff"..fact_name.." birliğinden başarıyla ayrıldınız.",player,0,255,255,true)
		triggerClientEvent(player, "closeAll", player)
	end
end
addEvent("leaveFactionEvent", true)
addEventHandler("leaveFactionEvent", root, leaveFromFaction)

function infoFromFaction(player)
	if (getElementType(player)=="player") then
		local fact_name = getFactionData(getElementData(player, "faction"), "name")
		local fact_type = getFactionData(getElementData(player, "faction"), "type")
		local have_lead = getPlayerFactionLead(getPlayerName(player))
		local fact_rank = getElementData(player, "factionrank")
		local id = getFactionData(getElementData(player, "faction"), "id")
		if tonumber(have_lead)==1 then
			perm = "Lider"
		else
			perm = "Oyuncu"
		end
		outputChatBox("[-] #ffffffBirlik: "..fact_name.." (ID"..id..") - Birlik Tipi: "..factiontype[fact_type].."",player,0,255,255,true)
		outputChatBox("[-] #ffffffMevcut: "..#getPlayersByFaction(id).." - Birlik Seviye: 1",player,0,255,255,true)
		outputChatBox("[-] #ffffffBirlik Rütbeniz: "..getFactionRank(id, fact_rank).." - Birlik Yetkisi: "..perm.."",player,0,255,255,true)
	end
end
addEvent("infoFactionEvent", true)
addEventHandler("infoFactionEvent", root, infoFromFaction)

function updateDesc(desc)
	local desc_check = exports.globals:stringCheck(desc, 0, 2500)
	if (desc_check) then
		local id = tonumber(getElementData(source, "faction"))
		dbExec(exports.mysql:dbConnect(), "UPDATE factions SET `desc`=? WHERE id=?",""..desc.."",id)
		outputChatBox("[-] #ffffffBirlik açıklaması güncellendi.",player,0,255,255,true)
		return true
	end
end
addEvent("updateFactionDesc", true)
addEventHandler("updateFactionDesc", root, updateDesc)

function updateRank(faction, rankid, rankname, rankprice)
	if tonumber(faction) then
		if rankprice then
		if not tonumber(rankprice) or not rankname then outputChatBox("[-] #ffffffRütbe ve/veya maaş alanı boş bırakılamaz.",source,255,0,0,true) return end
		local rankn = "rank"..rankid
		local rankn_price = "rank"..rankid.."price"
		dbExec(exports.mysql:dbConnect(), "UPDATE factions SET "..rankn.."=? WHERE id=?",rankname,faction)
		dbExec(exports.mysql:dbConnect(), "UPDATE factions SET "..rankn_price.."=? WHERE id=?",rankprice,faction)
		triggerClientEvent(source, "updateRankGui", source, rankid, rankname, rankprice)
		else
		if rankname=="" then outputChatBox("[-] #ffffffRütbe alanı boş bırakılamaz.",source,255,0,0,true) return end
		local rankn = "rank"..rankid
		dbExec(exports.mysql:dbConnect(), "UPDATE factions SET "..rankn.."=? WHERE id=?",rankname,faction)
		triggerClientEvent(source, "updateRankGui", source, rankid, rankname, false)
		end
	end
end
addEvent("updateFactionRank", true)
addEventHandler("updateFactionRank", root, updateRank)

function changePlayerFactionRank(target, rankid, newrankname)
	if target and rankid and newrankname then
		local target_p = exports.globals:findPlayerByPartialNick(target) or false
		local faction = getOnlineFactionPlayers(tonumber(getElementData(source, "faction")))
		if (target_p) then
			setElementData(target_p, "factionrank", rankid)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionrank=? WHERE name=?",rankid,target)
			outputChatBox("#66CCCC[B] "..getPlayerName(source).." isimli yönetici "..target.."'n rütbesini "..newrankname.." olarak değiştirdi.",faction,0,0,0,true)
		else
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionrank=? WHERE name=?",rankid,target)
			outputChatBox("#66CCCC[B] "..getPlayerName(source).." isimli yönetici "..target.."'n rütbesini "..newrankname.." olarak değiştirdi.",faction,0,0,0,true)
		end
	end
end
addEvent("changePlayerRank", true)
addEventHandler("changePlayerRank", root, changePlayerFactionRank)

function kickPlayerFromFaction(target)
	if (target) then
		local target_p = exports.globals:findPlayerByPartialNick(target) or false
		local faction = getOnlineFactionPlayers(tonumber(getElementData(source, "faction")))
		if (target_p) then
			outputChatBox("#66CCCC[B] "..getPlayerName(source).." isimli yönetici "..target.." kişisini birlikten kovdu.",faction,0,0,0,true)
			triggerClientEvent(target_p, "closeAll", target_p)
			setElementData(target_p, "faction", -1)
			setElementData(target_p, "factionrank", 1)
			setElementData(target_p, "factionlead", 0)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET faction=? WHERE name=?",-1,target)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionrank=? WHERE name=?",0,target)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",0,target)
			triggerClientEvent(faction, "closeAll", faction)
		else
			outputChatBox("#66CCCC[B] "..getPlayerName(source).." isimli yönetici "..target.." kişisini birlikten kovdu.",faction,0,0,0,true)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET faction=? WHERE name=?",-1,target)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionrank=? WHERE name=?",0,target)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",0,target)
			triggerClientEvent(faction, "closeAll", faction)
		end
	end
end
addEvent("kickPlayerFaction", true)
addEventHandler("kickPlayerFaction", root, kickPlayerFromFaction)

function leadPlayerFromFaction(target)
	if (target) then
		local target_p = exports.globals:findPlayerByPartialNick(target) or false
		local faction = getOnlineFactionPlayers(tonumber(getElementData(source, "faction")))
		if (target_p) then
			if tonumber(getElementData(target_p, "factionlead"))==0 then
			setElementData(target_p, "factionlead", 1)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",1,target)
			else
			setElementData(target_p, "factionlead", 0)
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",0,target)
			end
			triggerClientEvent(target_p, "closeAll", target_p)
		else
			local leads = exports.globals:getPlayerCharacterData(tostring(target), "factionlead")
			if tonumber(leads)==0 then
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",1,target)
			else
			dbExec(exports.mysql:dbConnect(), "UPDATE karakterler SET factionlead=? WHERE name=?",0,target)
			end
		end
	end
end
addEvent("leadPlayerFaction", true)
addEventHandler("leadPlayerFaction", root, leadPlayerFromFaction)

function invitePlayerToFactionFunction(id, faction)
	local target_p = exports.globals:findPlayerByPartialNick(id) or false
	local factname = getFactionData(tonumber(faction), "name")
	if not target_p then outputChatBox("[-] #ffffffBirliğe davet etmek istediğiniz oyuncu bulunamadı.",source,255,0,0,true) return end
	if tonumber(getElementData(target_p, "faction"))>=0 then outputChatBox("[-] #ffffffDavet ettiğiniz oyuncu başka bir birlikte.",source,255,0,0,true) return end
	triggerClientEvent(target_p, "inviteScreenGUI", target_p, source, factname, tonumber(faction))
end
addEvent("invitePlayerToFaction", true)
addEventHandler("invitePlayerToFaction", root, invitePlayerToFactionFunction)