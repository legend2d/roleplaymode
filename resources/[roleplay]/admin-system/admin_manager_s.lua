local db = exports.mysql:dbConnect()

function isPlayerOnline(NAME)
return getPlayerFromName(NAME) ~= false;
end

function openManagerPanel(p, c)
	if getElementData(p, "admin")>=6 then
		triggerClientEvent(p, "managerPanelClient", p)
	end
end
addCommandHandler("staffs", openManagerPanel)

function mysqlAuthCheck(username)
    local qh = dbQuery( db, "SELECT * FROM accounts WHERE account=?", username)
    local result = dbPoll( qh, -1 )
    if #result > 0 then  
    	triggerClientEvent(source, "updateCheck", source, result[1].account, result[1].bakiye, result[1].karakter1, result[1].karakter2, result[1].karakter3, result[1].admin, result[1].support)
    else
    	triggerClientEvent(source, "loginerr", source, "Arattığınız isim veritabanında bulunamadı, başka bir isim deneyin.")
    end
end
addEvent("manager:userCheck", true)
addEventHandler("manager:userCheck", root, mysqlAuthCheck)

function mysqlAuthPermissionCheck(username)
    local qh = dbQuery( db, "SELECT * FROM accounts WHERE account=?", username)
    local result = dbPoll( qh, -1 )
    if #result > 0 then  
    	triggerClientEvent(source, "updatePermissionCheck", source, result[1].account, result[1].admin, result[1].support)
    else
    	triggerClientEvent(source, "loginerr", source, "Arattığınız isim veritabanında bulunamadı, başka bir isim deneyin.")
    end
end
addEvent("manager:userPermissionCheck", true)
addEventHandler("manager:userPermissionCheck", root, mysqlAuthPermissionCheck)

function updateUserPermission(username, adminseviye, supportseviye)
    local qh = dbQuery( db, "SELECT * FROM accounts WHERE account=?", username)
    local result = dbPoll( qh, -1 )
    if #result > 0 then  
    	dbExec(db, "UPDATE accounts SET admin=? WHERE account=?",adminseviye,username)
    	dbExec(db, "UPDATE accounts SET support=? WHERE account=?",supportseviye,username)
    	outputChatBox("[!] #ffffffBaşarıyla "..username.." kullanıcısının yetkilerini güncellediniz.",source,0,255,0,true)
    	local targetPlayer = exports.globals:findPlayerByAccount(username)
    	if (targetPlayer) then
    		setElementData(targetPlayer, "admin", adminseviye)
    		setElementData(targetPlayer, "support", supportseviye)
    		outputChatBox("[!] #ffffffOyun yetkileriniz "..getElementData(source, "account").." tarafından güncellendi.",targetPlayer,0,255,0,true)
    	end
    else
    	triggerClientEvent(source, "loginerr", source, "Arattığınız isim veritabanında bulunamadı, başka bir isim deneyin.")
    end
end
addEvent("manager:updateUserPermission", true)
addEventHandler("manager:updateUserPermission", root, updateUserPermission)

function isimbul(plr,cmd,id)
	if tonumber(id) then
    local target = exports.globals:findPlayerByID(id)
    if (target) then
    local seviye = getElementData(target, "level") or 0
    outputChatBox("[-] #ffffffID"..id.." "..getPlayerName(target).." - Seviye: "..seviye.."",plr,0,255,0,true)
    else
    outputChatBox("[!] #ffffffAramak istediğiniz oyuncu bulunamadı.",plr,255,0,0,true)
    return end
    elseif (id) then
    local target = exports.globals:findIDByPlayer(id)
    local target_t = exports.globals:findPlayerByID(target)
    if (target) then
    local seviye = getElementData(target_t, "level") or 0
    outputChatBox("[-] #ffffffID"..target.." "..getPlayerName(target_t).." - Seviye: "..seviye.."",plr,0,255,0,true)
    else
    outputChatBox("[!] #ffffffAramak istediğiniz oyuncu bulunamadı.",plr,255,0,0,true)
    return end
    else
    outputChatBox("[!] #ffffffAramak istediğiniz oyuncu bulunamadı.",plr,255,0,0,true)
    return end
end
addCommandHandler("id", isimbul)