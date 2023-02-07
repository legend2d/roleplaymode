previewPed = {}
local db = exports.mysql:dbConnect()


function createCharactherServer(u)
	setCameraMatrix(source, -2665.09106, 1410.49072, 908.30750, -2669.81885, 1410.48303, 907.57031)
	setElementInterior(source, 3)
	setElementDimension(source, math.random(300,65000))
	previewPed[source] = createPed(70, -2670.60352, 1410.39258, 907.57031)
	setElementInterior(previewPed[source], 3)
	setElementDimension(previewPed[source], getElementDimension(source))
	setPedRotation(previewPed[source], -90)
	triggerClientEvent(source, "first:client", source)
end
addEvent("createCharacther:Server", true)
addEventHandler("createCharacther:Server", root, createCharactherServer)

function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end

function skinDegisIleri(cinsiyet)
	if cinsiyet == "Erkek" then
		local skinler = table.random(erkek)
		setElementModel(previewPed[source], skinler)
		setElementData(source, "ssd", skinler)
    else
    	local skinler = table.random(kadin)
    	setElementModel(previewPed[source], skinler)
    	setElementData(source, "ssd", skinler)
    end
end
addEvent("skinDegisIleri", true)
addEventHandler("skinDegisIleri", root, skinDegisIleri)

function skinAcceptDefault(c)
	if c == "Erkek" then
		setElementModel(previewPed[source], 70)
		setElementData(source, "ssd", 70)
	else
		setElementModel(previewPed[source], 40)
		setElementData(source, "ssd", 40)
	end
end
addEvent("skinDefault", true)
addEventHandler("skinDefault", root, skinAcceptDefault)

function karakterOlustur(skin, yas, kilo, uzunluk, isim, irk, cinsiyet)
	outputChatBox(isim)
	if not tonumber(yas) or not tonumber(kilo) or not tonumber(uzunluk) then 
		triggerClientEvent(source, "loginerr", source, "Lütfen yaşınızı, kilonuzu ve boyunuzu sayısal (girdiğinizden) emin olun ve tekrar deneyin.")
	end
	if tonumber(yas)>18 and tonumber(yas)<100 and tonumber(kilo)>50 and tonumber(kilo)<151 and tonumber(uzunluk) > 110 and tonumber(uzunluk)<191 then

	else
	triggerClientEvent(source, "loginerr", source, "Minumum yaş 18, maksimum yaş 99. Minimum kilo 50, maksimum kilo 150. Minimum boy 110, maksimum boy 190.")
	return end
	local characterName = string.gsub(tostring(isim), " ", "_")
	local qh = dbQuery( db, "SELECT * FROM karakterler WHERE name=?", characterName)
    local result = dbPoll( qh, -1 )
    if #result > 0 then triggerClientEvent(source, "loginerr", source, "Bu karakter ismi sunucuda zaten kullanılıyor, değiştirmelisiniz.") return end
	dbExec(db, "INSERT INTO karakterler(owner, name, age, gender, weight, height, race, x, y, z, interior, dimension, hp, armor, money, skin) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",getElementData(source, "account"), characterName, yas, cinsiyet, kilo, uzunluk, irk, 1945.00586, -1791.48901, 13.38281, 0, 0, 100, 0, 250, skin)
	if getElementData(source, "karakter1") == "Yok" then
	dbExec(db, "UPDATE accounts SET karakter1=? WHERE account=?", characterName, getElementData(source, "account"))
	local qh = dbQuery( db, "SELECT * FROM karakterler WHERE name=?", characterName)
    local result = dbPoll( qh, -1 )
	dbExec(db, "UPDATE accounts SET karakter1dbid=? WHERE account=?",result[1].dbid, getElementData(source, "account"))
	setElementData(source, "karakter1dbid", result[1].dbid)
	elseif getElementData(source, "karakter2") == "Yok" then 
	dbExec(db, "UPDATE accounts SET karakter2=? WHERE account=?", characterName, getElementData(source, "account"))
	local qh = dbQuery( db, "SELECT * FROM karakterler WHERE name=?", characterName)
    local result = dbPoll( qh, -1 )
	setElementData(source, "karakter2dbid", result[1].dbid)
	dbExec(db, "UPDATE accounts SET karakter2dbid=? WHERE account=?",result[1].dbid, getElementData(source, "account"))
	elseif getElementData(source, "karakter3") == "Yok" then
	dbExec(db, "UPDATE accounts SET karakter3=? WHERE account=?", characterName, getElementData(source, "account"))
	local qh = dbQuery( db, "SELECT * FROM karakterler WHERE name=?", characterName)
    local result = dbPoll( qh, -1 )
	dbExec(db, "UPDATE accounts SET karakter3dbid=? WHERE account=?",result[1].dbid, getElementData(source, "account"))
	setElementData(source, "karakter3dbid", result[1].dbid)
	end 
	destroyElement(previewPed[source])
	local result = dbPoll ( dbQuery ( db,'SELECT * FROM `karakterler` WHERE name=?',characterName),-1 )
	for rid, row in ipairs (result) do
    for column, value in pairs (row) do 
    if column ~= "password" then
    setElementData(source, column, value)
    end
	end
    end
	joinServer(source)
end
addEvent("karakterYarat", true)
addEventHandler("karakterYarat", root, karakterOlustur)

function joinServer(source)
	local x, y, z =  getElementData(source, "x"),  getElementData(source, "y"),  getElementData(source, "z")
	local int, dim = getElementData(source, "interior"),  getElementData(source, "dimension")
	local hp, armor, money, skin = getElementData(source, "hp"), getElementData(source, "armor"), getElementData(source, "money"), getElementData(source, "skin")
	local characterName = string.gsub(tostring(getElementData(source, "name")), " ", "_")
	spawnPlayer(source, x, y, z, 90, skin, int, dim)
	setPlayerMoney(source, money)
	setElementHealth(source, hp)
	setPedArmor(source, armor)
	setPlayerName(source, characterName)
	outputChatBox("[-] #ffffffKarakter verileriniz başarıyla yüklendi, iyi oyunlar.",source,0,255,0,true)
	setElementData(source, "logged", true)
	triggerClientEvent(source, "succesClient", source)
	setCameraTarget(source, source)
	outputDebugString(""..characterName.." adlı oyuncuya sunucuya giriş yaptı, veriler yüklendi.")
	triggerClientEvent(source, "guikapat", source)
	triggerClientEvent(source, "succesClient", source)
end
