local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "radar", "area_name" }

function checkValidCharacterName(theText)
    local foundSpace, valid = false, true
    local lastChar, current = ' ', ''
    for i = 1, #theText do
        local char = theText:sub( i, i )
        if char == ' ' then -- it's a space
            if i == #theText then -- space at the end of name is not allowed
                valid = false
                return false, "You cannot have a space at the end\n of the name"
            else
                foundSpace = true -- we have at least two name parts
            end
            
            if #current < 2 then -- check if name's part is at least 2 chars
                valid = false
                return false, "Your name cannot be that small"
            end
            current = ''
        elseif lastChar == ' ' then -- this char follows a space, we need a capital letter
            if char < 'A' or char > 'Z' then
                valid = false
                return false, "You did not use capitals at a start of a name."
            end
            current = current .. char
        elseif ( char >= 'a' and char <= 'z' ) or ( char >= 'A' and char <= 'Z' ) or (char == "'") then -- can have letters anywhere in the name
            current = current .. char
        else -- unrecognized char (numbers, special chars)
            valid = false
            return false, "There are unknown characters \nin the text. You can only use\n A-Z, a-z and spaces"
        end
        lastChar = char
    end

    
    if valid and foundSpace and #theText < 25 and #current >= 2 then
        return true, "Looking good!" -- passed
    else
        return false, "Name is too long or too short \n(min 2, max 25)" -- failed for the checks
    end
end


GUIEditor = {
    edit = {},
    button = {},
    window = {},
    label = {},
    combobox = {},
    memo = {}
}
    function karakterYaratClientFc(u)
        showCursor(true)
        GUIEditor.window[1] = guiCreateWindow(75, 127, 346, 428, ""..u.." - Karakter Oluşturma", false)
        guiWindowSetMovable(GUIEditor.window[1], false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 0.82)

        GUIEditor.label[1] = guiCreateLabel(8, 26, 328, 88, "XXX sunucusuna hoş geldin. Aşağıdan tüm alanları tuşlayıp \nkarakterini yaratabilirsin, karakter adını tuşlamayı unutma.", false, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(8, 139, 78, 31, "Karakter Yaşı", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        GUIEditor.edit[1] = guiCreateEdit(9, 171, 77, 30, "", false, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(131, 139, 78, 31, "Karakter Kilosu", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        GUIEditor.edit[2] = guiCreateEdit(131, 171, 77, 30, "", false, GUIEditor.window[1])
        GUIEditor.label[4] = guiCreateLabel(243, 139, 78, 31, "Karakter Boyu", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
        GUIEditor.edit[3] = guiCreateEdit(244, 171, 77, 30, "", false, GUIEditor.window[1])
        GUIEditor.label[5] = guiCreateLabel(8, 201, 78, 31, "(Max 99)", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
        GUIEditor.label[6] = guiCreateLabel(130, 201, 78, 31, "(Max 150)", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
        GUIEditor.label[7] = guiCreateLabel(244, 201, 78, 31, "(Max 190)", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
        GUIEditor.combobox[1] = guiCreateComboBox(9, 259, 122, 81, "Beyaz", false, GUIEditor.window[1])
        guiComboBoxAddItem(GUIEditor.combobox[1], "Beyaz")
        guiComboBoxAddItem(GUIEditor.combobox[1], "Siyahi")
        guiComboBoxAddItem(GUIEditor.combobox[1], "Asyalı")
        GUIEditor.combobox[2] = guiCreateComboBox(204, 259, 122, 81, "Erkek", false, GUIEditor.window[1])
        guiComboBoxAddItem(GUIEditor.combobox[2], "Erkek")
        guiComboBoxAddItem(GUIEditor.combobox[2], "Kadın")
        karakteri_yarat = guiCreateButton(13, 350, 313, 68, "Karakteri Yarat", false, GUIEditor.window[1])


        skin_geri = guiCreateButton(553, 670, 63, 46, "<<", false)


        skin_ileri = guiCreateButton(719, 670, 63, 46, ">>", false)


        GUIEditor.edit[4] = guiCreateEdit(550, 630, 242, 31, "Ad_Soyad", false)
        guiEditSetMaxLength(GUIEditor.edit[4], 30)    
    end
    addEvent("karakterYaratClient", true)
    addEventHandler("karakterYaratClient", root, karakterYaratClientFc)

    addEventHandler("onClientGUIClick", root, function()
        if source == GUIEditor.edit[4] and (guiGetText(GUIEditor.edit[4]) == "Ad_Soyad") then guiSetText(GUIEditor.edit[4], "") end
        if source == skin_ileri or source == skin_geri then triggerServerEvent("skinDegisIleri", localPlayer, guiComboBoxGetItemText(GUIEditor.combobox[2], guiComboBoxGetSelected(GUIEditor.combobox[2]))) end
        if source == karakteri_yarat then
            local skin, yas, kilo, uzunluk = getElementData(localPlayer, "ssd"), guiGetText(GUIEditor.edit[1]), guiGetText(GUIEditor.edit[2]), guiGetText(GUIEditor.edit[3])
            local characterName  = guiGetText(GUIEditor.edit[4])
            local irk, cinsiyet = guiComboBoxGetItemText(GUIEditor.combobox[1], guiComboBoxGetSelected(GUIEditor.combobox[1])), guiComboBoxGetItemText(GUIEditor.combobox[2], guiComboBoxGetSelected(GUIEditor.combobox[2]))
            if characterName  == "Ad_Soyad" then triggerEvent("loginerr", localPlayer, "Lütfen karakterinizin ad ve soyad kısmını doldurun.") return end
            local nameCheckPassed, nameCheckError = checkValidCharacterName(characterName)
            if not nameCheckPassed then
            triggerEvent("loginerr", localPlayer, "Karakter isminizi uygun şekilde doldurun. Özel harf, sembol, sayı bulundurmayın. Örnek: Ali Unlu")
            return end
            triggerServerEvent("karakterYarat", localPlayer, skin, yas, kilo, uzunluk, characterName, irk, cinsiyet)
        end 
        if source == GUIEditor.button[21] then guiSetVisible(GUIEditor.window[21], false) end
        if source == GUIEditor.button[31] then triggerServerEvent("createCharacther:Server", localPlayer, getElementData(localPlayer, "account")) triggerEvent("karakterOlusturKapat", localPlayer) triggerEvent("karakterYaratClient", localPlayer, getElementData(localPlayer, "account")) end
    end)

    addEventHandler ( "onClientGUIComboBoxAccepted", root, function ()
        if source == GUIEditor.combobox[2] then
            local cinsiyet = guiComboBoxGetItemText(GUIEditor.combobox[2], guiComboBoxGetSelected(GUIEditor.combobox[2]))
            triggerServerEvent("skinDefault", localPlayer, cinsiyet)
        end
    end)

    addEvent("guikapat", true)
    addEventHandler("guikapat", root, function()
        if (guiGetVisible(GUIEditor.window[1] ) == true) then
            guiSetVisible(GUIEditor.window[1], false)
            guiSetVisible(skin_ileri, false)
            guiSetVisible(skin_geri, false)
            guiSetVisible(GUIEditor.edit[4], false)
            showCursor(false)
            showChat(true)
            for _, component in ipairs( components ) do
             setPlayerHudComponentVisible( component, true )
            end
        end
    end)



    function loginError(mesaj)
        local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[21] = guiCreateWindow((screenW - 434) / 2, (screenH - 146) / 2, 434, 146, "Bir şeyler ters gidiyor.", false)
        guiWindowSetSizable(GUIEditor.window[21], false)
        guiSetAlpha(GUIEditor.window[21], 1.00)

        GUIEditor.memo[21] = guiCreateMemo(9, 28, 409, 71, mesaj, false, GUIEditor.window[21])
        guiMemoSetReadOnly(GUIEditor.memo[21], true)
        GUIEditor.button[21] = guiCreateButton(147, 103, 146, 33, "Anladım / Düzelteceğim", false, GUIEditor.window[21])    
    end
    addEvent("loginerr", true)
    addEventHandler("loginerr", root, loginError)

    addEvent("karakterOlustur", true)
    addEventHandler("karakterOlustur", root,
    function()
        GUIEditor.button[31] = guiCreateButton(570, 648, 225, 56, "Yeni Karakter Oluştur", false)
        guiSetFont(GUIEditor.button[31], "default-bold-small")


        GUIEditor.label[31] = guiCreateLabel(503, 622, 355, 32, "Lütfen giriş yapmak istediğiniz karaktere tıklayın.", false)
        guiSetFont(GUIEditor.label[31], "clear-normal")
        guiLabelSetHorizontalAlign(GUIEditor.label[31], "center", false)    
    end)

    addEvent("karakterOlusturKapat", true)
    addEventHandler("karakterOlusturKapat", root, function()
        showCursor(false)
        if guiGetVisible(GUIEditor.button[31]) == true then
            guiSetVisible(GUIEditor.button[31], false)
            guiSetVisible(GUIEditor.label[31], false)
        end
    end)


