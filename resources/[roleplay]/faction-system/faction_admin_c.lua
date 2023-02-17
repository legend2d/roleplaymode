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


	function updatePersonalRankExample()
		if not personelRank_window or personelRank_window and guiGetVisible(personelRank_window)==false then
		local screenW, screenH = guiGetScreenSize()
        personelRank_window_example = guiCreateWindow((screenW - 257) / 2, (screenH - 285) / 2, 257, 285, "Rütbe Güncelleme - Yükleniyor", false)
        guiWindowSetMovable(personelRank_window_example, false)
        guiWindowSetSizable(personelRank_window_example, false)
        guiSetAlpha(personelRank_window_example, 1.00)
		else
		guiSetVisible(personelRank_window_example, false)
		end
	end
	addEvent("updatePersonalRankEx", true)
	addEventHandler("updatePersonalRankEx", root, updatePersonalRankExample)

    function updatePersonalRank(name, allrank, playerank)
		guiSetVisible(personelRank_window_example, false)
		if personelRank_window and guiGetVisible(personelRank_window)==true then guiSetVisible(personelRank_window, false) guiSetVisible(personelRank_window_example, false) return end
		local screenW, screenH = guiGetScreenSize()
        personelRank_window = guiCreateWindow((screenW - 257) / 2, (screenH - 285) / 2, 257, 285, "Rütbe Güncelleme - "..name, false)
        guiWindowSetMovable(personelRank_window, false)
        guiWindowSetSizable(personelRank_window, false)
        guiSetAlpha(personelRank_window, 1.00)

        personelRank_updatebutton = guiCreateButton(9, 209, 238, 31, "Rütbe Güncelle", false, personelRank_window)
        personalRank_close = guiCreateButton(9, 244, 238, 31, "İptal", false, personelRank_window)
        personelRank_ranks = guiCreateComboBox(9, 25, 238, 179, "", false, personelRank_window)
		for k, ranks in pairs(allrank) do
		guiComboBoxAddItem(personelRank_ranks, ranks.rname)
		end
		guiComboBoxSetSelected(personelRank_ranks, tonumber(playerank)-1)
		target_name = name
    end
	addEvent("updateRankGUI", true)
	addEventHandler("updateRankGUI", root, updatePersonalRank)

	addEventHandler("onClientGUIClick", root, function()
		if source == personalRank_close then guiSetVisible(personelRank_window, false) 
		elseif source == personelRank_updatebutton then
			local selected_rank = guiComboBoxGetSelected(personelRank_ranks)
			local new_rankname = tostring(guiComboBoxGetItemText(personelRank_ranks, selected_rank))
			triggerServerEvent("changePlayerRank", localPlayer, target_name, tonumber(selected_rank)+1, new_rankname)
		end
	end)