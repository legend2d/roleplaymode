
GUIEditor = {
    button = {},
    window = {},
    memo = {}
}
    function authGuiInfo()
        if guiGetVisible(GUIEditor.window[1])==true then 
        guiSetVisible(GUIEditor.window[1], false) 
        else
        GUIEditor.window[1] = guiCreateWindow(284, 212, 296, 228, "Başarıyla kayıt oldunuz!", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.memo[1] = guiCreateMemo(10, 30, 273, 163, "Sunucumuzda belirli kurallar bulunur, kurallara uymayı unutmayın. \n\nDiscord:\nYouTube:\n\nİyi oyunlar!", false, GUIEditor.window[1])
        guiMemoSetReadOnly(GUIEditor.memo[1], true)
        GUIEditor.button[1] = guiCreateButton(16, 195, 267, 23, "Okudum ve anladım.", false, GUIEditor.window[1])    
    end
    end
    addEvent("authgui", true)
    addEventHandler("authgui", root, authGuiInfo)

    addEventHandler("onClientGUIClick", root, function()
        if source == GUIEditor.button[1] then guiSetVisible(GUIEditor.window[1], false) end
    end)
