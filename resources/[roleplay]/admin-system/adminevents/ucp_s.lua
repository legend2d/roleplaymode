function openUserControlPanel(plr, cmd)
	if getElementData(plr, "admin")>5 then
		triggerClientEvent(plr, "userControlPanel", plr)
	end
end
addCommandHandler("ucp", openUserControlPanel)