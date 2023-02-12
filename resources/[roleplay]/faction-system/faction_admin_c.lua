local factiontype = {

[1] = "Çete",
[2] = "Mafya",
[3] = "Belediye",
[4] = "Diğer",
[5] = "Departman",

}

function showFactionList(factions)
	if not showFactions_window or showFactions_window and guiGetVisible(showFactions_window)==false then
	showCursor(true)
	local screenW, screenH = guiGetScreenSize()
	showFactions_window = guiCreateWindow((screenW - 451) / 2, (screenH - 319) / 2, 451, 319, "Eastland Roleplay - Faction List", false)
	guiWindowSetMovable(showFactions_window, false)
	guiWindowSetSizable(showFactions_window, false)
	showFactions_gridlist = guiCreateGridList(9, 24, 432, 244, false, showFactions_window)
	faction_id = guiGridListAddColumn(showFactions_gridlist, "ID", 0.2)
	faction_name = guiGridListAddColumn(showFactions_gridlist, "Name", 0.3)
	faction_type = guiGridListAddColumn(showFactions_gridlist, "Type", 0.2)
	faction_personal = guiGridListAddColumn(showFactions_gridlist, "Players", 0.2)
	deletefaction_button = guiCreateButton(10, 280, 113, 29, "Birliği Kaldır", false, showFactions_window)
	close_button = guiCreateButton(151, 280, 113, 29, "Kapat", false, showFactions_window)    
	for k, fs in pairs(factions) do 
	local row = guiGridListAddRow(showFactions_gridlist)
	guiGridListSetItemText ( showFactions_gridlist, row, faction_id, fs[1], false, false )
	guiGridListSetItemText ( showFactions_gridlist, row, faction_name, fs[2], false, false )
	guiGridListSetItemText ( showFactions_gridlist, row, faction_type, factiontype[fs[3]], false, false )
	guiGridListSetItemText ( showFactions_gridlist, row, faction_personal, fs[4], false, false )
	end
	end
end
addEvent("showFactionsClient", true)
addEventHandler("showFactionsClient", root, showFactionList)

addEventHandler("onClientGUIClick", root, function()
	if source == close_button then guiSetVisible(showFactions_window, false) showCursor(false) end
end)

