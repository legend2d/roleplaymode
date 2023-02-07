
GUIEditor = {
    tab = {},
    tabpanel = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {},
    memo = {}
}
addEvent("userControlPanel", true)
addEventHandler("userControlPanel", root,
    function()
        if guiGetVisible(GUIEditor.window[31]) == true then guiSetVisible(GUIEditor.window[31], false) showCursor(false) end
        showCursor(true)
        local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[31] = guiCreateWindow((screenW - 653) / 2, (screenH - 379) / 2, 653, 379, "XXX Roleplay - Oyuncu Kontrol Paneli", false)
        guiWindowSetMovable(GUIEditor.window[31], false)
        guiWindowSetSizable(GUIEditor.window[31], false)

        GUIEditor.tabpanel[31] = guiCreateTabPanel(9, 24, 634, 345, false, GUIEditor.window[31])

        GUIEditor.tab[31] = guiCreateTab("Oyuncu Bul", GUIEditor.tabpanel[31])

        GUIEditor.button[31] = guiCreateButton(522, 273, 102, 38, "Ayrıl", false, GUIEditor.tab[31])
        GUIEditor.gridlist[31] = guiCreateGridList(4, 9, 620, 254, false, GUIEditor.tab[31])
        local id = guiGridListAddColumn(GUIEditor.gridlist[31], "ID", 0.3)
        crc = guiGridListAddColumn(GUIEditor.gridlist[31], "Karakter", 0.3)
        local account = guiGridListAddColumn(GUIEditor.gridlist[31], "Hesap", 0.3)
        GUIEditor.label[31] = guiCreateLabel(7, 269, 505, 42, "Bilgilerini kontrol etmek veya işlem uygulamak istediğiniz oyuncuya çift tıklayın.", false, GUIEditor.tab[31])
        guiLabelSetHorizontalAlign(GUIEditor.label[31], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[31], "center")

        GUIEditor.tab[32] = guiCreateTab("Oyuncu Arat", GUIEditor.tabpanel[31])

        GUIEditor.edit[31] = guiCreateEdit(98, 24, 457, 40, "", false, GUIEditor.tab[32])
        GUIEditor.button[32] = guiCreateButton(206, 93, 205, 46, "Oyuncuyu Sorgula", false, GUIEditor.tab[32])
        GUIEditor.label[32] = guiCreateLabel(51, 159, 526, 37, "Sunucuda bulunmayan/bulunan oyuncuları doğrudan teyit edebilir ve yaptırım uygulayabilirsiniz.", false, GUIEditor.tab[32])    
        for ids, users in pairs(getElementsByType("player")) do
            if getElementData(users, "logged") then
                local row = guiGridListAddRow(GUIEditor.gridlist[31])
                guiGridListSetItemText ( GUIEditor.gridlist[31], row, id, ids, false, false )
                guiGridListSetItemText ( GUIEditor.gridlist[31], row, crc, getPlayerName(users), false, false )
                guiGridListSetItemText ( GUIEditor.gridlist[31], row, account, getElementData(users, "account"), false, false )
            end
        end
    end
)

    function showCrc(isim, yas, cinsiyet, kilo, boy, ten, can, zirh, para, skin, level)
        if guiGetVisible(GUIEditor.window[11]) == true then guiSetVisible(GUIEditor.window[11], false) end
        GUIEditor.window[11] = guiCreateWindow(1013, 196, 316, 373, isim, false)
        guiWindowSetMovable(GUIEditor.window[11], false)
        guiWindowSetSizable(GUIEditor.window[11], false)
        guiSetAlpha(GUIEditor.window[11], 1.00)

        GUIEditor.button[11] = guiCreateButton(98, 326, 144, 37, "Kapat", false, GUIEditor.window[11])
        GUIEditor.memo[11] = guiCreateMemo(9, 22, 297, 298, "", false, GUIEditor.window[11])
        guiMemoSetReadOnly(GUIEditor.memo[11], true)    
        guiSetText(GUIEditor.memo[11], "Isim: "..isim.." \nYaş: "..yas.." \nCinsiyet: "..cinsiyet.." \nKilo: "..kilo.." \nBoy: "..boy.." \nTen Rengi: "..ten.." \nZırh: %"..zirh.." \nSağlık: %"..can.." \nPara: $"..para.." \nModel ID: "..skin.." \nSeviye: "..level.."")
    end


addEventHandler("onClientGUIClick", root, function()
    if source == GUIEditor.button[31] then guiSetVisible(GUIEditor.window[31], false) showCursor(false) end
    if source == GUIEditor.button[11] then guiSetVisible(GUIEditor.window[11], false) end
end)

addEventHandler("onClientGUIDoubleClick", root, function()
    if source == GUIEditor.gridlist[31] then
    local secili_karakter = guiGridListGetItemText ( GUIEditor.gridlist[31], guiGridListGetSelectedItem ( GUIEditor.gridlist[31] ), crc )
    local target = getPlayerFromName(secili_karakter)
    if (target) then
    local isim, yas, cinsiyet, kilo, boy, ten, can, zirh, para, skin, level = getPlayerName(target), getElementData(target, "age"), getElementData(target, "gender"), getElementData(target, "weight"), getElementData(target, "height"), getElementData(target, "race"), getElementHealth(target), getPlayerArmor(target), getPlayerMoney(target), getElementModel(target), getElementData(target, "level") 
    showCrc(isim, yas, cinsiyet, kilo, boy, ten, can, zirh, para, skin, level)
end
end
end)



