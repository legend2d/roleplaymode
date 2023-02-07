	local function vCP_Panel(vehicles_list)
		local screenW, screenH = guiGetScreenSize()
		showCursor(true)
        vCP_Window = guiCreateWindow((screenW - 724) / 2, (screenH - 474) / 2, 724, 474, "Eastland Roleplay - Araç Yönetim Paneli", false)
        guiWindowSetMovable(vCP_Window, false)
        guiWindowSetSizable(vCP_Window, false)
        guiSetAlpha(vCP_Window, 1.00)

        vCP_gridlist = guiCreateGridList(9, 22, 705, 391, false, vCP_Window)
        dbid = guiGridListAddColumn(vCP_gridlist, "Veritabanı ID", 0.1)
        gtamodel = guiGridListAddColumn(vCP_gridlist, "GTA Model", 0.2)
        marka = guiGridListAddColumn(vCP_gridlist, "Marka", 0.2)
        model = guiGridListAddColumn(vCP_gridlist, "Model", 0.2)
        ucret = guiGridListAddColumn(vCP_gridlist, "Ücret", 0.1)
		vergi = guiGridListAddColumn(vCP_gridlist, "Vergi", 0.1)
        vCP_Close = guiCreateButton(14, 428, 138, 36, "Kapat", false, vCP_Window)
        vCP_AddVehicle = guiCreateButton(566, 428, 138, 36, "Araç Ekle", false, vCP_Window)
        vCP_RemoveVehicle = guiCreateButton(414, 428, 138, 36, "Araç Sil", false, vCP_Window)   
		for k, vehicles in pairs(vehicles_list) do
		local row = guiGridListAddRow(vCP_gridlist)
		guiGridListSetItemText ( vCP_gridlist, row, dbid, vehicles[1], false, false )
		guiGridListSetItemText ( vCP_gridlist, row, gtamodel, ""..getVehicleNameFromModel(vehicles[2]).."("..vehicles[2]..")", false, false )
		guiGridListSetItemText ( vCP_gridlist, row, marka, vehicles[3], false, false )
		guiGridListSetItemText ( vCP_gridlist, row, model, vehicles[4], false, false )
		guiGridListSetItemText ( vCP_gridlist, row, ucret, "$"..vehicles[5].."", false, false )
		guiGridListSetItemText ( vCP_gridlist, row, vergi, "$"..vehicles[6].."", false, false )
		end
    end
	addEvent("vcp_panel", true)
	addEventHandler("vcp_panel", root, vCP_Panel)

	addEventHandler("onClientGUIClick", root, function()
		if source == vCP_Close then guiSetVisible(vCP_Window, false) showCursor(false) end
		if source == vCP_AddVehicle then triggerEvent("vcvp_panel", localPlayer) end
		if source == vCVP_Close then guiSetVisible(vCVP_Window, false) end
		if source == vCVP_Create then 
		local gtamodel = guiGetText(vCVP_gtamodelbox)
		local ucret, vergi = guiGetText(vCVP_pricebox), guiGetText(vCVP_vergibox)
		local marka, model = guiGetText(vCVP_markabox), guiGetText(vCVP_modelbox)
		triggerServerEvent("vCVP_createVehicle", localPlayer, gtamodel, ucret, vergi, marka, model)
		end
		if source == vCP_RemoveVehicle then
		local secili_dbid = guiGridListGetItemText ( vCP_gridlist, guiGridListGetSelectedItem ( vCP_gridlist ), dbid )
		triggerServerEvent("vCP_removeVehicle", localPlayer, secili_dbid)
		end
	end)
	
	
    local function vehicleCreateVehiclePanel()
		local screenW, screenH = guiGetScreenSize()
        vCVP_Window = guiCreateWindow((screenW - 414) / 2, (screenH - 319) / 2, 414, 319, "Eastland Roleplay - Araç Oluşturma Paneli", false)
        guiWindowSetSizable(vCVP_Window, false)

        vCVP_gtamodeltext = guiCreateLabel(16, 31, 139, 23, "Araç GTA Model ID", false, vCVP_Window)
        vCVP_gtamodelbox = guiCreateEdit(13, 54, 110, 34, "", false, vCVP_Window)
        guiEditSetMaxLength(vCVP_gtamodelbox, 5)
        vCVP_pricetext = guiCreateLabel(160, 31, 100, 23, "Araç Fiyatı", false, vCVP_Window)
        guiLabelSetHorizontalAlign(vCVP_pricetext, "center", false)
        vCVP_pricebox = guiCreateEdit(155, 54, 110, 34, "", false, vCVP_Window)
        guiEditSetMaxLength(vCVP_pricebox, 5)
        vCVP_vergibox = guiCreateEdit(283, 54, 110, 34, "", false, vCVP_Window)
        guiEditSetMaxLength(vCVP_vergibox, 5)
        vCVP_vergitext = guiCreateLabel(287, 31, 100, 23, "Araç Vergisi", false, vCVP_Window)
        guiLabelSetHorizontalAlign(vCVP_vergitext, "center", false)
        vCVP_markabox = guiCreateEdit(13, 163, 185, 34, "", false, vCVP_Window)
        guiEditSetMaxLength(vCVP_markabox, 30)
        vCVP_markatext = guiCreateLabel(35, 140, 139, 23, "Araç Markası", false, vCVP_Window)
        guiLabelSetHorizontalAlign(vCVP_markatext, "center", false)
        vCVP_modelbox = guiCreateEdit(218, 163, 185, 34, "", false, vCVP_Window)
        guiEditSetMaxLength(vCVP_modelbox, 30)
        vCVP_modeltext = guiCreateLabel(236, 140, 139, 23, "Araç Modeli", false, vCVP_Window)
        guiLabelSetHorizontalAlign(vCVP_modeltext, "center", false)
        vCVP_Close = guiCreateButton(21, 264, 153, 39, "İptal Et", false, vCVP_Window)
        vCVP_Create = guiCreateButton(236, 264, 153, 39, "Oluştur", false, vCVP_Window)    
    end
	addEvent("vcvp_panel", true)
	addEventHandler("vcvp_panel", root, vehicleCreateVehiclePanel)

	addEvent("vCVP_succesfullyClient", true)
	addEventHandler("vCVP_succesfullyClient", root, function()
		showCursor(false)
		guiSetVisible(vCVP_Window, false)
		guiSetVisible(vCP_Window, false)
	end)