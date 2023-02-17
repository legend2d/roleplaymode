	local function factionPanel_example()
		if not faction_window or faction_window and guiGetVisible(faction_window)==false then
		showCursor(true)
		local screenW, screenH = guiGetScreenSize()
        faction_window_example = guiCreateWindow((screenW - 876) / 2, (screenH - 543) / 2, 876, 543, "Birlik Verileri Yükleniyor...", false)
        guiWindowSetMovable(faction_window_example, false)
        guiWindowSetSizable(faction_window_example, false)
        guiSetAlpha(faction_window_example, 1.00)
		return true
		else
		guiSetVisible(faction_window_example, false)
		return false
		end
	end
	addEvent("factionPanel_example", true)
	addEventHandler("factionPanel_example", root, factionPanel_example)


    function factionPanel(id, fname, faction, desc)
		if faction_window and guiGetVisible(faction_window)==true then guiSetVisible(faction_window, false) showCursor(false) return end	
		showCursor(true)
		local screenW, screenH = guiGetScreenSize()
        faction_window = guiCreateWindow((screenW - 876) / 2, (screenH - 543) / 2, 876, 543, fname, false)
        guiWindowSetMovable(faction_window, false)
        guiWindowSetSizable(faction_window, false)
        guiSetAlpha(faction_window, 1.00)

        FactionTab = guiCreateTabPanel(9, 19, 857, 514, false, faction_window)

        main_tab = guiCreateTab("Main Menu", FactionTab)

        faction_player_gridlist = guiCreateGridList(2, 5, 643, 475, false, main_tab)
        faction_personal = guiGridListAddColumn(faction_player_gridlist, "Karakter", 0.2)
        faction_rank = guiGridListAddColumn(faction_player_gridlist, "Rütbe", 0.2)
        faction_online = guiGridListAddColumn(faction_player_gridlist, "Aktiflik", 0.2)
        faction_lead = guiGridListAddColumn(faction_player_gridlist, "Lider", 0.2)
		for k, personel in pairs(faction) do
		if personel.online == "Aktif" then
		r, g, b = 0, 255, 0
		else
		r, g, b = 255, 0, 0
		end
		local row = guiGridListAddRow(faction_player_gridlist)
		guiGridListSetItemText ( faction_player_gridlist, row, faction_personal, personel.player, false, false )
		guiGridListSetItemText ( faction_player_gridlist, row, faction_rank, personel.rank, false, false )
		guiGridListSetItemText ( faction_player_gridlist, row, faction_online, personel.online, false, false )
		guiGridListSetItemColor ( faction_player_gridlist, row, faction_online, r, g, b )
		guiGridListSetItemText ( faction_player_gridlist, row, faction_lead, personel.leader, false, false )
		end
		if getElementData(localPlayer, "factionlead")==1 then
        leader_button = guiCreateButton(645, 6, 202, 36, "Lider Durumunu Değiştir", false, main_tab)
        changerank_button = guiCreateButton(645, 52, 202, 36, "Rütbesini Güncelle", false, main_tab)
		invite_button = guiCreateButton(645, 98, 202, 36, "Birliğe Davet Et", false, main_tab)
        kick_button = guiCreateButton(645, 144, 202, 36, "Seçili Üyeyi Çıkart", false, main_tab)
        updateranks_button = guiCreateButton(645, 229, 202, 36, "Birlik Rütbelerini Güncelle", false, main_tab)
		end
        leavefaction_button = guiCreateButton(645, 444, 202, 36, "Birlikten Ayrıl", false, main_tab)
        factioninfo_button = guiCreateButton(645, 398, 202, 36, "Birlik Hakkında", false, main_tab)

        description_tab = guiCreateTab("Description", FactionTab)

        faction_description = guiCreateMemo(4, 5, 843, 436, "That's My Faction!", false, description_tab)
		guiMemoSetReadOnly(faction_description, true)
		guiSetText(faction_description, desc)
		if getElementData(localPlayer, "factionlead")==1 then
		guiMemoSetReadOnly(faction_description, false)

        updatedesc_button = guiCreateButton(674, 447, 169, 33, "Açıklamayı Güncelle", false, description_tab)
        leader_tab = guiCreateTab("Yönetim", FactionTab)

        faction_vehicle_gridlist = guiCreateGridList(8, 8, 335, 370, false, leader_tab)
        guiGridListAddColumn(faction_vehicle_gridlist, "Araç ID", 0.3)
        guiGridListAddColumn(faction_vehicle_gridlist, "Model", 0.3)
        guiGridListAddColumn(faction_vehicle_gridlist, "Plaka", 0.3)
        addcar_button = guiCreateButton(8, 391, 335, 35, "Birliğe Araç Ekle", false, leader_tab)
        kickcar_button = guiCreateButton(8, 445, 335, 35, "Seçili Aracı Çıkart", false, leader_tab)
        addmoney_button = guiCreateButton(512, 391, 335, 35, "Kasaya Para Ekle", false, leader_tab)
        takemoney_button = guiCreateButton(512, 445, 335, 35, "Kasadan Para Çek", false, leader_tab)
        faction_money = guiCreateLabel(0.59, 0.70, 0.39, 0.08, "Birlik Kasası: $31", true, leader_tab)
        guiSetFont(faction_money, "clear-normal")
        guiLabelSetHorizontalAlign(faction_money, "center", false)
        guiLabelSetVerticalAlign(faction_money, "center")
        factionchat_button = guiCreateButton(512, 18, 335, 35, "Birlik Sohbetini Kapat/Aç", false, leader_tab)
        respawncars_button = guiCreateButton(512, 63, 335, 35, "Birlik Araçlarını Yenile", false, leader_tab)   
		end		
    end	
	addEvent("factionPanel", true)
	addEventHandler("factionPanel", root, factionPanel)

	-- OYUNCU TIKLAMA FONKSIYONLARI
	function playerClickOptions()
		if source == leavefaction_button then
			triggerServerEvent("leaveFactionEvent", localPlayer, localPlayer)
			showCursor(false)
			guiSetVisible(faction_window, false)
		end
		if source == factioninfo_button then
			triggerServerEvent("infoFactionEvent", localPlayer, localPlayer)
		end
	end
	addEventHandler("onClientGUIClick", root, playerClickOptions)
	
	-- YÖNETİM TIKLAMA FONKSIYONLARI
	function leaderClickOptions()
		if source == updatedesc_button then
			local new_desc = tostring(guiGetText(faction_description))
			triggerServerEvent("updateFactionDesc", localPlayer, new_desc)
		elseif source == updateranks_button then
			local screenW, screenH = guiGetScreenSize()
			rankChange_window_example = guiCreateWindow((screenW - 584) / 2, (screenH - 285) / 2, 584, 285, "Yükleniyor...", false)
			guiWindowSetSizable(rankChange_window_example, false)
			guiWindowSetMovable(rankChange_window_example, false)
			guiSetAlpha(rankChange_window_example, 1.00)
			triggerServerEvent("getAllRanks", localPlayer, tonumber(getElementData(localPlayer, "faction")))
		elseif source == rankChange_close then
			guiSetVisible(rankChange_window, false)
			if rankChange_show_window then guiSetVisible(rankChange_show_window, false) end
		elseif source == factionchat_button then
			triggerServerEvent("factionChat", localPlayer, getElementData(localPlayer, "faction"))
		elseif source == rankChange_show_updatebutton then
			if tonumber(factiontype)==5 then
			triggerServerEvent("updateFactionRank", localPlayer, tonumber(getElementData(localPlayer, "faction")), _rankid, tostring(guiGetText(rankChange_show_rankname)), guiGetText(rankChange_show_price))
			else
			triggerServerEvent("updateFactionRank", localPlayer, tonumber(getElementData(localPlayer, "faction")), _rankid, tostring(guiGetText(rankChange_show_rankname)), false)
			end
		elseif source == changerank_button then
			local player = guiGridListGetItemText ( faction_player_gridlist, guiGridListGetSelectedItem ( faction_player_gridlist ), faction_personal )
			if player ~= "" then
				triggerServerEvent("changeRankServer", localPlayer, player)
			end
		elseif source == kick_button then
			local player = guiGridListGetItemText ( faction_player_gridlist, guiGridListGetSelectedItem ( faction_player_gridlist ), faction_personal )
			if player ~= "" then
				triggerServerEvent("kickPlayerFaction", localPlayer, player)
			end
		elseif source == leader_button then
			local player = guiGridListGetItemText ( faction_player_gridlist, guiGridListGetSelectedItem ( faction_player_gridlist ), faction_personal )
			if player ~= "" then
				triggerServerEvent("leadPlayerFaction", localPlayer, player)
			end
		elseif source == invite_button then
			inviteScreen()
		end
	end
	addEventHandler("onClientGUIClick", root, leaderClickOptions)
	
	function closeExamples()
		if rankChange_window_example then guiSetVisible(rankChange_window_example, false) return end
		if faction_window_example then guiSetVisible(faction_window_example, false) return end
	end
	addEvent("closeExamples", true)
	addEventHandler("closeExamples", root, closeExamples)
	
	function closeAll()
		showCursor(false)
		if rankChange_window_example then guiSetVisible(rankChange_window_example, false) end
		if faction_window_example then guiSetVisible(faction_window_example, false) end
		if faction_window then guiSetVisible(faction_window, false) end
		if rankChange_window then guiSetVisible(rankChange_window, false)  end
		if personelRank_window_example then guiSetVisible(personelRank_window_example, false) end
		if personelRank_window then guiSetVisible(personelRank_window, false) end
		if invite_window then guiSetVisible(invite_window, false) end
		setElementData(localPlayer, "factionpanel", false)
	end
	addEvent("closeAll", true)
	addEventHandler("closeAll", root, closeAll)
	

    function rankChange(ranks, ftype)
		factiontype = ftype
		if rankChange_window and guiGetVisible(rankChange_window)==true then guiSetVisible(rankChange_window, false) showCursor(false) return end	
		local screenW, screenH = guiGetScreenSize()
        rankChange_window = guiCreateWindow((screenW - 584) / 2, (screenH - 285) / 2, 584, 285, "Rütbe Düzenleme", false)
        guiWindowSetSizable(rankChange_window, false)
		guiWindowSetMovable(rankChange_window, false)
        guiSetAlpha(rankChange_window, 1.00)

        rankChange_gridlist = guiCreateGridList(9, 22, 565, 215, false, rankChange_window)
        rank_id = guiGridListAddColumn(rankChange_gridlist, "Rütbe ", 0.3)
        rank_name = guiGridListAddColumn(rankChange_gridlist, "İsim", 0.3)
		if tonumber(ftype)==5 then
        rank_price = guiGridListAddColumn(rankChange_gridlist, "Maaş", 0.3)
		end
        for k, rutbe in pairs(ranks) do
        local row = guiGridListAddRow(rankChange_gridlist)
        guiGridListSetItemText(rankChange_gridlist, row, rank_id, rutbe.id, false, false)
        guiGridListSetItemText(rankChange_gridlist, row, rank_name, rutbe.rankname, false, false)
		if tonumber(ftype)==5 then
		guiGridListSetItemText(rankChange_gridlist, row, rank_price, rutbe.rankpricex, false, false)
		end
		end
        rankChange_close = guiCreateButton(404, 246, 160, 29, "Kapat", false, rankChange_window)
        rankChange_info = guiCreateLabel(13, 247, 391, 28, "Düzenlemek İstediğiniz Rütbeye Çift Tıklayın", false, rankChange_window)
        guiLabelSetHorizontalAlign(rankChange_info, "center", false)
        guiLabelSetVerticalAlign(rankChange_info, "center")    
    end
	addEvent("faction_rankChange", true)
	addEventHandler("faction_rankChange", root, rankChange)


    function showRank(rankid, rankname, rankprice)
		_rankid = rankid
		_rankname = rankname
		_rankprice = rankprice or false
		if rankChange_show_window and guiGetVisible(rankChange_show_window)==true then guiSetVisible(rankChange_show_window, false) return end
		local screenW, screenH = guiGetScreenSize()
        rankChange_show_window = guiCreateWindow(0.72, 0.32, 0.16, 0.37, "Rütbe: "..rankid.."", true)
        guiWindowSetMovable(rankChange_show_window, false)
        guiWindowSetSizable(rankChange_show_window, false)
        guiSetAlpha(rankChange_show_window, 1.00)

        rankChange_show_rankname = guiCreateEdit(9, 28, 193, 30, rankname, false, rankChange_show_window)
        guiEditSetMaxLength(rankChange_show_rankname, 30)
		if tonumber(factiontype) == 5 and rankprice then
        rankChange_show_price = guiCreateEdit(9, 68, 193, 30, rankprice, false, rankChange_show_window)
        guiEditSetMaxLength(rankChange_show_price, 9)
		end
        rankChange_show_updatebutton = guiCreateButton(20, 222, 176, 34, "Güncelle", false, rankChange_show_window)    
    end
	addEvent("faction_rankShow", true)
	addEventHandler("faction_rankShow", root, showRank)

	addEventHandler("onClientGUIDoubleClick", root, function()
		if source == rankChange_gridlist then 
			local selected_rank = guiGridListGetItemText ( rankChange_gridlist, guiGridListGetSelectedItem ( rankChange_gridlist ), rank_id )
			local selected_rankname = guiGridListGetItemText ( rankChange_gridlist, guiGridListGetSelectedItem ( rankChange_gridlist ), rank_name )
			local selected_rankprice = guiGridListGetItemText ( rankChange_gridlist, guiGridListGetSelectedItem ( rankChange_gridlist ), rank_price ) 
			if selected_rank ~= "" then 
				showRank(selected_rank, selected_rankname, selected_rankprice)
			end
		end
	end)
	
	addEvent("updateRankGui", true)
	addEventHandler("updateRankGui", root, function(id, name, price)
		if not price then
		guiGridListSetItemText(rankChange_gridlist, tonumber(id)-1, rank_name, name, false, false)
		else
		guiGridListSetItemText(rankChange_gridlist, tonumber(id)-1, rank_name, name, false, false)
		guiGridListSetItemText(rankChange_gridlist, tonumber(id)-1, rank_price, price, false, false)
		end
	end)
	

    function inviteScreen()
		if invite_window and guiGetVisible(invite_window)==true then guiSetVisible(invite_window, false) return end
		local screenW, screenH = guiGetScreenSize()
        invite_window = guiCreateWindow((screenW - 338) / 2, (screenH - 113) / 2, 338, 113, "Birlik Davet Paneli", false)
        guiWindowSetMovable(invite_window, false)
        guiWindowSetSizable(invite_window, false)

        invite_editbox = guiCreateEdit(11, 27, 317, 24, "", false, invite_window)
        invite_infolabel = guiCreateLabel(10, 52, 318, 28, "Davet etmek istediğiniz oyuncunun adını \nveya ID'sini kutucuğa yazın.", false, invite_window)
        guiLabelSetHorizontalAlign(invite_infolabel, "center", false)
        invite_cancelbutton = guiCreateButton(9, 83, 78, 20, "İptal", false, invite_window)
        invite_sendbutton = guiCreateButton(246, 83, 78, 20, "Davet Et", false, invite_window)    
    end	
	
	function inviteScreenToPlayer(daveteden, factionname, id)
		showCursor(true)
		if invite_window_player and guiGetVisible(invite_window_player)==true then guiSetVisible(invite_window_player, false) return end
		local screenW, screenH = guiGetScreenSize()
        invite_window_player = guiCreateWindow((screenW - 338) / 2, (screenH - 113) / 2, 338, 113, factionname, false)
        guiWindowSetMovable(invite_window_player, false)
        guiWindowSetSizable(invite_window_player, false)
        invite_infolabel_player = guiCreateLabel(10, 52, 318, 28, getPlayerName(daveteden).." tarafından bir birlik daveti aldınız.", false, invite_window_player)
        guiLabelSetHorizontalAlign(invite_infolabel_player, "center", false)
        invite_cancelbutton_player = guiCreateButton(9, 83, 78, 20, "Reddet", false, invite_window_player)
        invite_acceptbutton_player = guiCreateButton(246, 83, 78, 20, "Kabul Et", false, invite_window_player)    
    end	
	addEvent("inviteScreenGUI", true)
	addEventHandler("inviteScreenGUI", root, inviteScreenToPlayer)

	addEventHandler("onClientGUIClick", root, function()
		if source == invite_cancelbutton then guiSetVisible(invite_window, false) return end
		if source == invite_sendbutton then
		local name = guiGetText(invite_editbox) or ""
		triggerServerEvent("invitePlayerToFaction", localPlayer, name, getElementData(localPlayer, "faction"))
		end
	end)