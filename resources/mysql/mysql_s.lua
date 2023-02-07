local database = "oyun"
local host = "188.132.174.71"
local username = "eastlandsupervisor"
local password = "eastlandprojectoncoast"

connectData = dbConnect( "mysql", "dbname="..database..";host="..host..";charset=utf8", ""..username.."", ""..password.."", "share=1" )

function mysqlConnect()
	if (connectData) then
		outputDebugString("[MySQL] Veritabani baglantisi basariyla kuruldu.")
		startResource(getResourceFromName("play"))
	else
		setTimer(function()
		local login = getResourceFromName("auth")
		stopResource(login)
		outputChatBox("[MySQL] Hata, bilgilerin erişilebilir olduğundan emin olun.")
		outputDebugString("[MySQL] Hata, bilgilerin erişilebilir olduğundan emin olun.")
		end, 10000, 0, true)
	end
end
addEventHandler("onResourceStart", resourceRoot, mysqlConnect)


function dbConnect()
	return connectData
end
