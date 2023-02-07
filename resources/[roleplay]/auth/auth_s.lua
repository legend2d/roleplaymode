local db = exports.mysql:dbConnect()
local k1x, k1y, k1z = 1735.25732, -1656.34436, 34.45894
local k2x, k2y, k2z = 1734.64355, -1657.82568, 34.46149
local k3x, k3y, k3z = 1734.71692, -1655.01355, 34.45797
local cx, cy, cz, c2x, c2y, c2z = 1739.46021, -1656.24280, 34.45476, 1733.63855, -1656.66064, 34.46130
local firstC = {}
local secondC = {}
local thirdC = {}

function selectCharacter(u)
	setElementInterior(source, 0)
	loadData(u)
	triggerClientEvent(source, "first:client", source)
	setCameraMatrix(source, cx, cy, cz, c2x, c2y, c2z)
	setElementDimension(source, math.random(200, 65000))
	if getElementData(source, "karakter1") ~= "Yok" then
	firstC[source] = createPed(getElementData(source, "karakter1:skin"), k1x, k1y, k1z)
	setPedRotation(firstC[source], -90)
	setElementDimension(firstC[source], getElementDimension(source))
	setElementData(firstC[source], "isim", getElementData(source, "karakter1"))
	setElementData(firstC[source], "account", u)
	end
	if getElementData(source, "karakter2") ~= "Yok" then
	secondC[source] = createPed(getElementData(source, "karakter2:skin"), k2x, k2y, k2z)	
	setElementDimension(secondC[source], getElementDimension(source))
	setPedRotation(secondC[source], -90)
	setElementData(secondC[source], "isim", getElementData(source, "karakter2"))
	setElementData(secondC[source], "account", u)
	end
	if getElementData(source, "karakter3") ~= "Yok" then
	thirdC[source] = createPed(getElementData(source, "karakter3:skin"), k3x, k3y, k3z)
	setElementDimension(thirdC[source], getElementDimension(source))
	setPedRotation(thirdC[source], -90)
	setElementData(thirdC[source], "isim", getElementData(source, "karakter3"))
	setElementData(thirdC[source], "account", u)
	else
	triggerClientEvent(source, "karakterOlustur", source)
	end
	for k, peds in pairs(getElementsByType("ped")) do
	if getElementData(peds, "account") == u then
	setElementVisibleTo(peds, source, true)
	else
	setElementVisibleTo(peds, source, false)
	end
	end
end

function mysqlAuthCheck(source)
    local serial = getPlayerSerial(source)
    local qh = dbQuery( db, "SELECT * FROM accounts WHERE serial=?", serial)
    local result = dbPoll( qh, -1 )
    if #result > 0 then  setElementData(source, "haveacc", true) 
    else
    setElementData(source, "haveacc", false)
    end
end

function loginServer()
	spawnPlayer(source, 0, 0, 0, 0, 200)
	setCameraMatrix(source, 2932.20752, -758.35077, 5.59195, 2986.12305, -775.30322, 7.18526)
	triggerClientEvent(source, "authSettings", source)
	mysqlAuthCheck(source)
end
addEventHandler("onPlayerJoin", root, loginServer)
addEvent("loginServerside", true)
addEventHandler("loginServerside", root, loginServer)

function authRegister(username, password)
	if username ~= "" and password ~= "" then
	if getElementData(source, "haveacc") then return end
	dbExec(db, "INSERT INTO accounts(account, password, serial, ip, bakiye) VALUES(?,?,?,?,?)",username,password,getPlayerSerial(source), getPlayerIP(source), 0)
	setElementData(source, "haveacc", true)
	triggerClientEvent(source, "authgui", source)
	end
end
addEvent("authRegister:server", true)	
addEventHandler("authRegister:server", root, authRegister)


function authLogin(username, passwordx)
	local dataresult = dbPoll ( dbQuery ( db,'SELECT * FROM `accounts` WHERE account=?',username ),-1 )
   	if type ( dataresult ) == 'table' and #dataresult == 0 or not dataresult then return end
   	local acc, pass = dataresult[1].account, dataresult[1].password
    if username == acc and passwordx == pass then 
      	loginSuccesfully(username, passwordx)
      	loadData(username)
    else
    return end
end
addEvent("authLogin:server", true)	
addEventHandler("authLogin:server", root, authLogin)

function loginSuccesfully(u, p)
	local serial = getPlayerSerial(source)
    local qh = dbQuery( db, "SELECT * FROM karakterler WHERE owner=?", u)
    local result = dbPoll( qh, -1 )
    if #result == 0 then  
    	triggerEvent("createCharacther:Server", source, u, p)
    	triggerClientEvent(source, "karakterYaratClient", source, u)
    else
	-- joinServerAuth(source)
	selectCharacter(u)
end
end

function joinServerAuth(source, karakter)
	local resultcrc = dbPoll ( dbQuery ( db,'SELECT * FROM `karakterler` WHERE name=?',karakter),-1 )
	for rids, rows in ipairs (resultcrc) do
    for columnx, valuec in pairs (rows) do 
    setElementData(source, columnx, valuec)
	end
	end
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
	showChat(source, true)
end


function loadData(u)
	local result = dbPoll ( dbQuery ( db,'SELECT * FROM `accounts` WHERE account=?',u),-1 )
	for rid, row in ipairs (result) do
    for column, value in pairs (row) do 
    	if column ~= "password" then
        setElementData(source, column, value)
        if column == "karakter1" and value ~= "Yok" then
        	local karakter1_sonuc = dbPoll ( dbQuery ( db,'SELECT * FROM `karakterler` WHERE name=?',getElementData(source, "karakter1")),-1 )
        	setElementData(source, "karakter1:skin", karakter1_sonuc[1].skin)
        end
        if column == "karakter2" and value ~= "Yok" then
        	local karakter2_sonuc = dbPoll ( dbQuery ( db,'SELECT * FROM `karakterler` WHERE name=?',getElementData(source, "karakter2")),-1 )
        	setElementData(source, "karakter2:skin", karakter2_sonuc[1].skin)
        end
        if column == "karakter3" and value ~= "Yok" then
        	local karakter3_sonuc = dbPoll ( dbQuery ( db,'SELECT * FROM `karakterler` WHERE name=?',getElementData(source, "karakter3")),-1 )
        	setElementData(source, "karakter3:skin", karakter3_sonuc[1].skin)
        end
    end
	end
    end
end

addEventHandler("onResourceStart", root, function()
	for k, players in pairs(getElementsByType("player")) do
	local accs = getElementData(players, "account")
	local result = dbPoll ( dbQuery ( db,'SELECT * FROM `accounts` WHERE account=?',accs),-1 )
	for rid, row in ipairs (result) do
    for column, value in pairs (row) do 
    	if column ~= "password" then
        setElementData(players, column, value)
    end
	end
    end
end
end)

function elementClicked( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" then -- if left mouse button was pressed down
    	if getElementType(source) == "ped" then
        if getElementData(source, "isim") then
        	local isim = getElementData(source, "isim")
        	joinServerAuth(thePlayer, isim)
        	triggerClientEvent(thePlayer, "karakterOlusturKapat", thePlayer)
        	triggerClientEvent(thePlayer, "succesClient", thePlayer)
        end
    end
    end
end
addEventHandler( "onElementClicked", root, elementClicked )
