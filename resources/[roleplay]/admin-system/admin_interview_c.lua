addEventHandler("onClientRender", root,
    function()
        local seviye = getElementData(localPlayer, "admin") or 0
        if (seviye >= 1) and getElementData(localPlayer, "aduty") then
        local yetki = adminTags[seviye]["tag"]
        dxDrawLine(0 - 1, 724 - 1, 0 - 1, 768, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(1366, 724 - 1, 0 - 1, 724 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(0 - 1, 768, 1366, 768, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(1366, 768, 1366, 724 - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(0, 724, 1366, 44, tocolor(0, 0, 0, 200), false)
        dxDrawText("Yetkili Arayüzü\n"..yetki.."\n", 515, 729, 873, 763, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText("Bekleyen X Rapor Bulunuyor.\n", 153, 729, 511, 763, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Bekleyen X Soru Bulunuyor.", 873, 729, 1231, 763, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
        end
    end
)