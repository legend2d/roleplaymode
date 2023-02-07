function RemoveHEXColorCode( s ) 
    return s:gsub( '#%x%x%x%x%x%x', '' ) or s 
end 

function isimdenOyuncuBul(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

-- define our chat radius
local chatRadius = 5 --units

-- define a handler that will distribute the message to all nearby players
function sendMessageToNearbyPlayers(message, messageType)
    -- we will only send normal chat messages, action and team types will be ignored
    if messageType == 0 then
        -- get the chatting player's position
        local posX1, posY1, posZ1 = getElementPosition(source)

        -- loop through all player and check distance
        for id, player in ipairs(getElementsByType("player")) do
            local posX2, posY2, posZ2 = getElementPosition(player)
            if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= chatRadius then
            	local name = getPlayerName(source)
                setPlayerNametagColor ( source, false )
                outputChatBox("#ffffff"..name.." #ffffffdiyor ki: "..message.."", player,255,255,255,true)
            end
        end
    end
    -- block the original message by cancelling this event
    cancelEvent()
end
-- attach our new chat handler to onPlayerChat
addEventHandler( "onPlayerChat", root, sendMessageToNearbyPlayers )

function PrivateMessage(plr,cmd,target,...)
	if not target or not ... then
		outputChatBox("[!]#ffffff /pm [Oyuncu/ID] [Mesaj] - Özel mesaj gönderebilirsiniz.",plr,255,255,0,true)
	else
		local karsi = exports.globals:findPlayerByPartialNick(target)
		if not karsi then
			outputChatBox("[!] #ffffffBöyle bir oyuncu yok.",plr,255,0,0,true)
		else
		if (karsi==plr) then
			outputChatBox("[!] #ffffffKendine özel mesaj gönderemezsin.",plr,255,0,0,true)
		else
			local message = table.concat( {...}, " ")
			local r, g, b = getPlayerNametagColor(plr) 
			local message = message:gsub("#%x%x%x%x%x%x", "") 
			outputChatBox("#ffae00[PM >> "..string.gsub(getPlayerName(plr),"#%x%x%x%x%x%x","").."] "..message, karsi, r, g, b, true) 
			outputChatBox("#ffae00[PM << "..string.gsub(getPlayerName(plr),"#%x%x%x%x%x%x","").."] "..message, plr, r, g, b, true) 
			end
		end
	end
end
addCommandHandler("pm", PrivateMessage)

function OOChat(plr,cmd,...)
	local chatRadius = 120
	if not ... then
		outputChatBox("[!] #ffffff/ooc [İleti]",plr,255,255,0,true)
	else
		local message =  table.concat({...}, " ")
        local posX1, posY1, posZ1 = getElementPosition(plr)
        for id, player in ipairs(getElementsByType("player")) do
            local posX2, posY2, posZ2 = getElementPosition(player)
            if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= chatRadius then
            	local name = getPlayerName(plr)
                setPlayerNametagColor ( plr, false )
				if getElementData(plr, "gduty") then
				outputChatBox("#ffffff(( #66CC33SUPPORT #ffffff"..getElementData(plr, "account")..": "..message.." #ffffff))", player,255,255,255,true)
				elseif getElementData(plr, "aduty") then
				outputChatBox("#ffffff(( #ff0000ADMIN #ffffff"..getElementData(plr, "account")..": "..message.." #ffffff))", player,255,255,255,true)
				else                
				outputChatBox("#ffffff(( OOC - "..name..": "..message.." #ffffff))", player,255,255,255,true)
				end
            end
        end
	end
end
addCommandHandler("ooc",OOChat)
addCommandHandler("OOC",OOChat)

addEventHandler("onPlayerJoin",getRootElement(),
function ()
bindKey(source,"b","down","chatbox","OOC")
end)
 
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
function ()
for index, player in pairs(getElementsByType("player")) do
bindKey(player,"b","down","chatbox","OOC")
  end
end)


addEventHandler('onPlayerChat', getRootElement(), 
function(message, messageType) 
    if (messageType == 1) then 
        cancelEvent() 
		if not message then
		outputChatBox("[!] #ffffff/me [Eylem]",source,255,0,0,true)
		else
        meEmote(source, 'me', message) 
		end
    end 
end) 

function isPlayerInRangeOfPoint(player,x,y,z,range)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end
 
 chat_range=100
function meEmote(plr,cmd,...)
	if not ... then
		outputChatBox("[!] #ffffff/me [Eylem]",plr,255,0,0,true)
	else
		local px,py,pz=getElementPosition(plr)
		local msg = table.concat({...}, " ")
		local nick=getPlayerName(plr)
		local r,g,b = getPlayerNametagColor(plr)
		for _,v in ipairs(getElementsByType("player")) do
		if isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then
			outputChatBox("#CC66CC* "..nick.." #CC66CC"..msg,v,r,g,b,true)
			end
		end
	end
end
addCommandHandler("me",meEmote)

function doEmote(plr,cmd,...)
	if not ... then
		outputChatBox("[!] #ffffff/do [Eylem]",plr,255,0,0,true)
	else
		local px,py,pz=getElementPosition(plr)
		local msg = table.concat({...}, " ")
		local nick=getPlayerName(plr)
		local r,g,b = getPlayerNametagColor(plr)
		for _,v in ipairs(getElementsByType("player")) do
		if isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then
			outputChatBox("#99CCCC* "..msg.."  (("..nick.."#99CCCC))",v,r,g,b,true)
			end
		end
	end
end
addCommandHandler("do",doEmote)


function isPlayerInRangeOfPointt(player,x,y,z,range)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^5<=range
end

function shouts(plr,cmd,...)
	if not ... then
		outputChatBox("[!] #ffffff/s(houts) [İleti]",plr,255,0,0,true)
	else
		local posX1, posY1, posZ1 = getElementPosition(plr)
		for id, player in ipairs(getElementsByType("player")) do
        local posX2, posY2, posZ2 = getElementPosition(player)
        if getDistanceBetweenPoints3D(posX1, posY1, posZ1, posX2, posY2, posZ2) <= 7 then
			local message = table.concat( {...}, " ")
			local name = getPlayerName(plr)
			outputChatBox("#ffffff"..name.." #ffffffbağırıyor: "..message.."! ",player,255,255,255,true)
			end
		end
	end
end
addCommandHandler("s",shouts)
addCommandHandler("shouts",shouts)
		