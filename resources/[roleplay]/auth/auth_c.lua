local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "radar", "area_name" }
loadstring(exports.dgs:dgsImportFunction())()
local font = dxCreateFont('pear.ttf', 15, false, 'default') or 'default'
local lp = localPlayer

local authPed = createPed(45, 2947.45581, -764.57513, 1.32520)
setPedAnimation(authPed, "BEACH", "ParkSit_M_loop")
setPedRotation(authPed, -90)
setElementFrozen(authPed, true)
setElementDimension(authPed, 200)

local authPedT = createPed(140, 2947.57153, -763.36261, 1.57089)
setPedAnimation(authPedT, "BEACH", "ParkSit_W_loop")
setPedRotation(authPedT, -90)
setElementFrozen(authPedT, true)
setElementDimension(authPedT, 200)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	if not getElementData(lp, "logged") then
	triggerServerEvent("loginServerside", localPlayer)
	showCursor(true)
	auth_username = dgsCreateEdit(0.3, 0.2, 0.1+0.04, 0.04, "Username", true, nil, nil, nil, nil, nil, 0xFFb22222)
	auth_password = dgsCreateEdit(0.4+0.03, 0.5+0.03, 0.1+0.04, 0.04, "Password", true, nil, nil, nil, nil, nil, 0xFFb22222)
	login_button = dgsCreateButton( 0.4+0.03, 0.6, 0.1+0.04, 0.04, "Login Account", true, nil, nil, nil, nil, nil, nil, nil, 0xFF8b8989, 0xFF8b8378, 	0xFF8b7d6b )
	register_button = dgsCreateButton( 0.4+0.03, 0.6+0.06, 0.1+0.04, 0.04, "Register Account", true, nil, nil, nil, nil, nil, nil, nil, 0xFF8b8989, 0xFF8b8378, 	0xFF8b7d6b )
	dgsCenterElement(auth_username)
	dgsSetFont(auth_username, font)
	dgsSetFont(auth_password, font)
	dgsSetFont(login_button, font)
	dgsSetFont(register_button, font)
	dgsSetProperty(auth_password, "masked", true)
	addEventHandler ( "onDgsMouseClick", register_button, authRegister )
	addEventHandler ( "onDgsMouseClick", login_button, authLogin )
end
end)

function authRegister ( button, state )
    if button == "left" and state == "down" then
    	local a_u = dgsGetText(auth_username)
		local a_p = dgsGetText(auth_password)
    	triggerServerEvent("authRegister:server", lp, a_u, a_p)
    end
end

function authLogin ( button, state )
    if button == "left" and state == "down" then
    	local a_u = dgsGetText(auth_username)
		local a_p = dgsGetText(auth_password)
    	triggerServerEvent("authLogin:server", lp, a_u, a_p)
    end
end


function setSettings()
	for _, component in ipairs( components ) do
	setPlayerHudComponentVisible( component, false )
	end
	showChat(false)
	setElementDimension(localPlayer, 200)
end
addEvent("authSettings", true)
addEventHandler("authSettings", getRootElement(), setSettings)

function loginClientside()
	if (dgsGetVisible(login_button) == true) then
	dgsSetVisible(auth_username, false)
	dgsSetVisible(auth_password, false)
	dgsSetVisible(login_button, false)
	dgsSetVisible(register_button, false)
	showCursor(false)
	showChat(true)
	end
	for _, component in ipairs( components ) do
	setPlayerHudComponentVisible( component, true )
end
end
addEvent("succesClient", true)
addEventHandler("succesClient", root, loginClientside)

function firstCrcClient()
	dgsSetVisible(auth_username, false)
	dgsSetVisible(auth_password, false)
	dgsSetVisible(login_button, false)
	dgsSetVisible(register_button, false)
end
addEvent("first:client", true)
addEventHandler("first:client", root, firstCrcClient)

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end

addEventHandler("onClientRender", root, function()
	for k, peds in pairs(getElementsByType("ped")) do
		if getElementData(peds, "isim") and getElementData(peds, "account") == getElementData(localPlayer, "account") then
			dxDrawTextOnElement(peds, getElementData(peds, "isim"), 1, 30, 128, 118, 116, 255, 1.7, "default-bold")
		end
	end
end)