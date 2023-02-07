local db = exports.mysql:dbConnect()

local function showVehicleControlPanel(p, c)
	local vCP_Vehicles = {}
	if getElementData(p, "admin")>6 then
		dbQuery(
		function(qh)
			local res, rows, err = dbPoll(qh, 0)
			for index, row in ipairs(res) do
				table.insert(vCP_Vehicles, { row["databaseID"], row["gtamodel"], row["model"], row["marka"], row["fiyat"], row["vergi"] } )
			end
			triggerClientEvent(p, "vcp_panel", p, vCP_Vehicles)
		end, db, "SELECT * FROM databasevehicles")
	end
end
addCommandHandler("vehicles", showVehicleControlPanel)

local function addDatabaseVehicle(gtamodel, ucret, vergi, marka, model)
	local gtamodel_ex = getVehicleNameFromModel(gtamodel) or 0
	if not gtamodel_ex or gtamodel_ex == 0 then triggerClientEvent(source, "loginerr", source, "GTA Araç Model bölmününü uygun şekilde girmelisiniz.") return end
	if not tonumber(ucret) then triggerClientEvent(source, "loginerr", source, "Aracın ücret bölümünü doldurmalısınız.") return end
	if not tonumber(vergi) then triggerClientEvent(source, "loginerr", source, "Aracın vergi bölümünü doldurmalısınız.") return end
	if marka=="" then triggerClientEvent(source, "loginerr", source, "Araç markasını belirtmeniz gerekiyor") return end
	if model=="" then triggerClientEvent(source, "loginerr", source, "Araç modelini belirtmeniz gerekiyor") return end
	dbExec(db, "INSERT INTO databasevehicles(gtamodel, model, marka, fiyat, vergi) VALUES(?,?,?,?,?)",gtamodel,marka,model,ucret,vergi)
	triggerClientEvent(source, "vCVP_succesfullyClient", source)
	outputChatBox("[-] #ffffffBaşarıyla veritabanında bir araç oluştrudunuz.",source,0,255,0,true)
end
addEvent("vCVP_createVehicle", true)
addEventHandler("vCVP_createVehicle", root, addDatabaseVehicle)

local function removeDatabaseVehicle(databaseid)
	if not tonumber(databaseid) then triggerClientEvent(source, "loginerr", source, "Silmek istediğiniz aracı panelden seçin.") return end
	dbExec(db, "DELETE FROM databasevehicles WHERE databaseID=?",databaseid)
	triggerClientEvent(source, "vCVP_succesfullyClient", source)
	outputChatBox("[-] #ffffffID"..databaseid.." aracı başarıyla veritabanından kaldırdınız.",source,0,255,0,true)
end
addEvent("vCP_removeVehicle", true)
addEventHandler("vCP_removeVehicle", root, removeDatabaseVehicle)