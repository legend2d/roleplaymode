function findPlayerByAccount(account)
	if account then
		for k, users in pairs(getElementsByType("player")) do
			if getElementData(users, "account")==account then
				return users
			end
		break
	end
	end
end

function findPlayerByName(name)
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