function givePlayerMoneyAdmin(player, c, target, price)
	if getElementData(player, "admin")>6 then
		if not target or not tonumber(price) then outputChatBox("[-] #ffffff/givemoney [Player/ID] [Money]",player,0,255,0,true) return end
		local targetP = exports.globals:findPlayerByPartialNick(target)
		if not (targetP) then outputChatBox("[-] #ffffffHedef kişi bulunamadı.",player,255,0,0,true) return end
		local give_money = exports.globals:giveMoney(targetP, price)
		if (give_money) then 
			outputChatBox("[-] #ffffff"..getPlayerName(targetP).." isimli oyuncuya $"..price.." para gönderdiniz.",player,0,255,0,true)
			outputChatBox("[-] #ffffff"..getElementData(targetP, "account").." isimli yönetici hesabınıza $"..price.." para ekledi.",targetP,0,255,0,true)
		end
	end
end
addCommandHandler("givemoney", givePlayerMoneyAdmin)

function takePlayerMoneyAdmin(player, c, target, price)
	if getElementData(player, "admin")>6 then
		if not target or not tonumber(price) then outputChatBox("[-] #ffffff/takemoney [Player/ID] [Money]",player,0,255,0,true) return end
		local targetP = exports.globals:findPlayerByPartialNick(target)
		if not (targetP) then outputChatBox("[-] #ffffffHedef kişi bulunamadı.",player,255,0,0,true) return end
		local take_money = exports.globals:takeMoney(targetP, price)
		if (take_money) then 
			outputChatBox("[-] #ffffff"..getPlayerName(targetP).." isimli oyuncudan $"..price.." para kestiniz.",player,0,255,0,true)
			outputChatBox("[-] #ffffff"..getElementData(targetP, "account").." isimli yönetici hesabınızdan $"..price.." para kesti.",targetP,0,255,0,true)
		end
	end
end
addCommandHandler("takemoney", takePlayerMoneyAdmin)

function setPlayerMoneyAdmin(player, c, target, price)
	if getElementData(player, "admin")>6 then
		if not target or not tonumber(price) then outputChatBox("[-] #ffffff/setmoney [Player/ID] [Money]",player,0,255,0,true) return end
		local targetP = exports.globals:findPlayerByPartialNick(target)
		if not (targetP) then outputChatBox("[-] #ffffffHedef kişi bulunamadı.",player,255,0,0,true) return end
		local set_money = exports.globals:setMoney(targetP, price)
		if (set_money) then 
			outputChatBox("[-] #ffffff"..getPlayerName(targetP).." isimli oyuncunun parasını $"..price.." yaptınız.",player,0,255,0,true)
			outputChatBox("[-] #ffffff"..getElementData(targetP, "account").." isimli yönetici hesabınızdaki parayı $"..price.." olarak ayarladı.",targetP,0,255,0,true)
		end
	end
end
addCommandHandler("setmoney", setPlayerMoneyAdmin)

function setPlayerArmorAdmin(player, c, target, price)
	if getElementData(player, "admin")>6 then
		if not target or not tonumber(price) then outputChatBox("[-] #ffffff/setarmor [Player/ID] [Armor Value]",player,0,255,0,true) return end
		local targetP = exports.globals:findPlayerByPartialNick(target)
		if not (targetP) then outputChatBox("[-] #ffffffHedef kişi bulunamadı.",player,255,0,0,true) return end
		local set_armor = exports.globals:setArmor(targetP, price)
		if (set_armor) then 
			outputChatBox("[-] #ffffff"..getPlayerName(targetP).." isimli oyuncunun zırh değerini %"..price.." yaptınız.",player,0,255,0,true)
			outputChatBox("[-] #ffffff"..getElementData(targetP, "account").." isimli yönetici zırh değerinizi %"..price.." olarak ayarladı.",targetP,0,255,0,true)
		end
	end
end
addCommandHandler("setarmor", setPlayerArmorAdmin)

function setPlayerHealthAdmin(player, c, target, price)
	if getElementData(player, "admin")>6 then
		if not target or not tonumber(price) then outputChatBox("[-] #ffffff/sethp [Player/ID] [Health Value]",player,0,255,0,true) return end
		local targetP = exports.globals:findPlayerByPartialNick(target)
		if not (targetP) then outputChatBox("[-] #ffffffHedef kişi bulunamadı.",player,255,0,0,true) return end
		local set_hp = exports.globals:setHP(targetP, price)
		if (set_hp) then 
			outputChatBox("[-] #ffffff"..getPlayerName(targetP).." isimli oyuncunun sağlık değerini %"..price.." yaptınız.",player,0,255,0,true)
			outputChatBox("[-] #ffffff"..getElementData(targetP, "account").." isimli yönetici sağlık değerinizi %"..price.." olarak ayarladı.",targetP,0,255,0,true)
		end
	end
end
addCommandHandler("sethp", setPlayerHealthAdmin)

function setPlayerModelAdmin(player, c, target, price)
	if getElementData(player, "admin")>6 then
		if not target or not tonumber(price) then outputChatBox("[-] #ffffff/setskin [Player/ID] [Skin Value]",player,0,255,0,true) return end
		local targetP = exports.globals:findPlayerByPartialNick(target)
		if not (targetP) then outputChatBox("[-] #ffffffHedef kişi bulunamadı.",player,255,0,0,true) return end
		local set_skin = exports.globals:setSkin(targetP, price)
		if (set_skin) then 
			outputChatBox("[-] #ffffff"..getPlayerName(targetP).." isimli oyuncunun modelini ID"..price.." yaptınız.",player,0,255,0,true)
			outputChatBox("[-] #ffffff"..getElementData(targetP, "account").." isimli yönetici modelinizi ID"..price.." olarak ayarladı.",targetP,0,255,0,true)
		end
	end
end
addCommandHandler("setmodel", setPlayerModelAdmin)

function setPlayerLevelAdmin(player, c, target, price)
	if getElementData(player, "admin")>6 then
		if not target or not tonumber(price) then outputChatBox("[-] #ffffff/setlevel [Player/ID] [Level Value]",player,0,255,0,true) return end
		local targetP = exports.globals:findPlayerByPartialNick(target)
		if not (targetP) then outputChatBox("[-] #ffffffHedef kişi bulunamadı.",player,255,0,0,true) return end
		local set_level		= exports.globals:setLevel(targetP, price)
		if (set_level) then 
			outputChatBox("[-] #ffffff"..getPlayerName(targetP).." isimli oyuncunun seviyesini "..price.." yaptınız.",player,0,255,0,true)
			outputChatBox("[-] #ffffff"..getElementData(targetP, "account").." isimli yönetici seviyenizi "..price.." olarak ayarladı.",targetP,0,255,0,true)
		end
	end
end
addCommandHandler("setlevel", setPlayerLevelAdmin)

function adminInfo(p, c, ...)
	if getElementData(p, "admin")>3 then
		if not ... then outputChatBox("[-] #ffffff/"..c.." [Metin]",p,0,0,45,true) return end
		local m = table.concat({...}, " ")
		for k, server in pairs(getElementsByType("player")) do
			outputChatBox("#6699FF(( Duyuru: "..m.." ))",server,0,0,0,true)
		end
	end
end
addCommandHandler("duyuru", adminInfo)