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