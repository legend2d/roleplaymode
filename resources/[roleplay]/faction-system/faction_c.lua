
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
		local factrank = triggerServerEvent("getFactionRank", localPlayer, id, rank)
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
