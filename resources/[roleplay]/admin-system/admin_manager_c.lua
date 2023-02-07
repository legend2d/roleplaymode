
GUIEditor = {
    tab = {},
    label = {},
    tabpanel = {},
    edit = {},
    button = {},
    window = {},
    combobox = {},
    memo = {}
}

function getAdminTags()
    local adminPermission = {}
    for k,v in pairs(adminTags) do
        table.insert(adminPermission, {id = v.id, name = v.tag})
    end
    table.sort(adminPermission, function(a,b) return a.id < b.id end)
    return adminPermission
end

function getSupportTags()
    local supportPermission = {}
    for k,v in pairs(supportTags) do
        table.insert(supportPermission, {id = v.id, name = v.tag})
    end
    table.sort(supportPermission, function(a,b) return a.id < b.id end)
    return supportPermission
end

    function managerPanel()
        if guiGetVisible(GUIEditor.window[1])==true then
            showCursor(false)
            guiSetVisible(GUIEditor.window[1], false)
        else
        showCursor(true)
        local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 621) / 2, (screenH - 418) / 2, 621, 418, "XXX Roleplay - Yönetici Kontrol Paneli", false)
        guiWindowSetMovable(GUIEditor.window[1], false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.tabpanel[1] = guiCreateTabPanel(9, 24, 598, 380, false, GUIEditor.window[1])

        GUIEditor.tab[1] = guiCreateTab("Kontrol Paneli", GUIEditor.tabpanel[1])

        GUIEditor.edit[1] = guiCreateEdit(116, 34, 366, 44, "", false, GUIEditor.tab[1])
        GUIEditor.button[1] = guiCreateButton(484, 36, 69, 42, "ARAT", false, GUIEditor.tab[1])
        GUIEditor.label[1] = guiCreateLabel(114, 8, 368, 22, "Kontrol etmek istediğiniz hesabın kullanıcı adını giriniz.", false, GUIEditor.tab[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.memo[1] = guiCreateMemo(116, 97, 419, 237, "Kullanıcı Adı: N/A\n\nKarakter 1:\n\nKarakter2: N/A\n\nKarakter3: N/A\n\nAdmin Seviyesi: N/A\n\nRehber Seviyesi: N/A\n\nOOC Bakiye: N/A", false, GUIEditor.tab[1])
        guiMemoSetReadOnly(GUIEditor.memo[1], true)

        GUIEditor.tab[2] = guiCreateTab("Yönetim Paneli", GUIEditor.tabpanel[1])

        GUIEditor.edit[2] = guiCreateEdit(101, 73, 400, 42, "", false, GUIEditor.tab[2])
        GUIEditor.button[2] = guiCreateButton(501, 73, 77, 42, "ARAT", false, GUIEditor.tab[2])
        GUIEditor.label[2] = guiCreateLabel(97, 49, 423, 18, "Yönetmek istediğiniz hesabın kullanıcı adını giriniz.", false, GUIEditor.tab[2])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        adminCombobox = guiCreateComboBox(101, 157, 160, 193, "", false, GUIEditor.tab[2])
        rehberCombobox = guiCreateComboBox(341, 157, 160, 193, "", false, GUIEditor.tab[2])
        GUIEditor.label[3] = guiCreateLabel(98, 136, 158, 15, "Admin Seviyesi", false, GUIEditor.tab[2])
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        GUIEditor.label[4] = guiCreateLabel(341, 136, 158, 15, "Rehber Seviyesi", false, GUIEditor.tab[2])
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
        GUIEditor.button[3] = guiCreateButton(266, 315, 75, 35, "Uygula", false, GUIEditor.tab[2])   
        local adminYetkileri = getAdminTags()
        local rehberYetkileri = getSupportTags()
        for k, atags in pairs(adminYetkileri) do
            guiComboBoxAddItem(adminCombobox, atags.name)
        end
        for k, stags in pairs(rehberYetkileri) do
            guiComboBoxAddItem(rehberCombobox, stags.name)
        end
        guiSetVisible(adminCombobox, false)
        guiSetVisible(rehberCombobox, false)
        end 
    end
    addEvent("managerPanelClient", true)
    addEventHandler("managerPanelClient", root, managerPanel)

    addEventHandler("onClientGUIClick", root, function()
        if source == GUIEditor.button[1] then
            triggerServerEvent("manager:userCheck", localPlayer, guiGetText(GUIEditor.edit[1]))
        end
        if source == GUIEditor.button[2] then
            triggerServerEvent("manager:userPermissionCheck", localPlayer, guiGetText(GUIEditor.edit[2]))
        end
        if source == GUIEditor.button[3] then
            triggerServerEvent("manager:updateUserPermission", localPlayer, guiGetText(GUIEditor.edit[2]), guiComboBoxGetSelected(adminCombobox), guiComboBoxGetSelected(rehberCombobox))
        end
    end)

    addEvent("updateCheck", true)
    addEventHandler("updateCheck", root, function(isim, bakiye, karakter1, karakter2, karakter3, adminseviye, supportseviye)
        guiSetText(GUIEditor.memo[1], "Kullanıcı Adı: "..isim.."\n\nKarakter 1: "..karakter1.."\n\nKarakter 2: "..karakter2.."\n\nKarakter 3: "..karakter3.."\n\nAdmin Seviyesi: "..adminseviye.."\n\nRehber Seviyesi: "..supportseviye.."\n\nOOC Bakiye: "..bakiye.."")
    end)

    addEvent("updatePermissionCheck", true)
    addEventHandler("updatePermissionCheck", root, function(isim, adminseviye, supportseviye)
        guiSetVisible(adminCombobox, true)
        guiSetVisible(rehberCombobox, true)
        guiComboBoxSetSelected(adminCombobox, adminseviye)
        guiComboBoxSetSelected(rehberCombobox, supportseviye)
    end)