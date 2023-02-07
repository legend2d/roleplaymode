function adminDuty(plr, cmd)
	local seviye = getElementData(plr, "admin") or 0
	if (seviye >= 1) then
		if not getElementData(plr, "aduty") then
			setElementData(plr, "aduty", true)
		else
			setElementData(plr, "aduty", false)
		end
		triggerClientEvent(plr, "onClientFlyToggle", plr)
	end
end
addCommandHandler("aduty", adminDuty)

function supportDuty(plr, cmd)
	local seviye = getElementData(plr, "support") or 0
	if (seviye >= 1) then
		if not getElementData(plr, "gduty") then
			setElementData(plr, "gduty", true)
		else
			setElementData(plr, "gduty", false)
		end
		triggerClientEvent(plr, "onClientFlyToggle", plr)
	end
end
addCommandHandler("gduty", supportDuty)